create or replace package mail
authid current_user
as

  /** Public constant declarations */

  /** Public type declarations  */
  type address_rec is record(
    user_name pit_util.ora_name_type,
    email varchar2(200));
  type address_tab is table of address_rec;

  /** Public variable declarations */
  g_pkg_is_working boolean;
  

  /* Prozedur SEND_MAIL versendet Mails inkl. Attachments.
   * #param p_sender Absender der Mail. Die Adresse kann in der Form
   *        foo@server.de oder "Willi Schmitz"<foo@server.de> uebergeben werden.
   * #param p_recipients Instanz der Nested Table MAIL.ADDRESS_TAB mit der Struktur
   *        <USER_NAME>|<EMAIL>. Die Email kann analog zu P_SENDER uebergeben werden,
   *        der Benutzername ist der Benutzername, der mit der Mailadresse verbunden
   *        ist. Der Benutzername wird Jasper Reports zur Filterung von Berichten
   *        uebergeben.
   * #param p_subject Betreff der Mail. Maximale Laenge ist 1000 Zeichen (empfohlen: 78 Zeichen)
   * #param p_message Inhalt der Mail. Innerhalb der Mail werden verschiedene Platzhalter
   *        automatisch ersetzt. Bislang ist folgender Platzhalter vorgesehen:
   *        #SALUTATION#: Wird ersetzt durch
   *           Sehr geehrter Herr/geehrte Frau <Titel> <Vorname> <Nachname>
   *        die Informationen werden aus den Benutzerstammdaten gewonnen und in
   *        Message MAIL_SALUTATION eingefuegt.
   *        Maximale Laenge der Mail: 32KByte.
   * #param p_filename Name der Datei, in der das Attachment uebergeben werden soll.
   *        Den Dateinamen mit Mime-Type angeben, typischerweise: <Berichtname>.<Mime-Type>.
   * #param p_attachment BLOB des Attachments. Falls NULL, wird kein Attachment angefuegt.
   *        in diesem Fall kann auch P_FILENAME NULL sein.
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


  /* Prozedur SEND_MAIL versendet Mails inkl. Attachments.
   * Ueberladung zur vereinfachten Verwendung
   * #param p_sender Absender der Mail. Die Adresse kann in der Form
   *        foo@server.de oder "Willi Schmitz"<foo@server.de> uebergeben werden.
   * #param p_recipient Einzelne Adresse, an die die Mail gesendet werden soll.
   * #param p_subject Betreff der Mail. Maximale Laenge ist 1000 Zeichen (empfohlen: 78 Zeichen)
   * #param p_message Inhalt der Mail. Innerhalb der Mail werden verschiedene Platzhalter
   *        automatisch ersetzt. Bislang ist folgender Platzhalter vorgesehen:
   *        #SALUTATION#: Wird ersetzt durch
   *           Sehr geehrter Herr/geehrte Frau <Titel> <Vorname> <Nachname>
   *        die Informationen werden aus den Benutzerstammdaten gewonnen und in
   *        Message MAIL_SALUTATION eingefuegt.
   *        Maximale Laenge der Mail: 32KByte.
   * #param p_filename Name der Datei, in der das Attachment uebergeben werden soll.
   *        Den Dateinamen mit Mime-Type angeben, typischerweise: <Berichtname>.<Mime-Type>.
   * #param p_attachment BLOB des Attachments. Falls NULL, wird kein Attachment angefuegt.
   *        in diesem Fall kann auch P_FILENAME NULL sein.
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