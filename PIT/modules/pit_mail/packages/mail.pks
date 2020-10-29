create or replace package mail
authid current_user
as

  /** Helper package to send emails */

  /* Public type declarations  */
  type address_rec is record(
    user_name pit_util.ora_name_type,
    email varchar2(200));
  type address_tab is table of address_rec;

  /* Public variable declarations */
  g_pkg_is_working boolean;
  

  /** Procedure SEND_MAIL sends mails including attachments.
   * %param  p_sender          Sender of the mail. 
   *                           The address can be transferred in the form foo@server.de or "Bill Smith"<foo@server.de>.
   * %param  p_recipients      Recipients of the mail. 
   *                           Instance of the nested table MAIL.ADDRESS_TAB with the structure <USER_NAME>|<EMAIL>.
   *                           The email can be passed in the same way as P_SENDER, the username is the username associated with the email address.
   * %param  p_cc_recipients   CC-Recipients of the mail.
   *                           Instance of the nested table MAIL.ADDRESS_TAB with the structure <USER_NAME>|<EMAIL>.
   *                           The email can be passed in the same way as P_SENDER, the username is the username associated with the email address.
   * %param  p_subject         Subject of the mail.
   *                           Maximum length is 1000 characters (recommended: 78 characters)
   * %param  p_message         Content of the mail.
   *                           Maximum length of the mail: 32KByte.
   * %param [p_filename]       Name of the file in which the attachment should be transferred, including the file extension. Example: foo.pdf
   * %param [p_mime_type]      Mime type of the attachment. Example: application/pdf
   * %param [p_attachment]     BLOB of the attachment.
   *                           If NULL, no attachment is added. In this case P_FILENAME can also be NULL.
   */
  procedure send_mail(
    p_sender in varchar2,
    p_recipients in mail.address_tab,
    p_cc_recipients in mail.address_tab,
    p_subject in varchar2,
    p_message in varchar2,
    p_filename in varchar2,
    p_mime_type in varchar2,
    p_attachment in blob);


  /** Procedure SEND_MAIL sends mails including attachments. Overloaded to send a mail to one recipient without cc-recipients only.
   * %param  p_sender          Sender of the mail. 
   *                           The address can be transferred in the form foo@server.de or "Bill Smith"<foo@server.de>.
   * %param  p_recipient       semicolon-delimited list of addresses to which the mail should be sent.
   * %param  p_subject         Subject of the mail.
   *                           Maximum length is 1000 characters (recommended: 78 characters)
   * %param  p_message         Content of the mail.
   *                           Maximum length of the mail: 32KByte.
   * %param [p_filename]       Name of the file in which the attachment should be transferred, including the file extension. Example: foo.pdf 
   * %param [p_mime_type]      Mime type of the attachment. Example: application/pdf
   * %param [p_attachment]     BLOB of the attachment.
   *                           If NULL, no attachment is added. In this case P_FILENAME can also be NULL.
   */
  procedure send_mail(
    p_sender in varchar2,
    p_recipient in varchar2,
    p_subject in varchar2,
    p_message in varchar2,
    p_filename in varchar2 default null,
    p_mime_type in varchar2 default null,
    p_attachment in blob default null);

  procedure initialize;

end mail;
/