create or replace view pit_pmg_language_v as
select ptsc_pmg_name,
       ptsc_pml_name pml_name
  from pit_translation_scope
 where ptsc_is_default = true;
 
comment on table pit_pmg_language_v is 'Resolves the default language per message group.';
