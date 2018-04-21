begin
  
  pit_admin.merge_message_group(
    p_pmg_name => 'PIT_MAIL',
    p_pmg_description => q'^Message for Outputmodule PIT_MAIL^'
  );
  
  pit_admin.merge_message(
    p_pms_name => 'PIT_MAIL_ERROR',
    p_pms_pmg_name => 'PIT_MAIL',
    p_pms_text => 'Fehler beim Versenden einer Email: #1#, #2#',
    p_pms_pse_id => 30,
    p_pms_pml_name => 'GERMAN');
  
  pit_admin.merge_message(
    p_pms_name => 'INVALID_MIME_TYPE',
    p_pms_pmg_name => 'PIT_MAIL',
    p_pms_text => q'^Ungültiger Mime-Typ:#1#^',
    p_pms_pse_id => 30,
    p_pms_pml_name => 'GERMAN',
    p_error_number => -20000
  );

  pit_admin.merge_message(
    p_pms_name => 'MAIL_DELIVERY_FAILED',
    p_pms_pmg_name => 'PIT_MAIL',
    p_pms_text => q'^Fehler beim Versenden der E-Mail^',
    p_pms_pse_id => 30,
    p_pms_pml_name => 'GERMAN',
    p_error_number => -20000
  );

  pit_admin.merge_message(
    p_pms_name => 'MAIL_ERROR',
    p_pms_pmg_name => 'PIT_MAIL',
    p_pms_text => q'^Fehler bei der Erzeugung einer E-Mail.^',
    p_pms_pse_id => 30,
    p_pms_pml_name => 'GERMAN',
    p_error_number => -20000
  );

  pit_admin.merge_message(
    p_pms_name => 'MAIL_LOG',
    p_pms_pmg_name => 'PIT_MAIL',
    p_pms_text => q'^#1#^',
    p_pms_pse_id => 60,
    p_pms_pml_name => 'GERMAN',
    p_error_number => null
  );

  pit_admin.merge_message(
    p_pms_name => 'MAIL_LOGIN',
    p_pms_pmg_name => 'PIT_MAIL',
    p_pms_text => q'^Einloggen mittels '#1#'-Verfahren und Zugangsdaten '#2#'^',
    p_pms_pse_id => 60,
    p_pms_pml_name => 'GERMAN',
    p_error_number => null
  );

  pit_admin.merge_message(
    p_pms_name => 'MAIL_LOGIN_METHODS',
    p_pms_pmg_name => 'PIT_MAIL',
    p_pms_text => q'^Unterstützte Authentifizierungsverfahren: '#1#'^',
    p_pms_pse_id => 60,
    p_pms_pml_name => 'GERMAN',
    p_error_number => null
  );

  pit_admin.merge_message(
    p_pms_name => 'MAIL_PKG_NOT_WORKING',
    p_pms_pmg_name => 'PIT_MAIL',
    p_pms_text => q'^Fehler beim Versuch, das MAIL-Package zu initialisieren.^',
    p_pms_pse_id => 30,
    p_pms_pml_name => 'GERMAN',
    p_error_number => -20000
  );

  pit_admin.merge_message(
    p_pms_name => 'MAIL_RECIPIENTS',
    p_pms_pmg_name => 'PIT_MAIL',
    p_pms_text => q'^Empfänger: '#1#'^',
    p_pms_pse_id => 60,
    p_pms_pml_name => 'GERMAN',
    p_error_number => null
  );

  pit_admin.merge_message(
    p_pms_name => 'MAIL_SALUTATION',
    p_pms_pmg_name => 'PIT_MAIL',
    p_pms_text => q'^Sehr geehrte Damen und Herren^',
    p_pms_pse_id => 60,
    p_pms_pml_name => 'GERMAN',
    p_error_number => null
  );

  pit_admin.merge_message(
    p_pms_name => 'MAIL_SALUTATION_FEMALE',
    p_pms_pmg_name => 'PIT_MAIL',
    p_pms_text => q'^Sehr geehte Frau #1##2#^',
    p_pms_pse_id => 60,
    p_pms_pml_name => 'GERMAN',
    p_error_number => null
  );

  pit_admin.merge_message(
    p_pms_name => 'MAIL_SALUTATION_MALE',
    p_pms_pmg_name => 'PIT_MAIL',
    p_pms_text => q'^Sehr geehrter Herr #1##2#^',
    p_pms_pse_id => 60,
    p_pms_pml_name => 'GERMAN',
    p_error_number => null
  );

  pit_admin.merge_message(
    p_pms_name => 'MAIL_SENDER',
    p_pms_pmg_name => 'PIT_MAIL',
    p_pms_text => q'^Absender: '#1#'^',
    p_pms_pse_id => 60,
    p_pms_pml_name => 'GERMAN',
    p_error_number => null
  );

  pit_admin.merge_message(
    p_pms_name => 'MAIL_SENT',
    p_pms_pmg_name => 'PIT_MAIL',
    p_pms_text => q'^Mail erfolgreich versendet.^',
    p_pms_pse_id => 60,
    p_pms_pml_name => 'GERMAN',
    p_error_number => null
  );

  pit_admin.merge_message(
    p_pms_name => 'MAIL_SERVER_ACCESS_DENIED',
    p_pms_pmg_name => 'PIT_MAIL',
    p_pms_text => q'^Die Datenbank hat den Zugriff auf den Mail-Server verweigert.^',
    p_pms_pse_id => 30,
    p_pms_pml_name => 'GERMAN',
    p_error_number => -20000
  );

  pit_admin.merge_message(
    p_pms_name => 'MAIL_SERVER_ACCESS_GRANTED',
    p_pms_pmg_name => 'PIT_MAIL',
    p_pms_text => q'^Die Datenbank hat den Zugriff auf den Mail-Server gestattet.^',
    p_pms_pse_id => 70,
    p_pms_pml_name => 'GERMAN',
    p_error_number => null
  );

  pit_admin.merge_message(
    p_pms_name => 'MAIL_SERVER_ACCESSIBLE',
    p_pms_pmg_name => 'PIT_MAIL',
    p_pms_text => q'^Der Mail-Server ist erreichbar.^',
    p_pms_pse_id => 70,
    p_pms_pml_name => 'GERMAN',
    p_error_number => null
  );

  pit_admin.merge_message(
    p_pms_name => 'MAIL_SERVER_CONNECTED',
    p_pms_pmg_name => 'PIT_MAIL',
    p_pms_text => q'^Verbindung zum Mailserver hergestellt.^',
    p_pms_pse_id => 60,
    p_pms_pml_name => 'GERMAN',
    p_error_number => null
  );

  pit_admin.merge_message(
    p_pms_name => 'MAIL_SERVER_DISCONNECTED',
    p_pms_pmg_name => 'PIT_MAIL',
    p_pms_text => q'^Verbindung zum Mailserver beendet.^',
    p_pms_pse_id => 60,
    p_pms_pml_name => 'GERMAN',
    p_error_number => null
  );

  pit_admin.merge_message(
    p_pms_name => 'MAIL_SERVER_UNAVAILABLE',
    p_pms_pmg_name => 'PIT_MAIL',
    p_pms_text => q'^Der Mail-Server ist nicht erreichbar.^',
    p_pms_pse_id => 30,
    p_pms_pml_name => 'GERMAN',
    p_error_number => -20000
  );

  pit_admin.merge_message(
    p_pms_name => 'MAIL_TEST',
    p_pms_pmg_name => 'PIT_MAIL',
    p_pms_text => q'^Das ist eine Testmail zum Nachweis, dass die Verbindung funktioniert.^',
    p_pms_pse_id => 70,
    p_pms_pml_name => 'GERMAN',
    p_error_number => null
  );

  pit_admin.create_message_package;
  
end;
/