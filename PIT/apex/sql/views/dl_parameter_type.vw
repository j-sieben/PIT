create or replace view &APP_USER..dl_parameter_type as
select pat_id, pat_description
  from &INSTALL_USER..parameter_type;
