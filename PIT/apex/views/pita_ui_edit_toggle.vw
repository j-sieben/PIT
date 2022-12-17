create or replace force view pita_ui_edit_toggle as
select par_id, 
       par_pgr_id,
       par_description,
       substr(par_string_value, 1, instr(par_string_value, '|') - 1) toggle_module_list,
       substr(par_string_value, instr(par_string_value, '|') + 1) toggle_context_name
  from table(pit_app_api.get_parameter_table)
 where par_pgr_id = 'PIT'
   and par_id like 'TOGGLE%';