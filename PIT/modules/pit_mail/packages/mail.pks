create or replace package mail
  authid current_user
as

  /**
    Package: Output Modules.PIT_MAIL.MAIL
      Package to wrap sending mails via UTL_SMTP
   
    Author::
      Juergen Sieben, ConDeS GmbH
   */

  /**
    Group: Public Types
   */
  /**
    Type: address_rec
      Record to store a user name and its email address
      
    Attributes:
      user_name - Name of the user to send the email to
      email - Email address      
   */
  type address_rec is record(
    user_name varchar2(30),
    email varchar2(200));
    
  /** 
    Type: address_tab
      Nested table of <address_rec>. 
   */
  type address_tab is table of address_rec;


  /**
    Group: Public Methods
   */
  /**
    Function: pkg_is_working
      Getter to retrieve the package status.
      
      Is used to check whether the package works as expected. This is checked based on whether 
      
      - the required ACL to contact the mail server is available
      - the mail server can be contacted and logged on
      
    Returns: 
      TRUE if the package is working normally, FALSE otherwise
   */
  function pkg_is_working
    return boolean;
   

  /**
    Procedure: set_credentials
      Method encodes confidential data. The method encodes the given parameters and stores them at parameter 
      <PIT_MAIL_CREDENTIALS>
      
    CAVEAT:: 
      This is anything but secure. If in a sensitive environment, rather set up a SMTP relay
      
    Parameters:
      p_host - Mail server to send mails to
      p_host - Port of the Mail server
      p_user - Username at the mail server
      p_password - Password of the user
   */
  procedure set_credentials(
    p_host in varchar2,
    p_port in pls_integer,
    p_user in varchar2,
    p_password in varchar2);


  /**
    Procedure: send_mail
      Method sends mails including attachments.
      
    Parameters:
      p_sender - Sender of the mail. The address can be in the form foo@server.de or "Willi Schmitz"<foo@server.de>.
      p_recipients - Instance of the nested table MAIL.ADDRESS_TAB with the structure <USER_NAME>|<EMAIL>. 
                     The email can be passed analogous to P_SENDER, the username is the username associated with the mail address.
      p_cc_recipients - Instance of the nested table MAIL.ADDRESS_TAB with the structure <USER_NAME>|<EMAIL>. 
                        The email can be passed analogous to P_SENDER, the username is the username associated with the mail address
      p_subject - Subject of the mail. Maximum length is 1000 characters (recommended: 78 characters)
      p_message - Content of the mail. Maximum length of the mail is 32KByte.
      p_fil_ename - Name of the file in which the attachment should be transferred.
      p_fmime_type - Mime-Type of the attachment, such as text/html, application/pdf and so on
      p_attachment - BLOB of the attachment.
   */
  procedure send_mail(
    p_sender in varchar2,
    p_recipients in mail.address_tab,
    p_cc_recipients in mail.address_tab,
    p_subject in varchar2,
    p_message in varchar2,
    p_file_name in varchar2,
    p_mime_type in varchar2,
    p_attachment in blob);


  /**
    Procedure: send_mail
      Method sends mails without attachments.
      
    Parameters:
      p_sender - Sender of the mail. The address can be in the form foo@server.de or "Willi Schmitz"<foo@server.de>.
      p_recipients - Instance of the nested table MAIL.ADDRESS_TAB with the structure <USER_NAME>|<EMAIL>. 
                     The email can be passed analogous to P_SENDER, the username is the username associated with the mail address.
      p_cc_recipients - Instance of the nested table MAIL.ADDRESS_TAB with the structure <USER_NAME>|<EMAIL>. 
                        The email can be passed analogous to P_SENDER, the username is the username associated with the mail address
      p_subject - Subject of the mail. Maximum length is 1000 characters (recommended: 78 characters)
      p_message - Content of the mail. Maximum length of the mail is 32KByte.
   */
  procedure send_mail(
    p_sender in varchar2,
    p_recipients in mail.address_tab,
    p_cc_recipients in mail.address_tab,
    p_subject in varchar2,
    p_message in varchar2);


  /**
    Procedure: send_mail
      Sends mails including attachments. Overload for simplified use.
      
    Parameters:
      p_sender - Sender of the mail. The address can be transferred in the form foo@server.de or "Willi Schmitz"<foo@server.de>.
      p_recipient - Single address to which the mail should be sent.
      p_subject - Subject of the mail. Maximum length is 1000 characters (recommended: 78 characters)
      p_message - Content of the mail. Maximum length of the mail: 32KByte.
      p_file_name - Optional name of the fattachment file.
      p_filename - Optional mime-Type of the attachment, such as text/html, application/pdf and so on
      p_attachment - Optional BLOB of the attachment. If not NULL P_FILENAME and P_MIME_TYPE are required
   */
  procedure send_mail(
    p_sender in varchar2,
    p_recipient in varchar2,
    p_subject in varchar2,
    p_message in varchar2,
    p_file_name in varchar2 default null,
    p_mime_type in varchar2 default null,
    p_attachment in blob default null);

  /**
    Procedure: initialize
      Initialization method
   */
  procedure initialize;

end mail;
/

