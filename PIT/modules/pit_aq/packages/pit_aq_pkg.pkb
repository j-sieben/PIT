create or replace package body pit_aq_pkg 
as

  C_FIRE_THRESHOLD constant pit_util.ora_name_type := 'PIT_AQ_FIRE_THRESHOLD';
  C_PARAM_GROUP constant pit_util.ora_name_type := 'PIT';
  C_OK constant varchar2(10) := 'OK';
  C_ERROR constant varchar2(10) := 'ERROR';
  
  g_message message_type_aq;
  
  /* HELPER */
  function cast_message_type(
    p_message in utils.message_type)
    return message_type_aq
  as
  begin
    g_message := message_type_aq(
                   p_message.id, p_message.message_name, p_message.affected_id, p_message.session_id, p_message.user_name,
                   p_message.message_text, p_message.message_description,
                   p_message.severity, p_message.stack, p_message.backtrace, p_message.error_number);
    return g_message;
  end;
  
  
  /* INTERACE */
  procedure log (
    p_message in message_type) 
  as
  begin
    g_message := cast_message_type(p_message);
  end log;
  

  procedure print (
    p_message in message_type) 
  as
  begin
    g_message := cast_message_type(p_message);
  end print;
  

  procedure notify (
    p_message in message_type) 
  as
  begin
    g_message := cast_message_type(p_message);
  end notify;
  

  procedure enter(
    p_call_stack in call_stack_type)
  as
  begin
    null;
  end enter;


  procedure leave(
    p_call_stack in call_stack_type) 
  as
  begin
    null;
  end leave;
  

  procedure purge_log(
    p_purge_date in date,
    p_severity_greater_equal in number default null) 
  as
  begin
    null;
  end purge_log;


  procedure context_changed(
    p_ctx in pit_context)
  as
  begin
    null;
  end context_changed;


  procedure initialize_module(
    self in out nocopy pit_aq) 
  as
  begin
    null;
  end initialize_module;

end pit_aq_pkg;
/