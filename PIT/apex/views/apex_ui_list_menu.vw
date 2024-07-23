create or replace view apex_ui_list_menu as
   with params as (
         select utl_apex.get_application_id(utl_apex.c_false) application_id,
                utl_apex.c_true is_true
           from dual)
 select /*+ no_merge (p) */
        level level_value,
        list_name,
        display_sequence,
        parent_entry_text,
        entry_text label_value,
        entry_target target_value,
        'NO' is_current,
        entry_image image_value,
        entry_image_attributes image_attr_value,
        entry_image_alt_attribute image_alt_value,
        entry_attribute_01 attribute_01,
        entry_attribute_02 attribute_02,
        entry_attribute_03 attribute_03,
        entry_attribute_04 attribute_04,
        entry_attribute_05 attribute_05,
        entry_attribute_06 attribute_06,
        entry_attribute_07 attribute_07,
        entry_attribute_08 attribute_08,
        entry_attribute_09 attribute_09,
        entry_attribute_10 attribute_10
   from apex_application_list_entries l
   left join apex_application_build_options o
     on l.application_id = o.application_id
    and l.build_option = o.build_option_name
   join params p
     on l.application_id = p.application_id
    and utl_apex.user_is_authorized(l.authorization_scheme) = p.is_true
  where coalesce(o.build_option_status, 'Include') = 'Include'
  start with list_entry_parent_id is null
connect by prior list_entry_id = list_entry_parent_id;
