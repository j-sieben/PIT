create or replace package pit_ui_pkg
  authid definer
as 

  /* TODO Funktionen für
     - Erzeugen, Editieren, Uebersetzen und Loeschen von Meldungen
     - Erzeugen, Editieren, Loeschen von benannten Kontexten
     - Erzeugen, Editieren und Loeschen von Parametern / Parametergruppen
     - Export von Nachrichten, Kontexten, Parametern
   */
   
  /** Getter method to retrieve the default PIT language. This language is defined upon installation of PIT and cannot be changed.
   * @return Default language
   */
  function get_default_language
    return varchar2;
    
  
  /** Wrapper around PIT_UTIL.harmonize_sql_name
   * @param  p_item_name  Name of the page item containing the SQL name
   * @param [p_prefix]    Optional prefix for the resulting name
   * @usage  Is used to format an entered alphanumerical key according to the naming conventions of PIT
   */
  procedure harmonize_sql_name(
    p_item_name in varchar2,
    p_prefix in varchar2 default null);
    
  
  /** Method to check whether translatable items are present.
   * @usage  Is used to toggle the visibility of a region
   */
  function has_translatable_items
    return boolean;
    
  
  /** Method to check whether local parameters are present.
   * @usage  Is used to toggle the visibility of a region
   */
  function has_local_parameters
    return boolean;
    
  
  /** Method to check whether toggle feature is switched on
   * @usage  Is used to toggle the visibility of a region
   */
  function allows_toggles
    return utl_apex.flag_type;
    
  
  /** Method to set a new toggle value.
   * @usage  Is called by the application via an AJAX call
   */
  procedure set_allow_toggles;
  
  
  /** Method to check wether the actually selected context is the default context
   * @return Flag to indicate that the context is the default context (TRUE) or not (FALSE)
   * @usage  Is used to control the visibility and editability of page items
   */
  function is_default_context
    return boolean;
    
    
  /** Procedure to validate or process application pages
   */
  
  function validate_edit_pms
    return boolean;
  
  procedure process_edit_pms;
  
  
  function validate_edit_pmg
    return boolean;
  
  procedure process_edit_pmg;
  
   
  function validate_edit_pgr
    return boolean;
  
  procedure process_edit_pgr;
  
  
  function validate_edit_par
    return boolean;
  
  procedure process_edit_par;
  
  
  function validate_export
    return boolean;
  
  procedure process_export;
  
  
  function validate_edit_module
    return boolean;
  
  procedure process_edit_module;
  
  
  function validate_edit_context
    return boolean;
  
  procedure process_edit_context;
  
  
  function validate_edit_toggle
    return boolean;
  
  procedure process_edit_toggle;
   
   
  /* Prozedur zur Verwaltung der Standardsprachen
   * @param p_pml_list Liste der Sprachen in der Reihenfolge ihrer Verwendung
   * @usage Wird verwendet, um die Spracheinstellungen fuer PIT einzustellen.
   *        Die Standardsprache kann hier nicht geaendert werden, die wurde bei 
   *        der Installation von PIT festgelegt. Hier kann nur definiert werden,
   *        Welce Uebersetzungen mit welchem Vorrang verwendet werden sollen.
   */
  procedure set_language_settings(
    p_pml_list in pit_util.max_sql_char);
  
  
  /* Funktion prueft, ob uebergebene Zahl eine Ganzzahl ist
   * @param p_value Zahl, die gepueft werden soll
   * @usage Wird verwendet, um Ganzzahlparameter zu validieren
   */
  function validate_is_integer(
    p_value in varchar2)
    return varchar2;
   
end pit_ui_pkg;
/