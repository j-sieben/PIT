create or replace view v_message_language as
select name, default_order
  from message_language
 where default_order > 0
union all
select value, 100
  from v$nls_parameters
 where parameter = 'NLS_LANGUAGE';
