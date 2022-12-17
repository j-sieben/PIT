create or replace view pita_ui_log_errors as
select log_id, log_date, log_session_id, log_user_name, pit.get_message_text(log_message_name, log_message_args) log_message, pse_display_name log_severity
  from pit_table_log
  join pit_message_severity_v
    on log_severity = pse_id
 where log_severity <= 30
 order by log_id desc;