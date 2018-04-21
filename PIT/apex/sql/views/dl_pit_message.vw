create or replace view &APP_USER..dl_pit_message as
select pms_name, pms_pmg_name, pms_pml_name, pms_text, pms_pse_id, pms_custom_error, pms_active_error, pms_id
  from &INSTALL_USER..pit_message;
