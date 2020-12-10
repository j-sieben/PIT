create or replace package pit_admin
authid definer
as 

  /**
    Package to administer PIT. Provides methods to create or maintain messages.
  */
  
  -- Installation switches
  c_level_le_warn constant boolean := TRUE;
  c_level_le_info constant boolean := TRUE;
  c_level_le_debug constant boolean := TRUE;
  c_level_le_all constant boolean := TRUE;
  
  c_trace_le_off constant boolean := TRUE;
  c_trace_le_mandatory constant boolean := TRUE;
  c_trace_le_optional constant boolean := TRUE;
  c_trace_le_detailed constant boolean := TRUE;
  c_trace_le_all constant boolean := TRUE;
  
  -- Target distinguish between areas of similar items to streamline the API
  C_TARGET_PMS constant pit_util.ora_name_type := 'PMS'; -- Messages
  C_TARGET_PTI constant pit_util.ora_name_type := 'PTI'; -- Translatable Items
  C_TARGET_PAR constant pit_util.ora_name_type := 'PAR'; -- Parameters
    

  /********** ITEM MAINTENANCE ***********/
  /* Procedure to maintain message groups
   * %param  p_pmg_name         Name of the message group
   * %param [p_pmg_description] Optional description to describe the message group.
   * %usage  Is used to create or change a message group. Message groups do not have any special meaning
   *         other than sorting messages for easier maintenance and export separation
   */
  procedure merge_message_group(
    p_pmg_name in pit_message_group.pmg_name%TYPE,
    p_pmg_description in pit_message_group.pmg_description%TYPE default null);
    
    
  /** Procedure to delete a message group
   * %param  p_pmg_name  Name of the message group
   * %param [p_force]    Flag to indicate whether deleting this group should delete all messages of this group
   *                     Standard: FALSE: If messages exists, an error is thrown
   * %usage  Is used to delete a message group. Does not delete a message group if messages exists within that group,
   *         unless specified by setting the P_FORCE parameter to TRUE. Will not commit nor re-create the MSG package.
   */
  procedure delete_message_group(
    p_pmg_name in pit_message_group.pmg_name%TYPE,
    p_force in boolean default false);
    

  /* Procedure to maintain messages
   * %param  p_pms_name      Name of the respective pit_message. Must be unique for the default language
   * %param  p_pms_text      Message text with replacement anchors in the format #n#, 
   *                         where n is an integer that references up to 50 replacement items
   * %param  p_pms_pse_id    Reference to a severity as defined in PIT.LEVEL_<level> constants.
   *                         Ranges from PIT.LEVEL_FATAL to PIT.LEVEL_VERBOSE or 20..70
   * %param [p_pms_pmg_name] Reference to the message group
   * %param [p_pms_pml_name] Reference to the Oracle supported language names, 
   *                         if null, the default language is used (as defined in pms_pml_name)
   * %param [p_error_number] Optional reference to an Oracle system error number.
   *                         must not be a number of an Oracle predefined error number. If null
   *                         and the severity of the message is in 20|30, then an error number
   *                         from the range -20999..-20000 is used.
   * %usage  Is used to create or change a PIT message. Will not commit nor re-create the MSG package.
   */
  procedure merge_message(
    p_pms_name in pit_message.pms_name%TYPE,
    p_pms_text in pit_message.pms_text%TYPE,
    p_pms_pse_id in pit_message.pms_pse_id%TYPE,
    p_pms_description in pit_message.pms_description%TYPE default null,
    p_pms_pmg_name in pit_message_group.pmg_name%TYPE default null,
    p_pms_pml_name in pit_message_language.pml_name%TYPE default null,
    p_error_number in pit_message.pms_custom_error%TYPE default null);
    
    
  /* Procedure to delete a single pit_message. Will delete all translations as well
   * %param  p_pms_name      Name of the message to delete
   * %param [p_pms_pml_name] Optional language of the message to delete. 
   *                         If null, all translations are deleted, otherwise only the translated message
   * %usage  is called to remove mistyped or unnecessary messages in all languages.
   *         Will not commit nor re-create the MSG package.
   */
  procedure delete_message(
    p_pms_name in pit_message.pms_name%TYPE,
    p_pms_pml_name in pit_message_language.pml_name%TYPE default null);
    
  
  /* Procedure to delete all messages
   * %param [p_pmg_name] Optional message group to limit deletion to message of this group.
   * %usage Is called if a new set of messages shall be installed and all old and
   *        unneeded messages shall be thrown away.
   *        Will not commit nor re-create the MSG package.
   */
  procedure delete_all_messages(
    p_pmg_name in pit_message_group.pmg_name%TYPE default null);
    
  
  /* Translatable items */
  /** Procedure to create a or change a translatable item
   * %param  p_pti_id            ID of the translatable item
   * %param  p_pit_pml_name      Language of the translatable item
   * %param  p_pti_pmg_name      Message group of the translatable item
   * %param  p_pti_name          Text of the translatable item
   * %param [p_pti_display_name] Optional display name of the translatable item
   * %param [p_pti_description]  Optional description of the translatable item
   * %usage  Is used to create or change a translatable item. Any item may have up to three different text items
   *         assotiated with it to allow for short, medium and longer versions of a text item.
   */
  procedure merge_translatable_item(
    p_pti_id in pit_translatable_item.pti_id%TYPE,
    p_pti_pml_name in pit_message_language.pml_name%TYPE,
    p_pti_pmg_name in pit_message_group.pmg_name%TYPE,
    p_pti_name in varchar2,
    p_pti_display_name in varchar2 default null,
    p_pti_description in clob default null);    
    
    
  /** Procedure to create a or change a translatable item
   * %param  p_pti_id  ID of the translatable item
   * %usage  Deletes a translatable item and all its translations.
   */
  procedure delete_translatable_item(
    p_pti_id in pit_translatable_item.pti_id%TYPE);
    
    
  /*********** SETTINGS **************/
  /* Function to retrieve the text for a given language without replacements
   * %param  p_pms_name      Name of the message to retrieve the text for
   * %param [p_pms_pml_name] Oracle language reference
   * %usage  This function is used to review the text of a given message in a desired language 
   */
  function get_message_text(
    p_pms_name in pit_message.pms_name%TYPE,
    p_pms_pml_name in pit_message_language.pml_name%TYPE default null)
    return varchar2;
    
    
  /* Method to set default language settings
   * %param  p_pml_list  List of colon-separated language names
   * %usage  Is used to initially set the default language settings
   *         Precedence is set accoding to the sort order: First languages preceede later languages
   */
  procedure set_language_settings(
    p_pml_list in pit_util.max_sql_char);
    

  /* Procedure to (re-) create package MSG
   * %param  p_directory  Optional parameter to define a directory object the creation writes to.
   *                      If NULL, the code is executed immediately.
   * %usage  If called with no parameter, this procedure creates package MSG based on the actual messages
   *         from table pit_message. It automatically maps all custom or oracle errors and creates respective
   *         exception variables for them.
   *         If called with a directory name, the package is not created but its DDL is written to 
   *         the file system for later creation or deployment purposes.
   */
  procedure create_message_package(
    p_directory varchar2 default null);
    
    
  /* Procedure to create a named context
   * %param  p_context_name  Name of the context. Maximum of 20 byte. Don't use umlauts or special chars
   * %param  p_log_level     Log level of the named context. Allowed values: LOG_LEVEL(10,20..70)
   * %param  p_trace level   Trace level of the named context. Allowed values: TRACE_LEVEL (10,20..40)
   * %param  p_trace_timing  Flag to indicate whether timing information should be captured
   * %param  p_module_list   List of colon separated output module names to be used for logging
   * %param [p_comment]      Optional comment to explain the usage of the named context
   * %usage  Is called to create a named context to control  debug settings
   */
  procedure create_named_context(
    p_context_name in varchar2,
    p_log_level in number,
    p_trace_level in number,
    p_trace_timing in boolean,
    p_module_list in varchar2,
    p_comment in varchar2 default null);
  
  
  /* Procedure to create a named context. Overload
   * %param  p_context_name  Name of the context. Maximum of 20 byte. Don't use umlauts or special chars
   * %param  p_settings      Settings string in the format LOG_LEVEL(10,20..70)|TRACE_LEVEL (10,20..40)|TRACE_TIMING_FLAG (Y,N)|MODULE_LIST (MODULE_1:MODULE_2)
   *                         Valid examples are: 
   *                         - 30|10|N|PIT_TABLE:PIT_MAIL, 
   *                         - 70|40|Y|PIT_CONSOLE
   *                         If you want to express that no logging should be used, use 10|10|N|
   * %param [p_comment]      Optional comment to explain the usage of the named context
   * %usage  Is called to create a new named context
   */
  procedure create_named_context(
    p_context_name in varchar2,
    p_settings in varchar2,
    p_comment in varchar2 default null);
    
  
  /* Procedure to remove a named context
   * %param  p_context_name  Name of the context to remove
   * %usage  Is called to remove a named context
   */
  procedure remove_named_context(
    p_context_name in varchar2);
    
    
  /* Procedure to create a context toggle
   * %param  p_toggle_name   Name of the context toggle. Maximum of 20 byte. Don't use umlauts or special chars
   * %param  p_module_list   Name of the module to toggle the context for. May be a pipe separated list of modules
   *                         Two formats are allowed: Name of a package/method or qualified name of a method in a package (without owner):
   *                         Examples: MY_PACKAGE|MY_OTHER_PACKAGE.MY_PROC
   * %param  p_context_name  Name of the context to switch to. Must be an excisting context
   * %param [p_comment]      Optional comment to explain the usage of the toggle
   * %usage  Is called to have PIT toggle it's context settings based on entering a module or a list of modules.
   *         A toggle switches the debug settings if the package or procedure mentioned in the toggle is entered.
   */
  procedure create_context_toggle(
    p_toggle_name in varchar2,
    p_module_list in varchar2,
    p_context_name in varchar2,
    p_comment in varchar2 default null);
    
    
  /* Procedure to remove a context toggle
   * %param  p_toggle_name  Name of the context toggle to remove
   * %usage  Is used to delete a context toggle
   */
  procedure delete_context_toggle(
    p_toggle_name in varchar2); 
    
  
  /*********** EXPORT **************/
  /** Method to get items of a group as a script of API calls to PIT_ADMIN package
   * %param  p_pmg_name   Message group to filter output
   * %param  p_target     Type of items to translate C_TARGET_PMS | C_TARGET_PTI | C_TARGET_PAR
   * %param  p_file_name  Out parameter that provides the file name for the Script file
   * %param  p_script     Out parameter that contains the SQL script created
   * %usage  Call this method to create a script file that can be used to export all
   *         items of this particular group as a SQL script file.
   */
  procedure create_installation_script(
    p_pmg_name in pit_message_group.pmg_name%TYPE,
    p_target in varchar2,
    p_file_name out nocopy pit_util.ora_name_type,
    p_script out nocopy clob);
    
  
  /** Method to get items of a group as a script of API calls to PIT_ADMIN package
   * %param  p_pmg_name   Message group to filter output
   * %param  p_target     Type of items to translate C_TARGET_PMS | C_TARGET_PTI | C_TARGET_PAR
   * %return CLOB instance with the installation script
   * %usage  Call this method to create a script file that can be used to export all
   *         items of this particular group directly from SQL.
   */
  function get_installation_script(
    p_pmg_name in pit_message_group.pmg_name%TYPE,
    p_target in varchar2)
    return clob;
    

  /*********** TRANSLATION **************/
  /* Procedure to translate a given message
   * %param  p_pms_name         Name of the respective pit_message. Must be unique for the default language
   * %param  p_pms_text         Message text with replacement anchors in the format #n#, 
   *                            where n is an integer that references up to 50 replacement items
   * %param  p_pms_pml_name     Reference to the Oracle supported language names
   * %param [p_pms_description] Optional description to translate the message description
   * %usage  Use this procedure as a shortcut for an already existing message, if
   *         the only task is to translate it.
   */
  procedure translate_message(
    p_pms_name in pit_message.pms_name%TYPE,
    p_pms_text in pit_message.pms_text%TYPE,
    p_pms_pml_name in pit_message_language.pml_name%TYPE,
    p_pms_description in pit_message.pms_description%TYPE default null);
    

  /* Method to generate an XML file in format XLIFF to translate items
   * %param  p_target_language  Oracle supported language name to tranlsate the items to
   * %param  p_pmg_name         Group to filter the items to translate
   * %param  p_target           Type of items to translate C_TARGET_PMS | C_TARGET_PTI
   * %param  p_file_name        Out parameter that provides the file name for the XLIFF file
   * %param  p_xliff            Out parameter that contains the XLIFF file created
   * %usage  Call this procedure to create an XLIFF-File that can be used to translate
   *         all members of a target type group to a target language.
   */
  procedure create_translation_xml(
    p_target_language in pit_message_language.pml_name%TYPE,
    p_pmg_name in pit_message_group.pmg_name%TYPE default null,
    p_target in varchar2,
    p_file_name out nocopy pit_util.ora_name_type,
    p_xliff out nocopy xmltype);
    
  
  /** Method to directly create a translation XLIFF file and return it as CLOB
   * %param  p_target_language  Oracle supported language name to tranlsate the items to
   * %param  p_pmg_name         Group to filter the items to translate
   * %param  p_target           Type of items to translate C_TARGET_PMS | C_TARGET_PTI
   * %return CLOB in format XLIFF to be opened and edited by an XLIFF-Editor
   * %usage  Use this method to directly create a translation XLIFF file from SQL.
   */
  function get_translation_xml(
    p_target_language in pit_message_language.pml_name%TYPE,
    p_pmg_name in pit_message_group.pmg_name%TYPE default null,
    p_target in varchar2)
    return clob;
    

  /* Procedure to import translated items into the database
   * %param  p_xliff   XLIFF-instance with the translated messages
   * %param  p_target  Type of items to translate C_TARGET_PMS | C_TARGET_PTI
   * %usage  If provided with a translated XLIFF-Instance, this procedure creates
   *         the necessary items for the new language based on it target type.
   */
  procedure apply_translation(
    p_xliff in xmltype,
    p_target in varchar2);
  
  
  /* Procedure to delete a translation
   * %param  p_pml_name  Oracle language name of the translation to be removed
   * %param  p_target    Type of items to translate C_TARGET_PMS | C_TARGET_PTI
   * %usage  Is called to remove all items in the given language and target type.
   *         Will not commit.
   */
  procedure delete_translation(
    p_pml_name in pit_message_language.pml_name%TYPE,
    p_target in varchar2);
    
    
  /* Method to register a translated message, if not yet registered
   * %param  p_pml_name Oracle language name of the translation to register
   * %param  Is called when loading a translation. The translation message is set to one of the available langauges
   */
  procedure register_translation(
    p_pml_name in pit_message_language.pml_name%TYPE);
    
    
end pit_admin;
/