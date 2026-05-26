create or replace view pit_pmg_language_v as
with session_language as (
       select /*+ no_merge */
              substr(
                sys_context('USERENV', 'LANGUAGE'),
                1,
                instr(sys_context('USERENV', 'LANGUAGE'), '_') - 1) pml_active,
              pit_util.C_TRUE() ptsc_is_default
         from dual)
select ptsc_pmg_name pgl_name,
       coalesce(
         max(case
               when ptsc_pml_name = pml_active
               then ptsc_pml_name
             end),
         max(case
               when s.ptsc_is_default = t.ptsc_is_default
               then ptsc_pml_name
             end)) pgl_pml_name
  from pit_translation_scope t
 cross join session_language s
 group by ptsc_pmg_name;
 
comment on table pit_pmg_language_v is 'Resolves the language per message group from the current session language.';
