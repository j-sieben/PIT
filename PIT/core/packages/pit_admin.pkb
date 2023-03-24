create or replace package body adc_admin
as

  /**
    Package: ADC_ADMIN Body
      Implementation of methods to administer ADC rules and related metadata.

    Author::
      Juergen Sieben, ConDeS GmbH

   */

  
  /**
    Group: Private constants
   */
   
  /**
    Constants: 
      C_ADC - UTL_TEXT template group for ADC
      C_REGEX_ITEM - Regular expression to identify firing items in trechnical conditions
      C_REGEX_CSS - Regular expression to identify CSS class references
   */
  C_ADC constant adc_util.ora_name_type := 'ADC';
  C_FRAME constant adc_util.ora_name_type := 'FRAME';
  C_DEFAULT constant adc_util.ora_name_type := 'DEFAULT';
  C_CAPT_VIEW_NAME_PREFIX constant adc_util.ora_name_type := 'ADC_PARAM_LOV_';  
  C_STATIC_LIST constant adc_util.ora_name_type := 'STATIC_LIST';

  C_REGEX_ITEM constant varchar2(50 byte) := q'~(^|[ '\(])#ITEM#([ ',=<^>\)]|$)~';
  C_REGEX_CSS constant varchar2(50 byte) := q'~'.+'~';
  
  C_UTTM_NAME constant adc_util.ora_name_type := 'EXPORT_ACTION_TYPE';
  C_WRAP_START constant adc_util.tiny_char := 'q''{';
  C_WRAP_END constant adc_util.tiny_char := '}''';
  
  C_PIPE constant adc_util.tiny_char := '|';
  

  /* Globale Variablen */
  g_offset binary_integer;
  g_action_type_filename adc_util.ora_name_type;
  g_user_action_type_filename adc_util.ora_name_type;
  g_rule_group_filename adc_util.ora_name_type;
  
  /**
    Group: Type definitions
   */
   
  /**
    Type: id_map_t
      PL/SQL table for mapping old IDs to new ones. Used when importing rule groups.
   */
  type id_map_t is table of binary_integer index by binary_integer;
  g_id_map id_map_t;
  
  /**
    Group: Private Methods
   */
  /** 
    Procedure: create_decision_table
      Method to generate the decision table logic for an ADC rule group.
      Result is persisted in column <Tables.ADC_RULE_GROUPS>.CRG_DECISION_TABLE.
      
    Parameter:
      p_crg_id - Rule group ID
   */
  procedure create_decision_table(
    p_crg_id in adc_rule_groups.crg_id%type)
  as
    C_UTTM_NAME constant adc_util.ora_name_type := 'RULE_VIEW';
    l_stmt clob;
  begin
    pit.enter_optional('create_decision_table', 
      p_params => msg_params(msg_param('p_crg_id', p_crg_id)));

    -- generate view SQL
    with params as(
           select /*+ no_merge */
                  uttm_text template, uttm_log_text log_template,
                  uttm_name, uttm_mode, p_crg_id g_crg_id,
                  adc_util.C_TRUE c_true,
                  adc_util.C_CR cr
             from utl_text_templates
            where uttm_type = C_ADC
              and uttm_name = C_UTTM_NAME)
    select utl_text.generate_text(cursor(
             select template, log_template, g_crg_id crg_id,
                    -- Events
                    utl_text.generate_text(cursor(
                      select template, cet_id, lower(cet_column_name) cet_column_name
                        from adc_event_types_v
                        join params
                          on uttm_mode = case cet_is_custom_event when c_true then 'EVENT' else upper(cet_id) end
                       where (cet_is_custom_event = c_true
                          or cet_id in ('initialize', 'command'))
                       order by case cet_is_custom_event when c_true then 1 else 0 end, cet_id), ',' || CR, 14) event_list,
                    -- Spaltenliste im SessionState
                    utl_text.generate_text(cursor(
                      select cpit_col_template template,
                             replace(cpi_conversion, 'G') conversion,
                             cpi_id item,
                             cpit_cet_id
                        from adc_page_item_types_v sit
                        left join (
                               select cpi_id, cpi_cpit_id, cpi_conversion, cpi_is_required
                                 from adc_page_items
                                where cpi_crg_id = g_crg_id) cpi
                          on sit.cpit_id = cpi.cpi_cpit_id
                        join params p
                          on C_TRUE in (cpi_is_required, cpit_include_in_view)
                       where cpit_col_template is not null
                         and uttm_mode = 'WHERE_CLAUSE'
                       order by cpit_include_in_view desc, cpi_id), ',' || CR, 14) column_list,
                    coalesce(
                      utl_text.generate_text(cursor(
                        select template, cru_id, cru_name, cru_condition, cru_firing_items,
                               row_number() over (order by cru_id) sort_seq
                          from adc_rules
                          join params p
                            on cru_crg_id in (0, g_crg_id)
                           and cru_active = c_true
                         where uttm_mode = 'WHERE_CLAUSE'
                         order by cru_id), CR || '           or '),
                      to_clob('null is null')) where_clause
               from dual)) resultat
      into l_stmt
      from params p
     where uttm_mode = 'FRAME';

    -- persist outcome with rule group
    update adc_rule_groups
       set crg_decision_table = l_stmt
     where crg_id = p_crg_id;

    pit.leave_optional;
  exception
    when others then
      pit.stop(msg.ADC_VIEW_CREATION, msg_args(sqlerrm, l_stmt));
  end create_decision_table;


  /** 
    Function: create_initialization_code
      Method to generate initialization code that copies initial page item values to the session state.
      
      Is used to copy initial values into the session state during page rendering. This is required to assure that
      any rule that is based on certain session state values is processed at initialization time.
      
    Parameter:
      p_crg_id - Rule group ID
      
    Returns:
      Anonymous PL/SQL block that copies the actual session state values into the session state
   */
  function create_initialization_code(
    p_crg_id in adc_rule_groups.crg_id%type)
    return varchar2
  as
    l_initialization_code utl_apex.max_char;
  begin
    pit.enter_optional('create_initialization_code',
      p_params => msg_params(
                    msg_param('p_crg_id', p_crg_id)));

      with params as (
           -- Get common values, depending on whether the page contains a DML_FETCH_ROW process
           select cgr.crg_id, adc_util.C_CR cr,
                  uttm.uttm_name, uttm.uttm_mode, uttm.uttm_text template,
                  app.attribute_02, app.attribute_03, app.attribute_04, app.application_id, app.page_id
             from apex_application_page_proc app
             join adc_rule_groups cgr
               on app.application_id = cgr.crg_app_id
              and app.page_id = cgr.crg_page_id
            cross join utl_text_templates uttm
            where app.process_type_code = 'DML_FETCH_ROW'
              and uttm_type = C_ADC
              and uttm_name like 'INITIALIZE%'
              and cgr.crg_id = p_crg_id)
    select utl_text.generate_text(cursor(
             select template,
                    cr,
                    -- select statement to select the actual page values from the table referenced by the DML_FETCH_ROW process
                    utl_text.generate_text(cursor(
                      select p.template, p.attribute_02, p.attribute_03, p.attribute_04
                        from params p
                       where p.uttm_mode = case p.attribute_04 when 'ROWID' then p.attribute_04 else 'DEFAULT' end
                         and p.uttm_name = 'INITIALIZE_COLUMN'), ',' || CR) sql_stmt,
                    -- generate adc_util.set_session_state calls for any page element
                    utl_text.generate_text(cursor(
                      select p.template, sit.cpit_init_template, cpi.cpi_conversion,
                             api.item_name, api.item_source
                        from params p
                        join apex_application_page_items api
                          on p.application_id = api.application_id
                         and p.page_id = api.page_id
                        join adc_page_items cpi
                          on p.crg_id = cpi.cpi_crg_id
                         and api.item_name = cpi.cpi_id
                        join adc_page_item_types sit
                          on cpi.cpi_cpit_id = sit.cpit_id
                       where api.item_source_type = 'Database Column'
                         and cpi.cpi_is_required = adc_util.C_TRUE
                         and p.uttm_name = 'INITIALIZE_COL_VAL'), CR) item_stmt
               from dual)) resultat
      into l_initialization_code
      from params
     where uttm_name = 'INITIALIZE';

    pit.leave_optional(p_params => msg_params(msg_param('Initialization Code', l_initialization_code)));
    return l_initialization_code;
  exception
    when no_data_found then
      pit.leave_optional(p_params => msg_params(msg_param('Initialization Code', 'NULL')));
      return null;
  end create_initialization_code;
  
  
  /**
    Procedure: get_key
      Method to retrive a new primary key if not present. If P_KEY is NULL, a new sequence key is provided.
      
    Parameter:  
      p_key - Key to set
   */
  procedure get_key(
    p_key in out nocopy binary_integer)
  as
  begin
    if p_key is null then
      p_key := adc_seq.nextval;
    end if;
  end get_key;
  
  
  /**
    Procedure: mark_number_date_required_fields
      Mark any item with a conversion or mandatory as required to enable ADC to dynamically validate the format.
      Mark any item with a required label as mandatory to dynamically check for NOT NULL.
      
    Parameters:
      p_crg_id - Rule group ID
   */
  procedure mark_number_date_required_fields(
    p_crg_id in adc_rule_groups.crg_id%type)
  as
  begin
    pit.enter_optional('mark_number_date_required_fields');
    
    merge into adc_page_items t
    using (select cpi_crg_id,
                  cpi_cpit_id,
                  cpi_caat_id,
                  cpi_id,
                  cpi_label,
                  cpi_conversion,
                  cpi_item_default,
                  cpi_css,
                  adc_util.C_FALSE cpi_has_error,
                  cpi_is_required,
                  cpi_is_mandatory,
                  cpi_may_have_value
             from adc_bl_page_targets
            where cpi_crg_id = p_crg_id
              and cpi_id is not null) s
       on (t.cpi_id = s.cpi_id and t.cpi_crg_id = s.cpi_crg_id)
     when matched then update set
          t.cpi_cpit_id = s.cpi_cpit_id,
          t.cpi_caat_id = s.cpi_caat_id,
          t.cpi_label = s.cpi_label,
          t.cpi_conversion = s.cpi_conversion,
          t.cpi_item_default = s.cpi_item_default,
          t.cpi_css = s.cpi_css,
          t.cpi_has_error = s.cpi_has_error,
          t.cpi_is_required = s.cpi_is_required,
          t.cpi_is_mandatory = s.cpi_is_mandatory,
          t.cpi_may_have_value = s.cpi_may_have_value
     when not matched then insert(
            cpi_id, cpi_cpit_id, cpi_caat_id, cpi_label, cpi_crg_id, 
            cpi_conversion, cpi_item_default, cpi_css, cpi_is_required, 
            cpi_is_mandatory, cpi_may_have_value)
          values(
            s.cpi_id, s.cpi_cpit_id, s.cpi_caat_id, s.cpi_label, s.cpi_crg_id, 
            s.cpi_conversion, s.cpi_item_default, s.cpi_css, s.cpi_is_required, 
            s.cpi_is_mandatory, s.cpi_may_have_value);
            
    pit.leave_optional;
  end mark_number_date_required_fields;
  
  
  /**
    Procedure: mark_rule_condition_items
      Mark any page item that is referenced in a technical rule condition as required.
      Method evaluates existing and newly added rule conditions.
      
    Parameters:
      p_crg_id - Rule group ID
      p_new_condition - Optional. If a new rule is created, the new rule condition must be obeyed as well
   */
  procedure mark_rule_condition_items(
    p_crg_id in adc_rule_groups.crg_id%type,
    p_new_condition in adc_rules.cru_condition%type default null)
  as
  begin
    pit.enter_optional('mark_rule_condition_items');
    
    merge into adc_page_items t
    using (select distinct cpi_crg_id, cpi_id
             from (select cgr.crg_id cpi_crg_id, i.column_value cpi_id
                     from adc_rules cru
                     join adc_rule_groups cgr
                       on cru.cru_crg_id = cgr.crg_id
                    cross join table(utl_text.string_to_table(cru.cru_firing_items, ',')) i
                    where crg_id = p_crg_id
                    union all
                   select cpi_crg_id, cpi_id
                     from adc_page_items cpi
                    where (regexp_instr(upper(p_new_condition), replace(C_REGEX_ITEM, '#ITEM#', cpi.cpi_id)) > 0
                       or instr(cpi.cpi_css, replace(regexp_substr(p_new_condition, C_REGEX_CSS), adc_util.C_APOS, C_PIPE)) > 0)
                      and cpi_crg_id = p_crg_id)) s
       on (t.cpi_id = s.cpi_id
       and t.cpi_crg_id = s.cpi_crg_id)
     when matched then update set
          t.cpi_is_required = adc_util.C_TRUE;
            
    pit.leave_optional;
  end mark_rule_condition_items;
  
  
  /**
    Procedure: mark_auto_validate_fields
      Mark any item that is referenced in action type VALIDATE_ITEMS and
      store the validation method name with the item.
      
    Parameters:
      p_crg_id - Rule group ID
   */
  procedure mark_auto_validate_fields(
    p_crg_id in adc_rule_groups.crg_id%type)
  as
  begin
    pit.enter_optional('mark_auto_validate_fields');
    
    merge into adc_page_items t
    using (with data as(
                  select cra_param_1, cra_param_2
                    from adc_rule_actions
                   where cra_crg_id = 162
                     and cra_cat_id = 'VALIDATE_ITEMS')
           select p_crg_id cpi_crg_id,
                  column_value cpi_id, 
                  replace(cra_param_2, '#ITEM#', column_value) cpi_validation_method,
                  adc_util.c_true cpi_is_required
             from data
            cross join table(
                  select utl_text.string_to_table(cra_param_1)
                    from data)) s
       on (t.cpi_id = s.cpi_id and t.cpi_crg_id = s.cpi_crg_id)
     when matched then update set
          t.cpi_validation_method = s.cpi_validation_method,
          t.cpi_is_required = s.cpi_is_required;
            
    pit.leave_optional;
  end mark_auto_validate_fields;
  
  
  /**
    Procedure: remove_irrelevant_fields
      Remove any item that is 
     
      - irrelevant and
      - erroneus (fi not existing anymore) and
      - not referenced by rule actions
      
    Parameters:
      p_crg_id - Rule group ID
   */
  procedure remove_irrelevant_fields(
    p_crg_id in adc_rule_groups.crg_id%type)
  as
  begin
    pit.enter_optional('mark_auto_validate_fields');
    
      delete from adc_page_items
       where cpi_crg_id = p_crg_id
         and cpi_is_required = adc_util.C_FALSE
         and cpi_has_error = adc_util.C_TRUE
         and cpi_id not in (
             select cra_cpi_id
               from adc_rule_actions
              where cra_crg_id = p_crg_id);
            
    pit.leave_optional;
  end remove_irrelevant_fields;
  
  
  /**
    Procedure: mark_error_fields
      Marks rules and rule actions that have any errors
      
    Parameters:
      p_crg_id - Rule group ID
   */
  procedure mark_error_fields(
    p_crg_id in adc_rule_groups.crg_id%type)
  as
  begin
    pit.enter_optional('mark_error_fields');

      update adc_rules
         set cru_has_error = adc_util.C_FALSE
       where cru_crg_id = p_crg_id;
    
      merge into adc_rules t
      using (select distinct cru.cru_id
               from adc_page_items cpi
               join adc_rules cru
                 on utl_text.contains(cru_firing_items, cpi_id) = adc_util.C_TRUE
              where cpi_crg_id = p_crg_id
                and cpi_has_error = adc_util.C_TRUE) s
         on (t.cru_id = s.cru_id)
       when matched then update set
            t.cru_has_error = adc_util.C_TRUE;
            
      update adc_rule_actions
         set cra_has_error = adc_util.C_FALSE
       where cra_crg_id = p_crg_id;

      pit.debug(msg.ADC_HARMONIZE_CPI_STEP_8);
      merge into adc_rule_actions t
      using (select cpi_crg_id cra_crg_id, cpi_id cra_cpi_id
               from adc_page_items
              where cpi_crg_id = p_crg_id
                and cpi_has_error = adc_util.C_TRUE) s
         on (t.cra_crg_id = s.cra_crg_id
         and t.cra_cpi_id = s.cra_cpi_id)
       when matched then update set
            t.cra_has_error = adc_util.C_TRUE;
            
    pit.leave_optional;
  end mark_error_fields;
  
  
  /**
    Procedure: create_initialization_code
      Creates optional initialization code for the rule group
      
    Parameters:
      p_crg_id - Rule group ID
   */
  procedure create_initialization_code(
    p_crg_id in adc_rule_groups.crg_id%type)
  as
    l_initialization_code adc_rule_groups.crg_initialization_code%type;
  begin
    pit.enter_optional('create_initialization_code');
            
    l_initialization_code := create_initialization_code(p_crg_id);

    update adc_rule_groups
       set crg_initialization_code = l_initialization_code
     where crg_id = p_crg_id;
     
    pit.leave_optional;
  end create_initialization_code;
  
  
  /** 
    Procedure: harmonize_adc_page_item
      Method to harmonize <Tables.ADC_PAGE_ITEMS> against APEX Data Dictionary.
      
      If a rule group changes, all rules and page elements are checked against each other.
      The resulting values are used as the basis for a single rule.
      Additionally, this method is called if a new rule is created to check whether the condition
      is syntactically plausible. Therefore, the new condition (which is not stored in the tables yet)
      must be added to identify any new page items referenced within this rule.
      
    Attention:: 
      Method removes non existing page items from the table and deletes any rule actions attached to these page items!
      
    Parameters:
      p_crg_id - Rule group ID
      p_new_condition - Optional. If a new rule is created, the new rule condition must be obeyed as well
      
   */
  procedure harmonize_adc_page_item(
    p_crg_id in adc_rule_groups.crg_id%type,
    p_new_condition in adc_rules.cru_condition%type default null)
  as
  begin
    pit.enter_optional('harmonize_adc_page_item',
      p_params => msg_params(
                    msg_param('p_crg_id', p_crg_id)));

    -- Initialize
    pit.debug(msg.ADC_HARMONIZE_CPI_STEP_1);
    update adc_page_items
       set cpi_is_required = adc_util.C_FALSE,
           cpi_has_error = adc_util.C_TRUE,
           cpi_validation_method = null
     where cpi_crg_id = p_crg_id;

    mark_number_date_required_fields(p_crg_id);

    mark_rule_condition_items(p_crg_id, p_new_condition);
    
    mark_auto_validate_fields(p_crg_id);
    
    remove_irrelevant_fields(p_crg_id);
      
    mark_error_fields(p_crg_id);
    
    create_initialization_code(p_crg_id);

    pit.leave_optional;
  exception
    when others then
      pit.stop(msg.ADC_INITIALZE_CRG_FAILED, msg_args(to_char(p_crg_id),sqlerrm));
  end harmonize_adc_page_item;


  /** 
    Procedure: harmonize_firing_items
      Helper to harmonize page items which are referenced by a rule at <Tables.ADC_RULES>.
      
      Method extracts page item names from a rule condition using regex C_REGEX_ITEM.
      Used to validate a rule condition and further application logic.
      
    Parameter:
      p_crg_id - Rule group ID
   */
  procedure harmonize_firing_items(
    p_crg_id in adc_rule_groups.crg_id%type)
  as
  begin
    pit.enter_detailed('harmonize_firing_items',
      p_params => msg_params(
                    msg_param('p_crg_id', p_crg_id)));

    merge into adc_rules t
    using (select cru.cru_id,
                  listagg(cpi.cpi_id, ',') within group (order by cpi.cpi_id) cru_firing_items
             from adc_page_items cpi
             join adc_rules cru
               on cpi.cpi_crg_id = cru.cru_crg_id
              and (regexp_instr(upper(cru.cru_condition), replace(C_REGEX_ITEM, '#ITEM#', cpi.cpi_id)) > 0
               or instr(cpi.cpi_css, replace(regexp_substr(cru.cru_condition, C_REGEX_CSS), adc_util.C_APOS, C_PIPE)) > 0)
            where cpi.cpi_crg_id = p_crg_id
              and cru.cru_active = adc_util.C_TRUE
            group by cru.cru_id) s
       on (t.cru_id = s.cru_id)
     when matched then update set
          t.cru_firing_items = s.cru_firing_items;

    pit.leave_detailed;
  end harmonize_firing_items;
  
  
  /** 
    Function: integrate_rule_groups_into_app
      Helper method to include rule group export script into the application export.
      
    Parameters:
      p_crg_app_id - ID of the APEX application to integrate the rule group script into
      p_script - Rule group script
      p_install_id - ID for the APEX supporting object install id
      
    Returns:
      Script with the APEX export and rule group script integrated
   */
  function integrate_rule_groups_into_app(
    p_crg_app_id in adc_rule_groups.crg_app_id%type,
    p_rule_group in clob,
    p_install_id in number)
    return clob
  as
    C_MAX_LENGTH constant pls_integer := 30000;
    C_END_COMMENT constant utl_apex.small_char := q'^prompt --application/end_environment^';
    l_export_file apex_t_export_files;
    l_offset pls_integer := 1;
    l_add_amount pls_integer;
    l_amount pls_integer := C_MAX_LENGTH;
    l_length pls_integer;
    l_buffer utl_apex.max_char;
    l_script clob;
    l_prefix adc_util.max_char;
    l_no_end_comment_found boolean := true;
  begin
    dbms_lob.createtemporary(l_script, false, dbms_lob.call);
    
    -- Get APEX application
    l_export_file := apex_export.get_application (
                       p_application_id => p_crg_app_id,
                       p_with_ir_public_reports => true,
                       p_with_supporting_objects => 'N');
                
    -- Find position to integrate rule script into the export file
    l_length := dbms_lob.getlength(l_export_file(1).contents);

    while l_offset < l_length and l_no_end_comment_found loop
      -- Add some text to securly detect C_END_COMMENT
      l_add_amount := length(C_END_COMMENT);
      l_amount := l_amount + l_add_amount;
    
      dbms_lob.read(l_export_file(1).contents, l_amount, l_offset, l_buffer);
      -- Try to find C_END_COMMENT.
      if instr(l_buffer, C_END_COMMENT) > 0 then
        -- found, read the rest of the file and split it
        l_amount := l_amount + 1000;
        dbms_lob.read(l_export_file(1).contents, l_amount, l_offset, l_buffer);
        dbms_lob.append(l_script, substr(l_buffer, 1, instr(l_buffer, C_END_COMMENT) - 1));
      
      select replace(uttm_text, '#CRG_INSTALL_ID#', p_install_id)
        into l_prefix
        from utl_text_templates
       where uttm_type = C_ADC
         and uttm_name = 'EXPORT_RULE_GROUP'
         and uttm_mode = 'DEFAULT_APP_PREFIX';
         
        dbms_lob.append(l_script, l_prefix);
        dbms_lob.append(l_script, p_rule_group);
        dbms_lob.append(l_script, substr(l_buffer, instr(l_buffer, C_END_COMMENT)));
        l_no_end_comment_found := false;
      else
        -- Not found, add buffer to out script and read on
        l_amount := l_amount - l_add_amount;
        dbms_lob.append(l_script, substr(l_buffer, 1, length(l_buffer) - l_add_amount));
      end if;
    
      l_offset := l_offset + l_amount;
    end loop;
    
    return l_script;
  end integrate_rule_groups_into_app;
  
  
  /** 
    Procedure: validate_export_rule_groups
      Helper method to validate an export rule group according to the P_MODE request.
      Based on the parameters passed in this method will export one or more rule groups.
      
    Parameters:
      p_crg_app_id - APEX application ID of the application of which all rule groups are to be exported.
      p_crg_page_id - If a rule group is copied, this parameter defines the target application page id
      p_mode - Export mode. Determines which parameters are mandatory
      
    Errors:
      APP_ID_MISSING - if <P_MODE> requires an application id
      PAGE_ID_MISSING - if <P_MODE> requires an application page id
   */
  procedure validate_export_rule_groups(
    p_crg_app_id in out nocopy adc_rule_groups.crg_app_id%type,
    p_crg_page_id in out nocopy adc_rule_groups.crg_page_id%type,
    p_mode in varchar2)
  as
    l_cur sys_refcursor;
  begin
    pit.enter_optional(
      p_params => msg_params(
                    msg_param('p_crg_app_id', p_crg_app_id),
                    msg_param('p_crg_page_id', p_crg_page_id)));
    case p_mode
      when C_ALL_GROUPS then
        -- Reset unneeded restrictions
        p_crg_app_id := null;
        p_crg_page_id := null;
      when C_APEX_APP then
        pit.assert_not_null(p_crg_app_id, p_error_code => 'APP_ID_MISSING');
        -- Reset unneeded restrictions
        p_crg_page_id := null;
      when C_APP_GROUPS then
        pit.assert_not_null(p_crg_app_id, p_error_code => 'APP_ID_MISSING');
        -- Reset unneeded restrictions
        p_crg_page_id := null;
      when C_PAGE_GROUP then
        pit.assert_not_null(p_crg_app_id, p_error_code => 'APP_ID_MISSING');
        pit.assert_not_null(p_crg_page_id, p_error_code => 'PAGE_ID_MISSING');
        -- Reset unneeded restrictions
        p_crg_page_id := null;
      else
        pit.error(msg.ADC_UNKNOWN_EXPORT_MODE, msg_args(p_mode));
      end case;
    pit.leave_optional;
  exception
    when others then
      pit.stop;
  end validate_export_rule_groups;
  
  
  /**
    Function: get_action_param_types
      Method to retrieve all action parameter type scripts for the given action type owner.
      
      If the requested owner is different from the default owner C_ADC then only those
      parameter types are returned which are not already defined within the core delivery.
      
    Parameter:
      p_cato_id - Owner of the action parameter types
      
    Returns:
      Install script with all API calls for the action parameter types for the requested owner
   */
  function get_action_param_types(
    p_cato_id in adc_action_type_owners.cato_id%type)
    return clob
  as
    l_action_param_types clob;
  begin
    pit.enter_optional('get_action_param_types',
      p_params => msg_params(
                    msg_param('p_cato_id', p_cato_id)));
                    
    select utl_text.generate_text(cursor(
            select uttm_text template,
                   capt_id, capt_name, adc_util.to_bool(capt_active) capt_active,
                   utl_text.wrap_string(capt_description, C_WRAP_START, C_WRAP_END) capt_description,
                   capt_capvt_id,
                   utl_text.wrap_string(capt_select_list_query, C_WRAP_START, C_WRAP_END) capt_select_list_query,
                   utl_text.wrap_string(capt_select_view_comment, C_WRAP_START, C_WRAP_END) capt_select_view_comment,
                   capt_display_name, capt_sort_seq
              from adc_action_param_types_v
              join adc_action_parameters
                on capt_id = cap_capt_id
              join adc_action_types
                on cap_cat_id = cat_id
             where cat_cato_id = p_cato_id
                   -- if CATO_ID is not C_ADC, exclude all parameter types already exported by C_ADC
               and (capt_id not in (
                      select cap_capt_id
                        from adc_action_parameters
                        join adc_action_types
                          on cap_cat_id = cat_id
                       where cat_cato_id = C_ADC)
                or p_cato_id = C_ADC)
           ), adc_util.C_CR)
      into l_action_param_types
      from utl_text_templates
     where uttm_type = C_ADC
       and uttm_name = C_UTTM_NAME
       and uttm_mode = 'PARAM_TYPE';
       
    pit.leave_optional;
    return l_action_param_types;
  end get_action_param_types;
  
  
  /**
    Function: get_action_types
      Method to retrieve all action type scripts for the given action type owner.
      
    Parameter:
      p_cato_id - Owner of the action types
      
    Returns:
      Install script with all API calls for the action types for the requested owner
   */
  function get_action_types(
    p_cato_id in adc_action_type_owners.cato_id%type)
    return clob
  as
    l_cur sys_refcursor;
    l_action_types clob;
    l_action_type_list clob_table;
  begin
    pit.enter_optional('get_action_types',
      p_params => msg_params(
                    msg_param('p_cato_id', p_cato_id)));
                    
    -- Collect action types. Different API for performance and size reasons
    dbms_lob.createtemporary(l_action_types, false, dbms_lob.call);
    open l_cur for         
       with params as (
              select uttm_mode, uttm_text template, null p_cat_is_editable
                from utl_text_templates
               where uttm_type = C_ADC
                 and uttm_name = C_UTTM_NAME)
       select template,
              cat_id, cat_catg_id, cat_caif_id, cat_cato_id, cat_name,
              utl_text.wrap_string(cat_display_name, C_WRAP_START, C_WRAP_END) cat_display_name,
              utl_text.wrap_string(cat_description, C_WRAP_START, C_WRAP_END) cat_description,
              utl_text.wrap_string(cat_pl_sql, C_WRAP_START, C_WRAP_END) cat_pl_sql,
              utl_text.wrap_string(cat_js, C_WRAP_START, C_WRAP_END) cat_js,
              adc_util.to_bool(cat_is_editable) cat_is_editable,
              adc_util.to_bool(cat_raise_recursive) cat_raise_recursive,
              -- rule action_params
              utl_text.generate_text(cursor(
                select template, cap_cat_id, cap_capt_id, cap_sort_seq,
                       adc_util.to_bool(cap_mandatory) cap_mandatory,
                       adc_util.to_bool(cap_active) cap_active,
                       utl_text.wrap_string(cap_default, C_WRAP_START, C_WRAP_END) cap_default,
                       utl_text.wrap_string(cap_description, C_WRAP_START, C_WRAP_END) cap_description,
                       cap_display_name
                  from adc_action_parameters_v
                 cross join params p
                 where uttm_mode = 'ACTION_PARAMS'
                   and cap_cat_id = cat_id
              ), adc_util.C_CR) rule_action_params
         from adc_action_types_v
         join params
           on cat_is_editable = p_cat_is_editable
           or p_cat_is_editable is null
        where uttm_mode = 'ACTION_TYPE'
          and cat_cato_id = p_cato_id;
    utl_text.generate_text_table(l_cur, l_action_type_list);

    for i in 1 .. l_action_type_list.count loop
      dbms_lob.append(l_action_types, l_action_type_list(i));
    end loop;
    
    pit.leave_optional;
    return l_action_types;
  end get_action_types;
  
  
  /**
    Procedure: add_param_lov_statements
      Method to add install scripts vor dynamically defined, lov based action parameter types
      
    Parameter:
      p_zip_file - ZIP file with all files generated so far
      p_cato_id - Owner of the parameters
   */
  procedure add_param_lov_statements(
    p_cato_id in adc_action_type_owners_v.cato_id%type,
    p_zip_file in out nocopy blob)
  as
    l_export_script clob;
  begin
    pit.enter_optional('add_custom_action_types');
    
    -- Finally, add all create view statements for LOV-based parameter types
    for cpt in (select v.*
                  from adc_action_param_types_v v
                  join adc_action_parameters
                    on capt_id = cap_capt_id
                  join adc_action_types
                    on cap_cat_id = cat_id
                 where cat_cato_id = p_cato_id
                   and (capt_capvt_id = C_STATIC_LIST
                    or capt_select_list_query is not null)) loop
      l_export_script := adc_parameter.get_param_lov_query(cpt);
    
      apex_zip.add_file(
        p_zipped_blob => p_zip_file,
        p_file_name => 'adc_param_lov_' || lower(cpt.capt_id) || '.lov',
        p_content => utl_text.clob_to_blob(l_export_script));
    end loop;
    
    pit.leave_optional;
  end add_param_lov_statements;
  
  
  /**
    Procedure: add_custom_action_types
      Method to add all custom defined action types along with their exclusively
      defined parameter types to separate installation files
      
    Parameter:
      p_zip_file - ZIP file with all files generated so far
   */
  procedure add_custom_action_types(
    p_zip_file in out nocopy blob)
  as
    cursor custom_actions_cur is
      select cato_id
        from adc_action_type_owners
       where cato_id != C_ADC;
    l_action_param_types clob;
    l_action_types clob;
    l_custom_action_types clob;
  begin
    pit.enter_optional('add_custom_action_types');
    
    for cato in custom_actions_cur loop
      l_action_param_types := get_action_param_types(cato.cato_id);
      l_action_types := get_action_types(cato.cato_id);
      
      select utl_text.generate_text(cursor(
               select uttm_text template, 
                      l_action_param_types action_param_types,
                      l_action_types action_types
                 from utl_text_templates
                where uttm_type = C_ADC
                  and uttm_name = C_UTTM_NAME
                  and uttm_mode = 'CUSTOM_FRAME'))
        into l_custom_action_types
        from dual;
      
      apex_zip.add_file(
        p_zipped_blob => p_zip_file,
        p_file_name => replace(g_user_action_type_filename, '#CATO#', cato.cato_id),
        p_content => utl_text.clob_to_blob(l_custom_action_types));
        
      add_param_lov_statements(cato.cato_id, p_zip_file);
    end loop;
    
    pit.leave_optional;
  end add_custom_action_types;
  

  /**
    Procedure: initialize
      Package initialization method.
   */
  procedure initialize
  as
  begin
    g_offset := 0;
    g_action_type_filename := param.get_string(C_ADC, 'ACTION_TYPE_FILENAME');
    g_user_action_type_filename := param.get_string(C_ADC, 'USER_ACTION_TYPE_FILENAME');
    g_rule_group_filename := param.get_string(C_ADC, 'RULE_GROUP_FILENAME');
  end;


  /**
    Group: Public Methods - Helper Functions
   */
  
  /**
    Function: map_id
      See <ADC_ADMIN.map_id>
   */
  function map_id(
    p_id in number)
    return number
  as
    l_new_id binary_integer;
  begin
    pit.enter_mandatory;

    if p_id is null then
      g_id_map.delete;
    else
      if not g_id_map.exists(p_id) then
        g_id_map(p_id) := adc_seq.nextval;
      end if;
      l_new_id := g_id_map(p_id);
    end if;

    pit.leave_mandatory(p_params => msg_params(msg_param('Return', l_new_id)));
    return l_new_id;
  end map_id;


  /**
    Procedure: add_translation
      See <ADC_ADMIN.add_translation>
   */
  procedure add_translation(
    p_table_shortcut in adc_util.ora_name_type,
    p_item_id in adc_util.ora_name_type,
    p_pml_name in pit_translatable_item.pti_pml_name%type,
    p_name in pit_translatable_item.pti_name%type,
    p_display_name in pit_translatable_item.pti_display_name%type,
    p_description in pit_translatable_item.pti_description%type)
  as
  begin
    pit_admin.merge_translatable_item(
      p_pti_id => p_table_shortcut || '_' || p_item_id,
      p_pti_pml_name => p_pml_name,
      p_pti_pmg_name => C_ADC,
      p_pti_name => p_name,
      p_pti_display_name => p_display_name,
      p_pti_description => p_description);
  end add_translation;


  /**
    Group: Public Methods - Rule Group Functions
   */    
  /**
    Procedure: merge_rule_group
      See <ADC_ADMIN.merge_rule_group>
   */ 
  procedure merge_rule_group(
    p_crg_app_id in adc_rule_groups.crg_app_id%type,
    p_crg_page_id in adc_rule_groups.crg_page_id%type,
    p_crg_id in adc_rule_groups.crg_id%type default null,
    p_crg_with_recursion in adc_rule_groups.crg_with_recursion%type default adc_util.C_TRUE,
    p_crg_active in adc_rule_groups.crg_active%type default adc_util.C_TRUE)
  as
    l_row adc_rule_groups%rowtype;
  begin
    pit.enter_mandatory(
      p_params => msg_params(
                    msg_param('p_crg_app_id', p_crg_app_id),
                    msg_param('p_crg_page_id', p_crg_page_id),
                    msg_param('p_crg_id', p_crg_id),
                    msg_param('p_crg_with_recursion', p_crg_with_recursion),
                    msg_param('p_crg_active', p_crg_active)));
                    
    l_row.crg_app_id := p_crg_app_id + g_offset;
    l_row.crg_page_id := p_crg_page_id;
    l_row.crg_id := p_crg_id;
    l_row.crg_with_recursion := adc_util.get_boolean(p_crg_with_recursion);
    l_row.crg_active := adc_util.get_boolean(p_crg_active);
    
    merge_rule_group(l_row);    

    pit.leave_mandatory;
  end merge_rule_group;


  /**
    Procedure: merge_rule_group
      See <ADC_ADMIN.merge_rule_group>
   */ 
  procedure merge_rule_group(
    p_row in out nocopy adc_rule_groups%rowtype)
  as
  begin
    pit.enter_mandatory;
    
    p_row.crg_with_recursion := coalesce(p_row.crg_with_recursion, adc_util.C_TRUE);
    p_row.crg_active := coalesce(p_row.crg_active, adc_util.C_TRUE);

    validate_rule_group(p_row);
      
    get_key(p_row.crg_id);    

    merge into adc_rule_groups t
    using (select p_row.crg_id crg_id,
                  p_row.crg_app_id crg_app_id,
                  p_row.crg_page_id crg_page_id,
                  p_row.crg_with_recursion crg_with_recursion,
                  p_row.crg_active crg_active
             from dual) s
       on (t.crg_id = s.crg_id and t.crg_app_id = s.crg_app_id)
     when matched then update set
          t.crg_page_id = s.crg_page_id,
          t.crg_with_recursion = s.crg_with_recursion,
          t.crg_active = s.crg_active
     when not matched then insert(crg_id, crg_app_id, crg_page_id, crg_with_recursion, crg_active)
          values(s.crg_id, s.crg_app_id, s.crg_page_id, s.crg_with_recursion, s.crg_active);
     
    harmonize_adc_page_item(p_row.crg_id);
    
    pit.leave_mandatory;
  exception
    when others then
      pit.handle_exception(msg.ADC_MERGE_RULE_GROUP, msg_args(to_char(p_row.crg_id)));
  end merge_rule_group;


  /**
    Procedure: delete_rule_group
      See <ADC_ADMIN.delete_rule_group>
   */ 
  procedure delete_rule_group(
    p_crg_id in adc_rule_groups.crg_id%type)
  as
    l_row adc_rule_groups%rowtype;
  begin
    pit.enter_mandatory(
      p_params => msg_params(
                    msg_param('p_crg_id', p_crg_id)));
                    
    l_row.crg_id := p_crg_id;
    
    delete_rule_group(l_row);
     
    pit.leave_mandatory;
  end delete_rule_group;


  /**
    Procedure: delete_rule_group
      See <ADC_ADMIN.delete_rule_group>
   */ 
  procedure delete_rule_group(
    p_row in out nocopy adc_rule_groups%rowtype)
  as
  begin
    pit.enter_mandatory;
    
    delete from adc_rule_groups
     where crg_id = p_row.crg_id;
     
    pit.leave_mandatory;
  end delete_rule_group;
  
  
  /**
    Procedure: validate_rule_group
      See <ADC_ADMIN.validate_rule_group>
   */ 
  procedure validate_rule_group(
    p_row in adc_rule_groups%rowtype)
  as
    l_cur sys_refcursor;
  begin
    pit.enter_mandatory;
      
    pit.assert_not_null(p_row.crg_app_id, msg.ADC_PARAM_MISSING, p_error_code => 'CRG_APP_ID_MISSING');
    pit.assert_not_null(p_row.crg_page_id, msg.ADC_PARAM_MISSING, p_error_code => 'CRG_PAGE_ID_MISSING');

    if p_row.crg_id is null then
      -- only if inserting we need to check whether the name is unique
      open l_cur for 
        select null
          from adc_rule_groups
         where crg_app_id = p_row.crg_app_id
           and crg_page_id = p_row.crg_page_id;
      pit.assert_not_exists(
        p_cursor => l_cur,
        p_message_name => msg.ADC_CRG_MUST_BE_UNIQUE,
        p_msg_args => null,
        p_affected_id => 'CRG_PAGE_ID');
    end if;
    
    pit.leave_mandatory;
  end validate_rule_group;
  
  
  /**
    Procedure: toggle_rule_group
      See <ADC_ADMIN.toggle_rule_group>
   */ 
  procedure toggle_rule_group(
    p_crg_id in adc_rule_groups.crg_id%type)
  as
  begin
    pit.enter_mandatory(
      p_params => msg_params(msg_param('p_crg_id', p_crg_id)));
      
    update adc_rule_groups
       set crg_active = case crg_active when adc_util.c_true then adc_util.c_false else adc_util.c_true end
     where crg_id = p_crg_id;

    pit.leave_mandatory;
  end toggle_rule_group;


  /**
    Function: validate_rule_group
      See <ADC_ADMIN.validate_rule_group>
   */ 
  function validate_rule_group(
    p_crg_id in adc_rule_groups.crg_id%type)
    return varchar2
  as
    C_UTTM_NAME constant adc_util.ora_name_type := 'VALIDATE_RULE_GROUP_EXPORT';
    l_error_list clob;
  begin
    pit.enter_mandatory(
      p_params => msg_params(
                    msg_param('p_crg_id', p_crg_id)));

    harmonize_adc_page_item(p_crg_id);

    with params as (
           select uttm_mode, uttm_text template,
                  crg_id, crg_app_id
             from adc_rule_groups
            cross join utl_text_templates
            where uttm_type = C_ADC
              and uttm_name = C_UTTM_NAME
              and crg_id = p_crg_id
              and exists(
                  select null
                    from adc_page_items
                   where cpi_crg_id = crg_id
                     and cpi_has_error = adc_util.C_TRUE))
    select utl_text.generate_text(cursor(
             select template, 
                    utl_text.generate_text(cursor(
                      select p.template, p.crg_app_id, cpi.cpi_id
                        from adc_page_items cpi
                        join adc_page_item_types sit
                          on cpi.cpi_cpit_id = sit.cpit_id
                        join params p
                          on cpi.cpi_crg_id = p.crg_id
                       where cpi.cpi_has_error = adc_util.C_TRUE
                    )) error_list
               from dual
           )) resultat
      into l_error_list
      from params
     where uttm_mode = C_DEFAULT;

    pit.leave_mandatory(p_params => msg_params(msg_param('Return', l_error_list)));
    return l_error_list;
  end validate_rule_group;


  /**
    Procedure: propagate_rule_change
      See <ADC_ADMIN.propagate_rule_change>
   */ 
  procedure propagate_rule_change(
    p_crg_id in adc_rule_groups.crg_id%type)
  as
  begin
    pit.enter_mandatory(
      p_params => msg_params(
                    msg_param('p_crg_id', p_crg_id)));

    harmonize_firing_items(p_crg_id);
    harmonize_adc_page_item(p_crg_id);
    create_decision_table(p_crg_id);
    resequence_rule(p_crg_id);

    pit.leave_mandatory;
  end propagate_rule_change;
  
  
  /**
    Function: export_rule_group
      See <ADC_ADMIN.export_rule_group>
   */ 
  function export_rule_group(
    p_crg_id in adc_rule_groups.crg_id%type,
    p_mode in varchar2 default C_APP_GROUPS,
    p_install_id in number default null)
    return clob
  as
    C_UTTM_NAME constant adc_util.ora_name_type := 'EXPORT_RULE_GROUP';
    l_template adc_util.ora_name_type;
    l_stmt_frame clob;
    l_stmt clob;
  begin      
    -- Create export script based on UTL_TEXT export templates
    utl_text.set_secondary_anchor_char('§');
        
    with params as (
           select uttm_mode, uttm_text template,
                  case p_mode when C_APEX_APP then 'DEFAULT_APP' else C_DEFAULT end g_mode,
                  crg_id, crg_app_id, crg_page_id, 
                  adc_util.to_bool(crg_active) crg_active,
                  adc_util.to_bool(crg_with_recursion) crg_with_recursion,
                  p_install_id crg_install_id
             from utl_text_templates
            cross join adc_rule_groups
            where uttm_type = C_ADC
              and uttm_name = C_UTTM_NAME
              and crg_id = p_crg_id)
    select utl_text.generate_text(cursor(
             select template, crg_id, crg_app_id, crg_page_id, crg_active, crg_with_recursion,
                    -- apex_actions
                    utl_text.generate_text(cursor(
                      select p.template, caa_id, caa_crg_id, caa_caat_id, caa_name, caa_label, caa_context_label,
                             caa_icon, caa_icon_type, caa_title, caa_shortcut, caa_confirm_message_name,
                             adc_util.to_bool(caa_initially_disabled) caa_initially_disabled,
                             adc_util.to_bool(caa_initially_hidden) caa_initially_hidden,
                             caa_href, caa_action, caa_on_label, caa_off_label, caa_get, caa_set, caa_choices,
                             caa_label_classes, caa_label_start_classes, caa_label_end_classes, caa_item_wrap_class,
                             -- apex_action_items
                             utl_text.generate_text(cursor(
                               select p.template, caai_caa_id, caai_cpi_crg_id, caai_cpi_id,
                                      adc_util.to_bool(caai_active) caai_active
                                 from adc_apex_action_items sai
                                 join params p
                                   on p.uttm_mode = 'APEX_ACTION_ITEM'
                                where caai_caa_id = saa.caa_id
                             )) apex_action_items
                        from adc_apex_actions_v saa
                        join params p
                          on p.uttm_mode = 'APEX_ACTION_' || saa.caa_caat_id
                       where caa_crg_id = crg_id
                    )) apex_actions,
                    -- rules
                    utl_text.generate_text(cursor(
                      select p.template, cru_id, cru_crg_id, cru_name, cru_condition, cru_sort_seq,
                             cru_firing_items, adc_util.to_bool(cru_active) cru_active,
                             adc_util.to_bool(cru_fire_on_page_load) cru_fire_on_page_load,
                             -- rule actions
                             utl_text.generate_text(cursor(
                               select p.template, cra_id, cra_crg_id, cra_cru_id, cra_cpi_id, cra_cat_id,
                                      adc_util.to_bool(cra_on_error) cra_on_error,
                                      cra_param_1, cra_param_2, cra_param_3, cra_comment, cra_sort_seq,
                                      adc_util.to_bool(cra_raise_recursive) cra_raise_recursive,
                                      adc_util.to_bool(cra_raise_on_validation) cra_raise_on_validation,
                                      adc_util.to_bool(cra_active) cra_active
                                 from adc_rule_actions a
                                cross join params p
                                where uttm_mode = 'RULE_ACTION'
                                  and cra_cru_id = r.cru_id
                             )) rule_actions
                        from adc_rules r
                        join params p
                          on r.cru_crg_id = p.crg_id
                       where p.uttm_mode = 'RULE'
                    )) rules
               from dual)) resultat
      into l_stmt
      from params p
     where uttm_mode = g_mode;
     
    if p_mode = C_APEX_APP then
      l_stmt := replace(replace(utl_text.wrap_string(l_stmt), ' ||', ','), '\CR\');
      select utl_text.generate_text(cursor(
               select uttm_text template, crg_id * crg_id crg_id_square, lower(page_alias) crg_page_alias, 
                      crg_sort_seq, p_install_id crg_install_id
                 from (select cgr.*, rank() over (partition by crg_app_id order by crg_page_id) * 10 crg_sort_seq
                         from adc_rule_groups cgr)
                 join apex_application_pages
                   on crg_app_id = application_id
                  and crg_page_id = page_id
                where crg_id = p_crg_id)) frame
        into l_stmt_frame
        from utl_text_templates
       where uttm_type = C_ADC
         and uttm_name = C_UTTM_NAME
         and uttm_mode = 'DEFAULT_APP_FRAME';
      l_stmt := utl_text.clob_replace(l_stmt_frame, '#CRG_SCRIPT#', l_stmt);
    end if;
    return l_stmt;
  end export_rule_group;
  

  /**
    Function: export_rule_groups
      See <ADC_ADMIN.export_rule_groups>
   */ 
  function export_rule_groups(
    p_crg_app_id in adc_rule_groups.crg_app_id%type default null,
    p_crg_page_id in adc_rule_groups.crg_page_id%type default null,
    p_mode in varchar2 default C_APP_GROUPS)
    return blob
  as
    cursor rule_group_cur(
      p_crg_app_id in adc_rule_groups.crg_app_id%type,
      p_crg_page_id in adc_rule_groups.crg_page_id%type) 
    is
      select crg_id, lower(a.alias || '_' || p.page_alias) crg_file_name
        from adc_rule_groups
        join apex_applications a
          on crg_app_id = a.application_id
        join apex_application_pages p
          on crg_app_id = p.application_id
         and crg_page_id = p.page_id
       where (crg_app_id = p_crg_app_id or p_crg_app_id is null)
         and (crg_page_id = p_crg_page_id or p_crg_page_id is null)
       order by p.page_id;
    
    l_zip_file blob;
    l_clob clob;
    l_blob blob;
    l_file_name varchar2(100);
    
    l_crg_app_id adc_rule_groups.crg_app_id%type;
    l_crg_page_id adc_rule_groups.crg_page_id%type;
    l_install_id number;
  begin
    pit.enter_mandatory(
      p_params => msg_params(
                    msg_param('p_crg_app_id', p_crg_app_id),
                    msg_param('p_crg_page_id', p_crg_page_id),
                    msg_param('p_mode', p_mode)));
    
    -- Initialize
    dbms_lob.createtemporary(l_clob, false, dbms_lob.call);
    l_crg_app_id := p_crg_app_id;
    l_crg_page_id := p_crg_page_id;
    
    if p_mode = C_APEX_APP then
      l_install_id := trunc(dbms_random.value * 100000000);
    end if;
                    
    validate_export_rule_groups(
      p_crg_app_id => l_crg_app_id,
      p_crg_page_id => l_crg_page_id,
      p_mode => p_mode);      
    
    if p_mode = C_APEX_APP then
      -- Get all rule groups
      for cgr in rule_group_cur(l_crg_app_id, l_crg_page_id) loop
        dbms_lob.append(
          l_clob, 
          export_rule_group(
            p_crg_id => cgr.crg_id,
            p_mode => p_mode,
            p_install_id => l_install_id));
      end loop;
         
      l_clob := integrate_rule_groups_into_app(
                  p_crg_app_id => p_crg_app_id, 
                  p_rule_group => l_clob,
                  p_install_id => l_install_id);
      l_blob := utl_text.clob_to_blob(l_clob);
      
      apex_zip.add_file(
        p_zipped_blob => l_zip_file,
        p_file_name => 'application.sql',
        p_content => l_blob);   
    else   
      for cgr in rule_group_cur(l_crg_app_id, l_crg_page_id) loop
      
        l_blob := utl_text.clob_to_blob(
                    export_rule_group(
                      p_crg_id => cgr.crg_id,
                      p_mode => p_mode));
                  
        l_file_name := replace(g_rule_group_filename, '#CRG_FILE_NAME#', cgr.crg_file_name);
     
        apex_zip.add_file(
          p_zipped_blob => l_zip_file,
          p_file_name => l_file_name,
          p_content => l_blob);
  
      end loop;
    end if;
    
    apex_zip.finish(l_zip_file);

    pit.leave_mandatory(
      p_params => msg_params(
                    msg_param('ZIP file size', dbms_lob.getlength(l_zip_file))));
    return l_zip_file;
  end export_rule_groups;


  /**
    Procedure: prepare_rule_group_import
      See <ADC_ADMIN.prepare_rule_group_import>
   */ 
  procedure prepare_rule_group_import(
    p_workspace in varchar2,
    p_app_alias in varchar2)
  as
    l_ws_id apex_applications.workspace_id%type;
    l_app_id apex_applications.application_id%type;
  begin
    pit.enter_mandatory(
      p_params => msg_params(
                    msg_param('p_workspace', p_workspace),
                    msg_param('p_app_alias', p_app_alias)));

    select workspace_id, application_id
      into l_ws_id, l_app_id
      from apex_applications
     where alias = p_app_alias
       and workspace = p_workspace;

    apex_application_install.set_workspace_id(l_ws_id);
    apex_application_install.set_application_id(l_app_id + g_offset);

    pit.leave_mandatory;
  exception
    when no_data_found then
      pit.warn(msg.ADC_NO_RULE_GROUP_FOUND, msg_args(p_workspace, p_app_alias));
      pit.leave_mandatory;
  end prepare_rule_group_import;


  /**
    Procedure: prepare_rule_group_import
      See <ADC_ADMIN.prepare_rule_group_import>
   */ 
  procedure prepare_rule_group_import(
    p_workspace in varchar2,
    p_app_id in adc_rule_groups.crg_app_id%type)
  as
    l_ws_id apex_applications.workspace_id%type;
  begin
    pit.enter_mandatory(
      p_params => msg_params(
                    msg_param('p_workspace', p_workspace),
                    msg_param('p_app_id', p_app_id)));

    select workspace_id
      into l_ws_id
      from apex_applications
     where application_id = p_app_id
       and workspace = p_workspace;

    apex_application_install.set_workspace_id(l_ws_id);
    apex_application_install.set_application_id(p_app_id + g_offset);

    pit.leave_mandatory;
  end prepare_rule_group_import;


  /**
    Procedure: prepare_rule_group_import
      See <ADC_ADMIN.prepare_rule_group_import>
   */
  procedure prepare_rule_group_import(
    p_crg_app_id in adc_rule_groups.crg_app_id%type,
    p_crg_page_id in adc_rule_groups.crg_page_id%type)
  as
  begin
    pit.enter_mandatory('prepare_rule_group_import', 
      p_params => msg_params(
                    msg_param('p_crg_app_id', p_crg_app_id),
                    msg_param('p_crg_page_id', p_crg_page_id)));

    -- Recursively delete any existing rulegroup with same APP_ID and PAGE_ID
    delete from adc_rule_groups
     where crg_app_id = p_crg_app_id
       and crg_page_id = p_crg_page_id;

    pit.leave_mandatory;
  end prepare_rule_group_import;


  /**
    Group: Public Methods - Rule Methods
   */
  /**
    Procedure: merge_rule
      See <ADC_ADMIN.merge_rule>
   */ 
  procedure merge_rule(
    p_cru_id in adc_rules.cru_id%type default null,
    p_cru_crg_id in adc_rules.cru_crg_id%type,
    p_cru_name in adc_rules.cru_name%type,
    p_cru_condition in adc_rules.cru_condition%type,
    p_cru_fire_on_page_load in adc_rules.cru_fire_on_page_load%type,
    p_cru_sort_seq in adc_rules.cru_sort_seq%type,
    p_cru_active in adc_rules.cru_active%type default adc_util.C_TRUE)
  as
    l_row adc_rules%rowtype;
  begin
    pit.enter_mandatory('merge_rule',
      p_params => msg_params(
                    msg_param('p_cru_id', p_cru_id),
                    msg_param('p_cru_crg_id', p_cru_crg_id),
                    msg_param('p_cru_name', p_cru_name),
                    msg_param('p_cru_condition', p_cru_condition),
                    msg_param('p_cru_fire_on_page_load', p_cru_fire_on_page_load),
                    msg_param('p_cru_sort_seq', p_cru_sort_seq),
                    msg_param('p_cru_active', p_cru_active)));
                    
      l_row.cru_id := p_cru_id;
      l_row.cru_crg_id := p_cru_crg_id;
      l_row.cru_name := p_cru_name;
      l_row.cru_condition := p_cru_condition;
      l_row.cru_fire_on_page_load := p_cru_fire_on_page_load;
      l_row.cru_sort_seq := p_cru_sort_seq;
      l_row.cru_active := p_cru_active;
      
    merge_rule(l_row);
      
    pit.leave_mandatory;
  end merge_rule;


  /**
    Procedure: merge_rule
      See <ADC_ADMIN.merge_rule>
   */ 
  procedure merge_rule(
    p_row in out nocopy adc_rules%rowtype)
  as
  begin
    pit.enter_mandatory;
    
    validate_rule(p_row);
    
    get_key(p_row.cru_id);
    
    merge into adc_rules t
    using (select p_row.cru_id cru_id,
                  p_row.cru_crg_id cru_crg_id,
                  p_row.cru_name cru_name,
                  p_row.cru_condition cru_condition,
                  p_row.cru_fire_on_page_load cru_fire_on_page_load,
                  p_row.cru_sort_seq cru_sort_seq,
                  p_row.cru_active cru_active
             from dual) s
       on (t.cru_id = s.cru_id
       and t.cru_crg_id = s.cru_crg_id)
     when matched then update set
          t.cru_name = s.cru_name,
          t.cru_condition = s.cru_condition,
          t.cru_fire_on_page_load = s.cru_fire_on_page_load,
          t.cru_sort_seq = s.cru_sort_seq,
          t.cru_active = s.cru_active
     when not matched then insert(cru_id, cru_crg_id, cru_name, cru_condition, cru_fire_on_page_load, cru_sort_seq, cru_active)
          values (s.cru_id, s.cru_crg_id, s.cru_name, s.cru_condition, s.cru_fire_on_page_load, s.cru_sort_seq, s.cru_active);

    pit.leave_mandatory;
  exception
    when others then
      pit.handle_exception(msg.ADC_MERGE_RULE, msg_args(p_row.cru_name));
  end merge_rule;


  /**
    Procedure: delete_rule
      See <ADC_ADMIN.delete_rule>
   */ 
  procedure delete_rule(
    p_cru_id in adc_rules.cru_id%type)
  as
    l_row adc_rules%rowtype;
  begin
    pit.enter_mandatory;
    
    l_row.cru_id := p_cru_id;
    
    delete_rule(l_row);

    pit.leave_mandatory;
  end delete_rule;


  /**
    Procedure: delete_rule
      See <ADC_ADMIN.delete_rule>
   */ 
  procedure delete_rule(
    p_row in adc_rules%rowtype)
  as
  begin
    pit.enter_mandatory;

    delete from adc_rules
     where cru_id = p_row.cru_id;

    pit.leave_mandatory;
  end delete_rule;
  
  
  /**
    Procedure: validate_rule_condition
      See <ADC_ADMIN.validate_rule_condition>
   */ 
  procedure validate_rule_condition(
    p_row in adc_rules%rowtype)
  as
    C_UTTM_NAME constant adc_util.ora_name_type := 'RULE_VALIDATION';
    l_data_cols utl_apex.max_char;
    l_stmt utl_apex.max_char;
    l_ctx pls_integer;
  begin
    pit.enter_mandatory('validate_rule_condition');
    
    pit.assert_not_null(p_row.cru_condition, msg.ADC_PARAM_MISSING, p_error_code => 'CRU_CONDITION_MISSING');

    harmonize_adc_page_item(p_row.cru_crg_id, p_row.cru_condition);

    -- create validation statement
    with params as(
           select /*+ no_merge */ uttm_text template, uttm_mode,
                  p_row.cru_crg_id crg_id,
                  p_row.cru_condition condition,
                  adc_util.c_true c_true,
                  adc_util.C_CR cr
             from utl_text_templates
            where uttm_type = C_ADC
              and uttm_name in (C_UTTM_NAME, 'RULE_VIEW'))
    select utl_text.generate_text(cursor(
             select p.template, p.condition,
                    -- Events
                    utl_text.generate_text(cursor(
                      select template, cet_id, lower(cet_column_name) cet_column_name
                        from adc_event_types_v
                        join params
                          on uttm_mode = case cet_is_custom_event when c_true then 'EVENT' else upper(cet_id) end
                       where (cet_is_custom_event = c_true
                          or cet_id in ('initialize', 'command'))
                       order by case cet_is_custom_event when c_true then 1 else 0 end, cet_id), ',' || CR, 14) event_list,
                    -- Column List
                    utl_text.generate_text(cursor(
                      select cpit_col_template template,
                             replace(cpi_conversion, 'G') conversion,
                             cpi_id item,
                             cpit_cet_id
                        from adc_page_item_types_v sit
                        left join (
                               select cpi_id, cpi_cpit_id, cpi_conversion, cpi_is_required
                                 from adc_page_items
                                where cpi_crg_id = crg_id) cpi
                          on sit.cpit_id = cpi.cpi_cpit_id
                       where adc_util.C_TRUE in (cpi_is_required, cpit_include_in_view)
                         and cpit_col_template is not null
                      order by cpit_include_in_view desc, cpi_id), ',' || CR, 14) column_list
               from dual)) resultat
      into l_stmt
      from params p
     where uttm_mode = C_DEFAULT;

    -- perform validation
    begin
      l_ctx := dbms_sql.open_cursor;
      dbms_sql.parse(l_ctx, l_stmt, dbms_sql.native);
      dbms_sql.close_cursor(l_ctx);
    exception
      when others then
        if dbms_sql.is_open(l_ctx) then
          dbms_sql.close_cursor(l_ctx);
        end if;
        pit.error(msg.ADC_INVALID_SQL, msg_args(substr(sqlerrm, 12)));
    end;
    
    pit.leave_mandatory;
  end validate_rule_condition;
  

  /**
    Procedure: validate_rule
      See <ADC_ADMIN.validate_rule>
   */ 
  procedure validate_rule(
    p_row in adc_rules%rowtype)
  as
  begin
    pit.enter_mandatory;
    
    pit.assert_not_null(p_row.cru_crg_id, msg.ADC_PARAM_MISSING, p_error_code => 'CRU_CRG_ID_MISSING');
    pit.assert_not_null(p_row.cru_name, msg.ADC_PARAM_MISSING, p_error_code => 'CRU_NAME_MISSING');

    validate_rule_condition(p_row);
    
    pit.leave_mandatory;
  end validate_rule;


  /**
    Procedure: resequence_rule
      See <ADC_ADMIN.resequence_rule>
   */ 
  procedure resequence_rule(
    p_cru_id in adc_rules.cru_id%type)
  as
    l_crg_id adc_rule_groups.crg_id%type;
  begin
    pit.enter_optional(p_params => msg_params(msg_param('p_cru_id', p_cru_id)));
    
    begin
      select cru_crg_id
        into l_crg_id
        from adc_rules
       where cru_id = p_cru_id;
    exception
      when no_data_found then
        l_crg_id := p_cru_id;
    end;

    -- resequence rules
    merge into adc_rules t
    using (select cru_id, cru_crg_id,
                  row_number() over (partition by cru_crg_id order by cru_sort_seq) * 10 cru_sort_seq
             from adc_rules
            where cru_crg_id = l_crg_id
              and cru_crg_id > 0) s
       on (t.cru_id = s.cru_id and t.cru_crg_id = s.cru_crg_id)
     when matched then update set
          t.cru_sort_seq = s.cru_sort_seq;

    -- resequence rule actions
    merge into adc_rule_actions t
    using (select cra_id,
                  row_number() over (partition by cra_cru_id order by cra_on_error, cra_sort_seq) * 10 cra_sort_seq
             from adc_rule_actions
            where cra_crg_id = l_crg_id) s
       on (t.cra_id = s.cra_id)
     when matched then update set
          t.cra_sort_seq = s.cra_sort_seq;

    -- Is called outside the request-response-cycle, so commit explicitly
    commit;

    pit.leave_optional;
  end resequence_rule;


  /**
    Group: Public Methods - Rule Action Methods
   */
  /**
    Procedure: merge_rule_action
      See <ADC_ADMIN.merge_rule_action>
   */
  procedure merge_rule_action(
    p_cra_id in adc_rule_actions.cra_id%type,
    p_cra_cru_id in adc_rule_actions.cra_cru_id%type,
    p_cra_crg_id in adc_rule_actions.cra_crg_id%type,
    p_cra_cpi_id in adc_rule_actions.cra_cpi_id%type,
    p_cra_cat_id in adc_rule_actions.cra_cat_id%type,
    p_cra_sort_seq in adc_rule_actions.cra_sort_seq%type,
    p_cra_param_1 in adc_rule_actions.cra_param_1%type default null,
    p_cra_param_2 in adc_rule_actions.cra_param_2%type default null,
    p_cra_param_3 in adc_rule_actions.cra_param_3%type default null,
    p_cra_on_error in adc_rule_actions.cra_on_error%type default adc_util.C_FALSE,
    p_cra_raise_recursive in adc_rule_actions.cra_raise_recursive%type default adc_util.C_TRUE,
    p_cra_raise_on_validation in adc_rule_actions.cra_raise_on_validation%type default adc_util.C_FALSE,
    p_cra_active in adc_rule_actions.cra_active%type default adc_util.C_TRUE,
    p_cra_comment in adc_rule_actions.cra_comment%type default null)
  as
    l_row adc_rule_actions%rowtype;
  begin
    pit.enter_mandatory(
      p_params => msg_params(
                    msg_param('p_cra_id', p_cra_id),
                    msg_param('p_cra_cru_id', p_cra_cru_id),
                    msg_param('p_cra_crg_id', p_cra_crg_id),
                    msg_param('p_cra_cpi_id', p_cra_cpi_id),
                    msg_param('p_cra_cat_id', p_cra_cat_id),
                    msg_param('p_cra_sort_seq', p_cra_sort_seq),
                    msg_param('p_cra_param_1', p_cra_param_1),
                    msg_param('p_cra_param_2', p_cra_param_2),
                    msg_param('p_cra_param_3', p_cra_param_3),
                    msg_param('p_cra_on_error', p_cra_on_error),
                    msg_param('p_cra_raise_recursive', p_cra_raise_recursive),
                    msg_param('p_cra_raise_on_validation', p_cra_raise_on_validation),
                    msg_param('p_cra_active', p_cra_active),
                    msg_param('p_cra_comment', p_cra_comment)));
    
    l_row.cra_id := p_cra_id;
    l_row.cra_cru_id := p_cra_cru_id;
    l_row.cra_crg_id := p_cra_crg_id;
    l_row.cra_cpi_id := p_cra_cpi_id;
    l_row.cra_cat_id := p_cra_cat_id;
    l_row.cra_sort_seq := p_cra_sort_seq;
    l_row.cra_param_1 := p_cra_param_1;
    l_row.cra_param_2 := p_cra_param_2;
    l_row.cra_param_3 := p_cra_param_3;
    l_row.cra_on_error := adc_util.get_boolean(p_cra_on_error);
    l_row.cra_raise_recursive := adc_util.get_boolean(p_cra_raise_recursive);
    l_row.cra_raise_on_validation := adc_util.get_boolean(p_cra_raise_on_validation);
    l_row.cra_active := adc_util.get_boolean(p_cra_active);
    l_row.cra_comment := p_cra_comment;

    merge_rule_action(l_row);
    
    pit.leave_mandatory;
  exception
    when others then
      pit.stop(msg.ADC_MERGE_RULE_ACTION, msg_args(to_char(p_cra_cru_id), to_char( p_cra_cpi_id)));
  end merge_rule_action;


  /**
    Procedure: merge_rule_action
      See <ADC_ADMIN.merge_rule_action>
   */
  procedure merge_rule_action(
    p_row in out nocopy adc_rule_actions%rowtype)
  as
  begin
    pit.enter_mandatory;
    
    validate_rule_action(p_row);
    
    get_key(p_row.cra_id);
    
    merge into adc_rule_actions t
    using (select p_row.cra_id cra_id,
                  p_row.cra_cru_id cra_cru_id,
                  p_row.cra_crg_id cra_crg_id,
                  p_row.cra_cpi_id cra_cpi_id,
                  p_row.cra_cat_id cra_cat_id,
                  p_row.cra_sort_seq cra_sort_seq,
                  p_row.cra_param_1 cra_param_1,
                  p_row.cra_param_2 cra_param_2,
                  p_row.cra_param_3 cra_param_3,
                  p_row.cra_on_error cra_on_error,
                  p_row.cra_raise_recursive cra_raise_recursive,
                  p_row.cra_raise_on_validation cra_raise_on_validation,
                  p_row.cra_active cra_active,
                  p_row.cra_comment cra_comment
             from dual) s
       on (t.cra_id = s.cra_id)
     when matched then update set
          t.cra_cpi_id = s.cra_cpi_id,
          t.cra_cat_id = s.cra_cat_id,
          t.cra_sort_seq = s.cra_sort_seq,
          t.cra_param_1 = s.cra_param_1,
          t.cra_param_2 = s.cra_param_2,
          t.cra_param_3 = s.cra_param_3,
          t.cra_on_error = s.cra_on_error,
          t.cra_raise_recursive = s.cra_raise_recursive,
          t.cra_raise_on_validation = s.cra_raise_on_validation,
          t.cra_active = s.cra_active,
          t.cra_comment = s.cra_comment
     when not matched then insert (
            cra_id, cra_cru_id, cra_crg_id, cra_cpi_id, cra_cat_id, cra_sort_seq, cra_param_1, cra_param_2, cra_param_3,
            cra_on_error, cra_raise_recursive, cra_raise_on_validation, cra_active, cra_comment)
          values(
            s.cra_id, s.cra_cru_id, s.cra_crg_id, s.cra_cpi_id, s.cra_cat_id, s.cra_sort_seq, s.cra_param_1, s.cra_param_2, s.cra_param_3,
            s.cra_on_error, s.cra_raise_recursive, s.cra_raise_on_validation, s.cra_active, s.cra_comment);

    pit.leave_mandatory;
  end merge_rule_action;


  /**
    Procedure: delete_rule_action
      See <ADC_ADMIN.delete_rule_action>
   */
  procedure delete_rule_action(
    p_cra_id in adc_rule_actions.cra_id%type)
  as
    l_row adc_rule_actions%rowtype;
  begin
    pit.enter_mandatory(
      p_params => msg_params(
                    msg_param('p_cra_id', to_char(p_cra_id))));

    l_row.cra_id := p_cra_id;
    
    delete_rule_action(l_row);
    
    pit.leave_mandatory;
  end delete_rule_action;


  /**
    Procedure: delete_rule_action
      See <ADC_ADMIN.delete_rule_action>
   */
  procedure delete_rule_action(
    p_row in adc_rule_actions%rowtype)
  as
  begin
    pit.enter_optional;

    delete from adc_rule_actions
     where cra_id = p_row.cra_id;
    
    pit.leave_optional;
  end delete_rule_action;
  
  
  /**
    Procedure: validate_rule_action
      See <ADC_ADMIN.validate_rule_action>
   */
  procedure validate_rule_action(
    p_row in adc_rule_actions%rowtype)
  as
    l_cur sys_refcursor;
  begin
    pit.enter_optional;
    
    pit.assert_not_null(p_row.cra_cru_id, msg.ADC_PARAM_MISSING, p_error_code => 'CRA_CRU_ID_MISSING');
    pit.assert_not_null(p_row.cra_crg_id, msg.ADC_PARAM_MISSING, p_error_code => 'CRA_CRG_ID_MISSING');
    pit.assert_not_null(p_row.cra_cpi_id, msg.ADC_PARAM_MISSING, p_error_code => 'CRA_CPI_ID_MISSING');
    pit.assert_not_null(p_row.cra_cat_id, msg.ADC_PARAM_MISSING, p_error_code => 'CRA_CAT_ID_MISSING');
    
    if p_row.cra_id is null then
      open l_cur for
        select null
          from adc_rule_actions
         where cra_crg_id = p_row.cra_crg_id
           and cra_cru_id = p_row.cra_cru_id
           and cra_cpi_id = p_row.cra_cpi_id
           and cra_cat_id = p_row.cra_cat_id
           and cra_on_error = p_row.cra_on_error;
      pit.assert_not_exists(l_cur, msg.ADC_RULE_ACTION_EXISTS);
    end if;
    
    pit.leave_optional;
  end validate_rule_action;
  
  
  /**
    Group: Public Methods - Action Type Methods
   */
  /**
    Procedure: merge_action_type_group
      See <ADC_ADMIN.merge_action_type_group>
   */ 
  procedure merge_action_type_group(
    p_catg_id in adc_action_type_groups_v.catg_id%type,
    p_catg_name in adc_action_type_groups_v.catg_name%type,
    p_catg_description in adc_action_type_groups_v.catg_description%type,
    p_catg_active in adc_action_type_groups_v.catg_active%type default adc_util.C_TRUE)
  as
    l_row adc_action_type_groups_v%rowtype;
  begin
    pit.enter_mandatory(
      p_params => msg_params(
                    msg_param('p_catg_id', p_catg_id),
                    msg_param('p_catg_name', p_catg_name),
                    msg_param('p_catg_description', p_catg_description),
                    msg_param('p_catg_active', p_catg_active)));
                    
    l_row.catg_id := p_catg_id;
    l_row.catg_name := p_catg_name;
    l_row.catg_description := utl_text.unwrap_string(p_catg_description);
    l_row.catg_active := adc_util.get_boolean(p_catg_active);
    
    merge_action_type_group(l_row);

    pit.leave_mandatory;
  end merge_action_type_group;


  /**
    Procedure: merge_action_type_group
      See <ADC_ADMIN.merge_action_type_group>
   */ 
  procedure merge_action_type_group(
    p_row in out nocopy adc_action_type_groups_v%rowtype)
  as
    l_pti_id pit_translatable_item.pti_id%type;
  begin
    pit.enter_mandatory;
    
    validate_action_type_group(p_row);

    -- maintain translatable item
    l_pti_id := 'CATG_' || p_row.catg_id;
    pit_admin.merge_translatable_item(
      p_pti_id => l_pti_id,
      p_pti_pml_name => null,
      p_pti_pmg_name => C_ADC,
      p_pti_name => p_row.catg_name,
      p_pti_description => p_row.catg_description);

    -- store local data
    merge into adc_action_type_groups t
    using (select p_row.catg_id catg_id,
                  l_pti_id catg_pti_id,
                  C_ADC catg_pmg_name,
                  p_row.catg_active catg_active
             from dual) s
       on (t.catg_id = s.catg_id)
     when matched then update set
          t.catg_active = s.catg_active
     when not matched then insert(catg_id, catg_pti_id, catg_pmg_name, catg_active)
          values(s.catg_id, s.catg_pti_id, s.catg_pmg_name, s.catg_active);
    
    pit.leave_mandatory;
  end merge_action_type_group;


  /**
    Procedure: delete_action_type_group
      See <ADC_ADMIN.delete_action_type_group>
   */ 
  procedure delete_action_type_group(
    p_catg_id in adc_action_type_groups_v.catg_id%type)
  as
    l_row adc_action_type_groups_v%rowtype;
  begin
    pit.enter_mandatory(
      p_params => msg_params(
                    msg_param('p_catg_id', p_catg_id)));
    
    l_row.catg_id := p_catg_id;
    
    delete_action_type_group(l_row);
    
    pit.leave_mandatory;
  end delete_action_type_group;


  /**
    Procedure: delete_action_type_group
      See <ADC_ADMIN.delete_action_type_group>
   */ 
  procedure delete_action_type_group(
    p_row in adc_action_type_groups_v%rowtype)
  as
  begin
    pit.enter_mandatory;
                    
    delete from adc_action_type_groups
     where catg_id = p_row.catg_id;
    
    pit.leave_mandatory;
  end delete_action_type_group;


  /**
    Procedure: validate_action_type_group
      See <ADC_ADMIN.validate_action_type_group>
   */ 
  procedure validate_action_type_group(
    p_row in adc_action_type_groups_v%rowtype)
  as
  begin
    pit.enter_mandatory;
    
    pit.assert_not_null(p_row.catg_id, msg.ADC_PARAM_MISSING, p_error_code => 'CATG_ID_MISSING');
    pit.assert_not_null(p_row.catg_name, msg.ADC_PARAM_MISSING, p_error_code => 'CATG_NAME_MISSING');
    
    pit.leave_mandatory;
  end validate_action_type_group;
  
    
  /**
    Procedure: merge_action_type_owner
      See <ADC_ADMIN.merge_action_type_owner>
   */ 
  procedure merge_action_type_owner(
    p_cato_id in adc_action_type_owners_v.cato_id%type,
    p_cato_description in adc_action_type_owners_v.cato_description%type,
    p_cato_active in adc_action_type_owners_v.cato_active%type default adc_util.C_TRUE)
  as
    l_row adc_action_type_owners_v%rowtype;
  begin
    pit.enter_mandatory(
      p_params => msg_params(
                    msg_param('p_cato_id', p_cato_id),
                    msg_param('p_cato_description', p_cato_description),
                    msg_param('p_cato_active', p_cato_active)));
                    
    l_row.cato_id := p_cato_id;
    l_row.cato_description := utl_text.unwrap_string(p_cato_description);
    l_row.cato_active := adc_util.get_boolean(p_cato_active);
    
    merge_action_type_owner(l_row);

    pit.leave_mandatory;
  end merge_action_type_owner;


  /**
    Procedure: merge_action_type_owner
      See <ADC_ADMIN.merge_action_type_owner>
   */ 
  procedure merge_action_type_owner(
    p_row in out nocopy adc_action_type_owners_v%rowtype)
  as
    l_pti_id pit_translatable_item.pti_id%type;
  begin
    pit.enter_mandatory;
    
    validate_action_type_owner(p_row);

    -- store local data
    merge into adc_action_type_owners t
    using (select p_row.cato_id cato_id,
                  p_row.cato_description cato_description,
                  p_row.cato_active cato_active
             from dual) s
       on (t.cato_id = s.cato_id)
     when matched then update set
          t.cato_active = s.cato_active
     when not matched then insert(cato_id, cato_description, cato_active)
          values(s.cato_id, s.cato_description, s.cato_active);
    
    pit.leave_mandatory;
  end merge_action_type_owner;


  /**
    Procedure: delete_action_type_owner
      See <ADC_ADMIN.delete_action_type_owner>
   */ 
  procedure delete_action_type_owner(
    p_cato_id in adc_action_type_owners_v.cato_id%type)
  as
    l_row adc_action_type_owners_v%rowtype;
  begin
    pit.enter_mandatory(
      p_params => msg_params(
                    msg_param('p_cato_id', p_cato_id)));
    
    l_row.cato_id := p_cato_id;
    
    delete_action_type_owner(l_row);
    
    pit.leave_mandatory;
  end delete_action_type_owner;


  /**
    Procedure: delete_action_type_owner
      See <ADC_ADMIN.delete_action_type_owner>
   */ 
  procedure delete_action_type_owner(
    p_row in adc_action_type_owners_v%rowtype)
  as
  begin
    pit.enter_mandatory;
                    
    delete from adc_action_type_owners
     where cato_id = p_row.cato_id;
    
    pit.leave_mandatory;
  end delete_action_type_owner;


  /**
    Procedure: validate_action_type_owner
      See <ADC_ADMIN.validate_action_type_owner>
   */ 
  procedure validate_action_type_owner(
    p_row in adc_action_type_owners_v%rowtype)
  as
  begin
    pit.enter_mandatory;
    
    pit.assert_not_null(p_row.cato_id, msg.ADC_PARAM_MISSING, p_error_code => 'CATO_ID_MISSING');
    
    pit.leave_mandatory;
  end validate_action_type_owner;
  
  
  /**
    Procedure: merge_action_param_visual_type
      See <ADC_ADMIN.merge_action_param_visual_type>
   */ 
  procedure merge_action_param_visual_type(
    p_capvt_id in adc_action_param_visual_types_v.capvt_id%type,
    p_capvt_name in adc_action_param_visual_types_v.capvt_name%type,
    p_capvt_display_name in adc_action_param_visual_types_v.capvt_display_name%type default null,
    p_capvt_description in adc_action_param_visual_types_v.capvt_description%type default null,
    p_capvt_param_item_extension in adc_action_param_visual_types_v.capvt_param_item_extension%type default null,
    p_capvt_sort_seq in adc_action_param_visual_types_v.capvt_sort_seq%type default 10,
    p_capvt_active in adc_action_param_visual_types_v.capvt_active%type default ADC_UTIL.C_TRUE)
  as
    l_row adc_action_param_visual_types_v%rowtype;
  begin
    pit.enter_mandatory(
      p_params => msg_params(
                    msg_param('p_capvt_id', p_capvt_id),
                    msg_param('p_capvt_name', p_capvt_name),
                    msg_param('p_capvt_display_name', p_capvt_display_name),
                    msg_param('p_capvt_description', p_capvt_description),
                    msg_param('p_capvt_param_item_extension', p_capvt_param_item_extension),
                    msg_param('p_capvt_sort_seq', p_capvt_sort_seq),
                    msg_param('p_capvt_active', p_capvt_active)));
                    
    l_row.capvt_id := p_capvt_id;
    l_row.capvt_name := p_capvt_name;
    l_row.capvt_display_name := p_capvt_display_name;
    l_row.capvt_description := utl_text.unwrap_string(p_capvt_description);
    l_row.capvt_param_item_extension := p_capvt_param_item_extension;
    l_row.capvt_sort_seq := p_capvt_sort_seq;
    l_row.capvt_active := adc_util.get_boolean(p_capvt_active);
    
    merge_action_param_visual_type(l_row);
          
    pit.leave_mandatory;
  end merge_action_param_visual_type;


  /**
    Procedure: merge_action_param_visual_type
      See <ADC_ADMIN.merge_action_param_visual_type>
   */ 
  procedure merge_action_param_visual_type(
    p_row in out nocopy adc_action_param_visual_types_v%rowtype)
  as
    l_pti_id pit_translatable_item.pti_id%type;
  begin
    pit.enter_mandatory;
    
    validate_action_param_visual_type(p_row);
    
    -- maintain translatable item
    l_pti_id := 'CAPVT_' || p_row.capvt_id;
    
    pit_admin.merge_translatable_item(
      p_pti_id => l_pti_id,
      p_pti_pml_name => null,
      p_pti_pmg_name => C_ADC,
      p_pti_name => p_row.capvt_name,
      p_pti_display_name => p_row.capvt_display_name,
      p_pti_description => p_row.capvt_description);

    -- store local data
    merge into adc_action_param_visual_types t
    using (select p_row.capvt_id capvt_id,
                  l_pti_id capvt_pti_id,
                  C_ADC capvt_pmg_name,
                  p_row.capvt_param_item_extension capvt_param_item_extension,
                  p_row.capvt_sort_seq capvt_sort_seq,
                  p_row.capvt_active capvt_active
             from dual) s
       on (t.capvt_id = s.capvt_id)
     when matched then update set
          t.capvt_param_item_extension = s.capvt_param_item_extension,
          t.capvt_sort_seq = s.capvt_sort_seq,
          t.capvt_active = s.capvt_active
     when not matched then insert(capvt_id, capvt_pti_id, capvt_pmg_name, capvt_param_item_extension, capvt_sort_seq, capvt_active)
          values(s.capvt_id, s.capvt_pti_id, s.capvt_pmg_name, s.capvt_param_item_extension, s.capvt_sort_seq, s.capvt_active);
    
    pit.leave_mandatory;
  end merge_action_param_visual_type;


  /**
    Procedure: delete_action_param_visual_type
      See <ADC_ADMIN.delete_action_param_visual_type>
   */ 
  procedure delete_action_param_visual_type(
    p_capvt_id in adc_action_param_visual_types_v.capvt_id%type)
  as  
    l_row adc_action_param_visual_types_v%rowtype;
  begin
    pit.enter_mandatory(
      p_params => msg_params(
                    msg_param('p_capvt_id', p_capvt_id)));
    
    l_row.capvt_id := p_capvt_id;
    
    delete_action_param_visual_type(l_row);
    
    pit.leave_mandatory;
  end delete_action_param_visual_type;


  /**
    Procedure: delete_action_param_visual_type
      See <ADC_ADMIN.delete_action_param_visual_type>
   */ 
  procedure delete_action_param_visual_type(
    p_row in adc_action_param_visual_types_v%rowtype)
  as
  begin
    pit.enter_mandatory;
                    
    delete from adc_action_param_visual_types
     where capvt_id = p_row.capvt_id;
    
    pit.leave_mandatory;
  end delete_action_param_visual_type;
  
  
  /**
    Procedure: validate_action_param_visual_type
      See <ADC_ADMIN.validate_action_param_visual_type>
   */ 
  procedure validate_action_param_visual_type(
    p_row in adc_action_param_visual_types_v%rowtype)
  as
  begin
    pit.enter_mandatory;
    
    pit.assert_not_null(p_row.capvt_id, msg.ADC_PARAM_MISSING, p_error_code => 'CAPVT_ID_MISSING');
    pit.assert_not_null(p_row.capvt_name, msg.ADC_PARAM_MISSING, p_error_code => 'CAPVT_NAME_MISSING');
    
    pit.leave_mandatory;
  end validate_action_param_visual_type;
  
  
  /**
    Procedure: merge_action_param_type
      See <ADC_ADMIN.merge_action_param_type>
   */ 
  procedure merge_action_param_type(
    p_capt_id in adc_action_param_types_v.capt_id%type,
    p_capt_name in adc_action_param_types_v.capt_name%type,
    p_capt_display_name in adc_action_param_types_v.capt_display_name%type default null,
    p_capt_description in adc_action_param_types_v.capt_description%type default null,
    p_capt_capvt_id in adc_action_param_types_v.capt_capvt_id%type,
    p_capt_select_list_query in adc_action_param_types_v.capt_select_list_query%type default null, 
    p_capt_select_view_comment in adc_action_param_types_v.capt_select_view_comment%type default null,
    p_capt_sort_seq in adc_action_param_types_v.capt_sort_seq%type default 10,
    p_capt_active in adc_action_param_types_v.capt_active%type default ADC_UTIL.C_TRUE)
  as
    l_row adc_action_param_types_v%rowtype;
  begin
    pit.enter_mandatory(
      p_params => msg_params(
                    msg_param('p_capt_id', p_capt_id),
                    msg_param('p_capt_name', p_capt_name),
                    msg_param('p_capt_display_name', p_capt_display_name),
                    msg_param('p_capt_description', p_capt_description),
                    msg_param('p_capt_capvt_id', p_capt_capvt_id),
                    msg_param('p_capt_select_list_query', p_capt_select_list_query),
                    msg_param('p_capt_select_view_comment', p_capt_select_view_comment),
                    msg_param('p_capt_sort_seq', p_capt_sort_seq),
                    msg_param('p_capt_active', p_capt_active)));
                    
    l_row.capt_id := p_capt_id;
    l_row.capt_name := p_capt_name;
    l_row.capt_display_name := p_capt_display_name;
    l_row.capt_description := utl_text.unwrap_string(p_capt_description);
    l_row.capt_capvt_id := p_capt_capvt_id;
    l_row.capt_select_list_query := utl_text.unwrap_string(p_capt_select_list_query);
    l_row.capt_select_view_comment := utl_text.unwrap_string(p_capt_select_view_comment);
    l_row.capt_sort_seq := p_capt_sort_seq;
    l_row.capt_active := adc_util.get_boolean(p_capt_active);
    
    merge_action_param_type(l_row);
          
    pit.leave_mandatory;
  end merge_action_param_type;


  /**
    Procedure: merge_action_param_type
      See <ADC_ADMIN.merge_action_param_type>
   */ 
  procedure merge_action_param_type(
    p_row in out nocopy adc_action_param_types_v%rowtype)
  as
    l_stmt adc_util.max_char;
    l_pti_id pit_translatable_item.pti_id%type;
  begin
    pit.enter_mandatory;
    
    validate_action_param_type(p_row);
    
    -- maintain translatable item
    l_pti_id := 'CAPT_' || p_row.capt_id;
    
    pit_admin.merge_translatable_item(
      p_pti_id => l_pti_id,
      p_pti_pml_name => null,
      p_pti_pmg_name => C_ADC,
      p_pti_name => p_row.capt_name,
      p_pti_display_name => p_row.capt_display_name,
      p_pti_description => p_row.capt_description);

    -- store local data
    merge into adc_action_param_types t
    using (select p_row.capt_id capt_id,
                  l_pti_id capt_pti_id,
                  C_ADC capt_pmg_name,
                  p_row.capt_capvt_id capt_capvt_id,
                  p_row.capt_sort_seq capt_sort_seq,
                  p_row.capt_active capt_active
             from dual) s
       on (t.capt_id = s.capt_id)
     when matched then update set
          t.capt_capvt_id = s.capt_capvt_id,
          t.capt_sort_seq = s.capt_sort_seq,
          t.capt_active = s.capt_active
     when not matched then insert(capt_id, capt_pti_id, capt_pmg_name, capt_capvt_id, capt_sort_seq, capt_active)
          values(s.capt_id, s.capt_pti_id, s.capt_pmg_name, s.capt_capvt_id, s.capt_sort_seq, s.capt_active);
    
    -- Create generic View statement for static lists (they reference transalatable items)
    l_stmt := adc_parameter.get_param_lov_query(p_row, true);
    if l_stmt is not null then
      execute immediate l_stmt;
    end if;    
    
    pit.leave_mandatory;
  exception
    when others then
      pit.handle_exception(msg.PIT_PASS_MESSAGE, msg_args(sqlerrm || ': ' || l_stmt));
  end merge_action_param_type;


  /**
    Procedure: delete_action_param_type
      See <ADC_ADMIN.delete_action_param_type>
   */ 
  procedure delete_action_param_type(
    p_capt_id in adc_action_param_types_v.capt_id%type)
  as  
    l_row adc_action_param_types_v%rowtype;
  begin
    pit.enter_mandatory(
      p_params => msg_params(
                    msg_param('p_capt_id', p_capt_id)));
    
    l_row.capt_id := p_capt_id;
    
    delete_action_param_type(l_row);
    
    pit.leave_mandatory;
  end delete_action_param_type;


  /**
    Procedure: delete_action_param_type
      See <ADC_ADMIN.delete_action_param_type>
   */ 
  procedure delete_action_param_type(
    p_row in adc_action_param_types_v%rowtype)
  as
    l_has_view binary_integer;
    l_stmt adc_util.sql_char;
  begin
    pit.enter_mandatory;
                    
    delete from adc_action_param_types
     where capt_id = p_row.capt_id;
     
    select count(*)
      into l_has_view
      from user_views
     where exists(
           select null
             from user_views
            where view_name = C_CAPT_VIEW_NAME_PREFIX || p_row.capt_id);
    if l_has_view = 1 then
      l_stmt := 'drop view ' || C_CAPT_VIEW_NAME_PREFIX || p_row.capt_id;
      execute immediate l_stmt;
    end if;
    
    pit.leave_mandatory;
  end delete_action_param_type;
  
  
  /**
    Procedure: validate_action_param_type
      See <ADC_ADMIN.validate_action_param_type>
   */ 
  procedure validate_action_param_type(
    p_row in adc_action_param_types_v%rowtype)
  as
  begin
    pit.enter_mandatory;
    
    pit.assert_not_null(p_row.capt_id, msg.ADC_PARAM_MISSING, p_error_code => 'CAPT_ID_MISSING');
    pit.assert_not_null(p_row.capt_name, msg.ADC_PARAM_MISSING, p_error_code => 'CAPT_NAME_MISSING');
    pit.assert_not_null(p_row.capt_capvt_id, msg.ADC_PARAM_MISSING, p_error_code => 'CAPT_CAPVT_ID_MISSING');
    
    if p_row.capt_capvt_id = 'SELECT_LIST' then
      pit.assert_not_null(p_row.capt_select_list_query, msg.ADC_PARAM_MISSING, p_error_code => 'CAPVT_VIEW_STATEMENT_MISSING');
    end if;
    
    adc_parameter.validate_param_lov(
      p_capt_id => p_row.capt_id,
      p_capt_capvt_id => p_row.capt_capvt_id);
      
    pit.leave_mandatory;
  end validate_action_param_type;

  /**
    Procedure: merge_action_item_focus
      See <ADC_ADMIN.merge_action_item_focus>
   */ 
  procedure merge_action_item_focus(
    p_caif_id in adc_action_item_focus_v.caif_id%type,
    p_caif_name in adc_action_item_focus_v.caif_name%type,
    p_caif_description in adc_action_item_focus_v.caif_description%type,
    p_caif_actual_page_only in adc_action_item_focus_v.caif_actual_page_only%type default adc_util.C_TRUE,
    p_caif_item_types in adc_action_item_focus_v.caif_item_types%type,
    p_caif_default adc_action_item_focus_v.caif_default%type,
    p_caif_active in adc_action_item_focus_v.caif_active%type default adc_util.C_TRUE)
  as
    l_row adc_action_item_focus_v%rowtype;
  begin
    pit.enter_mandatory(
      p_params => msg_params(
                    msg_param('p_caif_id', p_caif_id),
                    msg_param('p_caif_name', p_caif_name),
                    msg_param('p_caif_description', p_caif_description),
                    msg_param('p_caif_actual_page_only', p_caif_actual_page_only),
                    msg_param('p_caif_item_types', p_caif_item_types),
                    msg_param('p_caif_default', p_caif_default),
                    msg_param('p_caif_active', p_caif_active)));
                    
    l_row.caif_id := p_caif_id;
    l_row.caif_name := p_caif_name;
    l_row.caif_description := utl_text.unwrap_string(p_caif_description);
    l_row.caif_actual_page_only := adc_util.get_boolean(p_caif_actual_page_only);
    l_row.caif_item_types := p_caif_item_types;
    l_row.caif_default := p_caif_default;
    l_row.caif_active := adc_util.get_boolean(p_caif_active);
    
    merge_action_item_focus(l_row);
    
    pit.leave_mandatory;
  end merge_action_item_focus;


  /**
    Procedure: merge_action_item_focus
      See <ADC_ADMIN.merge_action_item_focus>
   */ 
  procedure merge_action_item_focus(
    p_row in out nocopy adc_action_item_focus_v%rowtype)
  as
    l_pti_id pit_translatable_item.pti_id%type;
  begin
    pit.enter_mandatory;
    
    validate_action_item_focus(p_row);
                    
    -- maintain translatable item
    l_pti_id := 'CAIF_' || p_row.caif_id;
    pit_admin.merge_translatable_item(
      p_pti_id => l_pti_id,
      p_pti_pml_name => null,
      p_pti_pmg_name => C_ADC,
      p_pti_name => p_row.caif_name,
      p_pti_description => p_row.caif_description);

    -- store local data
    merge into adc_action_item_focus t
    using (select p_row.caif_id caif_id,
                  l_pti_id caif_pti_id,
                  C_ADC caif_pmg_name,
                  p_row.caif_actual_page_only caif_actual_page_only,
                  p_row.caif_item_types caif_item_types,
                  p_row.caif_default caif_default,
                  p_row.caif_active caif_active
             from dual) s
       on (t.caif_id = s.caif_id)
     when matched then update set
          t.caif_actual_page_only = s.caif_actual_page_only,
          t.caif_item_types = s.caif_item_types,
          t.caif_default = s.caif_default,
          t.caif_active = s.caif_active
     when not matched then insert(caif_id, caif_pti_id, caif_pmg_name, caif_actual_page_only, caif_item_types, caif_default, caif_active)
          values(s.caif_id, s.caif_pti_id, s.caif_pmg_name, s.caif_actual_page_only, s.caif_item_types, s.caif_default, s.caif_active);
    
    pit.leave_mandatory;
  end merge_action_item_focus;


  /**
    Procedure: delete_action_item_focus
      See <ADC_ADMIN.delete_action_item_focus>
   */ 
  procedure delete_action_item_focus(
    p_caif_id in adc_action_item_focus_v.caif_id%type)
  as
    l_row adc_action_item_focus_v%rowtype;
  begin
    pit.enter_mandatory(
      p_params => msg_params(
                    msg_param('p_caif_id', p_caif_id)));
    
    l_row.caif_id := p_caif_id;
    
    delete_action_item_focus(l_row);
    
    pit.leave_mandatory;
  end delete_action_item_focus;


  /**
    Procedure: delete_action_item_focus
      See <ADC_ADMIN.delete_action_item_focus>
   */ 
  procedure delete_action_item_focus(
    p_row in adc_action_item_focus_v%rowtype)
  as
  begin
    pit.enter_mandatory;
                    
    delete from adc_action_item_focus
     where caif_id = p_row.caif_id;
    
    pit.leave_mandatory;
  end delete_action_item_focus;
  

  /**
    Procedure: validate_action_item_focus
      See <ADC_ADMIN.validate_action_item_focus>
   */ 
  procedure validate_action_item_focus(
    p_row in adc_action_item_focus_v%rowtype)
  as
  begin
    pit.enter_mandatory;
    
    /** TODO: Add validation */
    
    pit.leave_mandatory;
  end validate_action_item_focus;



  /**
    Procedure: merge_action_type
      See <ADC_ADMIN.merge_action_type>
   */ 
  procedure merge_action_type(
    p_cat_id in adc_action_types_v.cat_id%type,
    p_cat_catg_id in adc_action_types_v.cat_catg_id%type,
    p_cat_caif_id in adc_action_types_v.cat_caif_id%type,
    p_cat_cato_id in adc_action_types_v.cat_cato_id%type,
    p_cat_name in adc_action_types_v.cat_name%type,
    p_cat_display_name in adc_action_types_v.cat_display_name%type default null,
    p_cat_description in adc_action_types_v.cat_description%type default null,
    p_cat_pl_sql in adc_action_types_v.cat_pl_sql%type,
    p_cat_js in adc_action_types_v.cat_js%type,
    p_cat_is_editable in adc_action_types_v.cat_is_editable%type default adc_util.C_TRUE,
    p_cat_raise_recursive in adc_action_types_v.cat_raise_recursive%type default adc_util.C_TRUE,
    p_cat_active in adc_action_types_v.cat_active%type default adc_util.C_TRUE)
  as
    l_row adc_action_types_v%rowtype;
  begin
    pit.enter_mandatory(
      p_params => msg_params(
                    msg_param('p_cat_id', p_cat_id),
                    msg_param('p_cat_catg_id', p_cat_catg_id),
                    msg_param('p_cat_caif_id', p_cat_caif_id),
                    msg_param('p_cat_cato_id', p_cat_cato_id),
                    msg_param('p_cat_name', p_cat_name),
                    msg_param('p_cat_display_name', p_cat_display_name),
                    msg_param('p_cat_description', p_cat_description),
                    msg_param('p_cat_pl_sql', p_cat_pl_sql),
                    msg_param('p_cat_js', p_cat_js),
                    msg_param('p_cat_is_editable', p_cat_is_editable),
                    msg_param('p_cat_raise_recursive', p_cat_raise_recursive),
                    msg_param('p_cat_active', p_cat_active)));
    
    l_row.cat_id := p_cat_id;
    l_row.cat_catg_id := p_cat_catg_id;
    l_row.cat_caif_id := p_cat_caif_id;
    l_row.cat_cato_id := p_cat_cato_id;
    l_row.cat_name := p_cat_name;
    l_row.cat_display_name := p_cat_display_name;
    l_row.cat_description := utl_text.unwrap_string(p_cat_description);
    l_row.cat_pl_sql := utl_text.unwrap_string(p_cat_pl_sql);
    l_row.cat_js := utl_text.unwrap_string(p_cat_js);
    l_row.cat_is_editable := adc_util.get_boolean(p_cat_is_editable);
    l_row.cat_raise_recursive := adc_util.get_boolean(p_cat_raise_recursive);
    l_row.cat_active := adc_util.get_boolean(p_cat_active);
    
    merge_action_type(l_row);
    
    pit.leave_mandatory;
  end merge_action_type;


  /**
    Procedure: merge_action_type
      See <ADC_ADMIN.merge_action_type>
   */ 
  procedure merge_action_type(
    p_row in adc_action_types_v%rowtype)
  as
    l_pti_id pit_translatable_item.pti_id%type;
  begin
    pit.enter_mandatory;

    validate_action_type(p_row);
      
    -- maintain translatable item
    l_pti_id := 'CAT_' || p_row.cat_id;
    pit_admin.merge_translatable_item(
      p_pti_id => l_pti_id,
      p_pti_pml_name => null,
      p_pti_pmg_name => C_ADC,
      p_pti_name => p_row.cat_name,
      p_pti_display_name => p_row.cat_display_name,
      p_pti_description => p_row.cat_description);

    -- store local data
    merge into adc_action_types t
    using (select p_row.cat_id cat_id,
                  p_row.cat_catg_id cat_catg_id,
                  p_row.cat_caif_id cat_caif_id,
                  p_row.cat_cato_id cat_cato_id,
                  l_pti_id cat_pti_id,
                  C_ADC cat_pmg_name,
                  p_row.cat_pl_sql cat_pl_sql,
                  p_row.cat_js cat_js,
                  p_row.cat_is_editable cat_is_editable,
                  p_row.cat_raise_recursive cat_raise_recursive,
                  p_row.cat_active cat_active
             from dual) s
       on (t.cat_id = s.cat_id)
     when matched then update set
          t.cat_catg_id = s.cat_catg_id,
          t.cat_caif_id = s.cat_caif_id,
          t.cat_cato_id = s.cat_cato_id,
          t.cat_pl_sql = s.cat_pl_sql,
          t.cat_js = s.cat_js,
          t.cat_is_editable = s.cat_is_editable,
          t.cat_raise_recursive = s.cat_raise_recursive,
          t.cat_active = s.cat_active
     when not matched then insert(
            cat_id, cat_catg_id, cat_caif_id, cat_cato_id, cat_pti_id, cat_pmg_name, cat_pl_sql, cat_js,
            cat_is_editable, cat_raise_recursive, cat_active)
          values (
            s.cat_id, s.cat_catg_id, s.cat_caif_id, s.cat_cato_id, s.cat_pti_id, s.cat_pmg_name, s.cat_pl_sql, s.cat_js,
            s.cat_is_editable, s.cat_raise_recursive, s.cat_active);
      
    pit.leave_mandatory;
  end merge_action_type;


  /**
    Procedure: delete_action_type
      See <ADC_ADMIN.delete_action_type>
   */ 
  procedure delete_action_type(
    p_cat_id in adc_action_types_v.cat_id%type)
  as
    l_row adc_action_types_v%rowtype;
  begin
    pit.enter_mandatory(
      p_params => msg_params(
                    msg_param('p_cat_id', p_cat_id)));
    
    l_row.cat_id := p_cat_id;
    
    delete_action_type(l_row);
    
    pit.leave_mandatory;
  end delete_action_type;


  /**
    Procedure: delete_action_type
      See <ADC_ADMIN.delete_action_type>
   */
  procedure delete_action_type(
    p_row in adc_action_types_v%rowtype)
  as
  begin
    pit.enter_mandatory;
                    
    delete from adc_action_types
     where cat_id = p_row.cat_id;
      
    pit.leave_mandatory;
  end delete_action_type;
  

  /**
    Procedure: validate_action_type
      See <ADC_ADMIN.validate_action_type>
   */
  procedure validate_action_type(
    p_row in adc_action_types_v%rowtype)
  as
  begin
    pit.enter_mandatory;
  
    pit.assert_not_null(p_row.cat_id, msg.ADC_PARAM_MISSING, p_error_code => 'CAT_ID_MISSING');
    pit.assert_not_null(p_row.cat_catg_id, msg.ADC_PARAM_MISSING, p_error_code => 'CAT_CATG_ID_MISSING');
    pit.assert_not_null(p_row.cat_caif_id, msg.ADC_PARAM_MISSING, p_error_code => 'CAT_CAIF_ID_MISSING');
    pit.assert_not_null(p_row.cat_cato_id, msg.ADC_PARAM_MISSING, p_error_code => 'CAT_CATO_ID_MISSING');
    pit.assert_not_null(p_row.cat_name, msg.ADC_PARAM_MISSING, p_error_code => 'CAT_NAME_MISSING');
    
    pit.leave_mandatory;
  exception
    when others then
      pit.leave_mandatory;
      raise;
  end validate_action_type;


  /**
    Function: export_action_types
      See <ADC_ADMIN.export_action_types>
   */
  function export_action_types(
    p_mode in varchar2)
    return blob
  as
    l_action_param_visual_types clob;
    l_action_param_types clob;
    l_page_item_type_groups clob;
    l_event_types clob;
    l_page_item_types clob;
    l_action_item_focus clob;
    l_action_type_groups clob;
    l_action_type_owners clob;
    l_action_types clob;
    l_apex_action_types clob;
    l_export_script clob;
    l_zip_file blob;
    l_zip_file_name adc_util.ora_name_type;
    l_with_system boolean;
    l_with_user boolean;
  begin
    pit.enter_mandatory(p_params => msg_params(msg_param('p_mode', p_mode)));
    -- prevent unwanted escapings on nested anchors
    utl_text.set_main_anchor_char('#');
    utl_text.set_secondary_anchor_char(null);
    
    -- Set export mode
    case p_mode
    when C_EXPORT_USER then
      l_zip_file_name := 'action_types_user.sql';
      l_with_user := true;
      l_with_system := false;
    when C_EXPORT_SYSTEM then
      l_zip_file_name := 'action_types_system.sql';
      l_with_user := false;
      l_with_system := true;
    else
      l_zip_file_name := 'action_types_all.sql';
      l_with_user := true;
      l_with_system := true;
    end case;

    -- export system action types
    if l_with_system then
      select utl_text.generate_text(cursor(
              select uttm_text template,
                     capvt_id, capvt_name, adc_util.to_bool(capvt_active) capvt_active,
                     utl_text.wrap_string(capvt_description, C_WRAP_START, C_WRAP_END) capvt_description,
                     capvt_param_item_extension, capvt_display_name, capvt_sort_seq
                from adc_action_param_visual_types_v
             ), adc_util.C_CR)
        into l_action_param_visual_types
        from utl_text_templates
       where uttm_type = C_ADC
         and uttm_name = C_UTTM_NAME
         and uttm_mode = 'PARAM_VISUAL_TYPE';
         
      l_action_param_types := get_action_param_types(C_ADC);
         
      select utl_text.generate_text(cursor(
              select uttm_text template,
                     cpitg_id, 
                     adc_util.to_bool(cpitg_has_value) cpitg_has_value, 
                     adc_util.to_bool(cpitg_include_in_view) cpitg_include_in_view
                from adc_page_item_type_groups
            ))
        into l_page_item_type_groups
        from utl_text_templates
       where uttm_type = C_ADC
         and uttm_name = C_UTTM_NAME
         and uttm_mode = 'PAGE_ITEM_TYPE_GROUP';
         
      select utl_text.generate_text(cursor(
              select uttm_text template,
                     cet_id, cet_name, cet_cpitg_id, cet_column_name,
                     adc_util.to_bool(cet_is_custom_event) cet_is_custom_event
                from adc_event_types_v
            ))
        into l_event_types
        from utl_text_templates
       where uttm_type = C_ADC
         and uttm_name = C_UTTM_NAME
         and uttm_mode = 'EVENT_TYPE';
  
      select utl_text.generate_text(cursor(
              select uttm_text template,
                     cpit_id, cpit_cpitg_id, cpit_name, 
                     adc_util.to_bool(cpit_has_value) cpit_has_value, 
                     adc_util.to_bool(cpit_include_in_view) cpit_include_in_view, 
                     cpit_cet_id, 
                     utl_text.wrap_string(cpit_col_template, C_WRAP_START, C_WRAP_END) cpit_col_template, 
                     utl_text.wrap_string(cpit_init_template, C_WRAP_START, C_WRAP_END) cpit_init_template
                from adc_page_item_types_v
            ))
        into l_page_item_types
        from utl_text_templates
       where uttm_type = C_ADC
         and uttm_name = C_UTTM_NAME
         and uttm_mode = 'PAGE_ITEM_TYPE';
  
      select utl_text.generate_text(cursor(
              select uttm_text template,
                     caif_id, caif_name, adc_util.to_bool(caif_active) caif_active, caif_default,
                     utl_text.wrap_string(caif_description, C_WRAP_START, C_WRAP_END) caif_description,
                     adc_util.to_bool(caif_actual_page_only) caif_actual_page_only, caif_item_types
                from adc_action_item_focus_v
             ), adc_util.C_CR)
        into l_action_item_focus
        from utl_text_templates
       where uttm_type = C_ADC
         and uttm_name = C_UTTM_NAME
         and uttm_mode = 'ITEM_FOCUS';
  
      select utl_text.generate_text(cursor(
              select uttm_text template,
                     catg_id, catg_name, adc_util.to_bool(catg_active) catg_active,
                     utl_text.wrap_string(catg_description, C_WRAP_START, C_WRAP_END) catg_description
                from adc_action_type_groups_v
             ), adc_util.C_CR)
        into l_action_type_groups
        from utl_text_templates
       where uttm_type = C_ADC
         and uttm_name = C_UTTM_NAME
         and uttm_mode = 'ACTION_TYPE_GROUP';
  
      select utl_text.generate_text(cursor(
              select uttm_text template,
                     cato_id, 
                     adc_util.to_bool(cato_active) cato_active,
                     utl_text.wrap_string(cato_description, C_WRAP_START, C_WRAP_END) cato_description
                from adc_action_type_owners_v
               where cato_id = C_ADC
             ), adc_util.C_CR)
        into l_action_type_owners
        from utl_text_templates
       where uttm_type = C_ADC
         and uttm_name = C_UTTM_NAME
         and uttm_mode = 'ACTION_TYPE_OWNER';
  
      select utl_text.generate_text(cursor(
              select uttm_text template,
                     caat_id, caat_name, adc_util.to_bool(caat_active) caat_active,
                     utl_text.wrap_string(caat_description, C_WRAP_START, C_WRAP_END) caat_description
                from adc_apex_action_types_v
             ), adc_util.C_CR)
        into l_apex_action_types
        from utl_text_templates
       where uttm_type = C_ADC
         and uttm_name = C_UTTM_NAME
         and uttm_mode = 'APEX_ACTION_TYPE';
         
      l_action_types := get_action_types(C_ADC);
  
      -- create export statement
      select utl_text.generate_text(cursor(
               select uttm_text template,
                      l_action_param_visual_types action_param_visual_types,
                      l_action_param_types action_param_types,
                      l_page_item_type_groups page_item_type_groups,
                      l_event_types event_types,
                      l_page_item_types page_item_types,
                      l_action_item_focus action_item_focus,
                      l_action_type_groups action_type_groups,
                      l_action_type_owners action_type_owners,
                      l_action_types action_types,
                      l_apex_action_types apex_action_types
                 from dual
             ), adc_util.C_CR) resultat
        into l_export_script
        from utl_text_templates
       where uttm_type = C_ADC
         and uttm_name = C_UTTM_NAME
         and uttm_mode = C_FRAME;
      
      apex_zip.add_file(
        p_zipped_blob => l_zip_file,
        p_file_name => l_zip_file_name,
        p_content => utl_text.clob_to_blob(l_export_script));
        
      add_param_lov_statements(C_ADC, l_zip_file);
    end if;
      
    -- export user action types
    if l_with_user then
      add_custom_action_types(l_zip_file);
    end if;
    
    if l_zip_file is not null then
      apex_zip.finish(l_zip_file);
    end if;

    -- reset utl_text to standard values
    utl_text.initialize;   
    pit.leave_mandatory(p_params => msg_params(msg_param('ZIP file size', dbms_lob.getlength(l_zip_file))));
    return l_zip_file;
  exception
    when others then
      pit.handle_exception;
      raise;
  end export_action_types;


  /**
    Procedure: merge_action_parameter
      See <ADC_ADMIN.merge_action_parameter>
   */
  procedure merge_action_parameter(
    p_cap_cat_id in adc_action_parameters_v.cap_cat_id%type,
    p_cap_capt_id in adc_action_parameters_v.cap_capt_id%type,
    p_cap_sort_seq in adc_action_parameters_v.cap_sort_seq%type,
    p_cap_default in adc_action_parameters_v.cap_default%type,
    p_cap_description in adc_action_parameters_v.cap_description%type,
    p_cap_display_name in adc_action_parameters_v.cap_display_name%type,
    p_cap_mandatory in adc_action_parameters_v.cap_mandatory%type,
    p_cap_active in adc_action_parameters_v.cap_active%type default adc_util.C_TRUE)
  as
    l_row adc_action_parameters_v%rowtype;
  begin
    pit.enter_mandatory(
      p_params => msg_params(
                    msg_param('p_cap_cat_id', p_cap_cat_id),
                    msg_param('p_cap_capt_id', p_cap_capt_id),
                    msg_param('p_cap_sort_seq', to_char(p_cap_sort_seq)),
                    msg_param('p_cap_default', p_cap_default),
                    msg_param('p_cap_description', p_cap_description),
                    msg_param('p_cap_display_name', p_cap_display_name),
                    msg_param('p_cap_mandatory', p_cap_mandatory),
                    msg_param('p_cap_active', p_cap_active)));
    
    l_row.cap_cat_id := p_cap_cat_id;
    l_row.cap_capt_id := p_cap_capt_id;
    l_row.cap_sort_seq := p_cap_sort_seq;
    l_row.cap_default := p_cap_default;
    l_row.cap_description := utl_text.unwrap_string(p_cap_description);
    l_row.cap_display_name := p_cap_display_name;
    l_row.cap_mandatory := p_cap_mandatory;
    l_row.cap_active := adc_util.get_boolean(p_cap_active);
    
    merge_action_parameter(l_row);
    
    pit.enter_mandatory;
  end merge_action_parameter;


  /**
    Procedure: merge_action_parameter
      See <ADC_ADMIN.merge_action_parameter>
   */
  procedure merge_action_parameter(
    p_row in out nocopy adc_action_parameters_v%rowtype)
  as
    l_pti_id pit_translatable_item.pti_id%type;
  begin
    pit.enter_mandatory;
    
    validate_action_parameter(p_row);
                    
    -- maintain translatable item
    select 'CAP_' || p_row.cap_cat_id || '_PARAM_' || p_row.cap_sort_seq
      into l_pti_id
      from dual;

    pit_admin.merge_translatable_item(
      p_pti_id => l_pti_id,
      p_pti_pml_name => null,
      p_pti_pmg_name => C_ADC,
      p_pti_name => p_row.cap_display_name,
      p_pti_description => p_row.cap_description);

    -- store local data
    merge into adc_action_parameters t
    using (select p_row.cap_cat_id cap_cat_id,
                  p_row.cap_capt_id cap_capt_id,
                  p_row.cap_sort_seq cap_sort_seq,
                  p_row.cap_default cap_default,
                  l_pti_id cap_pti_id,
                  C_ADC cap_pmg_name,
                  p_row.cap_mandatory cap_mandatory,
                  p_row.cap_active cap_active
             from dual) s
       on (t.cap_cat_id = s.cap_cat_id
      and t.cap_capt_id = s.cap_capt_id
      and t.cap_sort_seq = s.cap_sort_seq)
     when matched then update set
          t.cap_pti_id = s.cap_pti_id,
          t.cap_default = s.cap_default,
          t.cap_mandatory = s.cap_mandatory,
          t.cap_active = s.cap_active
     when not matched then insert(cap_cat_id, cap_capt_id, cap_sort_seq, cap_default, cap_pti_id, cap_pmg_name, cap_mandatory, cap_active)
          values(s.cap_cat_id, s.cap_capt_id, s.cap_sort_seq, s.cap_default, s.cap_pti_id, s.cap_pmg_name, s.cap_mandatory, s.cap_active);
    
    pit.leave_mandatory;
  end merge_action_parameter;
  
  
  /**
    Procedure: delete_action_parameter
      See <ADC_ADMIN.delete_action_parameter>
   */
  procedure delete_action_parameter(
    p_cap_cat_id in adc_action_parameters_v.cap_cat_id%type,
    p_cap_capt_id in adc_action_parameters_v.cap_capt_id%type,
    p_cap_sort_seq in adc_action_parameters_v.cap_sort_seq%type)
  as
    l_row adc_action_parameters_v%rowtype;
  begin
    pit.enter_mandatory(
      p_params => msg_params(
                    msg_param('p_cap_cat_id', p_cap_cat_id),
                    msg_param('p_cap_capt_id', p_cap_capt_id),
                    msg_param('p_cap_sort_seq', p_cap_sort_seq)));
                    
    l_row.cap_cat_id := p_cap_cat_id;
    l_row.cap_capt_id := p_cap_capt_id;
    l_row.cap_sort_seq := p_cap_sort_seq;
    
    delete_action_parameter(l_row);
    
    pit.leave_mandatory;
  end delete_action_parameter;      


  /**
    Procedure: delete_action_parameter
      See <ADC_ADMIN.delete_action_parameter>
   */
  procedure delete_action_parameter(
    p_row in adc_action_parameters_v%rowtype)
  as
  begin
                    
    delete from adc_action_parameters
     where cap_cat_id = p_row.cap_cat_id
       and cap_capt_id = p_row.cap_capt_id
       and cap_sort_seq = p_row.cap_sort_seq;
    
    pit.leave_mandatory;
  end delete_action_parameter;
  
  
  /**
    Procedure: delete_action_parameters
      See <ADC_ADMIN.delete_action_parameters>
   */
  procedure delete_action_parameters(
    p_cap_cat_id in adc_action_parameters_v.cap_cat_id%type)
  as
  begin
    pit.enter_mandatory(
      p_params => msg_params(
                    msg_param('p_cap_cat_id', p_cap_cat_id)));
                    
    delete from adc_action_parameters
     where cap_cat_id = p_cap_cat_id;
    
    pit.leave_mandatory;
  end delete_action_parameters;
    

  /**
    Procedure: validate_action_parameter
      See <ADC_ADMIN.validate_action_parameter>
   */
  procedure validate_action_parameter(
    p_row in adc_action_parameters_v%rowtype)
  as
  begin
    pit.enter_mandatory;
    
    /** TODO: Add validation */
    
    pit.leave_mandatory;
  end validate_action_parameter;
  
    
  /**
    Procedure: merge_page_item_type_group
      See <ADC_ADMIN.merge_page_item_type_group>
   */
  procedure merge_page_item_type_group(
    p_cpitg_id in adc_page_item_type_groups.cpitg_id%type,
    p_cpitg_has_value in adc_page_item_type_groups.cpitg_has_value%type,
    p_cpitg_include_in_view in adc_page_item_type_groups.cpitg_include_in_view%type)
  as
    l_row adc_page_item_type_groups%rowtype;
  begin
    pit.enter_mandatory(
      p_params => msg_params(
                    msg_param('p_cpitg_id', p_cpitg_id),
                    msg_param('p_cpitg_has_value', p_cpitg_has_value),
                    msg_param('p_cpitg_include_in_view', p_cpitg_include_in_view)));
    
    l_row.cpitg_id := p_cpitg_id;
    l_row.cpitg_has_value := p_cpitg_has_value;
    l_row.cpitg_include_in_view := p_cpitg_include_in_view;
    
    merge_page_item_type_group(l_row);
    
    pit.leave_mandatory;
  end merge_page_item_type_group;
    
  /**
    Procedure: merge_page_item_type_group
      See <ADC_ADMIN.merge_page_item_type_group>
   */
  procedure merge_page_item_type_group(
    p_row in out nocopy adc_page_item_type_groups%rowtype)
  as
  begin
    pit.enter_mandatory;
    
    validate_page_item_type_group(p_row);
    
    merge into adc_page_item_type_groups t
    using (select p_row.cpitg_id cpitg_id,
                  p_row.cpitg_has_value cpitg_has_value,
                  p_row.cpitg_include_in_view cpitg_include_in_view
             from dual) s
       on (t.cpitg_id = s.cpitg_id)
     when matched then update set
          t.cpitg_has_value = s.cpitg_has_value,
          t.cpitg_include_in_view = s.cpitg_include_in_view
    when not matched then insert(cpitg_id, cpitg_has_value, cpitg_include_in_view)
         values(s.cpitg_id, s.cpitg_has_value, s.cpitg_include_in_view);
         
    pit.leave_mandatory;
  end merge_page_item_type_group;

  /**
    Procedure: delete_page_item_type_group
      See <ADC_ADMIN.delete_page_item_type_group>
   */
  procedure delete_page_item_type_group(
    p_row in adc_page_item_type_groups%rowtype)
  as
  begin
    pit.enter_mandatory;
    
    delete from adc_page_item_type_groups
     where cpitg_id = p_row.cpitg_id;
    
    pit.leave_mandatory;
  end delete_page_item_type_group;
    
  /**
    Procedure: validate_page_item_type_group
      See <ADC_ADMIN.validate_page_item_type_group>
   */
  procedure validate_page_item_type_group(
    p_row in adc_page_item_type_groups%rowtype)
  as
  begin
    pit.enter_mandatory;
    
    pit.leave_mandatory;
  end validate_page_item_type_group;
  
  
  /**
    Procedure: merge_event_type
      See <ADC_ADMIN.merge_event_type>
   */
  procedure merge_event_type(
    p_cet_id in adc_event_types_v.cet_id%type,
    p_cet_name in adc_event_types_v.cet_name%type,
    p_cet_column_name in adc_event_types_v.cet_column_name%type,
    p_cet_is_custom_event in adc_event_types_v.cet_is_custom_event%type)
  as
    l_row adc_event_types_v%rowtype;
  begin
    pit.enter_mandatory(
      p_params => msg_params(
                    msg_param('p_cet_id', p_cet_id),
                    msg_param('p_cet_name', p_cet_name),
                    msg_param('p_cet_column_name', p_cet_column_name),
                    msg_param('p_cet_is_custom_event', p_cet_is_custom_event)));
    
    l_row.cet_id := p_cet_id;
    l_row.cet_name := p_cet_name;
    l_row.cet_column_name := p_cet_column_name;
    l_row.cet_is_custom_event := p_cet_is_custom_event;
    
    merge_event_type(l_row);
    
    pit.leave_mandatory;
  end merge_event_type;
    
  /**
    Procedure: merge_event_type
      See <ADC_ADMIN.merge_event_type>
   */
  procedure merge_event_type(
    p_row in out nocopy adc_event_types_v%rowtype)
  as
    l_pti_id pit_translatable_item.pti_id%type;
  begin
    pit.enter_mandatory;
    
    validate_event_type(p_row);
    
    -- maintain translatable item
    l_pti_id := 'CET_' || upper(replace(p_row.cet_id, '-', '_'));
    
    pit_admin.merge_translatable_item(
      p_pti_id => l_pti_id,
      p_pti_pml_name => null,
      p_pti_pmg_name => C_ADC,
      p_pti_name => p_row.cet_name);
    
    merge into adc_event_types t
    using (select p_row.cet_id cet_id,
                  l_pti_id cet_pti_id,
                  C_ADC cet_pmg_name,
                  'EVENT' cet_cpitg_id,
                  p_row.cet_column_name cet_column_name,
                  p_row.cet_is_custom_event cet_is_custom_event
             from dual) s
       on (t.cet_id = s.cet_id)
     when matched then update set
       t.cet_column_name = s.cet_column_name,
       t.cet_is_custom_event = s.cet_is_custom_event
     when not matched then insert (cet_id, cet_pti_id, cet_pmg_name, cet_cpitg_id, cet_column_name, cet_is_custom_event)
       values (s.cet_id, s.cet_pti_id, s.cet_pmg_name, s.cet_cpitg_id, s.cet_column_name, s.cet_is_custom_event);
    
    pit.leave_mandatory;
  end merge_event_type;

  /**
    Procedure: delete_event_type
      See <ADC_ADMIN.delete_event_type>
   */
  procedure delete_event_type(
    p_row in adc_event_types_v%rowtype)
  as
  begin
    null;
  end delete_event_type;
    
  /**
    Procedure: validate_event_type
      See <ADC_ADMIN.validate_event_type>
   */
  procedure validate_event_type(
    p_row in adc_event_types_v%rowtype)
  as
  begin
    null;
  end validate_event_type;
  
  
  /**
    Procedure: merge_page_item_type
      See <ADC_ADMIN.merge_page_item_type>
   */
  procedure merge_page_item_type(
    p_cpit_id in adc_page_item_types_v.cpit_id%type,
    p_cpit_name in adc_page_item_types_v.cpit_name%type,
    p_cpit_cpitg_id in adc_page_item_types_v.cpit_cpitg_id%type,
    p_cpit_cet_id in adc_page_item_types_v.cpit_cet_id%type,
    p_cpit_col_template in adc_page_item_types_v.cpit_col_template%type,
    p_cpit_init_template in adc_page_item_types_v.cpit_init_template%type) 
  as
    l_row adc_page_item_types_v%rowtype;
  begin
    pit.enter_mandatory;

    l_row.cpit_id := p_cpit_id;
    l_row.cpit_name := p_cpit_name;
    l_row.cpit_cpitg_id := p_cpit_cpitg_id;
    l_row.cpit_cet_id := p_cpit_cet_id;
    l_row.cpit_col_template := p_cpit_col_template;
    l_row.cpit_init_template := p_cpit_init_template;
    
    merge_page_item_type(l_row);

    pit.leave_mandatory;
  end merge_page_item_type;
  
  
  /**
    Procedure: merge_page_item_type
      See <ADC_ADMIN.merge_page_item_type>
   */
  procedure merge_page_item_type(
    p_row in out nocopy adc_page_item_types_v%rowtype)
  as
    l_pti_id pit_translatable_item.pti_id%type;
  begin
    pit.enter_mandatory;
    
    validate_page_item_type(p_row);
    
    -- maintain translatable item
    l_pti_id := 'CPIT_' || p_row.cpit_id;
    
    pit_admin.merge_translatable_item(
      p_pti_id => l_pti_id,
      p_pti_pml_name => null,
      p_pti_pmg_name => C_ADC,
      p_pti_name => p_row.cpit_name);

    merge into adc_page_item_types t
    using (select p_row.cpit_id cpit_id,
                  l_pti_id cpit_pti_id,
                  C_ADC cpit_pmg_name,
                  p_row.cpit_cpitg_id cpit_cpitg_id,
                  p_row.cpit_cet_id cpit_cet_id,
                  p_row.cpit_col_template cpit_col_template,
                  p_row.cpit_init_template cpit_init_template
             from dual) s
       on (t.cpit_id = s.cpit_id)
     when matched then update set
            t.cpit_cpitg_id = s.cpit_cpitg_id,
            t.cpit_cet_id = s.cpit_cet_id,
            t.cpit_col_template = s.cpit_col_template,
            t.cpit_init_template = s.cpit_init_template
     when not matched then insert(
            t.cpit_id, t.cpit_pti_id, t.cpit_pmg_name, t.cpit_cpitg_id, t.cpit_cet_id, t.cpit_col_template, t.cpit_init_template)
          values(
            s.cpit_id, s.cpit_pti_id, s.cpit_pmg_name, s.cpit_cpitg_id, s.cpit_cet_id, s.cpit_col_template, s.cpit_init_template);

    pit.leave_mandatory;
  end merge_page_item_type;


  /**
    Procedure: delete_page_item_type
      See <ADC_ADMIN.delete_page_item_type>
   */
  procedure delete_page_item_type(
    p_row in adc_page_item_types_v%rowtype)
  as
  begin
    pit.enter_mandatory;

    delete from adc_page_item_types
     where cpit_id = p_row.cpit_id;

    pit.leave_mandatory;
  end delete_page_item_type;
  
  
  /**
    Procedure: validate_page_item_type
      See <ADC_ADMIN.validate_page_item_type>
   */
  procedure validate_page_item_type(
    p_row in adc_page_item_types_v%rowtype)
  as
  begin
    pit.enter_mandatory;

    -- TODO: Add tests here
    null;

    pit.leave_mandatory;
  end validate_page_item_type;
  
  
  /**
    Group: Public Methods - APEX Action Methods
   */
  /**
    Procedure: merge_apex_action_type
      See <ADC_ADMIN.merge_apex_action_type>
   */ 
  procedure merge_apex_action_type(
    p_caat_id in adc_apex_action_types_v.caat_id%type,
    p_caat_name in adc_apex_action_types_v.caat_name%type,
    p_caat_description in adc_apex_action_types_v.caat_description%type,
    p_caat_active in adc_apex_action_types_v.caat_active%type)
  as
    l_row adc_apex_action_types_v%rowtype;
  begin
    pit.enter_mandatory(
      p_params => msg_params(
                    msg_param('p_caat_id', p_caat_id),
                    msg_param('p_caat_name', p_caat_name),
                    msg_param('p_caat_description', p_caat_description),
                    msg_param('p_caat_active', p_caat_active)));
                    
    l_row.caat_id := p_caat_id;
    l_row.caat_name := p_caat_name;
    l_row.caat_description := utl_text.unwrap_string(p_caat_description);
    l_row.caat_active := adc_util.get_boolean(p_caat_active);
    
    merge_apex_action_type(l_row);
    
    pit.leave_mandatory;
  end merge_apex_action_type;
  
  
  /**
    Procedure: merge_apex_action_type
      See <ADC_ADMIN.merge_apex_action_type>
   */ 
  procedure merge_apex_action_type(
    p_row in out nocopy adc_apex_action_types_v%rowtype)
  as
    l_pti_id pit_translatable_item.pti_id%type;
  begin
    pit.enter_mandatory;
    
    validate_apex_action_type(p_row);

    -- maintain translatable item
    l_pti_id := 'CAAT_' || p_row.caat_id;
    pit_admin.merge_translatable_item(
      p_pti_id => l_pti_id,
      p_pti_pml_name => null,
      p_pti_pmg_name => C_ADC,
      p_pti_name => p_row.caat_name,
      p_pti_description => p_row.caat_description);

    -- store local data
    merge into adc_apex_action_types t
    using (select p_row.caat_id caat_id,
                  l_pti_id caat_pti_id,
                  C_ADC caat_pmg_name,
                  p_row.caat_active caat_active
             from dual) s
       on (t.caat_id = s.caat_id)
     when matched then update set
            t.caat_active = s.caat_active
     when not matched then insert(t.caat_id, t.caat_pti_id, t.caat_pmg_name, t.caat_active)
          values(s.caat_id, s.caat_pti_id, s.caat_pmg_name, s.caat_active);
      
    pit.leave_mandatory;
  end merge_apex_action_type;


  /**
    Procedure: delete_apex_action_type
      See <ADC_ADMIN.delete_apex_action_type>
   */ 
  procedure delete_apex_action_type(
    p_caat_id in adc_apex_action_types_v.caat_id%type)
  as
    l_row adc_apex_action_types_v%rowtype;
  begin
    pit.enter_mandatory(
      p_params => msg_params(
                    msg_param('p_caat_id', p_caat_id)));
     
    l_row.caat_id := p_caat_id;
    delete_apex_action_type(l_row);
    
    pit.leave_mandatory;
  end delete_apex_action_type;


  /**
    Procedure: delete_apex_action_type
      See <ADC_ADMIN.delete_apex_action_type>
   */ 
  procedure delete_apex_action_type(
    p_row in adc_apex_action_types_v%rowtype)
  as
  begin
    pit.enter_mandatory;
    
    delete from adc_apex_action_types
     where caat_id = p_row.caat_id;
    
    pit.leave_mandatory;
  end delete_apex_action_type;
  
  
  /**
    Procedure: validate_apex_action_type
      See <ADC_ADMIN.validate_apex_action_type>
   */ 
  procedure validate_apex_action_type(
    p_row in adc_apex_action_types_v%rowtype)
  as
  begin
    pit.enter_mandatory;
    
    /** TODO: Enter validation */
    
    pit.leave_mandatory;
  end validate_apex_action_type;


  /**
    Procedure: merge_apex_action
      See <ADC_ADMIN.merge_apex_action>
   */ 
  procedure merge_apex_action(
    p_caa_id in adc_apex_actions_v.caa_id%type,
    p_caa_crg_id in adc_apex_actions_v.caa_crg_id%type,
    p_caa_caat_id in adc_apex_actions_v.caa_caat_id%type,
    p_caa_name in adc_apex_actions_v.caa_name%type,
    p_caa_confirm_message_name in adc_apex_actions_v.caa_confirm_message_name%type,
    p_caa_label in adc_apex_actions_v.caa_label%type,
    p_caa_context_label in adc_apex_actions_v.caa_context_label%type default null,
    p_caa_icon in adc_apex_actions_v.caa_icon%type default null,
    p_caa_icon_type in adc_apex_actions_v.caa_icon_type%type default 'fa',
    p_caa_title in adc_apex_actions_v.caa_title%type default null,
    p_caa_shortcut in adc_apex_actions_v.caa_shortcut%type default null,
    p_caa_initially_disabled in adc_apex_actions_v.caa_initially_disabled%type default 0,
    p_caa_initially_hidden in adc_apex_actions_v.caa_initially_hidden%type default 0,
    -- ACTION
    p_caa_href in adc_apex_actions_v.caa_href%type default null,
    p_caa_action in adc_apex_actions_v.caa_action%type default null,
    -- TOGGLE
    p_caa_on_label in adc_apex_actions_v.caa_on_label%type default null,
    p_caa_off_label in adc_apex_actions_v.caa_off_label%type default null,
    -- TOGGLE | RADIO_GROUP
    p_caa_get in adc_apex_actions_v.caa_get%type default null,
    p_caa_set in adc_apex_actions_v.caa_set%type default null,
    -- RADIO_GROUP
    p_caa_choices in adc_apex_actions_v.caa_choices%type default null,
    p_caa_label_classes in adc_apex_actions_v.caa_label_classes%type default null,
    p_caa_label_start_classes in adc_apex_actions_v.caa_label_start_classes%type default null,
    p_caa_label_end_classes in adc_apex_actions_v.caa_label_end_classes%type default null,
    p_caa_item_wrap_class in adc_apex_actions_v.caa_item_wrap_class%type default null)
  as
    l_row adc_apex_actions_v%rowtype;
  begin
    pit.enter_mandatory(
      p_params => msg_params(
                    msg_param('p_caa_id', p_caa_id),
                    msg_param('p_caa_crg_id', p_caa_crg_id),
                    msg_param('p_caa_caat_id', p_caa_caat_id),
                    msg_param('p_caa_name', p_caa_name),
                    msg_param('p_caa_confirm_message_name', p_caa_confirm_message_name),
                    msg_param('p_caa_label', p_caa_label),
                    msg_param('p_caa_context_label', p_caa_context_label),
                    msg_param('p_caa_icon', p_caa_icon),
                    msg_param('p_caa_icon_type', p_caa_icon_type),
                    msg_param('p_caa_title', p_caa_title),
                    msg_param('p_caa_shortcut', p_caa_shortcut),
                    msg_param('p_caa_initially_disabled', p_caa_initially_disabled),
                    msg_param('p_caa_initially_hidden', p_caa_initially_hidden),
                    msg_param('p_caa_href', p_caa_href),
                    msg_param('p_caa_action', p_caa_action),
                    msg_param('p_caa_on_label', p_caa_on_label),
                    msg_param('p_caa_off_label', p_caa_off_label),
                    msg_param('p_caa_get', p_caa_get),
                    msg_param('p_caa_set', p_caa_set),
                    msg_param('p_caa_choices', p_caa_choices),
                    msg_param('p_caa_label_classes', p_caa_label_classes),
                    msg_param('p_caa_label_start_classes', p_caa_label_start_classes),
                    msg_param('p_caa_label_end_classes', p_caa_label_end_classes),
                    msg_param('p_caa_item_wrap_class', p_caa_item_wrap_class)));
    
    l_row.caa_id := p_caa_id;
    l_row.caa_crg_id := p_caa_crg_id;
    l_row.caa_caat_id := p_caa_caat_id;
    l_row.caa_name := p_caa_name;
    l_row.caa_confirm_message_name := p_caa_confirm_message_name;
    l_row.caa_label := p_caa_label;
    l_row.caa_context_label := p_caa_context_label;
    l_row.caa_icon := p_caa_icon;
    l_row.caa_icon_type := p_caa_icon_type;
    l_row.caa_title := p_caa_title;
    l_row.caa_shortcut := p_caa_shortcut;
    l_row.caa_initially_disabled := adc_util.get_boolean(p_caa_initially_disabled);
    l_row.caa_initially_hidden := adc_util.get_boolean(p_caa_initially_hidden);
    l_row.caa_href := p_caa_href;
    l_row.caa_action := p_caa_action;
    l_row.caa_on_label := p_caa_on_label;
    l_row.caa_off_label := p_caa_off_label;
    l_row.caa_get := p_caa_get;
    l_row.caa_set := p_caa_set;
    l_row.caa_choices := p_caa_choices;
    l_row.caa_label_classes := p_caa_label_classes;
    l_row.caa_label_start_classes := p_caa_label_start_classes;
    l_row.caa_label_end_classes := p_caa_label_end_classes;
    l_row.caa_item_wrap_class := p_caa_item_wrap_class;
    
    merge_apex_action(l_row);

    pit.leave_mandatory;
  end merge_apex_action;


  /**
    Procedure: merge_apex_action
      See <ADC_ADMIN.merge_apex_action>
   */ 
  procedure merge_apex_action(
    p_row in out nocopy adc_apex_actions_v%rowtype,
    p_caa_caai_list in char_table default null)
  as
    l_pti_id pit_translatable_item.pti_id%type;
  begin
    pit.enter_mandatory;

    validate_apex_action(p_row);
    
    get_key(p_row.caa_id);    

    -- maintain translatable item
    l_pti_id := 'CAA_' || p_row.caa_id;
    pit_admin.merge_translatable_item(
      p_pti_id => l_pti_id,
      p_pti_pml_name => null,
      p_pti_pmg_name => C_ADC,
      p_pti_name => p_row.caa_label,
      p_pti_display_name => p_row.caa_title,
      p_pti_description => p_row.caa_context_label);

    merge into adc_apex_actions t
    using (select p_row.caa_id caa_id,
                  p_row.caa_crg_id caa_crg_id,
                  p_row.caa_name caa_name,
                  l_pti_id caa_pti_id,
                  C_ADC caa_pmg_name,
                  p_row.caa_caat_id caa_caat_id,
                  p_row.caa_confirm_message_name caa_confirm_message_name,
                  p_row.caa_icon caa_icon,
                  p_row.caa_icon_type caa_icon_type,
                  p_row.caa_title caa_title,
                  p_row.caa_shortcut caa_shortcut,
                  p_row.caa_initially_disabled caa_initially_disabled,
                  p_row.caa_initially_hidden caa_initially_hidden,
                  p_row.caa_href caa_href,
                  p_row.caa_action caa_action,
                  p_row.caa_on_label caa_on_label,
                  p_row.caa_off_label caa_off_label,
                  p_row.caa_get caa_get,
                  p_row.caa_set caa_set,
                  p_row.caa_choices caa_choices,
                  p_row.caa_label_classes caa_label_classes,
                  p_row.caa_label_start_classes caa_label_start_classes,
                  p_row.caa_label_end_classes caa_label_end_classes,
                  p_row.caa_item_wrap_class caa_item_wrap_class
             from dual) s
       on (t.caa_id = s.caa_id)
     when matched then update set
            t.caa_name = s.caa_name,
            t.caa_caat_id = s.caa_caat_id,
            t.caa_pti_id = s.caa_pti_id,
            t.caa_pmg_name = s.caa_pmg_name,
            t.caa_confirm_message_name = s.caa_confirm_message_name,
            t.caa_icon = s.caa_icon,
            t.caa_icon_type = s.caa_icon_type,
            t.caa_shortcut = s.caa_shortcut,
            t.caa_initially_disabled = s.caa_initially_disabled,
            t.caa_initially_hidden = s.caa_initially_hidden,
            t.caa_href = s.caa_href,
            t.caa_action = s.caa_action,
            t.caa_get = s.caa_get,
            t.caa_set = s.caa_set,
            t.caa_on_label = s.caa_on_label,
            t.caa_off_label = s.caa_off_label,
            t.caa_choices = s.caa_choices,
            t.caa_label_classes = s.caa_label_classes,
            t.caa_label_start_classes = s.caa_label_start_classes,
            t.caa_label_end_classes = s.caa_label_end_classes,
            t.caa_item_wrap_class = s.caa_item_wrap_class
     when not matched then insert(
            t.caa_id, t.caa_crg_id, t.caa_name, t.caa_caat_id, t.caa_pti_id, t.caa_pmg_name, t.caa_confirm_message_name, 
            t.caa_icon, t.caa_icon_type, t.caa_shortcut, t.caa_initially_disabled, t.caa_initially_hidden, 
            t.caa_href, t.caa_action, t.caa_get, t.caa_set, t.caa_on_label, t.caa_off_label, t.caa_choices, t.caa_label_classes, 
            t.caa_label_start_classes, t.caa_label_end_classes, t.caa_item_wrap_class)
          values(
            s.caa_id, s.caa_crg_id, s.caa_name, s.caa_caat_id, s.caa_pti_id, s.caa_pmg_name, s.caa_confirm_message_name,
            s.caa_icon, s.caa_icon_type, s.caa_shortcut, s.caa_initially_disabled, s.caa_initially_hidden, 
            s.caa_href, s.caa_action, s.caa_get, s.caa_set, s.caa_on_label, s.caa_off_label, s.caa_choices, s.caa_label_classes,
            s.caa_label_start_classes, s.caa_label_end_classes, s.caa_item_wrap_class);
    
    -- Register connected items by deleting and re-assigning them
    delete from adc_apex_action_items
     where caai_caa_id = p_row.caa_id
       and caai_cpi_crg_id = p_row.caa_crg_id;
       
    if p_caa_caai_list is not null then
      for i in 1 .. p_caa_caai_list.count loop
        merge_apex_action_item(
          p_caai_caa_id => p_row.caa_id,
          p_caai_cpi_crg_id => p_row.caa_crg_id,
          p_caai_cpi_id => p_caa_caai_list(i),
          p_caai_active => adc_util.C_TRUE);
      end loop;
    end if;
    
    pit.leave_mandatory;
  end merge_apex_action;


  /**
    Procedure: delete_apex_action
      See <ADC_ADMIN.delete_apex_action>
   */ 
  procedure delete_apex_action(
    p_caa_id in adc_apex_actions_v.caa_id%type)
  as
    l_row adc_apex_actions_v%rowtype;
  begin
    pit.enter_mandatory(
      p_params => msg_params(
                    msg_param('p_caa_id', p_caa_id)));
                    
    l_row.caa_id := p_caa_id;
    
    delete_apex_action(l_row);

    pit.leave_mandatory;
  end delete_apex_action;


  /**
    Procedure: delete_apex_action
      See <ADC_ADMIN.delete_apex_action>
   */ 
  procedure delete_apex_action(
    p_row in adc_apex_actions_v%rowtype)
  as
  begin
    pit.enter_mandatory;

    delete from adc_apex_actions
     where caa_id = p_row.caa_id;

    pit.leave_mandatory;
  end delete_apex_action;


  /**
    Procedure: validate_apex_action
      See <ADC_ADMIN.validate_apex_action>
   */ 
  procedure validate_apex_action(
    p_row in adc_apex_actions_v%rowtype)
  as
  begin
    pit.enter_mandatory;
    
    /** TODO: Add validation*/
    
    pit.leave_mandatory;
  end validate_apex_action;


  /**
    Procedure: merge_apex_action_item
      See <ADC_ADMIN.merge_apex_action_item>
   */ 
  procedure merge_apex_action_item(
    p_caai_caa_id in adc_apex_action_items.caai_caa_id%type,
    p_caai_cpi_crg_id in adc_apex_action_items.caai_cpi_crg_id%type,
    p_caai_cpi_id in adc_apex_action_items.caai_cpi_id%type,
    p_caai_active in adc_apex_action_items.caai_active%type)
  as
    l_row adc_apex_action_items%rowtype;
  begin
    pit.enter_mandatory(
      p_params => msg_params(
                    msg_param('p_caai_caa_id', p_caai_caa_id),
                    msg_param('p_caai_cpi_crg_id', p_caai_cpi_crg_id),
                    msg_param('p_caai_cpi_id', p_caai_cpi_id),
                    msg_param('p_caai_active', p_caai_active)));
                    
    l_row.caai_caa_id := p_caai_caa_id;
    l_row.caai_cpi_crg_id := p_caai_cpi_crg_id;
    l_row.caai_cpi_id := p_caai_cpi_id;
    l_row.caai_active := adc_util.get_boolean(p_caai_active);
    
    merge_apex_action_item(l_row);
            
    pit.leave_mandatory;
  end merge_apex_action_item;


  /**
    Procedure: merge_apex_action_item
      See <ADC_ADMIN.merge_apex_action_item>
   */ 
  procedure merge_apex_action_item(
    p_row in out nocopy adc_apex_action_items%rowtype)
  as
  begin
    pit.enter_mandatory;
    
    validate_apex_action_item(p_row);
                    
    merge into adc_apex_action_items t
    using (select p_row.caai_caa_id caai_caa_id,
                  p_row.caai_cpi_crg_id caai_cpi_crg_id,
                  p_row.caai_cpi_id caai_cpi_id,
                  p_row.caai_active caai_active
             from dual) s
       on (t.caai_caa_id = s.caai_caa_id
       and t.caai_cpi_crg_id = s.caai_cpi_crg_id
       and t.caai_cpi_id = s.caai_cpi_id)
     when matched then update set
            t.caai_active = s.caai_active
     when not matched then insert(t.caai_caa_id, t.caai_cpi_crg_id, t.caai_cpi_id, t.caai_active)
          values(s.caai_caa_id, s.caai_cpi_crg_id, s.caai_cpi_id, s.caai_active);
      
    pit.leave_mandatory;
  end merge_apex_action_item;


  /**
    Procedure: delete_apex_action_item
      See <ADC_ADMIN.delete_apex_action_item>
   */ 
  procedure delete_apex_action_item(
    p_caai_caa_id in adc_apex_action_items.caai_caa_id%type)
  as
    l_row adc_apex_action_items%rowtype;
  begin
    pit.enter_mandatory(
      p_params => msg_params(
                    msg_param('p_caai_caa_id', p_caai_caa_id)));
                    
    l_row.caai_caa_id := p_caai_caa_id;
    
    delete_apex_action_item(l_row);
    
    pit.leave_mandatory;
  end delete_apex_action_item;


  /**
    Procedure: delete_apex_action_item
      See <ADC_ADMIN.delete_apex_action_item>
   */ 
  procedure delete_apex_action_item(
    p_row in adc_apex_action_items%rowtype)
  as
  begin
    pit.enter_mandatory;
                    
    delete from adc_apex_action_items
     where caai_caa_id = p_row.caai_caa_id;
    
    pit.leave_mandatory;
  end delete_apex_action_item;
  
  
  /**
    Procedure: validate_apex_action_item
      See <ADC_ADMIN.validate_apex_action_item>
   */ 
  procedure validate_apex_action_item(
    p_row in adc_apex_action_items%rowtype)
  as
  begin
    pit.enter_mandatory('validate_apex_action_item');
    
    /** TODO: Add validation */
    
    pit.leave_mandatory;
  end validate_apex_action_item;

begin
  initialize;
end adc_admin;
/
