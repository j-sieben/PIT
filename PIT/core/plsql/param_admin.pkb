create or replace package body param_admin
as

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
       
end param_admin;
/
