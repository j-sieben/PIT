create or replace force view pit_message_group_v as
select pmg_name, pmg_description, pmg_error_prefix, pmg_error_postfix
  from pit_message_group;