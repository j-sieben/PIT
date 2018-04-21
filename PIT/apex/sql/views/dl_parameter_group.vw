create or replace view &APP_USER..dl_parameter_group as
select pgr_id, pgr_description, pgr_is_modifiable
  from &INSTALL_USER..parameter_group;
