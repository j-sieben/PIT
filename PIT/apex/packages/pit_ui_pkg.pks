create or replace package pit_ui_pkg
  authid definer
as 

  /* TODO Funktionen für
     - Erzeugen, Editieren, Uebersetzen und Loeschen von Meldungen
     - Erzeugen, Editieren, Loeschen von benannten Kontexten
     - Erzeugen, Editieren und Loeschen von Parametern / Parametergruppen
     - Export von Nachrichten, Kontexten, Parametern
   */
   
   
  /* Prozedur zur Verwaltung der Standardsprachen
   * %param p_pml_list Liste der Sprachen in der Reihenfolge ihrer Verwendung
   * %usage Wird verwendet, um die Spracheinstellungen fuer PIT einzustellen.
   *        Die Standardsprache kann hier nicht geaendert werden, die wurde bei 
   *        der Installation von PIT festgelegt. Hier kann nur definiert werden,
   *        Welce Uebersetzungen mit welchem Vorrang verwendet werden sollen.
   */
  procedure set_language_settings(
    p_pml_list in pit_util.max_sql_char);
    
  
  /* Prozedur zur Verwaltung von Meldungen
   * %param p_pms_name Name der Meldung
   * %param p_pms_pml_name Sprache des Meldungstextes
   * %param p_pms_text Meldungstext
   * %param p_pms_pse_id Schweregrad der Meldung
   * %param p_pms_custom_error Oracle-Fehlernummer, auf die die Meldung gemappt werden soll
   * %usage Wird verwendet, um eine Meldung zu editieren oder zu erstellen
   */
  procedure merge_message(
    p_pms_name in pit_util.ora_name_type,
    p_pms_pml_name in pit_util.ora_name_type,
    p_pms_text in clob,
    p_pms_pse_id in binary_integer,
    p_pms_custom_error binary_integer);
    
  
  /* Prozedur zum Entfernen von Meldungen
   * %param p_pms_name Name der Meldung, die entfernt werden soll
   * %param p_pms_pml_name Sprache der Meldung.
   * %usage Wird verwendet, um eine Meldung zu loeschen.
   *        Ist P_PMS_PSE_ID die Defaultsprache, werden alle Uebersetzungen
   *        entfernt, ansonsten nur die angeforderte Uebersetzung.
   */
  procedure delete_message(
    p_pms_name in pit_util.ora_name_type,
    p_pms_pml_name in pit_util.ora_name_type);
    
  
  /* Prozedur zum Exportieren von Meldungen
   * %param p_message_pattern Optionales Pattern, das festlegt, dass nur Meldungen
   *        exportiert werden sollen, die mit diesem Pattern beginnen
   * %usage Wird verwendet, um eine Datei zu erstellen und im Browser herunterzuladen.
   */
  procedure export_messages(
    p_message_pattern in pit_util.max_sql_char);
  
  
  /* Prozedur zur Erstellung einer XLIFF-Datei mit allen angeforderten Meldungen
   * %param p_target_language Zielsprache (Oracle-Name), in die die Meldungen 
   *        uebersetzt werden sollen
   * %param p_message_pattern Optionales Pattern, das festlegt, dass nur Meldungen
   *        ueberesetzt werden sollen, die mit diesem Pattern beginnen
   * %usage Wird verwendet, um eine Datei zu erstellen und im Browser herunterzuladen.
   */
  procedure translate_messages(
    p_target_language in pit_util.ora_name_type,
    p_message_pattern in pit_util.max_sql_char);
    
  
  /* Prozedur zur Verwaltung benannter Kontexte
   * %param p_context_name Name des Kontextes
   * %param p_log_level Eingestellter Debugging-Level
   * %param p_trace_level Eingestellter Trace-Level
   * %param p_trace_timing Flag, das anzeigt, ob Zeitinformationen erhoben werden sollen (Y|N)
   * %param p_module_list Liste der Ausgabemodule, ':'-separiert
   * %param p_comment Beschreibung des Kontextes
   * %usage Wird verwendet, um einen Kontext zu administrieren
   */
  procedure merge_named_context(
    p_context_name in pit_util.ora_name_type,
    p_log_level in binary_integer,
    p_trace_level in binary_integer,
    p_trace_timing in pit_util.flag_type,
    p_module_list in pit_util.max_sql_char,
    p_comment in pit_util.max_char);
    
    
  /* Prozedur zum Loeschen eines Kontextes
   * %param p_context_name Name des Kontextes
   * %usage Wird verwendet, um einen Kontext zu loeschen
   */
  procedure delete_named_context(
    p_context_name in pit_util.ora_name_type);
    
  
  /* Prozedur zur Erzeugung eines Kontext-Toggles
   * %param p_toggle_name Name des Toggles
   * %param p_module_list Liste der Packages, fuer die Debug getoggelt werden soll
   * %param p_context_name Name des Context, zu dem geschaltet werden soll
   * %param p_comment Beschreibung des Kontext-Toggles
   * %usage Wird verwendet, um einen Kontext-Toggle zu erstellen.
   */
  procedure merge_context_toggle(
    p_toggle_name in pit_util.ora_name_type,
    p_module_list in pit_util.max_sql_char,
    p_context_name in pit_util.ora_name_type,
    p_comment in pit_util.max_sql_char);
    
  
  /* Prozedur loescht einen bestehenden Kontext-Toggle
   * %param p_toggle_name Name des Toggles
   * %usage Wird verwendet, um einen Toggle zu entfernen.
   */
  procedure delete_context_toggle(
    p_toggle_name in pit_util.ora_name_type);
  
  
  /* Funktion prueft, ob uebergebene Zahl eine Ganzzahl ist
   * %param p_value Zahl, die gepueft werden soll
   * %usage Wird verwendet, um Ganzzahlparameter zu validieren
   */
  function validate_is_integer(
    p_value in varchar2)
    return varchar2;

  /* Prozedur export eine Liste von Parametergruppen
   * %param [p_parameter_groups] ':'-separierte Liste der Parametergruppen, die 
   *                             exportiert werden sollen.Falls NULL, werden
   *                             alle Parameter in eine einzelne Datei exportiert
   * %usage Wird aufgerufen, um eine gezippte Datei zu erhalten, die alle 
   *        angeforderten Parametergruppen als separate Dateien enthaelt.
   */
  procedure export_parameter_group(
    p_parameter_groups in pit_util.max_sql_char default null);
   
end pit_ui_pkg;
/