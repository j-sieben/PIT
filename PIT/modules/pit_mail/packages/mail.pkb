create or replace package body mail
as

  subtype address_char is varchar2(200 char);

  C_BOUNDARY constant varchar2(100) := 'Your.Boundary.0987654321';
  C_WALLET_PATH constant varchar2(2000) := 'file:<your Path to the wallet>';
  C_WALLET_PWD constant varchar2(20) := '<WalletPWD>';

  cr varchar2(2) := utl_tcp.crlf;
  g_host varchar2(64);
  g_sender varchar2(200);
  g_port binary_integer := 25;
  g_usr varchar2(64);
  g_pwd varchar2(64);
  g_encoding varchar2(20);
  g_is_multipart_mail boolean := false;
  g_html_content_type varchar2(200);
  g_multipart_content_type varchar2(200) := 'multipart/mixed; boundary=' || C_BOUNDARY;

  g_trace_text clob := '';
  g_prompt_flag boolean := false;


  /** Method to check whether an ACL entry for this mail server exists
   * %return Flag that indicates whether an ACL entry was found (TRUE) or not (FALSE)
   */
  function mail_server_access_granted
    return boolean
  as
    l_access_granted binary_integer := 0;
    l_result boolean;
  begin
    pit.enter_detailed('mail_server_access_granted');
    
    select count(*)
      into l_access_granted
      from dual
     where exists (
           select null
             from user_network_acl_privileges
            where host = g_host);
    
    l_result := l_access_granted = 1;
    
    if l_result then
      pit.verbose(msg.MAIL_SERVER_ACCESS_GRANTED);
    else
      pit.verbose(msg.MAIL_SERVER_ACCESS_DENIED);
    end if;
    
    pit.leave_detailed;
    return l_result;
  exception
    when others then
      pit.sql_exception(msg.MAIL_SERVER_ACCESS_DENIED);
      return false;
  end mail_server_access_granted;


  /** Method to check whether an ACL entry for this mail server is accessible
   * %return Flag that indicates whether the mail server was successfully touched (TRUE) or not (FALSE).
   *         If a UTL_TCP.NETWORK_ERROR is received, the return value indicates whether the exception relates
   *         to a LISTENER. If so, TRUE is returned and FALSE in other cases.
   */
  function mail_server_accessible
    return boolean
  as
    tcpconnection utl_tcp.connection;
    l_result boolean;
  begin
    pit.enter_detailed('mail_server_accessible');
    
    tcpconnection := utl_tcp.open_connection(
                       remote_host => g_host,
                       remote_port => g_port,
                       wallet_path => C_WALLET_PATH,
                       wallet_password => C_WALLET_PWD);
    utl_tcp.close_connection(tcpconnection);
    pit.verbose(msg.MAIL_SERVER_ACCESSIBLE);
      
    pit.leave_detailed;
    return true;
  exception
    when utl_tcp.network_error then
      pit.sql_exception(msg.MAIL_SERVER_UNAVAILABLE);
      return (upper(sqlerrm) like '%LISTENER%');
    when others then
      pit.sql_exception(msg.MAIL_SERVER_UNAVAILABLE);
      return false;
  end mail_server_accessible;


  /** Initialization method.
   * %usage  Initializes global variables and tries to detect whether the package is in a usable state.
   *         This requires that
   *         {*} - the mail server is accessible via ACL
   *         {*} - the mail server is accessible and responds to a touch
   */
  procedure initialize
  as
  begin
    pit.enter_optional;
    
    select case value
             when 'AL32UTF8' then 'utf-8'
             else 'iso-8859-15' end char_set
      into g_encoding
      from v$nls_parameters
     where parameter = 'NLS_CHARACTERSET';

    g_html_content_type := 'text/html; charset=' || g_encoding;

      with connection as (
           select utl_raw.cast_to_varchar2(utl_encode.base64_decode(
                   substr(param.get_string('SEND', 'MISC'), 1, 512))) connect_string,
                  utl_raw.cast_to_varchar2(sys.utl_encode.base64_decode(param.get_string('SEND', 'MISC'))) sender,
                  utl_raw.cast_to_varchar2(sys.utl_encode.base64_decode(param.get_string('HOST', 'MISC'))) host
             from dual)
    select rtrim(regexp_substr(reverse(connect_string), '.+\@'), '@') usr,
           ltrim(regexp_substr(reverse(connect_string), '\|.+'), '|') pwd,
           ltrim(rtrim(regexp_substr(reverse(connect_string), '\@.+\|'), '|'), '@') sender,
           reverse(host)
      into g_usr, g_pwd, g_sender, g_host
      from connection;

    g_pkg_is_working := mail_server_access_granted and mail_server_accessible;
    
    pit.leave_optional;
  exception
    when others then
      pit.sql_exception(msg.MAIL_PKG_NOT_WORKING);
      g_pkg_is_working := false;
  end initialize;


  /** Method to encode an item with UTL_ENCODE.QUOTED_PRINTABLE_ENCODE
   * %param  p_item  Item to encode
   * %return Encoded item value
   * %usage  Is called to encode specific items such as recipients, subjects etc.
   */
  function encode_item(
    p_item in varchar2)
    return varchar2
  as
    l_result varchar2(2000) := '=?#ENCODING#?Q?#NAME#?=';
    l_item varchar2(2000);
  begin
    pit.enter_detailed('encode_item',
      p_params => msg_params(
                    msg_param('p_item', p_item)));
    
    l_item := utl_raw.cast_to_varchar2(
                utl_encode.quoted_printable_encode(
                  utl_raw.cast_to_raw(p_item)));
                  
    l_result := replace(replace(l_result, '#ENCODING#', g_encoding), '#NAME#', l_item);
    
    pit.leave_detailed(
      p_params => msg_params(
                    msg_param('Result', l_result)));
    return l_result;
  end encode_item;


  /** Helper method to cast a string to an instance of ADDRESS_TAB
   * %param  p_address_list  Stringified address list, separated by semicolon
   * %return Instance of ADRESS_TAB containing the addresses
   * %usage  Is called from the simplified SEND_MAIL method to allow for more than one recpient without
   *         having to create an instance of ADDRESS_TAB externally. Instead, a semicolon-delimited list
   *         of addressees is sufficient
   */
  function string_to_address_tab(
    p_address_list in varchar2)
    return address_tab
  as
    l_address_list wwv_flow_global.vc_arr2;
    l_address wwv_flow_global.vc_arr2;
    l_address_rec address_rec;
    l_address_tab address_tab := address_tab();
  begin
    pit.enter_detailed('string_to_address_tab');
    
    l_address_list := apex_util.string_to_table(p_address_list, ';');
    for adr in l_address_list.first .. l_address_list.last loop
      l_address := apex_util.string_to_table(l_address_list(adr), '@');
      l_address_rec.user_name := l_address(l_address.first);
      l_address_rec.email := l_address_list(adr);
      l_address_tab.extend;
      l_address_tab(l_address_tab.last) := l_address_rec;
    end loop;
    
    pit.leave_detailed;
    return l_address_tab;
  end string_to_address_tab;


  /** Method extracts the mail address from a recipient or sender address
   * %param  p_address  Full address in the form "Bill Smith"<foo@server.de> or foo@server.de
   * %return email address of the full address
   * %usage  Is used to remove the quoted name and the brackets from the address if existing
   */
  function extract_mail_address(
    p_address in varchar2)
    return varchar2
  as
    l_address varchar2(200);
    l_idx binary_integer;
  begin
    pit.enter_detailed('extract_mail_address',
      p_params => msg_params(
                    msg_param('p_address', p_address)));
    
    l_idx := instr(p_address, '<');
    if l_idx > 0 then
      l_address := substr(p_address, l_idx + 1, length(p_address) - l_idx - 1);
    else
      l_address := p_address;
    end if;
    
    pit.leave_detailed(
      p_params => msg_params(
                    msg_param('Email Address', l_address)));
    return l_address;
  end extract_mail_address;


  /** Method encodes an address to adhere to the smtp standard
   * %param  p_address  Full address in the form "Bill Smith"<foo@server.de> or foo@server.de
   * %return email address of the full address
   * %usage  Makes sure that the addressee does not contain unprintable characters
   */
  function encode_mail_address(
    p_address in varchar2)
    return varchar2
  as
    l_result varchar2(200);
    l_quoted_name varchar2(200);
    l_mail_address varchar2(200) := p_address;
    l_idx binary_integer;
  begin
    pit.enter_detailed('encode_mail_address',
      p_params => msg_params(
                    msg_param('p_address', p_address)));

    l_idx := instr(p_address, '<');

    if l_idx > 0 then
      l_quoted_name := encode_item(substr(p_address, 1, l_idx - 2));
      l_mail_address := substr(p_address, l_idx);
      l_result := l_quoted_name || l_mail_address;
    else
      l_result := p_address;
    end if;

    pit.leave_detailed(
      p_params => msg_params(
                    msg_param('Encoded Address', l_result)));
    return l_result;
  end encode_mail_address;


  /** Method adds a log entry to G_TRACE_TEXT
   * %param  p_text  Text to add to the trace
   * %usage  Is used to maintain a trace log that is emitted upon disconnecting from the mail server.
   */
  procedure write_log(
    p_text in varchar2)
  as
    l_text pit_util.max_char;
  begin
    pit.enter('write_log');
    
    l_text := p_text;
    case
      when p_text = cr and g_prompt_flag then
        l_text := '.';
        g_prompt_flag := true;
      when p_text = cr then
        g_prompt_flag := true;
      when g_prompt_flag then
        l_text := cr || p_text || cr;
        g_prompt_flag := false;
      else
        l_text := p_text || cr;
    end case;
    dbms_lob.append(g_trace_text, l_text);
    
    pit.leave;
  end write_log;


  /** Method writes smtp header entries
   * %param  p_conn   Connection reference to the mail server
   * %param  p_item   Item to write to the smtp header
   * %param  p_value  Item value to write to the smtp header
   * %usage  Helper to write smtp header information in the correct format
   */
  procedure write_header(
    p_conn in out nocopy utl_smtp.connection,
    p_item in varchar2,
    p_value in varchar2)
  as
  begin
    utl_smtp.write_data(p_conn, p_item || ': ' || p_value || cr);
    write_log( p_item || ': ' || p_value);
  end write_header;


  /** Method writes smtp body entries
   * %param  p_conn  Connection reference to the mail server
   * %param  p_text  Value to write to the smtp body
   * %usage  Helper to write smtp body information in the correct format
   */
  procedure write_body(
    p_conn in out nocopy utl_smtp.connection,
    p_text in varchar2)
  as
  begin
    utl_smtp.write_data(p_conn, p_text || cr);
    write_log(p_text);
  end write_body;


  /** Method adds a boundary to the mail
   * %param  p_conn           Connection reference to the mail server
   * %param [p_last_boundary] Flag to indicate whether this is the last boundary for the mail
   * %usage  Writes boundaries to separate parts of the mail such as plain text and html text.
   */
  procedure write_boundary(
    p_conn in out nocopy utl_smtp.connection,
    p_last_boundary in boolean default false)
  as
    l_comment varchar2(2) := '--';
  begin
    if g_is_multipart_mail then
      write_body(p_conn, l_comment || C_BOUNDARY || case when p_last_boundary then l_comment end);
    end if;
  end write_boundary;


  /** Method to connect to a mail server
   * %param  p_conn  Reference to a UTL_SMTP.CONNECTION
   * %usage  Establishes a connection to the mail server via LOGIN method
   */
  procedure authenticate_via_login(
    p_conn in out nocopy utl_smtp.connection)
  as
  begin
    pit.verbose(msg.MAIL_LOGIN, msg_args('LOGIN', g_usr || '/' || g_pwd));
    utl_smtp.auth(
      c => p_conn,
      username => g_usr,
      password => g_pwd,
      schemes => utl_smtp.all_schemes);
  end authenticate_via_login;


  /** Method to connect to a mail server
   * %param  p_conn  Reference to a UTL_SMTP.CONNECTION
   * %usage  Establishes a connection to the mail server via AUTH PLAIN method
   */
  procedure authenticate_via_plain(
    p_conn in out nocopy utl_smtp.connection)
  as
    l_auth_string pit_util.max_char;
  begin
    pit.verbose(msg.MAIL_LOGIN, msg_args('PLAIN', g_usr || '/' || g_pwd));
    utl_smtp.command(p_conn, 'AUTH PLAIN');
    l_auth_string :=
      utl_raw.cast_to_varchar2(
        utl_encode.base64_encode(
          utl_raw.cast_to_raw(
            g_usr || chr(0) || g_usr || chr(0) || g_pwd)));
    utl_smtp.command(p_conn, 'AUTH', 'PLAIN ' || l_auth_string);
  end authenticate_via_plain;


  /** Method to connect to a mail server
   * %param  p_conn  Reference to a UTL_SMTP.CONNECTION
   * %usage  Analyzes the respond from the mail server regarding the supported authentication methods
   *         and calls the respective connection method
   *         Supported connection methods so far are LOGIN and PLAIN.
   */
  procedure connect_mail_server(
    p_conn out nocopy utl_smtp.connection)
  as
    l_reply utl_smtp.replies;
    C_LOGIN constant varchar2(10) := 'LOGIN';
    C_PLAIN constant varchar2(10) := 'PLAIN';
    C_NTLM constant varchar2(10) := 'NTLM';
  begin
    pit.enter_detailed('connect_mail_server');

    p_conn := utl_smtp.open_connection(g_host, g_port);
    l_reply := utl_smtp.ehlo(p_conn, g_host);
    for i in l_reply.first .. l_reply.last loop
      if l_reply(i).text like 'AUTH%' then
        -- Check required authentication procedure
        pit.verbose(msg.MAIL_LOGIN_METHODS, msg_args(replace(l_reply(i).text, 'AUTH ', '')));
        case
        when instr(l_reply(i).text, C_PLAIN) > 0 then
          authenticate_via_plain(p_conn);
        /*when instr(l_reply(i).text, mail_cram.c_hash_md5) > 0 then
          mail_cram.authenticate(
            p_conn => p_conn,
            p_hash_method => mail_cram.c_hash_md5,
            p_user_name => g_usr,
            p_password => g_pwd);*/
        /*when instr(l_reply(i).text, mail_cram.c_hash_sha1) > 0 then
          mail_cram.authenticate(
            p_conn => p_conn,
            p_hash_method => mail_cram.c_hash_sha1,
            p_user_name => g_usr,
            p_password => g_pwd);*/
        /*when instr(l_reply(i).text, C_NTLM) > 0 then
          mail_ntlm.authenticate(
            p_conn => p_conn,
            p_host => g_host,
            p_user_name => g_usr,
            p_password => g_pwd);*/
        when instr(l_reply(i).text, C_LOGIN) > 0 then
          authenticate_via_login(p_conn);
        else
          raise utl_smtp.transient_error;
        end case;
      end if;
    end loop;
    pit.verbose(msg.mail_server_connected);
    pit.leave('connect_mail_server');
  exception
    when utl_smtp.transient_error or utl_smtp.permanent_error then
      begin
        utl_smtp.quit(p_conn);
      exception
        when utl_smtp.transient_error or utl_smtp.permanent_error then
          null; -- When the SMTP server is down or unavailable, we don't have a connection to the server. 
                -- The QUIT call will raise an exception that we can ignore.
      end;
  end connect_mail_server;


  /** Method writes a recipient list to the mail text
   * %param  p_conn        Reference to a UTL_SMTP.CONNECTION
   * %see    SEND_MAIL for other parameters description
   */
  procedure set_recipient_list(
    p_conn in out nocopy utl_smtp.connection,
    p_sender in varchar2,
    p_subject in varchar2,
    p_recipients in mail.address_tab,
    p_cc_recipients in mail.address_tab)
  as
    l_sender address_char;
  begin
    pit.enter_detailed('set_recipient_list');
    
    pit.assert(p_recipients.count > 0, msg.assert_true);
    
    l_sender := extract_mail_address(coalesce(p_sender, g_sender));
    pit.verbose(msg.MAIL_SENDER, msg_args(l_sender));
    
    -- register sender
    utl_smtp.mail(p_conn, l_sender);
    
    -- register recipients
    for i in 1 .. p_recipients.count loop
      pit.verbose(msg.mail_recipients, msg_args(p_recipients(i).email));
      if p_recipients(i).email is not null then
        utl_smtp.rcpt(p_conn, extract_mail_address(p_recipients(i).email));
      end if;
    end loop;
    
    -- write meta data
    utl_smtp.open_data(p_conn);
    write_header(p_conn, 'Date', to_char(sysdate, 'YYYY-MM-DD HH24:MI:SS'));
    
    -- register cc-recipients
    if p_cc_recipients is not null then
      for i in 1 .. p_cc_recipients.count loop
        if p_recipients(i).email is not null then
          write_header(p_conn, 'Cc', extract_mail_address(p_cc_recipients(i).email));
        end if;
      end loop;
    end if;
    
    -- write header information
    for i in 1 .. p_recipients.count loop
      if p_recipients(i).email is not null then
        write_header(p_conn, 'To', extract_mail_address(p_recipients(i).email));
      end if;
    end loop;
    write_header(p_conn, 'From', encode_mail_address(l_sender));
    write_header(p_conn, 'Subject', encode_item(p_subject));
    write_header(p_conn, 'ReplyTo', encode_mail_address(l_sender));
    
    pit.leave_detailed;
  exception
    when utl_smtp.transient_error or utl_smtp.permanent_error or utl_smtp.invalid_operation then
      begin
        utl_smtp.quit(p_conn);
      exception
        when utl_smtp.transient_error or utl_smtp.permanent_error then
          null; -- When the SMTP server is down or unavailable, we don't have a connection to the server. 
                -- The QUIT call will raise an exception that we can ignore.
      end;
  end set_recipient_list;


  /** Method to set the content type
   * %param  p_conn  Reference to UTL_SMTP.CONNECTION
   * %usage  Based on G_IS_MULTIPART_MAIL ths method set the content type
   */
  procedure set_content_type(
    p_conn in out nocopy utl_smtp.connection)
  as
  begin
    pit.enter_detailed('set_content_type');
    
    write_header(p_conn, 'MIME-Version', '1.0');
    if g_is_multipart_mail then
      write_header(p_conn, 'Content-Type', g_multipart_content_type);
    else
      write_header(p_conn, 'Content-Type', g_html_content_type);
    end if;
    -- One blank line is required after the content type
    write_body(p_conn, null);
    
    pit.leave_detailed;
  end set_content_type;


  /** Method to write the mail body
   * %param  p_conn     Reference to UTL_SMTP.CONNECTION
   * %param  p_message  Content of the mail. May contain plain text, boundary and html text
   * %usage  Based on G_IS_MULTIPART_MAIL ths method set the content type
   */
  procedure send_mail_body(
    p_conn in out nocopy utl_smtp.connection,
    p_message in varchar2)
  as
  begin
    pit.enter_detailed('send_mail_body');
    
    write_boundary(p_conn);
    if g_is_multipart_mail then
      write_header(p_conn, 'Content-Type', g_html_content_type);
    end if;
    write_body(p_conn, cr);

    write_body(p_conn, substr(p_message, 1, 32000));
    write_body(p_conn, cr);
    
    pit.leave_detailed;
  exception
    when utl_smtp.transient_error or utl_smtp.permanent_error or utl_smtp.invalid_operation then
      begin
        utl_smtp.quit(p_conn);
      exception
        when utl_smtp.transient_error or utl_smtp.permanent_error then
          null; -- When the SMTP server is down or unavailable, we don't have a connection to the server. 
                -- The QUIT call will raise an exception that we can ignore.
      end;
  end send_mail_body;


  /** Method to write the attachment
   * %param  p_conn        Reference to UTL_SMTP.CONNECTION
   * %param  p_filename    File name of the attachment
   * %param  p_mime_type   Mime type of the attachment
   * %param  p_attachment  Binary content of the attachment
   * %usage  Writes the content of P_ATTACHMENT into a separate boundary region
   */
  procedure send_attachment(
    p_conn in out nocopy utl_smtp.connection,
    p_filename in varchar2,
    p_mime_type in varchar2,
    p_attachment in blob)
  as
    l_raw raw(57);
    l_length integer := 0;
    l_buffer_size integer := 57;
    l_offset integer := 1;
  begin
    pit.enter_detailed('send_attachment');
    if g_is_multipart_mail then

      l_length := dbms_lob.getlength(p_attachment);

      write_boundary(p_conn);
      write_header(p_conn, 'Content-Type', p_mime_type);
      write_header(p_conn, 'Content-Transfer-Encoding', 'base64');
      write_header(p_conn, 'Content-Disposition', 'attachment; filename=' || p_filename);
      write_body(p_conn, cr);

      while l_offset < l_length loop
        dbms_lob.read(p_attachment, l_buffer_size, l_offset, l_raw);
        utl_smtp.write_raw_data(p_conn, utl_encode.base64_encode(l_raw));
        write_body(p_conn, cr);
        l_offset := l_offset + l_buffer_size;
      end loop while_loop;

      write_body(p_conn, cr);
      write_log('Attachment sent, Filename: ' || p_filename || ', Length: ' || l_length || ';');
    end if;
    
    pit.leave_detailed;
  exception
    when no_data_found then
      pit.stop(msg.invalid_mime_type, msg_args(substr(p_filename, instr(p_filename, '.', -1) + 1)));
    when utl_smtp.transient_error or utl_smtp.permanent_error or utl_smtp.invalid_operation then
      begin
        utl_smtp.quit(p_conn);
      exception
        when utl_smtp.transient_error or utl_smtp.permanent_error then
          null; -- When the SMTP server is down or unavailable, we don't have a connection to the server. 
                -- The QUIT call will raise an exception that we can ignore.
      end;
  end send_attachment;


  /** Method disconnects from the mail server
   * %param  p_conn        Reference to UTL_SMTP.CONNECTION
   * %usage  Is used to 
   *         {*} - write a closing boundary
   *         {*} - close the data channel
   *         {*} - quit the connection
   *         {*} - emit the trace text via PIT.VERBOSE
   */
  procedure disconnect_mail_server(
    p_conn in out nocopy utl_smtp.connection)
  as
  begin
    pit.enter_detailed('disconnect_mail_server');
    
    write_boundary(
      p_conn => p_conn,
      p_last_boundary => true);
    utl_smtp.close_data(p_conn);
    utl_smtp.quit(p_conn);
    pit.verbose(msg.mail_log, msg_args(g_trace_text));
    pit.verbose(msg.mail_server_disconnected);
    
    pit.leave_detailed;
  exception
    when utl_smtp.transient_error or utl_smtp.permanent_error or utl_smtp.invalid_operation then
      utl_smtp.quit(p_conn);
      pit.warn(msg.MAIL_ERROR);
  end disconnect_mail_server;


  /* INTERFACE */
  procedure send_mail(
    p_sender in varchar2,
    p_recipients in mail.address_tab,
    p_cc_recipients in mail.address_tab,
    p_subject in varchar2,
    p_message in varchar2,
    p_filename in varchar2,
    p_mime_type in varchar2,
    p_attachment in blob)
  as
    l_mail_conn utl_smtp.connection;
  begin
    pit.enter('send_mail',
      p_params => msg_params(
        msg_param('p_sender', p_sender),
        msg_param('p_recipients (count)', to_char(p_recipients.count)),
        msg_param('p_subject', p_subject),
        msg_param('p_filename', p_filename),
        msg_param('p_mime_type', p_mime_type)));
    if g_pkg_is_working then

      pit.assert_not_null(p_sender, msg.assert_is_null, msg_args('P_SENDER'));
      pit.assert_not_null(p_message, msg.assert_is_null, msg_args('P_MESSAGE'));

      dbms_lob.createtemporary(g_trace_text, false, dbms_lob.call);
      g_is_multipart_mail := dbms_lob.getlength(p_attachment) > 0;

      connect_mail_server(l_mail_conn);
      set_recipient_list(
        p_conn => l_mail_conn,
        p_sender => p_sender,
        p_subject => p_subject,
        p_recipients => p_recipients,
        p_cc_recipients => p_cc_recipients);
        
      set_content_type(l_mail_conn);
      
      send_mail_body(
        p_conn => l_mail_conn,
        p_message => p_message);
        
      if p_filename is not null then
        send_attachment(
          p_conn => l_mail_conn,
          p_filename => p_filename,
          p_mime_type => p_mime_type,
          p_attachment => p_attachment);
      end if;
      disconnect_mail_server(l_mail_conn);
    end if;
    pit.leave('send_mail');
  exception
    when others then
      utl_tcp.close_all_connections;
      pit.sql_exception(msg.mail_delivery_failed);
  end send_mail;


  procedure send_mail(
    p_sender in varchar2,
    p_recipient in varchar2,
    p_subject in varchar2,
    p_message in varchar2,
    p_filename in varchar2 default null,
    p_mime_type in varchar2 default null,
    p_attachment in blob default null)
  as
  begin
    send_mail(
      p_sender => p_sender,
      p_recipients => string_to_address_tab(p_recipient),
      p_cc_recipients => null,
      p_subject => p_subject,
      p_message => p_message,
      p_filename => p_filename,
      p_mime_type => p_mime_type,
      p_attachment => p_attachment);
  end send_mail;

begin
  initialize;
end mail;
/