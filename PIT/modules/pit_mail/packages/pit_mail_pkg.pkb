create or replace
package body pit_mail_pkg
as
  
  type param_tab is table of varchar2(32767)
    index by varchar2(30);
  g_param_list param_tab;
  
  C_PARAM_GROUP constant varchar2(20) := 'PIT';
  C_FIRE_THRESHOLD constant pit_util.ora_name_type := 'PIT_MAIL_FIRE_THRESHOLD';
  C_TEMPLATE constant pit_util.ora_name_type := 'PIT_MAIL_TEMPLATE';
  C_HOST constant pit_util.ora_name_type := 'PIT_MAIL_HOST';
  C_FROM constant pit_util.ora_name_type := 'PIT_MAIL_FROM_ADDRESS';
  C_TO constant pit_util.ora_name_type := 'PIT_MAIL_TO_ADDRESS';
  C_SUBJECT constant pit_util.ora_name_type := 'PIT_MAIL_SUBJECT';
  
  C_RETURN varchar2(10) := utl_tcp.crlf;
  
  g_con utl_smtp.connection;
  g_mail_template clob;
  
  /* HELPER */
  /* Method to send header information for a mail
   * %param p_name Name of the header variable
   * %param p_header Header value
   * %usage Is called by the package to help write formatted header mail information
   */
  procedure send_header(
    p_name in varchar2, 
    p_header in varchar2)
  as
  begin
    utl_smtp.write_data(g_con, p_name || ': ' || p_header || utl_tcp.crlf);
  end send_header;
  
  /* INTERFACE*/
  
  procedure log(
    p_message in message_type)
  as
    l_mail_text pit_util.max_char;
  begin
    -- Messagetext vorbereiten
    l_mail_text := g_mail_template;
      
    -- Verbindung herstellen
    g_con := utl_smtp.open_connection(g_param_list(C_HOST));
    utl_smtp.helo(g_con, g_param_list(C_HOST));
    utl_smtp.mail(g_con, g_param_list(C_FROM));
    utl_smtp.rcpt(g_con, g_param_list(C_TO));
    
    -- Senden
    utl_smtp.open_data(g_con);
    send_header('From', g_param_list(C_FROM));
    send_header('To', g_param_list(C_TO));
    send_header('Subject', g_param_list(C_SUBJECT));
    utl_smtp.write_raw_data(g_con, utl_raw.cast_to_raw(C_RETURN || l_mail_text));
    
    -- Aufraeumen
    utl_smtp.close_data(g_con);
    utl_smtp.quit(g_con);
  exception
    when utl_smtp.transient_error or utl_smtp.permanent_error then
      begin
        utl_smtp.quit(g_con);
      exception
        when utl_smtp.transient_error or utl_smtp.permanent_error then
          null; -- When the SMTP server is down or unavailable, we don't have
                -- a connection to the server. The QUIT call will raise an
                -- exception that we can ignore.
      end;
      pit.error(msg.PIT_MAIL_ERROR, msg_args(to_char(sqlcode), sqlerrm));
  end log;
  
  
  procedure initialize_module(self in out PIT_MAIL)
  as
  begin
    self.fire_threshold := param.get_integer(C_FIRE_THRESHOLD, C_PARAM_GROUP);
    self.status := msg.PIT_MODULE_INSTANTIATED;
    -- Copy parameters
    g_mail_template := param.get_string(C_TEMPLATE, C_PARAM_GROUP);
    g_param_list(C_HOST) := param.get_string(C_HOST, C_PARAM_GROUP);
    g_param_list(C_FROM) := param.get_string(C_FROM, C_PARAM_GROUP);
    g_param_list(C_TO) := param.get_string(C_TO, C_PARAM_GROUP);
    g_param_list(C_SUBJECT) := param.get_string(C_SUBJECT, C_PARAM_GROUP);
  exception
    when others then
      self.fire_threshold := pit.level_off;
      self.status := msg.PIT_FAIL_MODULE_INIT;
      self.stack := dbms_utility.format_error_stack;
  end initialize_module;

end pit_mail_pkg;
/
