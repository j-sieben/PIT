create or replace force view pita_ui_admin_pms as
with session_state as(
       select /*+ no_merge */
              utl_apex.get_string('P2_PMG_NAME') pmg_name,
              utl_apex.get_string('P2_PML_NAME') pml_name,
              pml_name pml_name_default,
              pml_display_name
         from table(pit_app_api.get_pit_message_language_table)
        where pml_default_order = 10),
    messages as(
       select pms_name, pms_pmg_name, pms_pml_name, pms_pse_id, pms_custom_error, pms_active_error, 
              dbms_lob.substr(pms_text, 4000, 1) pms_text, 
              dbms_lob.substr(pms_description, 4000, 1) pms_description
         from table(pit_app_api.get_pit_message_table) pms
         join session_state s
           on pms.pms_pml_name = s.pml_name_default
          and pms.pms_pmg_name = s.pmg_name),
    translated_messages as (
       select pms_name, pms_pml_name,
              dbms_lob.substr(pms_text, 4000, 1) pms_text, 
              dbms_lob.substr(pms_description, 4000, 1) pms_description
         from table(pit_app_api.get_pit_message_table) pmt
         join session_state s
           on pms_pml_name = pml_name),
    best_match_messages as(
       select m.pms_name,
              m.pms_pmg_name,
              coalesce(t.pms_pml_name, m.pms_pml_name) pms_pml_name,
              coalesce(t.pms_text, m.pms_text) pms_text,
              coalesce(t.pms_description, m.pms_description) pms_description,
              m.pms_pse_id,
              m.pms_custom_error,
              m.pms_active_error
         from messages m
         left join translated_messages t
           on m.pms_name = t.pms_name)
select utl_apex.get_page_url(
         p_page => 'edit_pms',
         p_param_items => 'P3_PMS_PMG_NAME,P3_PMS_NAME,P3_PMS_PML_NAME',
         p_value_list => pms_pmg_name || ',' || pms_name || ',' || pms_pml_name,
         p_triggering_element => '#R2_MESSAGES') pms_link,
       m.pms_name,
       g.pmg_name || ' - ' || g.pmg_description pms_pmg_name,
       m.pms_pml_name,
       pml.pml_display_name,
       m.pms_text,
       pms_description,
       m.pms_pse_id,
       pse.pse_display_name,
       m.pms_custom_error,
       m.pms_active_error
  from best_match_messages m
  join table(pit_app_api.get_pit_message_group_table) g
    on m.pms_pmg_name = g.pmg_name
  join table(pit_app_api.get_pit_message_language_table) pml
    on m.pms_pml_name = pml.pml_name
  join table(pit_app_api.get_pit_message_severity_table) pse
    on m.pms_pse_id = pse.pse_id
 where pml_rank = 1;
    