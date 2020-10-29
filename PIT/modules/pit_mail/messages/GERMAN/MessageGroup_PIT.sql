begin
  
  pit_admin.merge_message(
    p_pms_name => 'PIT_MAIL_ERROR',
    p_pms_pmg_name => 'PIT',
    p_pms_text => 'Fehler beim Versenden einer Email: #1#, #2#',
    p_pms_description => q'^Generische Fehlernachricht für Fehler beim Versenden einer Mail.^',
    p_pms_pse_id => 30,
    p_pms_pml_name => 'GERMAN');
  
  pit_admin.merge_message(
    p_pms_name => 'INVALID_MIME_TYPE',
    p_pms_pmg_name => 'PIT',
    p_pms_text => q'^Ungültiger Mime-Typ:#1#^',
    p_pms_description => q'^Der Typ der zu übertragenden Datei ist ein Format, das von PIT_MAIL nicht unterstützt wird.^',
    p_pms_pse_id => 30,
    p_pms_pml_name => 'GERMAN',
    p_error_number => -20000
  );

  pit_admin.merge_message(
    p_pms_name => 'MAIL_DELIVERY_FAILED',
    p_pms_pmg_name => 'PIT',
    p_pms_text => q'^Fehler beim Versenden der E-Mail^',
    p_pms_description => q'^Der Versand konnte aus einem unbekannten Grund nicht ausgeführt werden. Bitte wenden Sie sich an den Support.^',
    p_pms_pse_id => 30,
    p_pms_pml_name => 'GERMAN',
    p_error_number => -20000
  );

  pit_admin.merge_message(
    p_pms_name => 'MAIL_ERROR',
    p_pms_pmg_name => 'PIT',
    p_pms_text => q'^Fehler bei der Erzeugung einer E-Mail.^',
    p_pms_description => q'^^',
    p_pms_pse_id => 30,
    p_pms_pml_name => 'GERMAN',
    p_error_number => -20000
  );

  pit_admin.merge_message(
    p_pms_name => 'MAIL_LOG',
    p_pms_pmg_name => 'PIT',
    p_pms_text => q'^#1#^',
    p_pms_description => q'^^',
    p_pms_pse_id => 60,
    p_pms_pml_name => 'GERMAN',
    p_error_number => null
  );

  pit_admin.merge_message(
    p_pms_name => 'MAIL_LOGIN',
    p_pms_pmg_name => 'PIT',
    p_pms_text => q'^Einloggen mittels '#1#'-Verfahren und Zugangsdaten '#2#'^',
    p_pms_description => q'^^',
    p_pms_pse_id => 60,
    p_pms_pml_name => 'GERMAN',
    p_error_number => null
  );

  pit_admin.merge_message(
    p_pms_name => 'MAIL_LOGIN_METHODS',
    p_pms_pmg_name => 'PIT',
    p_pms_text => q'^Unterstützte Authentifizierungsverfahren: '#1#'^',
    p_pms_description => q'^^',
    p_pms_pse_id => 60,
    p_pms_pml_name => 'GERMAN',
    p_error_number => null
  );

  pit_admin.merge_message(
    p_pms_name => 'MAIL_PKG_NOT_WORKING',
    p_pms_pmg_name => 'PIT',
    p_pms_text => q'^Fehler beim Versuch, das MAIL-Package zu initialisieren.^',
    p_pms_description => q'^Initialisierungsfehler deuten auf falsche Parameterwerte für das PIT_MAIL-Ausgabemodul hin. Bitte prüfen Sie die Parameter.^',
    p_pms_pse_id => 30,
    p_pms_pml_name => 'GERMAN',
    p_error_number => -20000
  );

  pit_admin.merge_message(
    p_pms_name => 'MAIL_RECIPIENTS',
    p_pms_pmg_name => 'PIT',
    p_pms_text => q'^Empfänger: '#1#'^',
    p_pms_description => q'^^',
    p_pms_pse_id => 60,
    p_pms_pml_name => 'GERMAN',
    p_error_number => null
  );

  pit_admin.merge_message(
    p_pms_name => 'MAIL_SALUTATION',
    p_pms_pmg_name => 'PIT',
    p_pms_text => q'^Sehr geehrte Damen und Herren^',
    p_pms_description => q'^^',
    p_pms_pse_id => 60,
    p_pms_pml_name => 'GERMAN',
    p_error_number => null
  );

  pit_admin.merge_message(
    p_pms_name => 'MAIL_SALUTATION_FEMALE',
    p_pms_pmg_name => 'PIT',
    p_pms_text => q'^Sehr geehte Frau #1##2#^',
    p_pms_description => q'^^',
    p_pms_pse_id => 60,
    p_pms_pml_name => 'GERMAN',
    p_error_number => null
  );

  pit_admin.merge_message(
    p_pms_name => 'MAIL_SALUTATION_MALE',
    p_pms_pmg_name => 'PIT',
    p_pms_text => q'^Sehr geehrter Herr #1##2#^',
    p_pms_description => q'^^',
    p_pms_pse_id => 60,
    p_pms_pml_name => 'GERMAN',
    p_error_number => null
  );

  pit_admin.merge_message(
    p_pms_name => 'MAIL_SENDER',
    p_pms_pmg_name => 'PIT',
    p_pms_text => q'^Absender: '#1#'^',
    p_pms_description => q'^^',
    p_pms_pse_id => 60,
    p_pms_pml_name => 'GERMAN',
    p_error_number => null
  );

  pit_admin.merge_message(
    p_pms_name => 'MAIL_SENT',
    p_pms_pmg_name => 'PIT',
    p_pms_text => q'^Mail erfolgreich versendet.^',
    p_pms_description => q'^^',
    p_pms_pse_id => 60,
    p_pms_pml_name => 'GERMAN',
    p_error_number => null
  );

  pit_admin.merge_message(
    p_pms_name => 'MAIL_SERVER_ACCESS_DENIED',
    p_pms_pmg_name => 'PIT',
    p_pms_text => q'^Die Datenbank hat den Zugriff auf den Mail-Server verweigert.^',
    p_pms_description => q'^Ab Version 11g benötigt Oracle eine Freigabe für den Zugriff auf eine Netzressource. Stellen Sie sicher, dass die Datenbank auf diese Ressource zugreifen darf.^',
    p_pms_pse_id => 30,
    p_pms_pml_name => 'GERMAN',
    p_error_number => -20000
  );

  pit_admin.merge_message(
    p_pms_name => 'MAIL_SERVER_ACCESS_GRANTED',
    p_pms_pmg_name => 'PIT',
    p_pms_text => q'^Die Datenbank hat den Zugriff auf den Mail-Server gestattet.^',
    p_pms_description => q'^^',
    p_pms_pse_id => 70,
    p_pms_pml_name => 'GERMAN',
    p_error_number => null
  );

  pit_admin.merge_message(
    p_pms_name => 'MAIL_SERVER_ACCESSIBLE',
    p_pms_pmg_name => 'PIT',
    p_pms_text => q'^Der Mail-Server ist erreichbar.^',
    p_pms_description => q'^^',
    p_pms_pse_id => 70,
    p_pms_pml_name => 'GERMAN',
    p_error_number => null
  );

  pit_admin.merge_message(
    p_pms_name => 'MAIL_SERVER_CONNECTED',
    p_pms_pmg_name => 'PIT',
    p_pms_text => q'^Verbindung zum Mailserver hergestellt.^',
    p_pms_description => q'^^',
    p_pms_pse_id => 60,
    p_pms_pml_name => 'GERMAN',
    p_error_number => null
  );

  pit_admin.merge_message(
    p_pms_name => 'MAIL_SERVER_DISCONNECTED',
    p_pms_pmg_name => 'PIT',
    p_pms_text => q'^Verbindung zum Mailserver beendet.^',
    p_pms_description => q'^^',
    p_pms_pse_id => 60,
    p_pms_pml_name => 'GERMAN',
    p_error_number => null
  );

  pit_admin.merge_message(
    p_pms_name => 'MAIL_SERVER_UNAVAILABLE',
    p_pms_pmg_name => 'PIT',
    p_pms_text => q'^Der Mail-Server ist nicht erreichbar.^',
    p_pms_description => q'^Die Verbindung zum Mailserver ist zwar erlaubt, doch technisch nicht möglich. Grund könnte sein, dass der Mailserver auf einem anderen Port eingerichtet oder abgeschaltet ist.^',
    p_pms_pse_id => 30,
    p_pms_pml_name => 'GERMAN',
    p_error_number => -20000
  );

  pit_admin.merge_message(
    p_pms_name => 'MAIL_TEST',
    p_pms_pmg_name => 'PIT',
    p_pms_text => q'^Das ist eine Testmail zum Nachweis, dass die Verbindung funktioniert.^',
    p_pms_description => q'^^',
    p_pms_pse_id => 70,
    p_pms_pml_name => 'GERMAN',
    p_error_number => null
  );

  pit_admin.merge_message(
    p_pms_name => 'MAIL_MESSAGE_TEMPLATE',
    p_pms_pmg_name => 'PIT',
    p_pms_text => q'^<tr><td>#SEVERITY#</td><td>#AMOUNT#</td><td>#FIRST_DATE#</td><td>#LAST_DATE#</td><td>#MESSAGE#</td><td>#STACK#</td><td>#BACKTRACE#</td></tr>^',
    p_pms_description => q'^Vorlage, die festlegt, wie eine Nachricht zum Senden vorbereitet werden soll. Sollte die Ersatzanker SEVERITY, AMOUNT, FIRST_DATE, LAST_DATE, MESSAGE, STACK und BACKTRACE enthalten^',
    p_pms_pse_id => 70,
    p_pms_pml_name => 'GERMAN');

  pit_admin.merge_message(
    p_pms_name => 'MAIL_MAIL_TEMPLATE',
    p_pms_pmg_name => 'PIT',
    p_pms_text => q'^<p>Die folgenden Fehler wurden gemeldet: <p>
   <table><thead><tr><td>Schweregrad</td><td>Menge</td><td>Erstes Vorkommen</td><td>Letztes Vorkommen</td><td>Text</td><td>Fehlernummer</td><td>Aufrufstapel</td></tr></thead><tbody>#MELDUNGEN#</body></table>^',
    p_pms_description => q'^Email-Vorlage des Moduls PIT_MAIL. Muss mindestens einen MESSAGES-Anker enthalten, in den die Nachrichten eingefügt werden.^',
    p_pms_pse_id => 70,
    p_pms_pml_name => 'GERMAN');

  pit_admin.merge_message(
    p_pms_name => 'MAIL_ATTACHMENT',
    p_pms_pmg_name => 'PIT',
    p_pms_text => q'^Please find the error report attached.^',
    p_pms_description => q'^Message is used if the error message is too long to be incorporated into a normal mail.^',
    p_pms_pse_id => 70,
    p_pms_pml_name => 'AMERICAN');

  pit_admin.merge_message(
    p_pms_name => 'MAIL_ATTACHMENT',
    p_pms_pmg_name => 'PIT',
    p_pms_text => q'^Der Fehlerbericht ist als Anhang beigefügt.^',
    p_pms_description => q'^Message wird verwendet, wenn die Fehlermeldung zu lang ist, um in eine normale Mail eingebaut zu werden.^',
    p_pms_pse_id => 70,
    p_pms_pml_name => 'GERMAN');


  commit;
  pit_admin.create_message_package;
  
end;
/