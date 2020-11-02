create or replace package body mail
as

  /** Package implementation to wrap sending mails via UTL_SMTP */

  /* Constants */
  CR varchar2(2) := utl_tcp.crlf;
  C_BOUNDARY constant varchar2(100) := '---+#abc1234321cba#+--';
  C_PARAM_GROUP constant varchar2(100) := 'MISC';
  
  /* Public variable declarations */
  g_pkg_is_working boolean;
  g_host varchar2(64);
  g_sender varchar2(200);
  g_port pls_integer := 25;
  g_usr varchar2(64);
  g_pwd varchar2(64);
  g_encoding varchar2(20);
  g_is_multipart_mail boolean := false;
  g_html_content_type varchar2(200);
  g_multipart_content_type varchar2(200) := 'multipart/mixed; boundary=' || C_BOUNDARY;

  g_trace_text clob := '';
  g_prompt_flag boolean := false;


  function mail_server_access_granted
    return boolean
  as
    l_access_granted pls_integer := 0;
  begin
  
    select count(*)
      into l_access_granted
      from user_network_acl_privileges
     where host = g_host;
     
    if l_access_granted > 0 then
      pit.verbose(msg.MAIL_SERVER_ACCESS_GRANTED);
    else
      pit.verbose(msg.MAIL_SERVER_ACCESS_DENIED);
    end if;
    
    return l_access_granted > 0;
  exception
    when others then
      pit.handle_exception(msg.MAIL_SERVER_ACCESS_DENIED);
      return false;
  end mail_server_access_granted;


  function mail_server_accessible
    return boolean
  as
    l_conn utl_smtp.connection;
  begin
    l_conn := utl_smtp.open_connection(
                host => g_host,
                port => g_port,
                tx_timeout => 2);
                
    utl_smtp.quit(l_conn);
    pit.verbose(msg.MAIL_SERVER_ACCESSIBLE);
    return true;
  exception
    when utl_tcp.network_error then
      pit.handle_exception(msg.MAIL_SERVER_UNAVAILABLE);
      return (upper(sqlerrm) like '%LISTENER%');
    when others then
      pit.handle_exception(msg.SQL_ERROR, msg_args(sqlerrm));
      return false;
  end mail_server_accessible;


  procedure initialize
  as
  begin
    pit.enter_mandatory;
    
    select case value
             when 'AL32UTF8' then 'utf-8'
             else 'iso-8859-15' end char_set
      into g_encoding
      from v$nls_parameters
     where parameter = 'NLS_CHARACTERSET';

    g_html_content_type := 'text/html; charset=' || g_encoding;

    with connection as (
           select reverse(
                    utl_raw.cast_to_varchar2(
                      utl_encode.base64_decode(
                        substr(param.get_string('SEND', C_PARAM_GROUP), 1, 512)))) connect_string
             from dual),
         data as (
           select connect_string,
                  instr(connect_string, '/') usr_pwd,
                  instr(connect_string, '^', -1) pwd_host,
                  instr(connect_string, ':', -1) host_port
             from connection)
    select substr(connect_string, 1, usr_pwd - 1) usr,
           substr(connect_string, usr_pwd + 1, pwd_host - usr_pwd - 1) pwd,
           substr(connect_string, pwd_host + 1, host_port - pwd_host - 1) host,
           substr(connect_string, host_port + 1) port
      into g_usr, g_pwd, g_host, g_port
      from data;    

    g_pkg_is_working := mail_server_access_granted and mail_server_accessible;
    
    pit.leave_mandatory;
  exception
    when others then
      pit.handle_exception(msg.MAIL_PKG_NOT_WORKING);
      g_pkg_is_working := false;
  end initialize;


  function encode_item(
    p_item in varchar2)
    return varchar2
  as
    C_ENCODING_TEMPLATE constant varchar2(100) := '=?#ENCODING#?Q?#NAME#?=';
    l_result varchar2(2000) := C_ENCODING_TEMPLATE;
    l_item varchar2(2000);
  begin
    pit.enter_detailed('encode_item',
      p_params => msg_params(msg_param('p_item', p_item)));
      
    l_item := utl_raw.cast_to_varchar2(
                utl_encode.quoted_printable_encode(
                  utl_raw.cast_to_raw(p_item)));
    utl_text.bulk_replace(l_result,
      char_table(
        '#ENCODING#', g_encoding,
        '#NAME#', l_item));
        
    pit.leave_detailed(
      p_params => msg_params(msg_param('Result', l_result)));
    return l_result;
  end encode_item;


  function create_address_list(
    p_address_list in varchar2)
    return address_tab
  as
    l_address_list char_table;
    l_address_rec address_rec;
    l_address_tab address_tab := address_tab();
  begin
    pit.enter_optional('create_address_list');
    
    if p_address_list is not null then
      utl_text.string_to_table(p_address_list, l_address_list, ';');
      for adr in l_address_list.first .. l_address_list.last loop
        l_address_rec.email := l_address_list(adr);
        l_address_rec.user_name := substr(l_address_rec.email, 1, instr(l_address_rec.email, '@') - 1);
        l_address_tab.extend;
        l_address_tab(l_address_tab.last) := l_address_rec;
      end loop;
    end if;
    
    pit.leave_optional;
    return l_address_tab;
  exception
    when others then
      pit.handle_exception(msg.SQL_ERROR);
  end create_address_list;


  function extract_mail_address(
    p_address in varchar2)
    return varchar2
  as
    l_address varchar2(200);
    l_idx pls_integer;
  begin
    pit.enter_detailed('extract_mail_address',
      p_params => msg_params(msg_param('p_address', p_address)));
      
    l_idx := instr(p_address, '<');
    if l_idx > 0 then
      l_address := substr(p_address, l_idx + 1, length(p_address) - l_idx - 1);
    else
      l_address := p_address;
    end if;
    
    pit.leave_detailed(
      p_params => msg_params(msg_param('Result', l_address)));
    return l_address;
  end extract_mail_address;


  function encode_mail_address(
    p_address in varchar2)
    return varchar2
  as
    l_result varchar2(200);
    l_quoted_name varchar2(200);
    l_mail_address varchar2(200) := p_address;
    l_idx pls_integer;
  begin
    pit.enter('encode_mail_address',
      p_params => msg_params(msg_param('p_address', p_address)));

    l_idx := instr(p_address, '<');

    if l_idx > 0 then
      l_quoted_name := encode_item(substr(p_address, 1, l_idx - 2));
      l_mail_address := substr(p_address, l_idx);
      l_result := l_quoted_name || l_mail_address;
    else
      l_result := p_address;
    end if;

    pit.leave_detailed(
      p_params => msg_params(msg_param('Result', l_result)));
    return l_result;
  end encode_mail_address;


  procedure write_log(
    p_text in varchar2)
  as
    l_text varchar2(32767);
  begin
    l_text := p_text;
    case
      when p_text = CR and g_prompt_flag then
        l_text := '.';
        g_prompt_flag := true;
      when p_text = CR then
        g_prompt_flag := true;
      when g_prompt_flag then
        l_text := CR || p_text || CR;
        g_prompt_flag := false;
      else
        l_text := p_text || CR;
    end case;
    dbms_lob.append(g_trace_text, l_text);
  end write_log;


  procedure write_header(
    p_conn in out nocopy utl_smtp.connection,
    p_item in varchar2,
    p_text in varchar2)
  as
  begin
    utl_smtp.write_data(p_conn, p_item || ': ' || p_text || CR);
    write_log( p_item || ': ' || p_text);
  end write_header;


  procedure write_body(
    p_conn in out nocopy utl_smtp.connection,
    p_text in varchar2)
  as
  begin
    utl_smtp.write_data(p_conn, p_text || CR);
    write_log(p_text);
  end write_body;


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


  procedure authenticate_via_login(
    p_conn in out nocopy utl_smtp.connection)
  as
  begin
    pit.enter_detailed('authenticate_via_login',
      p_params => msg_params(
                    msg_param('g_usr', g_usr),
                    msg_param('g_pwd', lpad('*', length(g_usr), '*'))));
                    
    utl_smtp.auth(
      c => p_conn,
      username => g_usr,
      password => g_pwd,
      schemes => utl_smtp.all_schemes);
      
    pit.leave_detailed;
  end authenticate_via_login;


  procedure authenticate_via_plain(
    p_conn in out nocopy utl_smtp.connection)
  as
    l_auth_string varchar2(32767);
  begin
    pit.enter_detailed('authenticate_via_login',
      p_params => msg_params(
                    msg_param('g_usr', g_usr),
                    msg_param('g_pwd', lpad('*', length(g_usr), '*'))));
                    
    utl_smtp.command(p_conn, 'AUTH PLAIN');
    l_auth_string :=
      utl_raw.cast_to_varchar2(
        utl_encode.base64_encode(
          utl_raw.cast_to_raw(
            g_usr || chr(0) || g_usr || chr(0) || g_pwd)));
    utl_smtp.command(p_conn, 'AUTH', 'PLAIN ' || l_auth_string);
    
    pit.leave_detailed;
  end authenticate_via_plain;


  procedure connect_mail_server(
    p_conn out nocopy utl_smtp.connection)
  as
    l_reply utl_smtp.replies;
    c_login constant varchar2(20) := 'LOGIN';
    c_plain constant varchar2(20) := 'PLAIN';
    c_ntlm constant varchar2(20) := 'NTLM';
  begin
    pit.enter_optional('connect_mail_server');

    p_conn := utl_smtp.open_connection(g_host, g_port);
    l_reply := utl_smtp.ehlo(p_conn, g_host);
    for i in l_reply.first .. l_reply.last loop
      if l_reply(i).text like 'AUTH%' then
        -- Check required authentication procedure
        pit.verbose(msg.MAIL_LOGIN_METHODS, msg_args(replace(l_reply(i).text, 'AUTH ', '')));
        case
        when instr(l_reply(i).text, c_login) > 0 then
          authenticate_via_login(p_conn);
        when instr(l_reply(i).text, c_plain) > 0 then
          authenticate_via_plain(p_conn);
        when instr(l_reply(i).text, mail_cram.c_hash_md5) > 0 then
          mail_cram.authenticate(
            p_conn => p_conn,
            p_hash_method => mail_cram.c_hash_md5,
            p_user_name => g_usr,
            p_password => g_pwd);
        when instr(l_reply(i).text, mail_cram.c_hash_sha1) > 0 then
          mail_cram.authenticate(
            p_conn => p_conn,
            p_hash_method => mail_cram.c_hash_sha1,
            p_user_name => g_usr,
            p_password => g_pwd);
        when instr(l_reply(i).text, c_ntlm) > 0 then
          mail_ntlm.authenticate(
            p_conn => p_conn,
            p_host => g_host,
            p_user_name => g_usr,
            p_password => g_pwd);
        else
          raise utl_smtp.TRANSIENT_ERROR;
        end case;
      end if;
    end loop;
    pit.verbose(msg.MAIL_SERVER_CONNECTED);
    
    pit.leave_optional;
  exception
    when utl_smtp.TRANSIENT_ERROR or utl_smtp.PERMANENT_ERROR then
      begin
        utl_smtp.quit(p_conn);
        pit.stop(msg.SQL_ERROR);
      exception
        when utl_smtp.TRANSIENT_ERROR or utl_smtp.PERMANENT_ERROR then
          null; -- When the SMTP server is down or unavailable, we don't have a connection to the server. 
                -- The QUIT call will raise an exception that we can ignore.
      end;
  end connect_mail_server;


  procedure set_recipient_list(
    p_conn in out nocopy utl_smtp.connection,
    p_sender in varchar2,
    p_subject in varchar2,
    p_recipients in mail.address_tab,
    p_cc_recipients in mail.address_tab)
  as
    l_sender varchar2(200);
  begin
    pit.enter_optional('set_recipient_list');
    
    l_sender := extract_mail_address(coalesce(p_sender, g_sender));
    pit.assert(p_recipients.count > 0);

    pit.verbose(msg.MAIL_SENDER, msg_args(l_sender));
    utl_smtp.mail(p_conn, l_sender);
    for i in 1 .. p_recipients.count loop
      pit.verbose(msg.MAIL_RECIPIENTS, msg_args(p_recipients(i).email));
      if p_recipients(i).email is not null then
        utl_smtp.rcpt(p_conn, extract_mail_address(p_recipients(i).email));
      end if;
    end loop;
    utl_smtp.open_data(p_conn);
    write_header(p_conn, 'Date', to_char(sysdate, 'YYYY-MM-DD HH24:MI:SS'));
    if p_cc_recipients is not null then
      for i in 1 .. p_cc_recipients.count loop
        if p_recipients(i).email is not null then
          write_header(p_conn, 'Cc', extract_mail_address(p_cc_recipients(i).email));
        end if;
      end loop;
    end if;
    for i in 1 .. p_recipients.count loop
      if p_recipients(i).email is not null then
        write_header(p_conn, 'To', extract_mail_address(p_recipients(i).email));
      end if;
    end loop;
    write_header(p_conn, 'From', encode_mail_address(l_sender));
    write_header(p_conn, 'Subject', encode_item(p_subject));
    write_header(p_conn, 'ReplyTo', encode_mail_address(l_sender));
    
    pit.leave_optional;
  exception
    when utl_smtp.TRANSIENT_ERROR or utl_smtp.PERMANENT_ERROR or utl_smtp.INVALID_OPERATION then
      begin
        utl_smtp.quit(p_conn);
        pit.stop(msg.SQL_ERROR);
      exception
        when utl_smtp.TRANSIENT_ERROR or utl_smtp.PERMANENT_ERROR then
          null; -- When the SMTP server is down or unavailable, we don't have a connection to the server. 
                -- The QUIT call will raise an exception that we can ignore.
      end;
  end set_recipient_list;


  procedure set_content_type(
    p_conn in out nocopy utl_smtp.connection)
  as
  begin
    pit.enter_detailed;
    
    write_header(p_conn, 'MIME-Version', '1.0');
    if g_is_multipart_mail then
      write_header(p_conn, 'Content-Type', g_multipart_content_type);
    else
      write_header(p_conn, 'Content-Type', g_html_content_type);
    end if;
    write_body(p_conn, null);
    
    pit.leave_detailed;
  end set_content_type;


  procedure send_mail_body(
    p_conn in out nocopy utl_smtp.connection,
    p_message in varchar2)
  as
  begin
    pit.enter_optional('send_mail_body');
    
    write_boundary(p_conn);
    if g_is_multipart_mail then
      write_header(p_conn, 'Content-Type', g_html_content_type);
    end if;
    write_body(p_conn, CR);

    write_body(p_conn, substr(p_message, 1, 32000));
    write_body(p_conn, CR);
    
    pit.leave_optional;
  exception
    when utl_smtp.TRANSIENT_ERROR or utl_smtp.PERMANENT_ERROR or utl_smtp.INVALID_OPERATION then
      begin
        utl_smtp.quit(p_conn);
        pit.stop(msg.SQL_ERROR);
      exception
        when utl_smtp.TRANSIENT_ERROR or utl_smtp.PERMANENT_ERROR then
          null; -- When the SMTP server is down or unavailable, we don't have a connection to the server. 
                -- The QUIT call will raise an exception that we can ignore.
      end;
  end send_mail_body;


  procedure send_attachment(
    p_conn in out nocopy utl_smtp.connection,
    p_file_name in varchar2,
    p_mime_type in varchar2,
    p_attachment in blob)
  as
    l_raw raw(57);
    l_length integer := 0;
    l_buffer_size integer := 57;
    l_offset integer := 1;
  begin
    pit.enter_optional('send_attachment',
      p_params => msg_params(
                    msg_param('p_file_name', p_file_name),
                    msg_param('p_mime_type', p_mime_type),
                    msg_param('p_attachment (length)', dbms_lob.getlength(p_attachment))));
                    
    if g_is_multipart_mail then

      l_length := dbms_lob.getlength(p_attachment);

      write_boundary(p_conn);
      write_header(p_conn, 'Content-Type', p_mime_type);
      write_header(p_conn, 'Content-Transfer-Encoding', 'base64');
      write_header(p_conn, 'Content-Disposition', 'attachment; filename=' || p_file_name);
      write_body(p_conn, CR);

      while l_offset < l_length loop
        dbms_lob.read(p_attachment, l_buffer_size, l_offset, l_raw);
        utl_smtp.write_raw_data(p_conn, utl_encode.base64_encode(l_raw));
        write_body(p_conn, CR);
        l_offset := l_offset + l_buffer_size;
      end loop while_loop;

      write_body(p_conn, CR);
      write_log('Attachment sent, Filename: ' || p_file_name || ', Length: ' || l_length || ';');
    end if;
    
    pit.leave_optional;
  exception
    when no_data_found then
      pit.stop(msg.INVALID_MIME_TYPE, msg_args(substr(p_file_name, instr(p_file_name, '.', -1) + 1)));
    when utl_smtp.TRANSIENT_ERROR or utl_smtp.PERMANENT_ERROR or utl_smtp.INVALID_OPERATION then
      begin
        utl_smtp.quit(p_conn);
        pit.stop(msg.SQL_ERROR);
      exception
        when utl_smtp.TRANSIENT_ERROR or utl_smtp.PERMANENT_ERROR then
          null; -- When the SMTP server is down or unavailable, we don't have a connection to the server. 
                -- The QUIT call will raise an exception that we can ignore.
      end;
  end send_attachment;


  procedure disconnect_mail_server(
    p_conn in out nocopy utl_smtp.connection)
  as
  begin
    pit.enter_optional('disonnect_mail_server');
    
    write_boundary(
      p_conn => p_conn,
      p_last_boundary => true);
    utl_smtp.close_data(p_conn);
    utl_smtp.quit(p_conn);
    pit.verbose(msg.MAIL_LOG, msg_args(g_trace_text));
    pit.verbose(msg.MAIL_SERVER_DISCONNECTED);
    
    pit.leave_optional;
  exception
    when utl_smtp.TRANSIENT_ERROR or utl_smtp.PERMANENT_ERROR or utl_smtp.INVALID_OPERATION then
      utl_smtp.quit(p_conn);
      pit.warn(msg.MAIL_ERROR);
  end disconnect_mail_server;


  /* INTERFACE */
  function pkg_is_working
    return boolean
  as
  begin
    return g_pkg_is_working;
  end pkg_is_working;
  
  
  procedure set_credentials(
    p_host in varchar2,
    p_port in pls_integer,
    p_user in varchar2,
    p_password in varchar2)
  as
    l_encoded_string varchar2(1000);
  begin
    pit.enter_mandatory(
      p_params => msg_params(
                    msg_param('p_host', p_host),
                    msg_param('p_port', p_port),
                    msg_param('p_user', p_user),
                    msg_param('p_password', lpad('*', length(p_password), '*'))));
    
    select utl_encode.base64_encode(utl_raw.cast_to_raw(reverse(p_user || '/' || p_password || '^' || p_host || ':' || p_port)))
      into l_encoded_string
      from dual;
    param.set_string('SEND', C_PARAM_GROUP, l_encoded_string);
    
    pit.leave_mandatory(
      p_params => msg_params(msg_param('Result', l_encoded_string)));
  end set_credentials;


  procedure send_mail(
    p_sender in varchar2,
    p_recipients in mail.address_tab,
    p_cc_recipients in mail.address_tab,
    p_subject in varchar2,
    p_message in varchar2,
    p_file_name in varchar2,
    p_mime_type in varchar2,
    p_attachment in blob)
  as
    l_mail_conn utl_smtp.connection;
  begin
    pit.enter_mandatory(
      p_params => msg_params(
        msg_param('p_sender', p_sender),
        msg_param('p_recipients (count)', to_char(p_recipients.count)),
        msg_param('p_cc_recipients (count)', to_char(p_cc_recipients.count)),
        msg_param('p_message (length)', length(p_message)),
        msg_param('p_subject', p_subject),
        msg_param('p_file_name', p_file_name),
        msg_param('p_mime_type', p_mime_type)));
        
    if g_pkg_is_working then

      pit.assert_not_null(p_sender, p_msg_args => msg_args('P_SENDER'));
      pit.assert(p_recipients.count > 0, p_msg_args => msg_args('P_RECIPIENTS'));
      pit.assert_not_null(p_subject, p_msg_args => msg_args('P_SUBJECT'));
      pit.assert_not_null(p_message, p_msg_args => msg_args('P_MESSAGE'));
      pit.assert_not_null(p_file_name, p_msg_args => msg_args('P_FILE_NAME'));
      pit.assert_not_null(p_mime_type, p_msg_args => msg_args('P_MIME_TYPE'));
      pit.assert(dbms_lob.getlength(p_attachment) > 0, p_msg_args => msg_args('P_ATTACHMENT'));

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
      send_attachment(
        p_conn => l_mail_conn,
        p_file_name => p_file_name,
        p_mime_type => p_mime_type,
        p_attachment => p_attachment);
      disconnect_mail_server(l_mail_conn);
      pit.verbose(msg.MAIL_SENT);
    else
      pit.warn(msg.MAIL_PKG_NOT_WORKING);
    end if;
    pit.leave_mandatory;
  exception
    when others then
      utl_tcp.close_all_connections;
      pit.handle_exception(msg.MAIL_DELIVERY_FAILED);
  end send_mail;


  procedure send_mail(
    p_sender in varchar2,
    p_recipients in mail.address_tab,
    p_cc_recipients in mail.address_tab,
    p_subject in varchar2,
    p_message in varchar2)
  as
    l_mail_conn utl_smtp.connection;
  begin
    pit.enter_mandatory(
      p_params => msg_params(
        msg_param('p_sender', p_sender),
        msg_param('p_recipients (count)', to_char(p_recipients.count)),
        msg_param('p_cc_recipients (count)', to_char(p_cc_recipients.count)),
        msg_param('p_message (length)', length(p_message)),
        msg_param('p_subject', p_subject)));
    
    if g_pkg_is_working then
      pit.assert_not_null(p_sender, p_msg_args => msg_args('P_SENDER'));
      pit.assert(p_recipients.count > 0, p_msg_args => msg_args('P_RECIPIENTS'));
      pit.assert_not_null(p_subject, p_msg_args => msg_args('P_SUBJECT'));
      pit.assert_not_null(p_message, p_msg_args => msg_args('P_MESSAGE'));

      dbms_lob.createtemporary(g_trace_text, false, dbms_lob.call);

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
      disconnect_mail_server(l_mail_conn);
      pit.verbose(msg.MAIL_SENT);
    else
      pit.warn(msg.MAIL_PKG_NOT_WORKING);
    end if;
    
    pit.leave_mandatory;
  exception
    when others then
      utl_tcp.close_all_connections;
      pit.handle_exception(msg.MAIL_DELIVERY_FAILED);
  end send_mail;


  procedure send_mail(
    p_sender in varchar2,
    p_recipient in varchar2,
    p_subject in varchar2,
    p_message in varchar2,
    p_file_name in varchar2 default null,
    p_mime_type in varchar2 default null,
    p_attachment in blob default null)
  as
    l_recipient_list mail.address_tab;
  begin
    pit.enter_mandatory;
    
    -- Instrumentation done at SEND_MAIL overload
    if g_pkg_is_working then
      l_recipient_list := create_address_list(p_recipient);
      
      if p_attachment is not null then
        send_mail(
          p_sender => p_sender,
          p_recipients => l_recipient_list,
          p_cc_recipients => mail.address_tab(),
          p_subject => p_subject,
          p_message => p_message,
          p_file_name => p_file_name,
          p_mime_type => p_mime_type,
          p_attachment => p_attachment);
      else
        send_mail(
          p_sender => p_sender,
          p_recipients => l_recipient_list,
          p_cc_recipients => mail.address_tab(),
          p_subject => p_subject,
          p_message => p_message);
      end if;
    end if;
    
    pit.leave_mandatory;
  end send_mail;

begin
  initialize;
end mail;
/

