create or replace view it_ui_ov_message_error_type as 
select 1 s, 'ohne' d, 'NONE' r from dual union all
select 2 s, 'eigene' d, 'CUSTOM' r from dual union all
select 3 s, 'Oracle' d, 'ORACLE' r from dual;