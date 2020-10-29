create or replace
package body pit_mail_pkg
as
  
  g_sender pit_util.max_char;
  g_recipient pit_util.max_char;
  g_subject pit_util.max_char;
  g_purge_period number;
  g_fire_threshold number(2,0);
  g_live_threshold number(2,0);
  g_daily_threshold number(2,0);
  g_file_name pit_util.small_char;
  
  C_PARAM_GROUP constant varchar2(20) := 'PIT';
  C_MODULE_NAME constant pit_util.ora_name_type := 'PIT_MAIL';
  C_FIRE_THRESHOLD constant pit_util.ora_name_type := C_MODULE_NAME || '_FIRE_THRESHOLD';
  C_FROM constant pit_util.ora_name_type := C_MODULE_NAME || '_FROM_ADDRESS';
  C_TO constant pit_util.ora_name_type := C_MODULE_NAME || '_TO_ADDRESS';
  C_SUBJECT constant pit_util.ora_name_type := C_MODULE_NAME || '_MAIL_SUBJECT';
  C_LIVE_THRESHOLD constant pit_util.ora_name_type := c_module_name || '_LIVE_LEVEL';
  C_DAILY_THRESHOLD constant pit_util.ora_name_type := c_module_name || '_DAILY_LEVEL';
  C_PURGE_PERIOD constant pit_util.ora_name_type := c_module_name || '_PURGE_PERIOD';
  C_FILE_NAME constant pit_util.ora_name_type := c_module_name || '_FILE_NAME';
  
  C_RETURN varchar2(10) := utl_tcp.crlf;
  C_DATE_FORMAT constant pit_util.ora_name_type := 'dd.mm. hh24:mi';
  
  
  /* HELPER */
  /** Method to convert a MESSAGE_TYPE.message into a string
   * %param  p_message     MESSAGE_TYPE instance
   * %param [p_amount]     Amount of messages of the same type within the report time frame
   * %param [p_first_date] First time the message was raised
   * %param [p_last_date]  Last time the message was raised
   * %return String with a formatted message
   * %usage  Is used to cast a message text into a CLOB text instance
   */
  function prepare_message(
    p_message in message_type,
    p_amount in number default null,
    p_first_date in date default null,
    p_last_date in date default null)
    return clob
  as
    l_message clob;
  begin
    l_message :=
      utl_text.bulk_replace(
        pit.get_message_text(msg.MAIL_MESSAGE_TEMPLATE),
        char_table(
          '#AMOUNT#', coalesce(to_char(p_amount), '#AMOUNT#'),
          '#FIRST_DATE#', coalesce(to_char(p_first_date, C_DATE_FORMAT), '#FIRST_DATE#'),
          '#LAST_DATE#', coalesce(to_char(p_last_date, C_DATE_FORMAT), '#LAST_DATE#'),
          '#SEVERITY#', to_char(p_message.severity),
          '#MESSAGE#', dbms_lob.substr(p_message.message_text, 32000, 1),
          '#STACK#', p_message.stack,
          '#BACKTRACE#', p_message.backtrace));
    return l_message;
  end prepare_message;


  /** Method to prepare a mail
   * %param  p_message_text  Text of the message to send
   * %param  p_attachment    Out variable, is filled if P_MESSAGE_TEXT exceeds 2000 byte in length
   * %usage  Is used to create an attachment if the length of the message is too long for a normal mail
   */
  procedure prepare_mail(
    p_message in out nocopy clob,
    p_attachment out nocopy blob)
  as
    l_message pit_util.max_sql_char;
  begin
    if dbms_lob.getlength(p_message) > 2000 then
      l_message := pit.get_message_text(msg.MAIL_ATTACHMENT);
      p_attachment := utl_text.clob_to_blob(p_message);
    else
      l_message := p_message;
    end if;
    p_message := pit.get_message_text(msg.MAIL_MAIL_TEMPLATE, msg_args(l_message));
  end prepare_mail;


  /** Sends a mail using the MAIL package
   * %param  p_message_text  Text of the message to send
   * %param  p_attachment    Optional attachment
   * %usage  Is used to send a message via mail
   */
  procedure send_mail(
    p_message in clob,
    p_attachment in blob)
  as
    l_file_name pit_util.small_char;
    l_mime_type pit_util.small_char;
    l_attachment blob;
  begin
    if dbms_lob.getlength(p_message) > 2500 then
      l_file_name := 'Fehlermeldungen.html';
      l_mime_type := 'text/html';
      l_attachment := utl_text.clob_to_blob(p_message);
    end if;
    
    mail.send_mail(
      p_sender => g_sender,
      p_recipient => g_recipient,
      p_subject => g_subject,
      p_message => substr(p_message, 1, 2500),
      p_filename => l_file_name,
      p_mime_type => l_mime_type,
      p_attachment => l_attachment);
      
  end send_mail;


  /** Method to send messages as a report
   * %param  p_threshold  Severity that defines which messages are being sent
   * %usage  This method is called from various SEND_<Name of the Schedule> methods defined in this package.
   *         If you want to create a new schedule, thew following tasks need to be done:
   *         {*} - Create a schedule and assign the method name as its action (or add this action to an existing schedule)
   *         {*} - Define a threshold that defines which messages are to be sent (All messages lower or equal this threshold are sent if they are not processed yet)
   *         {*} - Create a parameter to hold this threshold and read it in the initialize method
   */
  procedure send_schedule(
    p_threshold in number)
  as
    l_message clob;
    l_attachment blob;
    
    cursor message_mail_cur(p_threshold in number) is
      select utl_text.bulk_replace(min(to_char(pmq_message_text)), char_table(
               '#FIRST_DATE#', to_char(min(pmq_log_date), C_DATE_FORMAT), 
               '#LAST_DATE#', to_char(max(pmq_log_date), C_DATE_FORMAT), 
               '#AMOUNT#', to_char(count(*)))) message, 
             min(pmq_log_date) log_date
        from pit_mail_queue
       where pmq_pse_id <= p_threshold
         and pmq_is_processed = pit_util.C_FALSE
       group by pmq_pms_id;
  begin
  
    dbms_lob.createtemporary(l_message, false, dbms_lob.call);
    
    for msg in message_mail_cur(p_threshold) loop
      dbms_lob.append(l_message, msg.message);
    end loop;
    
    -- Send mail if some were found
    if dbms_lob.getlength(l_message) > 0 then
      prepare_mail(l_message, l_attachment);
      send_mail(l_message, l_attachment);
      update pit_mail_queue
         set pmq_is_processed = pit_util.C_TRUE
       where pmq_pse_id <= p_threshold
         and pmq_is_processed = pit_util.C_FALSE;
      
      -- Call local purge method to remove sent mails from PIT_MAIL_QUEUE
      purge(trunc(sysdate) - g_purge_period);
    end if;
    
  end send_schedule;
  
  /** Initialization method
   * %usage  Is called from INITIALIE_MODULE to read parameter values
   */
  procedure initialize
  as
  begin
    -- Copy parameters
    g_sender := param.get_string(C_FROM, C_PARAM_GROUP);
    g_recipient := param.get_string(C_TO, C_PARAM_GROUP);
    g_subject := param.get_string(C_SUBJECT, C_PARAM_GROUP);
    g_live_threshold := param.get_integer(C_LIVE_THRESHOLD, C_PARAM_GROUP);
    g_daily_threshold := param.get_integer(C_DAILY_THRESHOLD, C_PARAM_GROUP);
    g_purge_period := param.get_integer(C_PURGE_PERIOD, C_PARAM_GROUP);
    g_fire_threshold := param.get_integer(C_FIRE_THRESHOLD, C_PARAM_GROUP);
    g_file_name := param.get_integer(C_FILE_NAME, C_PARAM_GROUP);
  end initialize;
  
  
  /* INTERFACE*/  
  procedure send_daily
  as
  begin
    pit.enter_mandatory;
    send_schedule(g_daily_threshold);
    pit.leave_mandatory;
  end send_daily;
  
  
  procedure log(
    p_message in message_type)
  as
    l_message pit_util.max_char;
    l_attachment blob;
  begin
    if p_message.severity <= g_live_threshold then
      l_message := prepare_message(p_message, 1, sysdate, sysdate);
      prepare_mail(l_message, l_attachment);
      send_mail(l_message, l_attachment);
    else
      l_message := prepare_message(p_message);
      insert into pit_mail_queue(pmq_id, pmq_pms_id, pmq_pse_id, pmq_message_text, pmq_log_date)
      values (p_message.id, p_message.message_name, p_message.severity, l_message, sysdate);
    end if;
  end log;


  procedure purge(
    p_date_until in date,
    p_severity_greater_equal in number default null)
  as
  begin
    delete from pit_mail_queue
     where pmq_log_date < p_date_until
       and pmq_pse_id >= coalesce(p_severity_greater_equal, 0)
       and pmq_is_processed = pit_util.C_TRUE;
  end purge;
  
  
  procedure initialize_module(self in out PIT_MAIL)
  as
  begin
    self.fire_threshold := param.get_integer(C_FIRE_THRESHOLD, C_PARAM_GROUP);
    self.status := msg.PIT_MODULE_INSTANTIATED;
    
    initialize;
  exception
    when others then
      self.fire_threshold := pit.level_off;
      self.status := msg.PIT_FAIL_MODULE_INIT;
      self.stack := dbms_utility.format_error_stack;
  end initialize_module;

end pit_mail_pkg;
/
