create or replace package body param_admin
as
  
  c_pkg constant &ORA_NAME_TYPE. := $$PLSQL_UNIT;
  c_true constant &FLAG_TYPE. := &C_TRUE.;
  c_false constant &FLAG_TYPE. := &C_FALSE.;

  function convert_boolean(
    p_value in boolean)
    return varchar2
  as
    l_boolean parameter_tab.par_boolean_value%type;
  begin
    l_boolean := case when p_value then c_true
                      when not p_value then c_false
                      else null end;
    return l_boolean;
  end convert_boolean;
  
  
  procedure edit_parameter_group(
    p_pgr_id in parameter_group.pgr_id%type,
    p_pgr_description in parameter_group.pgr_description%type,
    p_pgr_is_modifiable in boolean default true) 
  as
    l_is_modifiable parameter_tab.par_is_modifiable%type;
  begin
    l_is_modifiable := convert_boolean(p_pgr_is_modifiable);
    merge into parameter_group p
    using (select p_pgr_id pgr_id,
                  p_pgr_description pgr_description,
                  l_is_modifiable pgr_is_modifiable
             from dual) v
       on (p.pgr_id = v.pgr_id)
     when matched then update set
          pgr_description = v.pgr_description,
          pgr_is_modifiable = v.pgr_is_modifiable
     when not matched then insert
          (pgr_id, pgr_description, pgr_is_modifiable)
          values
          (v.pgr_id, v.pgr_description, v.pgr_is_modifiable);
  end edit_parameter_group;
  

  procedure edit_parameter_type(
    p_pat_id parameter_type.pat_id%type,
	  p_pat_description parameter_type.pat_description%type) 
  as
  begin
    merge into parameter_type p
    using (select p_pat_id pat_id,
                  p_pat_description pat_description
             from dual) v
       on (p.pat_id = v.pat_id)
     when matched then update set
          pat_description = v.pat_description
     when not matched then insert
          (pat_id, pat_description)
          values
          (v.pat_id, v.pat_description);
  end edit_parameter_type;
  

  procedure edit_parameter(
    p_par_id in parameter_tab.par_id%type,
    p_par_pgr_id in parameter_tab.par_pgr_id%type,
	  p_par_description in parameter_tab.par_description%type,
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
    l_boolean parameter_tab.par_boolean_value%type;
    l_is_modifiable parameter_tab.par_is_modifiable%type;
  begin
    l_boolean := convert_boolean(p_par_boolean_value);
    l_is_modifiable := convert_boolean(p_par_is_modifiable);
                      
    merge into parameter_tab p
    using (select p_par_id par_id,
                  p_par_pgr_id par_pgr_id,
                  p_par_description par_description,
                  p_par_string_value par_string_value,
                  p_par_xml_value par_xml_value,
                  p_par_integer_value par_integer_value,
                  p_par_float_value par_float_value,
                  p_par_date_value par_date_value,
                  p_par_timestamp_value par_timestamp_value,
                  l_boolean par_boolean_value,
                  l_is_modifiable par_is_modifiable,
                  p_par_pat_id par_pat_id,
                  p_par_validation_string par_validation_string,
                  p_par_validation_message par_validation_message
             from dual) v
       on (p.par_id = v.par_id
       and p.par_pgr_id = v.par_pgr_id)
     when matched then update set
          par_description = v.par_description,
          par_string_value = v.par_string_value,
          par_xml_value = v.par_xml_value,
          par_integer_value = v.par_integer_value,
          par_float_value = v.par_float_value,
          par_date_value = v.par_date_value,
          par_timestamp_value = v.par_timestamp_value,
          par_boolean_value = v.par_boolean_value,
          par_is_modifiable = v.par_is_modifiable,
          par_pat_id = v.par_pat_id,
          par_validation_string = v.par_validation_string,
          par_validation_message = v.par_validation_message          
     when not matched then insert
          (par_id, par_pgr_id, par_description, par_string_value, 
           par_xml_value, par_integer_value, par_float_value, par_date_value, par_timestamp_value,
           par_boolean_value, par_is_modifiable, par_pat_id, par_validation_string, par_validation_message)
          values
          (v.par_id, v.par_pgr_id, v.par_description, v.par_string_value, 
           v.par_xml_value, v.par_integer_value, v.par_float_value, v.par_date_value, v.par_timestamp_value,
           v.par_boolean_value, v.par_is_modifiable, v.par_pat_id, v.par_validation_string, v.par_validation_message);
  end edit_parameter;


  procedure delete_parameter(
    p_par_id in parameter_tab.par_id%type,
    p_par_pgr_id in parameter_tab.par_pgr_id%type)
  as
  begin
    delete from parameter_tab
     where par_id = p_par_id
       and par_pgr_id = p_par_pgr_id;
  end delete_parameter;
  
  
  function export_parameter_group(
    p_pgr_id in parameter_group.pgr_id%type)
    return clob
  as
    cursor param_cur(p_pgr_id in varchar2) is
      select g.pgr_id, g.pgr_description, g.pgr_is_modifiable group_modifiable, 
             p.par_id,
             p.par_description,
             p.par_string_value,
             p.par_xml_value.getclobval() par_xml_value,
             to_char(par_integer_value) par_integer_value,
             replace(to_char(par_float_value), ',', '.') par_float_value,
             to_char(par_date_value, 'yyyy-mm-dd hh24:mi:ss') par_date_value,
             to_char(par_timestamp_value, 'yyyy-mm-dd hh24:mi:ssxff tzr') par_timestamp_value,
             par_boolean_value,
             p.par_is_modifiable param_modifiable,
             par_pat_id,
             par_validation_string,
             par_validation_message,
             row_number() over (partition by g.pgr_id order by p.par_id) row_num
        from parameter_tab p
        join parameter_group g
          on p.par_pgr_id = g.pgr_id
       where g.pgr_id = p_pgr_id
          or p_pgr_id is null
       order by p.par_id;
    l_script clob;
    l_chunk clob;
    l_clause varchar2(32767);
    c_start constant varchar2(2000) := q'~begin
~';
    c_end constant varchar2(2000) := q'~
  commit;
end;
/~';
    c_group_template constant varchar2(32767) := q'~
  param_admin.edit_parameter_group(
    p_par_pgr_id => '#PARAM_GROUP#',
    p_pgr_description => '#pgr_description#',
    p_par_is_modifiable => '#GROUP_MODIFIABLE#'
  );
~';
    c_param_template constant varchar2(32767) := q'~
  param_admin.edit_parameter(
    p_par_id => '#PARAM_NAME#'
   ,p_par_pgr_id => '#PARAM_GROUP#'
   ,p_par_description => '#PARAM_DESCRIPTION#'#CLAUSES#
  );
~';
    c_string_template constant varchar2(100) := q'~   ,p_par_string_value => q'^#STRING#^'~';
    c_xml_template constant varchar2(100) := q'~   ,p_par_xml_value => xmltype(q'^#XML#^')~';
    c_integer_template constant varchar2(100) := q'~   ,p_par_integer_value => #INTEGER#~';
    c_float_template constant varchar2(100) := q'~   ,p_par_float_value => #FLOAT#~';
    c_date_template constant varchar2(100) := q'~   ,p_par_date_value => date '#DATE#'~';
    c_timestamp_template constant varchar2(100) := q'~   ,p_par_timestamp_value => timestamp '#TIMESTAMP#'~';
    c_boolean_template constant varchar2(100) := q'~   ,p_par_boolean_value => '#BOOLEAN#'~';
    c_modifiable_template constant varchar2(100) := q'~   ,p_par_is_modifiable => '#MODIFIABLE#'~';
    c_param_type_template constant varchar2(100) := q'~   ,p_par_pat_id => '#PARAM_TYPE#'~';
    c_validataion_template constant varchar2(100) := q'~   ,p_par_validation_string => q'^#VALIDATION#^'~';
    c_val_msg_template constant varchar2(100) := q'~   ,p_par_validation_message => q'^#VAL_MSG#^'~';
    
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
    for par in param_cur(p_pgr_id) loop
      if par.row_num = 1 then
        l_chunk := replace(replace(replace(c_group_template,
                     '#PARAM_GROUP#', par.pgr_id),
                     '#pgr_description#', par.pgr_description),
                     '#GROUP_MODIFIABLE#', par.group_modifiable);
        dbms_lob.append(l_script, l_chunk);
      end if;
      calc_clause(l_clause, par.par_string_value, '#STRING#', c_string_template);
      calc_clause(l_clause, par.par_xml_value, '#XML#', c_xml_template);
      calc_clause(l_clause, par.par_integer_value, '#INTEGER#', c_integer_template);
      calc_clause(l_clause, par.par_float_value, '#FLOAT#', c_float_template);
      calc_clause(l_clause, par.par_date_value, '#DATE#', c_date_template);
      calc_clause(l_clause, par.par_timestamp_value, '#TIMESTAMP#', c_timestamp_template);
      calc_clause(l_clause, par.par_boolean_value, '#BOOLEAN#', c_boolean_template);
      calc_clause(l_clause, par.param_modifiable, '#MODIFIABLE#', c_modifiable_template);
      calc_clause(l_clause, par.par_pat_id, '#PARAM_TYPE#', c_param_type_template);
      calc_clause(l_clause, par.par_validation_string, '#VALIDATION#', c_validataion_template);
      calc_clause(l_clause, par.par_validation_message, '#VAL_MSG#', c_val_msg_template);
      l_chunk := replace(replace(replace(replace(c_param_template, 
                   '#PARAM_NAME#', par.par_id),
                   '#PARAM_GROUP#', par.pgr_id),
                   '#PARAM_DESCRIPTION#', par.par_description),
                   '#CLAUSES#', l_clause);
      l_clause := null;
      dbms_lob.append(l_script, l_chunk);
    end loop;
    dbms_lob.append(l_script, c_end);
    return l_script;
  end export_parameter_group;
  
  
  procedure write_parameter_files(
    p_pgr_id in parameter_group.pgr_id%type default null,
    p_directory in varchar2 default 'DATA_DIR')
  as
    cursor param_group_cur (p_pgr_id in parameter_group.pgr_id%type) is
      select pgr_id
        from parameter_group
       where pgr_id = p_pgr_id 
          or p_pgr_id is null;
    l_file_name varchar2(200);
  begin
    for pgr in param_group_cur (p_pgr_id) loop
      l_file_name := pgr.pgr_id || '.sql';
      dbms_xslprocessor.clob2file(export_parameter_group(pgr.pgr_id), p_directory, l_file_name);
    end loop;
  end write_parameter_files;

       
end param_admin;
/
