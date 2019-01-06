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

  /* Function to retrieve the text for a given language without replacements
   * %param p_pms_name Name of the message to retrieve the text for
   * %param p_pms_pml_name Oracle language reference
   * %usage This function is used to review the text a given message has in a 
   *        desired language 
   */
  function get_message_text(
    p_pms_name in pit_message.pms_name%type,
    p_pms_pml_name in pit_message_language.pml_name%type := null)
    return varchar2;
    

  /* Procedure to maintain message groups
   * %param  p_pmg_name         Name of the message_group
   * %param  p_pmg_description  Optional description to describe the message group.
   */
  procedure merge_message_group(
    p_pmg_name in pit_message_group.pmg_name%type,
    p_pmg_description in pit_message_group.pmg_description%type default null);
    

  /* Procedure to maintain messages
   * %param p_pms_name Name of the respective pit_message. Must be unique for the default language
   * %param p_pms_text Message text with replacement anchors in the format #n#, 
   *        where n is an integer that references up to 50 replacement items
   * %param p_pms_pse_id Reference to a severity as defined in PIT.LEVEL_<level> constants.
   *        Ranges from PIT.LEVEL_FATAL to PIT.LEVEL_VERBOSE or 20..70
   * %param p_pms_pml_name Reference to the Oracle supported language names, 
   *        if null, the default language is used (as defined in pms_pml_nameS)
   * %param p_error_number Optional reference to an Oracle system error number.
   *        must not be a number of an Oracle predefined error number. If null
   *        and the severity of the message is in 20|30, then an error number
   *        from the range -20999..-20000 is used.
   */
  procedure merge_message(
    p_pms_name in pit_message.pms_name%type,
    p_pms_text in pit_message.pms_text%type,
    p_pms_pse_id in pit_message.pms_pse_id%type,
    p_pms_description in pit_message.pms_description%type default null,
    p_pms_pmg_name in pit_message_group.pmg_name%type default null,
    p_pms_pml_name in pit_message_language.pml_name%type default null,
    p_error_number in pit_message.pms_custom_error%type default null);
    

  /* Procedure to translate a given message
   * %param p_pms_name Name of the respective pit_message. Must be unique for the default language
   * %param p_pms_text Message text with replacement anchors in the format #n#, 
   *        where n is an integer that references up to 50 replacement items
   * %param p_pms_pml_name Reference to the Oracle supported language names
   * %usage Use this procedure as a shortcut for an already existing message, if
   *        the only task is to translate it.
   */
  procedure translate_message(
    p_pms_name in pit_message.pms_name%type,
    p_pms_text in pit_message.pms_text%type,
    p_pms_pml_name in pit_message_language.pml_name%type,
    p_pms_description in pit_message.pms_description%type default null);
    
    
  /* Procedure to remoce a single pit_message. Will delete all translations as well
   * %param p_mesage_name Name of the message to delete
   * %param p_pms pse_id Language of the message to delete. If Default language,
   *        all translations are deleted, otherwise only the translated message
   * %usage is called to remove mistyped or unnecessary messages in all languages.
   *        Will not commit nor re-create the MSG package.
   */
  procedure remove_message(
    p_pms_name in pit_message.pms_name%type,
    p_pms_pml_name in pit_message_language.pml_name%type);
    
    
  /* Procedure to remoce a single pit_message. Will delete all translations as well
   * %param  p_pmg_name  Name of the message group to delete
   * %usage  is called to remove mistyped or unnecessary messages in all languages.
   *         Will commit and re-create the MSG package.
   */
  procedure remove_message_group(
    p_pmg_name in pit_message_group.pmg_name%type);
    
  
  /* Procedure to remove all messages
   * %usage Is called if a new set of messages shall be installed and all old and
   *        unneeded messages shall be thrown away.
   *        Will not commit nor re-create the MSG package.
   */
  procedure remove_all_messages;
    

  /* Function to retrieve an XML file in format XLIFF to translate messages
   * %param p_target_language Oracle supported language name the messages shall be translated to
   * %param p_message_pattern Optional pattern that restricts number of messages
   *        by filtering messages that start with P_MESSAGE_PATTERN
   * %return XML-instance in format XLIFF to be opened and edited by an XLIFF-Editor
   * %usage Call this function to create an XLIFF-File that can be used to translate all
   *        error messages into a target language at once.
   */
  function get_translation_xml(
    p_target_language in pit_message_language.pml_name%type,
    p_message_pattern in varchar2 default null)
    return xmltype;
    

  /* Procedure to import translated messages into the database
   * %param p_translation_xml XLIFF-instance with the translated messages
   * %usage If provided with a translated XLIFF-Instanve, this procedure creates
   *        the necessary entries in table MESSAGE for the new language.
   */
  procedure translate_messages(
    p_translation_xml in xmltype);
  
  
  /* Procedure to remove a translation
   * %param p_language Oracle language name of the translation to be removed
   * %usage Is called to remove all messages in the given language.
   *        Will not commit.
   */
  procedure remove_translation(
    p_language in pit_message_language.pml_name%type);
    
    
  /* Method to set default language settings
   * %param  p_pml_list  List of colon-separated language names
   * %usage  Is used to initially set the default language settings
   *         Precedence is set accoding to the sort order: First languages preceede later languages
   */
  procedure set_language_settings(
    p_pml_list in pit_util.max_sql_char);
    

  /* Procedure to (re-) create package MSG
   * %param p_directory Optional parameter to define a directory object the creation script shall be written to.
   *        if null, the code i executed immediately.
   * %usage If called with  no parameter, this procedure creates package MSG based on the actual messages
   *        from table pit_message. It automatically maps all custom or oracle errors and creates respective
   *        exception variables for them.
   *        If called with a directory name, the package is not created but written to 
   *        the file system for later creation or deployment purposes.
   */
  procedure create_message_package(
    p_directory varchar2 default null);
    
  
  /* Function to get messages as a CLOB instance
   * %param  p_message_pattern  Optional pattern that restricts number of messages
   *                            by filtering messages that start with P_MESSAGE_PATTERN
   * %param  p_pmg_id           Optional message group to filter message output
   * %return XML-instance in format XLIFF to be opened and edited by an XLIFF-Editor
   * %usage  Call this function to create an XLIFF-File that can be used to translate all
   *         error messages into a target language at once.
   */
  function get_messages(
    p_message_pattern in varchar2 default null,
    p_pmg_name in pit_message_group.pmg_name%type default null)
    return clob;
    
  
  /* Procedure to write all messages to a file
   * %param p_directory Name of a directory object the file shall be written to
   */  
  procedure write_message_file(
    p_directory in varchar2 := 'DATA_DIR');
    
  
  /* Translatable items */  
  procedure merge_translatable_item(
    p_pti_id in pit_translatable_item.pti_id%type,
    p_pti_pml_name in pit_message_language.pml_name%type,
    p_pti_pmg_name in pit_message_group.pmg_name%type,
    p_pti_name in varchar2,
    p_pti_display_name in varchar2 default null,
    p_pti_description in clob default null);    
    
  procedure delete_translatable_item(
    p_pti_id in pit_translatable_item.pti_id%type);
    
  
  function get_translatable_items(
    p_pmg_name in pit_message_group.pmg_name%type default null)
    return clob;
    
    
  /* Procedure to create a named context
   * %param p_context_name Name of the context. Maximum of 20 byte. Don't use umlauts or special chars
   * %param p_log_level Log level of the named context
   * %param p_trace level Trace level of the named context
   * %param p_trace_timing Flag to indicate whether timing information should be captured
   * %param p_module_list List of output modules to be used for logging
   * %param p_comment Optional comment to explain the usage of the named context
   * %usage Is called to create a named context
   */
  procedure create_named_context(
    p_context_name in varchar2,
    p_log_level in number,
    p_trace_level in number,
    p_trace_timing in boolean,
    p_module_list in varchar2,
    p_comment in varchar2 default null);
  
  
  /* Procedure to create a named context
   * %param p_context_name Name of the context. Maximum of 20 byte. Don't use umlauts or special chars
   * %param p_settings Settings string in the format LOG_LEVEL(10,20..70)|TRACE_LEVEL (10,20..40)|TRACE_TIMING_FLAG (Y,N)|MODULE_LIST (MODULE_1:MODULE_2)
   *        Valid examples are: 
   *        30|10|N|PIT_TABLE:PIT_MAIL, 70|40|Y|PIT_CONSOLE
   *        If you want to express that no logging should be used, use 10|10|N|
   * %param p_comment Optional comment to explain the usage of the named context
   * %usage Is called to create a new named context
   */
  procedure create_named_context(
    p_context_name in varchar2,
    p_settings in varchar2,
    p_comment in varchar2 default null);
    
  
  /* Procedure to remove a named context
   * %param p_context_name Name of the context to remove
   * %usage Is called to remove a named context
   */
  procedure remove_named_context(
    p_context_name in varchar2);
    
    
  /* Procedure to create a context toggle
   * %param p_toggle_name Name of the context toggle. Maximum of 20 byte. Don't use umlauts or special chars
   * %param p_module_list Name of the module to toggle the context for. May be a pipe separated list of modules
   *        Two formats are allowed: Name of a package/method or qualified name of a method in a package (without owner):
   *        Examples: MY_PACKAGE|MY_OTHER_PACKAGE.MY_PROC
   * %param p_context_name Name of the context to switch to. Must be an excisting context
   * %usage Is called to have PIT toggle it's context settings based on entering a module or a list of modules.
   */
  procedure create_context_toggle(
    p_toggle_name in varchar2,
    p_module_list in varchar2,
    p_context_name in varchar2,
    p_comment in varchar2 default null);
    
    
  /* Procedure to remove a context toggle
   * %param p_toggle_name Name of the context toggle to remove
   * %usage Is used to remove a context toggle
   */
  procedure remove_context_toggle(
    p_toggle_name in varchar2); 
    
end pit_admin;
/