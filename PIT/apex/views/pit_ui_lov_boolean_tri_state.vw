create or replace view pit_ui_lov_boolean_tri_state as
select '- optional wählen' d, null r from dual union all
select 'Ja' d, utl_apex.c_true r from dual union all
select 'Nein' d, utl_apex.c_false r from dual;

comment on table pit_ui_lov_boolean_tri_state is 'LOV view for TRUE, FALSE and NULL';