create or replace view pit_ui_lov_boolean_tri_state as
select '- optional wählen' d, null r from dual union all
select 'Ja' d, utl_apex.get_true r from dual union all
select 'Nein' d, utl_apex.get_false r from dual;