create or replace package ui_pit_pkg 
as 

  /* TODO Funktionen für
     - Erzeugen, Editieren, Uebersetzen und Loeschen von Meldungen
     - Erzeugen, Editieren, Loeschen von benannten Kontexten
     - Erzeugen, Editieren und Loeschen von Parametern / Parametergruppen
     - Export von Nachrichten, Kontexten, Parametern
   */
  
  /* Prozedur zur Verwaltung von Meldungen
   * %param p_pms_name Name der Meldung
   * %param p_pms_pml_name Sprache des Meldungstextes
   * %param p_pms_text Meldungstext
   * %param p_pms_pse_id Schweregrad der Meldung
   * %param p_pms_custom_error Oracle-Fehlernummer, auf die die Meldung gemappt werden soll
   * %usage Wird verwendet, um eine Meldung zu editieren oder zu erstellen
   */
  procedure merge_message(
    p_messagen_name in pit_message.pms_name%type,
    p_pms_pml_name in pit_message.pms_pml_name%type,
    p_pms_text in pit_message.pms_text%type,
    p_pms_pse_id in pit_message.pms_pse_id%type,
    p_pms_custom_error pit_message.pms_custom_error%type);
    
  
  /* Prozedur zum Entfernen von Meldungen
   * %param p_pms_name Name der Meldung, die entfernt werden soll
   * %usage Wird verwendet, um eine Meldung inkl. aller Uebersetzungen zu entfernen.
   */
  procedure delete_message(
    p_pms_name in pit_message.pms_name%type);

end ui_pit_pkg;