create or replace force view pit_ui_admin_pms as
with session_state as(
       select v('P2_PMG_NAME') pmg_name,
              v('P2_PML_NAME') pml_name,
              pml_name pml_name_default
         from pit_message_language
        where pml_default_order = 10),
    messages as(
       select /*+ no_merge (s) */
              pms.rowid row_id, pms_name, pms_pmg_name, pms_pml_name, pms_pse_id, pms_custom_error, pms_active_error, 
              dbms_lob.substr(pms_text, 4000, 1) pms_text, 
              dbms_lob.substr(pms_description, 4000, 1) pms_description
         from pit_message pms
         join session_state s
           on pms.pms_pml_name = s.pml_name_default
          and (pms.pms_pmg_name = s.pmg_name
           or s.pmg_name is null)),
    translated_messages as (
       select /*+ no_merge (s) */
              pmt.rowid row_id, pms_name, pms_pml_name,
              dbms_lob.substr(pms_text, 4000, 1) pms_text, 
              dbms_lob.substr(pms_description, 4000, 1) pms_description
         from pit_message pmt
         join session_state s
           on pms_pml_name = pml_name),
    best_match_messages as(
       select coalesce(t.row_id, m.row_id) row_id, 
              m.pms_name,
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
select m.row_id, 
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
  join pit_message_group g
    on m.pms_pmg_name = g.pmg_name
  join pit_message_language pml
    on m.pms_pml_name = pml.pml_name
  join pit_message_severity_v pse
    on m.pms_pse_id = pse.pse_id;