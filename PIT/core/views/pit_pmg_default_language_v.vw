create or replace view pit_pmg_language_v as
select ptsc_pmg_name pgl_name,
       ptsc_pml_name pgl_pml_name
  from pit_translation_scope
 where ptsc_is_default = (select pit_util.C_TRUE from dual);
 
comment on table pit_pmg_language_v is 'Resolves the default language per message group.';
