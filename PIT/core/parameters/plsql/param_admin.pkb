create or replace package body param_admin
as
  
  type char_table is table of varchar2(4000);
  
  /* TODO: Helper is identical to bulk_replace within PIT_ADMIN
           if available, call should be replaced with call to generic helper
           method in a utility package
   */
  /* Helper to bulk-replace chunks in a text
   * %param p_string Text with replacement anchors
   * %param p_chunks List of chars for replacement
   * %return p_string with replacements
   * %usage Is called to replace more replacement anchors at once
   */
  function bulk_replace(
    p_string in varchar2,
    p_chunks in char_table)
    return varchar2
  as
    l_string varchar2(32767) := p_string;
  begin
    for i in p_chunks.first .. p_chunks.last loop
      if mod(i, 2) = 1 then
        l_string := replace(l_string, p_chunks(i), p_chunks(i+1));
      end if;
    end loop;
    return l_string;
  end bulk_replace;
  

  procedure edit_parameter_group(
    p_parameter_group_id varchar2,
    p_group_description varchar2,
    p_is_modifiable varchar2) 
  as
  begin
    merge into parameter_group p
    using (select p_parameter_group_id parameter_group_id,
                  p_group_description group_description,
                  p_is_modifiable is_modifiable
             from dual) v
       on (p.parameter_group_id = v.parameter_group_id)
     when matched then update set
          group_description = v.group_description,
          is_modifiable = v.is_modifiable
     when not matched then insert
          (parameter_group_id, group_description, is_modifiable)
          values
          (v.parameter_group_id, v.group_description, v.is_modifiable);
  end edit_parameter_group;
  

  procedure edit_parameter_type(
    p_parameter_type_id varchar2,
    p_type_description varchar2) as
  begin
    merge into parameter_type p
    using (select p_parameter_type_id parameter_type_id,
                  p_type_description type_description
             from dual) v
       on (p.parameter_type_id = v.parameter_type_id)
     when matched then update set
          type_description = v.type_description
     when not matched then insert
          (parameter_type_id, type_description)
          values
          (v.parameter_type_id, v.type_description);
  end edit_parameter_type;
  

  procedure edit_parameter(
    p_parameter_id in varchar2,
    p_parameter_group_id in varchar2,
    p_parameter_description in varchar2,
    p_string_value in clob default null,
    p_xml_value in xmltype default null,
    p_integer_value in number default null,
    p_float_value in number default null,
    p_date_value in date default null,
    p_timestamp_value in timestamp with time zone default null,
    p_boolean_value in varchar2 default null,
    p_is_modifiable in varchar2 default null,
    p_parameter_type_id in varchar2 default null,
    p_validation_string in varchar2 default null,
    p_validation_message in varchar2 default null) as
  begin
    merge into parameter_tab p
    using (select p_parameter_id parameter_id,
                  p_parameter_group_id parameter_group_id,
                  p_parameter_description parameter_description,
                  p_string_value string_value,
                  p_xml_value xml_value,
                  p_integer_value integer_value,
                  p_float_value float_value,
                  p_date_value date_value,
                  p_timestamp_value timestamp_value,
                  p_boolean_value boolean_value,
                  p_is_modifiable is_modifiable,
                  p_validation_string validation_string,
                  p_validation_message validation_message
             from dual) v
       on (p.parameter_id = v.parameter_id
       and p.parameter_group_id = v.parameter_group_id)
     when matched then update set
          parameter_description = v.parameter_description,
          string_value = v.string_value,
          xml_value = v.xml_value,
          integer_value = v.integer_value,
          float_value = v.float_value,
          date_value = v.date_value,
          timestamp_value = v.timestamp_value,
          boolean_value = v.boolean_value,
          is_modifiable = v.is_modifiable,
          validation_string = v.validation_string,
          validation_message = v.validation_message          
     when not matched then insert
          (parameter_id, parameter_group_id, parameter_description, string_value, 
           xml_value, integer_value, float_value, date_value, timestamp_value,
           boolean_value, is_modifiable, validation_string, validation_message)
          values
          (v.parameter_id, v.parameter_group_id, v.parameter_description, v.string_value, 
           v.xml_value, v.integer_value, v.float_value, v.date_value, v.timestamp_value,
           v.boolean_value, v.is_modifiable, v.validation_string, v.validation_message);
  end edit_parameter;


  procedure delete_parameter(
    p_parameter_id in varchar2,
    p_parameter_group_id in varchar2)
  as
  begin
    delete from parameter_tab
     where parameter_id = p_parameter_id
       and parameter_group_id = p_parameter_group_id;
  end delete_parameter;
  
  
  procedure write_parameter_files(
    p_param_group in varchar2 default null,
    p_directory in varchar2 default 'DATA_DIR')
  as
    cursor param_cur(p_param_group in varchar2) is
      select g.parameter_group_id, g.group_description, g.is_modifiable group_modifiable, 
             p.parameter_id,
             p.parameter_description,
             p.string_value,
             p.xml_value.getclobval() xml_value,
             to_char(integer_value) integer_value,
             replace(to_char(float_value), ',', '.') float_value,
             to_char(date_value, 'yyyy-mm-dd hh24:mi:ss') date_value,
             to_char(timestamp_value, 'yyyy-mm-dd hh24:mi:ssxff tzr') timestamp_value,
             boolean_value,
             p.is_modifiable param_modifiable,
             parameter_type_id,
             validation_string,
             validation_message,
             row_number() over (partition by p_param_group order by p.parameter_id) row_num
        from parameter_tab p
        join parameter_group g
          on p.parameter_group_id = g.parameter_group_id
       where g.parameter_group_id = p_param_group or p_param_group is null
       order by p.parameter_id;
    l_script clob;
    l_chunk clob;
    l_clause varchar2(32767);
    l_file_name varchar2(200);
    c_start constant varchar2(2000) := q'~begin
~';
    c_end constant varchar2(2000) := q'~
  commit;
end;
/~';
    c_group_template constant varchar2(32767) := q'~
  param_admin.edit_parameter_group(
    p_parameter_group_id => '#PARAM_GROUP#',
    p_group_description => '#GROUP_DESCRIPTION#',
    p_is_modifiable => '#GROUP_MODIFIABLE#'
  );
~';
    c_param_template constant varchar2(32767) := q'~
  param_admin.edit_parameter(
    p_parameter_id => '#PARAM_NAME#'
   ,p_parameter_group_id => '#PARAM_GROUP#'
   ,p_parameter_description => '#PARAM_DESCRIPTION#'#CLAUSES#
  );
~';
    c_string_template constant varchar2(50) := q'~   ,p_string_value => q'ø#STRING#ø'~';
    c_xml_template constant varchar2(50) := q'~   ,p_xml_value => xmltype(q'ø#XML#ø')~';
    c_integer_template constant varchar2(50) := q'~   ,p_integer_value => #INTEGER#~';
    c_float_template constant varchar2(50) := q'~   ,p_float_value => #FLOAT#~';
    c_date_template constant varchar2(50) := q'~   ,p_date_value => date '#DATE#'~';
    c_timestamp_template constant varchar2(50) := q'~   ,p_timestamp_value => timestamp '#TIMESTAMP#'~';
    c_boolean_template constant varchar2(50) := q'~   ,p_boolean_value => '#BOOLEAN#'~';
    c_modifiable_template constant varchar2(50) := q'~   ,p_is_modifiable => '#MODIFIABLE#'~';
    c_param_type_template constant varchar2(50) := q'~   ,p_parameter_type_id => '#PARAM_TYPE#'~';
    c_validataion_template constant varchar2(50) := q'~   ,p_validation_string => q'ø#VALIDATION#ø'~';
    c_val_msg_template constant varchar2(50) := q'~   ,p_validation_message => q'ø#VAL_MSG#ø'~';
    
    procedure calc_clause(
      p_clause in out nocopy varchar2,
      p_value in varchar2,
      p_pattern in varchar2,
      p_template in varchar2)
    as
    begin
      if p_value is not null then
        p_clause := p_clause || chr(13) || replace(p_template, p_pattern, p_value);
      end if;
    end calc_clause;
  begin
    dbms_lob.createtemporary(l_script, false, dbms_lob.call);
    dbms_lob.append(l_script, c_start);
    for par in param_cur(p_param_group) loop
      l_file_name := par.parameter_group_id || '.sql';
      if par.row_num = 1 then
        l_chunk := bulk_replace(c_group_template, char_table(
                     '#PARAM_GROUP#', par.parameter_group_id,
                     '#GROUP_DESCRIPTION#', par.group_description,
                     '#GROUP_MODIFIABLE#', par.group_modifiable));
        dbms_lob.append(l_script, l_chunk);
      end if;
      calc_clause(l_clause, par.string_value, '#STRING#', c_string_template);
      calc_clause(l_clause, par.xml_value, '#XML#', c_xml_template);
      calc_clause(l_clause, par.integer_value, '#INTEGER#', c_integer_template);
      calc_clause(l_clause, par.float_value, '#FLOAT#', c_float_template);
      calc_clause(l_clause, par.date_value, '#DATE#', c_date_template);
      calc_clause(l_clause, par.timestamp_value, '#TIMESTAMP#', c_timestamp_template);
      calc_clause(l_clause, par.boolean_value, '#BOOLEAN#', c_boolean_template);
      calc_clause(l_clause, par.param_modifiable, '#MODIFIABLE#', c_modifiable_template);
      calc_clause(l_clause, par.parameter_type_id, '#PARAM_TYPE#', c_param_type_template);
      calc_clause(l_clause, par.validation_string, '#VALIDATION#', c_validataion_template);
      calc_clause(l_clause, par.validation_message, '#VAL_MSG#', c_val_msg_template);
      l_chunk := bulk_replace(c_param_template, char_table(
                   '#PARAM_NAME#', par.parameter_id,
                   '#PARAM_GROUP#', par.parameter_group_id,
                   '#PARAM_DESCRIPTION#', par.parameter_description,
                   '#CLAUSES#', l_clause));
      l_clause := null;
      dbms_lob.append(l_script, l_chunk);
    end loop;
    dbms_lob.append(l_script, c_end);
    
    dbms_xslprocessor.clob2file(l_script, p_directory, l_file_name);
  end write_parameter_files;

       
end param_admin;
/
