create or replace package body param_admin
as

  /** 
    Package: PARAM_ADMIN Body
      Package to maintain settings for parameter groups
   
    Author:: 
      Juergen Sieben, ConDeS GmbH
      
      Published under MIT licence
   */
  
  C_TRUE constant &FLAG_TYPE. := &C_TRUE.;
  C_FALSE constant &FLAG_TYPE. := &C_FALSE.;
  C_PRE_ALL constant parameter_realm.pre_id%type := 'ALLE';
  
  g_import_mode boolean;

  /**
    Group: Helper Methods
   */
  /** 
    Function: convert_boolean
      Helper method to cast a boolean value into the given FLAG_TYPE.
      
    Parameter:
      p_value - Boolean value to cast
      
    Returns:
      FLAG_TYPE representation of the boolean value passed in. May be NULL.
   */
  function convert_boolean(
    p_value in boolean)
    return varchar2
  as
    l_boolean parameter_tab.par_boolean_value%type;
  begin
    l_boolean := case when p_value then C_TRUE
                      when not p_value then C_FALSE
                      else null end;
    return l_boolean;
  end convert_boolean;
  
  
  /**
    Procedure: get_parameter_group
      See <PARAM_ADMIN.get_parameter_group>
   */
  function get_parameter_group(
    p_pgr_id in parameter_group.pgr_id%type)
    return clob
  as
    c_group_template constant varchar2(32767) := q'~
  param_admin.edit_parameter_group(
    p_pgr_id => '#PGR_ID#',
    p_pgr_description => '#PGR_DESCRIPTION#',
    p_pgr_is_modifiable => #PGR_IS_MODIFIALBLE#
  );
~';
    l_chunk clob;
  begin
    select replace(replace(replace(c_group_template,
                 '#PGR_ID#', pgr_id),
                 '#PGR_DESCRIPTION#', pgr_description),
                 '#PGR_IS_MODIFIALBLE#', case
                                           when pgr_is_modifiable = C_TRUE then 'true'
                                           when pgr_is_modifiable = C_FALSE then 'false'
                                          end)
      into l_chunk
      from parameter_group
     where pgr_id = p_pgr_id;
    return l_chunk;
  end get_parameter_group;
  
  
  /**
    Procedure: get_parameter_realms
      Method to create an installation script for all referenced parameter realms of a parameter group.
      
      This method assures that all realms required by a parameter group are existing.
      
    Parameter:
      p_pgr_id - ID of the parameter group to create a script for.
      
    Returns: 
      Installation script for all parameter realms used within that parameter group
   */
  function get_parameter_realms(
    p_pgr_id in parameter_group.pgr_id%type)
    return clob
  as
    cursor realm_cur(p_pgr_id in parameter_group.pgr_id%type) is
      select pre_id, 
             pre_description, 
             case pre_is_active when C_TRUE then 'true' else 'false' end pre_is_active
        from parameter_realm
        join parameter_local
          on pre_id = pal_pre_id
       where pal_pgr_id = p_pgr_id
       order by pre_id;
    
    c_realm_template constant varchar2(32767) := q'^
  param_admin.edit_parameter_realm(
    p_pre_id => '#PRE_ID#',
    p_pre_description => '#PRE_DESCRIPTION#',
    p_pre_is_active => #PRE_IS_ACTIVE#);
^';
       
    C_LOCAL_REALM_SEPARATOR constant varchar2(32767) := q'^
  -- Realms used
^';

    l_script clob;
    l_chunk clob;
  begin
    dbms_lob.createtemporary(l_script, false, dbms_lob.call);
    dbms_lob.append(l_script, C_LOCAL_REALM_SEPARATOR);
    
    for pre in realm_cur(p_pgr_id) loop
      l_chunk := replace(replace(replace(c_realm_template, 
                   '#PRE_ID#', pre.pre_id),
                   '#PRE_DESCRIPTION#', pre.pre_description),
                   '#PRE_IS_ACTIVE#', pre.pre_is_active);
      dbms_lob.append(l_script, l_chunk);
    end loop;
    
    return l_script;
  end get_parameter_realms;
  
  
  /**
    Procedure: get_parameters
      Method to create an installation script for all parameters of a parameter group.
      
    Parameter:
      p_pgr_id - ID of the parameter group to create a script for.
      
    Returns: 
      Installation script for all parameters of a parameter group
   */
  function get_parameters(
    p_pgr_id in parameter_group.pgr_id%type)
    return clob
  as
    cursor param_cur(p_pgr_id in parameter_group.pgr_id%type) is
      select par_id, par_pgr_id, par_description,
             par_string_value,
             p.par_xml_value.getclobval() par_xml_value,
             to_char(par_integer_value) par_integer_value,
             replace(to_char(par_float_value), ',', '.') par_float_value,
             to_char(par_date_value, 'yyyy-mm-dd hh24:mi:ss') par_date_value,
             to_char(par_timestamp_value, 'yyyy-mm-dd hh24:mi:ssxff tzr') par_timestamp_value,
             case 
               when par_boolean_value = C_TRUE then 'true' 
               when par_boolean_value = C_FALSE then 'false'
              end par_boolean_value,
             case
               when par_is_modifiable = C_TRUE then 'true'
               when par_is_modifiable = C_FALSE then 'false'
              end par_is_modifiable,
             par_pat_id,
             par_validation_string,
             par_validation_message
        from parameter_tab p
       where par_pgr_id = p_pgr_id
       order by par_id;
    c_param_template constant varchar2(32767) := q'~
  param_admin.edit_parameter(
    p_par_id => '#PARAM_NAME#',
    p_par_pgr_id => '#PARAM_GROUP#',
    p_par_description => '#PARAM_DESCRIPTION#'#CLAUSES#
  );
~';
    c_string_template constant varchar2(100) := q'~    p_par_string_value => q'^#STRING#^'~';
    c_xml_template constant varchar2(100) := q'~    p_par_xml_value => xmltype(q'^#XML#^')~';
    c_integer_template constant varchar2(100) := q'~    p_par_integer_value => #INTEGER#~';
    c_float_template constant varchar2(100) := q'~    p_par_float_value => #FLOAT#~';
    c_date_template constant varchar2(100) := q'~    p_par_date_value => date '#DATE#'~';
    c_timestamp_template constant varchar2(100) := q'~    p_par_timestamp_value => timestamp '#TIMESTAMP#'~';
    c_boolean_template constant varchar2(100) := q'~    p_par_boolean_value => #BOOLEAN#~';
    c_modifiable_template constant varchar2(100) := q'~    p_par_is_modifiable => #MODIFIABLE#~';
    c_param_type_template constant varchar2(100) := q'~    p_par_pat_id => '#PARAM_TYPE#'~';
    c_validataion_template constant varchar2(100) := q'~    p_par_validation_string => q'^#VALIDATION#^'~';
    c_val_msg_template constant varchar2(100) := q'~    p_par_validation_message => q'^#VAL_MSG#^'~';
    
    l_script clob;
    l_chunk clob;
    l_clause clob;
    
    procedure calc_clause(
      p_clause in out nocopy varchar2,
      p_value in varchar2,
      p_pattern in varchar2,
      p_template in varchar2)
    as
    begin
      if p_value is not null then
        p_clause := p_clause || ',' || chr(13) || replace(p_template, p_pattern, p_value);
      end if;
    end calc_clause;
  begin
    dbms_lob.createtemporary(l_script, false, dbms_lob.call);
    for par in param_cur(p_pgr_id) loop
      calc_clause(l_clause, par.par_string_value, '#STRING#', c_string_template);
      calc_clause(l_clause, par.par_xml_value, '#XML#', c_xml_template);
      calc_clause(l_clause, par.par_integer_value, '#INTEGER#', c_integer_template);
      calc_clause(l_clause, par.par_float_value, '#FLOAT#', c_float_template);
      calc_clause(l_clause, par.par_date_value, '#DATE#', c_date_template);
      calc_clause(l_clause, par.par_timestamp_value, '#TIMESTAMP#', c_timestamp_template);
      calc_clause(l_clause, par.par_boolean_value, '#BOOLEAN#', c_boolean_template);
      calc_clause(l_clause, par.par_is_modifiable, '#MODIFIABLE#', c_modifiable_template);
      calc_clause(l_clause, par.par_pat_id, '#PARAM_TYPE#', c_param_type_template);
      calc_clause(l_clause, par.par_validation_string, '#VALIDATION#', c_validataion_template);
      calc_clause(l_clause, par.par_validation_message, '#VAL_MSG#', c_val_msg_template);
      l_chunk := replace(replace(replace(replace(c_param_template, 
                   '#PARAM_NAME#', par.par_id),
                   '#PARAM_GROUP#', par.par_pgr_id),
                   '#PARAM_DESCRIPTION#', par.par_description),
                   '#CLAUSES#', l_clause);
      l_clause := null;
      dbms_lob.append(l_script, l_chunk);
    end loop;
    return l_script;
  end get_parameters;
  
  
  /**
    Procedure: get_local_parameters
      Method to create an installation script for all local parameters of a parameter group.
      
    Parameter:
      p_pgr_id - ID of the parameter group to create a script for.
      
    Returns: 
      Installation script for all local parameters of a parameter group
   */
  function get_local_parameters(
    p_pgr_id in parameter_group.pgr_id%type,
    p_realm in binary_integer)
    return clob
  as
    cursor local_param_cur(p_pgr_id in varchar2) is
      select pal_id par_id,
             pal_pre_id pre_id,
             pal_pgr_id pgr_id,
             case
               when pal_string_value is not null then 'string'
               when pal_xml_value is not null then 'xml'
               when pal_integer_value is not null then 'integer'
               when pal_float_value is not null then 'float'
               when pal_date_value is not null then 'date'
               when pal_timestamp_value is not null then 'timestamp'
               when pal_boolean_value is not null then 'boolean'
               else 'string'
             end value_type,
             case
               when pal_string_value is not null then to_char('''' || pal_string_value || '''')
               when pal_xml_value is not null then 'xmltype(q''{' || p.pal_xml_value.getStringVal() || '}'')'
               when pal_integer_value is not null then to_char(pal_integer_value)
               when pal_float_value is not null then to_char(pal_float_value, 'fm99999999999999.9999999999')
               when pal_date_value is not null then 'date ''' || to_char(pal_date_value, 'yyyy-mm-dd') || ''''
               when pal_timestamp_value is not null then 'timestamp ''' || to_char(pal_timestamp_value, 'yyyy-mm-dd hh24:mi:ssxff tzr') || ''''
               when pal_boolean_value is not null then case pal_boolean_value when C_FALSE then 'false' else 'true' end
               else 'null'
             end par_value
        from parameter_local p
       where (pal_pgr_id = p_pgr_id or p_pgr_id is null)
         and ((p_realm = 1 and pal_pre_id != C_PRE_ALL) or (p_realm = 0 and pal_pre_id = C_PRE_ALL))
       order by pal_id;
  
    C_LOCAL_PARAM_TEMPLATE constant varchar2(32767) := q'^
  param.set_#VALUE_TYPE#(
    p_par_id => '#PAR_ID#',
    p_par_pre_id => '#PRE_ID#',
    p_par_pgr_id => '#PGR_ID#',
    p_par_value => #PAR_VALUE#
  );
^';
    C_LOCAL_PARAM_SEPARATOR constant varchar2(32767) := q'^
  -- Local parameters
^';
    
    l_script clob;
    l_chunk clob;
  begin
    dbms_lob.createtemporary(l_script, false, dbms_lob.call);
    
    dbms_lob.append(l_script, C_LOCAL_PARAM_SEPARATOR);
    for par in local_param_cur(p_pgr_id) loop
      l_chunk := replace(replace(replace(replace(replace(replace(C_LOCAL_PARAM_TEMPLATE, 
                   '#VALUE_TYPE#', par.value_type),
                   '#PAR_ID#', par.par_id),
                   '#PRE_ID#', par.pre_id),
                   '#PGR_ID#', par.pgr_id),
                   '#PAR_ID#', par.par_id),
                   '#PAR_VALUE#', par.par_value);
      dbms_lob.append(l_script, l_chunk);
    end loop;
  
    return l_script;
  end get_local_parameters;
  
  
  /**
    Group: Public Methods
   */
  /**
    Procedure: set_import_mode
      See <PARAM_ADMIN.set_import_mode>
   */
  procedure set_import_mode(
    p_mode in boolean)
  as
  begin
    g_import_mode := p_mode;
  end set_import_mode;
  
  
  /**
    Procedure: get_parameter_settings
      See <PARAM_ADMIN.get_parameter_settings>
   */
  function get_parameter_settings(
    p_par_id in parameter_v.par_id%type,
    p_pgr_id in parameter_group.pgr_id%type)
    return parameter_v%rowtype
  as
    l_row parameter_v%rowtype;
    l_pgr_is_modifiable parameter_group.pgr_is_modifiable%type := C_FALSE;
  begin
    select -- If group cannot be modified, override individual setting, otherwise parameter setting
           par_id,
           par_pgr_id,
           case
             when pg.pgr_is_modifiable = C_TRUE then
               coalesce(p.par_is_modifiable, C_TRUE)
             else
               C_FALSE
           end is_modifiable,
           par_validation_string,
           par_validation_message
      into l_row.par_id, 
           l_row.par_pgr_id,
           l_row.par_is_modifiable,
           l_row.par_validation_string,
           l_row.par_validation_message
      from parameter_group pg
      join parameter_v p
        on pg.pgr_id = p.par_pgr_id
     where pg.pgr_id = p_pgr_id
       and p.par_id = p_par_id;
     
     return l_row;
  exception
    when no_data_found then
      l_row.par_id := p_par_id;
      l_row.par_pgr_id := p_pgr_id;
      l_row.par_is_modifiable := C_TRUE;
      l_row.par_validation_string := null;
      l_row.par_validation_message := null;
    return l_row;
  end get_parameter_settings;
  
  
  /**
    Procedure: validate_parameter_group
      See <PARAM_ADMIN.validate_parameter_group>
   */
  procedure validate_parameter_group(
    p_row in parameter_group%rowtype)
  as
  begin
    null;
  end validate_parameter_group;
  
  
  /**
    Procedure: edit_parameter_group
      See <PARAM_ADMIN.edit_parameter_group>
   */
  procedure edit_parameter_group(
    p_pgr_id in parameter_group.pgr_id%type,
    p_pgr_description in parameter_group.pgr_description%type,
    p_pgr_is_modifiable in boolean default true) 
  as
    l_row parameter_group%rowtype;
  begin
    l_row.pgr_id := p_pgr_id;
    l_row.pgr_description := p_pgr_description;
    l_row.pgr_is_modifiable := convert_boolean(p_pgr_is_modifiable);
    
    edit_parameter_group(l_row);
    
  end edit_parameter_group;
  
  
  /**
    Procedure: edit_parameter_group
      See <PARAM_ADMIN.edit_parameter_group>
   */
  procedure edit_parameter_group(
    p_row in parameter_group%rowtype)
  as
  begin
    
    validate_parameter_group(p_row);
    
    merge into parameter_group t
    using (select p_row.pgr_id pgr_id,
                  p_row.pgr_description pgr_description,
                  p_row.pgr_is_modifiable pgr_is_modifiable
             from dual) s
       on (t.pgr_id = s.pgr_id)
     when matched then update set
          pgr_description = s.pgr_description,
          pgr_is_modifiable = s.pgr_is_modifiable
     when not matched then insert
          (pgr_id, pgr_description, pgr_is_modifiable)
          values
          (s.pgr_id, s.pgr_description, s.pgr_is_modifiable);
          
  end edit_parameter_group;
  
  
  /**
    Procedure: delete_parameter_group
      See <PARAM_ADMIN.delete_parameter_group>
   */
  procedure delete_parameter_group(
    p_pgr_id in parameter_group.pgr_id%type,
    p_force in boolean default false)
  as
  begin
    if p_force then
      delete from parameter_local
       where pal_pgr_id = p_pgr_id;
      delete from parameter_tab
       where par_pgr_id = p_pgr_id;
    else
      delete from parameter_local
       where pal_pgr_id = p_pgr_id
         and pal_pre_id != C_PRE_ALL;
      delete from parameter_group
       where pgr_id = p_pgr_id
         and not exists(
             select null
               from parameter_local
              where pal_pgr_id = p_pgr_id);
    end if;
  end delete_parameter_group;
  
  
  /**
    Procedure: harmonize_parameter_group
      See <PARAM_ADMIN.harmonize_parameter_group>
   */
  procedure harmonize_parameter_group(
    p_pgr_id in parameter_group.pgr_id%type)
  as
  begin
    delete from parameter_local
     where pal_pgr_id = p_pgr_id
       and not exists(
           select null
             from parameter_tab
            where par_pgr_id = p_pgr_id
              and par_id = pal_id);
    commit;
  end harmonize_parameter_group;
  
  
  /**
    Procedure: edit_parameter_realm
      See <PARAM_ADMIN.edit_parameter_realm>
   */
  procedure edit_parameter_realm(
    p_pre_id in parameter_realm.pre_id%type,
    p_pre_description in parameter_realm.pre_description%type,
    p_pre_is_active in boolean default true)
  as
    l_row parameter_realm%rowtype;
  begin
    l_row.pre_id := p_pre_id;
    l_row.pre_description := p_pre_description;
    l_row.pre_is_active := convert_boolean(p_pre_is_active);
    
    edit_parameter_realm(l_row);
  end edit_parameter_realm;


  /**
    Procedure: edit_parameter_realm
      See <PARAM_ADMIN.edit_parameter_realm>
   */
  procedure edit_parameter_realm(
    p_row in parameter_realm%rowtype)
  as
  begin
    validate_parameter_realm(p_row);
    
    merge into parameter_realm t
    using (select p_row.pre_id pre_id,
                  p_row.pre_description pre_description,
                  p_row.pre_is_active pre_is_active
             from dual) s
       on (t.pre_id = s.pre_id)
     when matched then update set
          t.pre_description = s.pre_description,
          t.pre_is_active = s.pre_is_active
     when not matched then insert(pre_id, pre_description, pre_is_active)
          values(s.pre_id, s.pre_description, s.pre_is_active);
  end edit_parameter_realm;


  /**
    Procedure: delete_parameter_realm
      See <PARAM_ADMIN.delete_parameter_realm>
   */
  procedure delete_parameter_realm(
    p_pre_id in parameter_realm.pre_id%type,
    p_force in boolean default false)
  as
  begin
    if p_force then
      delete from parameter_local
       where pal_pre_id = p_pre_id;
    end if;
    
    delete from parameter_realm
     where pre_id = p_pre_id;
  end delete_parameter_realm;


  procedure validate_parameter_realm(
    p_pre_id in parameter_realm%rowtype)
  as
  begin
    null;
  end validate_parameter_realm;
  

  /**
    Procedure: edit_parameter_type
      See <PARAM_ADMIN.edit_parameter_type>
   */
  procedure edit_parameter_type(
    p_pat_id parameter_type.pat_id%type,
	  p_pat_description parameter_type.pat_description%type) 
  as
  begin
    merge into parameter_type t
    using (select p_pat_id pat_id,
                  p_pat_description pat_description
             from dual) s
       on (t.pat_id = s.pat_id)
     when matched then update set
          pat_description = s.pat_description
     when not matched then insert
          (pat_id, pat_description)
          values
          (s.pat_id, s.pat_description);
  end edit_parameter_type;
  
  
  /**
    Procedure: validate_parameter
      See <PARAM_ADMIN.validate_parameter>
   */
  procedure validate_parameter(
    p_row in parameter_v%rowtype)
  as
    l_pgr_is_modifiable parameter_tab.par_is_modifiable%type;
    l_stmt varchar2(4000 byte);
    l_valid pls_integer;
  begin
    select coalesce(max(pgr_is_modifiable), C_TRUE)
      into l_pgr_is_modifiable
      from parameter_group
     where pgr_id = p_row.par_pgr_id;
     
    if l_pgr_is_modifiable = C_TRUE or g_import_mode then
      -- Validiere Parameter
      if p_row.par_validation_string is not null then
        -- Erzeuge Validierungsanweisung
        l_stmt := p_row.par_validation_string;
        l_stmt := replace(l_stmt, '#STRING#', p_row.par_string_value);
        l_stmt := replace(l_stmt, '#DATE#', case when p_row.par_date_value is not null then 'timestamp ''' || to_char(p_row.par_date_value, 'yyyy-mm-dd hh24:mi:ss') || '''' else 'NULL' end);
        l_stmt := replace(l_stmt, '#FLOAT#', p_row.par_float_value);
        l_stmt := replace(l_stmt, '#INTEGER#', p_row.par_integer_value);
        l_stmt := replace(l_stmt, '#BOOLEAN#', case when coalesce(p_row.par_boolean_value, C_TRUE) = C_TRUE then dbms_assert.enquote_literal(C_TRUE) else dbms_assert.enquote_literal(C_FALSE) end);
        l_stmt := 'begin if ' || l_stmt || ' then :x := 1; else :x := 0; end if; end;';
        -- Validiere den Ausdruck
        begin
          execute immediate l_stmt using out l_valid;
        exception
          when others then
            raise_application_error(-20000, 'Invalid validation string "' || l_stmt || '" at ' || p_row.par_id);
        end;
        if l_valid != 1 then
          -- Validierung fehlgeschlagen, Fehler erzeugen
          raise_application_error(-20000, l_stmt || ': ' || p_row.par_validation_message);
        end if;
      end if;
    else
      raise_application_error(-20000, 'Parameter group not modifiable');
    end if;
  end validate_parameter;
  

  /**
    Procedure: edit_parameter
      See <PARAM_ADMIN.edit_parameter>
   */
  procedure edit_parameter(
    p_par_id in parameter_tab.par_id%type,
    p_par_pgr_id in parameter_tab.par_pgr_id%type,
	  p_par_description in parameter_tab.par_description%type default null,
    p_par_string_value in parameter_tab.par_string_value%type default null,
    p_par_xml_value in parameter_tab.par_xml_value%type default null,
    p_par_integer_value in parameter_tab.par_integer_value%type default null,
    p_par_float_value in parameter_tab.par_float_value%type default null,
    p_par_date_value in parameter_tab.par_date_value%type default null,
    p_par_timestamp_value in parameter_tab.par_timestamp_value%type default null,
    p_par_boolean_value in boolean default null,
    p_par_is_modifiable in boolean default null,
    p_par_pat_id in parameter_tab.par_pat_id%type default null,
    p_par_validation_string in parameter_tab.par_validation_string%type default null,
    p_par_validation_message in parameter_tab.par_validation_message%type default null) 
  as
    l_row parameter_v%rowtype;
  begin
    -- copy parameters to record instance
    l_row.par_id := p_par_id;
    l_row.par_pgr_id := p_par_pgr_id;
    l_row.par_description := p_par_description;
    l_row.par_string_value := p_par_string_value;
    l_row.par_xml_value := p_par_xml_value;
    l_row.par_integer_value := p_par_integer_value;
    l_row.par_float_value := p_par_float_value;
    l_row.par_date_value := p_par_date_value;
    l_row.par_timestamp_value := p_par_timestamp_value;
    l_row.par_boolean_value := convert_boolean(p_par_boolean_value);
    l_row.par_is_modifiable := convert_boolean(p_par_is_modifiable);
    l_row.par_pat_id := p_par_pat_id;
    l_row.par_validation_string := p_par_validation_string;
    l_row.par_validation_message := p_par_validation_message;
    
    edit_parameter(l_row);
    
  end edit_parameter;
  
  
  /**
    Procedure: edit_parameter
      See <PARAM_ADMIN.edit_parameter>
   */
  procedure edit_parameter(
    p_row in parameter_v%rowtype)
  as
  begin
    validate_parameter(p_row);
    
    merge into parameter_tab t
    using (select p_row.par_id par_id,
                  p_row.par_pgr_id par_pgr_id,
                  p_row.par_description par_description,
                  p_row.par_string_value par_string_value,
                  p_row.par_xml_value par_xml_value,
                  p_row.par_integer_value par_integer_value,
                  p_row.par_float_value par_float_value,
                  p_row.par_date_value par_date_value,
                  p_row.par_timestamp_value par_timestamp_value,
                  p_row.par_boolean_value par_boolean_value,
                  p_row.par_is_modifiable par_is_modifiable,
                  p_row.par_pat_id par_pat_id,
                  p_row.par_validation_string par_validation_string,
                  p_row.par_validation_message par_validation_message
             from dual) s
       on (t.par_id = s.par_id
       and t.par_pgr_id = s.par_pgr_id)
     when matched then update set
          par_description = coalesce(s.par_description, t.par_description),
          par_string_value = s.par_string_value,
          par_xml_value = s.par_xml_value,
          par_integer_value = s.par_integer_value,
          par_float_value = s.par_float_value,
          par_date_value = s.par_date_value,
          par_timestamp_value = s.par_timestamp_value,
          par_boolean_value = s.par_boolean_value,
          par_is_modifiable = s.par_is_modifiable,
          par_pat_id = s.par_pat_id,
          par_validation_string = s.par_validation_string,
          par_validation_message = s.par_validation_message          
     when not matched then insert
          (par_id, par_pgr_id, par_description, par_string_value, 
           par_xml_value, par_integer_value, par_float_value, par_date_value, par_timestamp_value,
           par_boolean_value, par_is_modifiable, par_pat_id, par_validation_string, par_validation_message)
          values
          (s.par_id, s.par_pgr_id, s.par_description, s.par_string_value, 
           s.par_xml_value, s.par_integer_value, s.par_float_value, s.par_date_value, s.par_timestamp_value,
           s.par_boolean_value, s.par_is_modifiable, s.par_pat_id, s.par_validation_string, s.par_validation_message);

  end edit_parameter;


  /**
    Procedure: delete_parameter
      See <PARAM_ADMIN.delete_parameter>
   */
  procedure delete_parameter(
    p_par_id in parameter_tab.par_id%type,
    p_par_pgr_id in parameter_tab.par_pgr_id%type)
  as
  begin
    delete from parameter_tab
     where par_id = p_par_id
       and par_pgr_id = p_par_pgr_id;
  end delete_parameter;
  
  
  /**
    Procedure: validate_realm_parameter
      See <PARAM_ADMIN.validate_realm_parameter>
   */
  procedure validate_realm_parameter(
    p_row in out nocopy parameter_v%rowtype)
  as
    param_value_invalid exception;
    param_not_modifiable exception;
    pragma exception_init(param_value_invalid, -20000);
    pragma exception_init(param_not_modifiable, -20001);
    l_parameter_rec parameter_v%rowtype;
  begin
    l_parameter_rec := p_row;
    l_parameter_rec := get_parameter_settings(
                         p_par_id => p_row.par_id,
                         p_pgr_id => p_row.par_pgr_id);
    
    if l_parameter_rec.par_is_modifiable = C_TRUE then
    
                           
      param_admin.validate_parameter(l_parameter_rec);
    else
      if l_parameter_rec.par_id is not null then
        raise_application_error(-20000, 'Parameter not existing');
      else
        raise_application_error(-20001, 'Parameter not modifiable');
      end if;
    end if;
  
  end validate_realm_parameter;
  
  
  /**
    Procedure: edit_realm_parameter
      See <PARAM_ADMIN.edit_realm_parameter>
   */
  procedure edit_realm_parameter(
    p_par_id parameter_v.par_id%type,
    p_par_pgr_id parameter_v.par_pgr_id%type,
    p_par_pre_id in parameter_realm.pre_id%type,
    p_par_string_value in parameter_v.par_string_value%type default null,
    p_par_xml_value in parameter_v.par_xml_value%type default null,
    p_par_integer_value in parameter_v.par_integer_value%type default null,
    p_par_float_value in parameter_v.par_float_value%type default null,
    p_par_date_value in parameter_v.par_date_value%type default null,
    p_par_timestamp_value in parameter_v.par_timestamp_value%type default null,
    p_par_boolean_value in boolean default null)
  as
    l_row parameter_v%rowtype;
  begin 
  
    l_row.par_id := p_par_id;
    l_row.par_pgr_id := p_par_pgr_id;
    l_row.par_pre_id := p_par_pre_id;
    l_row.par_string_value := p_par_string_value;
    l_row.par_xml_value := p_par_xml_value;
    l_row.par_integer_value := p_par_integer_value;
    l_row.par_float_value := p_par_float_value;
    l_row.par_date_value := p_par_date_value;
    l_row.par_timestamp_value := p_par_timestamp_value;
    l_row.par_boolean_value := convert_boolean(p_par_boolean_value);
    
    edit_realm_parameter(l_row);
    
  end edit_realm_parameter;
  
  
  /**
    Procedure: edit_realm_parameter
      See <PARAM_ADMIN.edit_realm_parameter>
   */
  procedure edit_realm_parameter(
    p_row in parameter_v%rowtype)
  as
    l_row parameter_v%rowtype;
  begin
  
    l_row := p_row;
    validate_realm_parameter(l_row);
    
    merge into parameter_local t
    using (select p_row.par_id pal_id,
                  p_row.par_pgr_id pal_pgr_id,
                  p_row.par_pre_id pal_pre_id,
                  p_row.par_string_value pal_string_value,
                  p_row.par_xml_value pal_xml_value,
                  p_row.par_integer_value pal_integer_value,
                  p_row.par_float_value pal_float_value,
                  p_row.par_date_value pal_date_value,
                  p_row.par_timestamp_value pal_timestamp_value,
                  p_row.par_boolean_value pal_boolean_value
             from dual) s
       on (t.pal_id = s.pal_id
       and t.pal_pgr_id = s.pal_pgr_id
           -- realm may or may not be set
       and decode(t.pal_pre_id, s.pal_pre_id, 0, 1) = 0)
     when matched then update set
          t.pal_string_value = s.pal_string_value,
          t.pal_xml_value = s.pal_xml_value,
          t.pal_integer_value = s.pal_integer_value,
          t.pal_float_value = s.pal_float_value,
          t.pal_date_value = s.pal_date_value,
          t.pal_timestamp_value = s.pal_timestamp_value,
          t.pal_boolean_value = s.pal_boolean_value
     when not matched then insert
          (pal_id, pal_pgr_id, pal_pre_id, pal_string_value, pal_xml_value, pal_integer_value, 
           pal_float_value, pal_date_value, pal_timestamp_value, pal_boolean_value)
          values
          (s.pal_id, s.pal_pgr_id, s.pal_pre_id, s.pal_string_value, s.pal_xml_value, s.pal_integer_value, 
           s.pal_float_value, s.pal_date_value, s.pal_timestamp_value, s.pal_boolean_value);
    
  end edit_realm_parameter;
  
  
  /**
    Procedure: delete_realm_parameter
      See <PARAM_ADMIN.delete_realm_parameter>
   */
  procedure delete_realm_parameter(
    p_par_id parameter_v.par_id%type,
    p_par_pgr_id parameter_v.par_pgr_id%type,
    p_par_pre_id in parameter_realm.pre_id%type)
  as
  begin
    delete from parameter_local
     where pal_id = p_par_id
       and pal_pgr_id = p_par_pgr_id
       and pal_pre_id = p_par_pre_id;
  end delete_realm_parameter;
  
  
  /**
    Procedure: export_parameter_group
      See <PARAM_ADMIN.export_parameter_group>
   */
  function export_parameter_group(
    p_pgr_id in parameter_group.pgr_id%type)
    return clob
  as
       
    l_script clob;
    l_chunk clob;
    l_clause varchar2(32767);
    c_start constant varchar2(2000) := q'~set define ~
    
begin
  param_admin.set_import_mode(true);
  
~';
    c_end constant varchar2(2000) := q'~
  
  param_admin.harmonize_parameter_group('#PGR_ID#');
  
  param_admin.set_import_mode(false);
  commit;
end;~' || chr(10) || '/' || chr(10) || 'set define &' || chr(10);

  begin
    dbms_lob.createtemporary(l_script, false, dbms_lob.call);
    dbms_lob.append(l_script, c_start);
    dbms_lob.append(l_script, get_parameter_group(p_pgr_id));
    dbms_lob.append(l_script, get_parameters(p_pgr_id));
    --dbms_lob.append(l_script, get_parameter_realms(p_pgr_id));
    dbms_lob.append(l_script, get_local_parameters(p_pgr_id, p_realm => 1));
    dbms_lob.append(l_script, REPLACE(C_END, '#PGR_ID#', p_pgr_id));
    return l_script;
  end export_parameter_group;
  
  
  /**
    Procedure: export_local_parameters
      See <PARAM_ADMIN.export_local_parameters>
   */
  function export_local_parameters(
    p_pgr_id in parameter_group.pgr_id%type default null)
    return clob
  as
    l_script clob;
    c_start constant varchar2(2000) := q'~begin
~';
    c_end constant varchar2(2000) := q'~
    
  commit;
end;
/~';
  begin
    dbms_lob.createtemporary(l_script, false, dbms_lob.call);
    dbms_lob.append(l_script, c_start);
    dbms_lob.append(l_script, get_local_parameters(p_pgr_id, p_realm => 0));
    dbms_lob.append(l_script, REPLACE(C_END, '#PGR_ID#', p_pgr_id));
    return l_script;
  end export_local_parameters;

       
end param_admin;
/
