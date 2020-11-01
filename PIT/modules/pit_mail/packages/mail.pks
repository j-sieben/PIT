create or replace package mail
authid current_user
as
  /** Package to wrap sending mails via UTL_SMTP */

  /* Public type declarations  */
  /** Record to store a user name and its email address */
  type address_rec is record(
    user_name varchar2(30),
    email varchar2(200));
  /** Nested table of address records. */
  type address_tab is table of address_rec;


  /** Getter to retrieve the package status
   * %return TRUE if the package is working normally, FALSE otherwise
   * %usage  Is used to check whether the package works as expected. This is checked based on whether 
   *         {*} - the required ACL to contact the mail server is available
   *         {*} - the mail server can be contacted and logged on
   */
  function pkg_is_working
    return boolean;
   

  /** Method encodes confidential data.
   * %param  p_host      Mail server to send mails to
   * %param  p_host      Port of the Mail server
   * %param  p_user      Username at the mail server
   * %param  p_password  Password of the user.
   * %usage The method encodes the given parameters and stores them at parameter PIT_MAIL_CREDENTIALS
   *        CAVEAT: This is anything but secure. If in a sensitive environment, rather set up a SMTP relay
   */
  procedure set_credentials(
    p_host in varchar2,
    p_port in pls_integer,
    p_user in varchar2,
    p_password in varchar2);


  /* Method sends mails including attachments.
   * %param  p_sender         Sender of the mail. The address can be in the form foo@server.de or "Willi Schmitz"<foo@server.de>.
   * %param  p_recipients     Instance of the nested table MAIL.ADDRESS_TAB with the structure <USER_NAME>|<EMAIL>. 
   *                          The email can be passed analogous to P_SENDER, the username is the username associated with the mail address
   * %param  p_cc_recipients  Instance of the nested table MAIL.ADDRESS_TAB with the structure <USER_NAME>|<EMAIL>. 
   *                          The email can be passed analogous to P_SENDER, the username is the username associated with the mail address
   * %param  p_subject        Subject of the mail. Maximum length is 1000 characters (recommended: 78 characters)
   * %param  p_message        Content of the mail. Maximum length of the mail is 32KByte.
   * %param  p_fil_ename      Name of the file in which the attachment should be transferred.
   * %param  p_fmime_type     Mime-Type of the attachment, such as text/html, application/pdf and so on
   * %param  p_attachment     BLOB of the attachment.
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


  /* Method sends mails without attachments.
   * %param  p_sender         Sender of the mail. The address can be in the form foo@server.de or "Willi Schmitz"<foo@server.de>.
   * %param  p_recipients     Instance of the nested table MAIL.ADDRESS_TAB with the structure <USER_NAME>|<EMAIL>. 
   *                          The email can be passed analogous to P_SENDER, the username is the username associated with the mail address
   * %param  p_cc_recipients  Instance of the nested table MAIL.ADDRESS_TAB with the structure <USER_NAME>|<EMAIL>. 
   *                          The email can be passed analogous to P_SENDER, the username is the username associated with the mail address
   * %param  p_subject        Subject of the mail. Maximum length is 1000 characters (recommended: 78 characters)
   * %param  p_message        Content of the mail. Maximum length of the mail is 32KByte.
   */
  procedure send_mail(
    p_sender in varchar2,
    p_recipients in mail.address_tab,
    p_cc_recipients in mail.address_tab,
    p_subject in varchar2,
    p_message in varchar2);


  /* Procedure SEND_MAIL sends mails including attachments. Overload for simplified use
   * %param  p_sender      Sender of the mail. The address can be transferred in the form foo@server.de or "Willi Schmitz"<foo@server.de>.
   * %param  p_recipient   Single address to which the mail should be sent.
   * %param  p_subject     Subject of the mail. Maximum length is 1000 characters (recommended: 78 characters)
   * %param  p_message     Content of the mail. Maximum length of the mail: 32KByte.
   * %param [p_file_name]  Name of the fattachment file.
   * %param [p_filename]   Mime-Type of the attachment, such as text/html, application/pdf and so on
   * %param [p_attachment] BLOB of the attachment. If not NULL P_FILENAME and P_MIME_TYPE are required
   */
  procedure send_mail(
    p_sender in varchar2,
    p_recipient in varchar2,
    p_subject in varchar2,
    p_message in varchar2,
    p_file_name in varchar2 default null,
    p_mime_type in varchar2 default null,
    p_attachment in blob default null);

  procedure initialize;

end mail;
/

