create or replace package pit_admin
authid definer
as 
  /** 
    Package: PIT_ADMIN
      Package to administer PIT. Provides methods to create or maintain messages.
   
    Author:: 
      Juergen Sieben, ConDeS GmbH
      
      Published under MIT licence
   */
  
  /**
    Group: Public Constants
   */
  /** 
    Constants: Installation switches
      Flags indicate whether the respective functionality should be compiled or not.
      
      C_LEVEL_LE_WARN - Method <pit.warn>
      C_LEVEL_LE_INFO - Method <pit.info>
      C_LEVEL_LE_DEBUG - Method <pit.debug>
      C_LEVEL_LE_ALL - Method <pit.log>      
      C_TRACE_LE_MANDATORY - Methods <pit.enter_mandatory> | <pit.leave_mandatory>
      C_TRACE_LE_OPTIONAL - Methods <pit.enter_optional> | <pit.leave_optional>
      C_TRACE_LE_DETAILED - Methods <pit.enter_detailed> | <pit.leave_detailed>
      C_TRACE_LE_ALL - Methods <pit.enter> | <pit.leave>
      
      C_GLOBAL_CONTEXT - PIT memory in globally accessible context
   */  
  C_LEVEL_LE_WARN constant boolean := true;
  C_LEVEL_LE_INFO constant boolean := true;
  C_LEVEL_LE_DEBUG constant boolean := true;
  C_LEVEL_LE_ALL constant boolean := true;
  
  C_TRACE_LE_OFF constant boolean := true;
  C_TRACE_LE_MANDATORY constant boolean := true;
  C_TRACE_LE_OPTIONAL constant boolean := true;
  C_TRACE_LE_DETAILED constant boolean := true;
  C_TRACE_LE_ALL constant boolean := true;
  
  C_HAS_GLOBAL_CONTEXT constant boolean := &WITH_CONTEXT.;
  
  /** 
    Constants: Export groups
      Target distinguish between areas of similar items to streamline the API
      
      C_TARGET_PMS - Messages
      C_TARGET_PTI - Translatable Items
      C_TARGET_PAR - Parameters
   */  
  C_TARGET_PMS constant pit_util.ora_name_type := 'PMS'; -- Messages
  C_TARGET_PTI constant pit_util.ora_name_type := 'PTI'; -- Translatable Items
  C_TARGET_PAR constant pit_util.ora_name_type := 'PAR'; -- Parameters
        
    
  /**
    Group: Administration methods
   */
  /**
    Procedure: create_message_package
      Procedure to (re-) create package <MSG>.
      
      If called with no parameter, this procedure creates package MSG based on the actual messages
      from table pit_message. It automatically maps all custom or oracle errors and creates respective
      exception variables for them.
      
      If called with a directory name, the package is not created but its DDL is written to 
      the file system for later creation or deployment purposes.
      
    Parameter:
      p_directory - Optional parameter to define a directory object the creation writes to. If NULL, the code is executed immediately.
   */
  procedure create_message_package(
    p_directory varchar2 default null);
    
    
  /**
    Function: get_message_text
      Function to retrieve the text for a given language without replacements.
      Is used to review the text of a given message in a desired language 

    Parameters:
      p_pms_name - Name of the message to retrieve the text for
      p_pms_pml_name - Optional Oracle language reference. If NULL, the default language is used.
   */
  function get_message_text(
    p_pms_name in pit_message.pms_name%type,
    p_pms_pml_name in pit_message_language.pml_name%type default null)
    return varchar2;
    
    
  /**
    Procedure: set_language_settings
      Method to set default language settings.
      
      Is used to initially set the default language settings.
      Precedence is set accoding to the sort order: First languages preceede later languages.
      
    Parameter:
      p_pml_list - List of colon-separated language names
   */
  procedure set_language_settings(
    p_pml_list in pit_util.max_sql_char);
    
  
  /**
    Group: Message maintenance methods
   */
  /**
    Procedure: merge_message_group
      Procedure to maintain message groups. Is used to create or change a message group. 
      Message groups do not have any special meaning other than sorting messages 
      for easier maintenance and export separation.
      
      Optional parameters for error pre/postixes allow for a deviating definition for individual message groups.
      This way, packages from other authors can be used without changing the complete package exceptions names.
      
    Parameters:
      p_pmg_name - Name of the message group
      p_pmg_description - Optional description to describe the message group.
      p_pmg_error_prefix - Optional prefix for derived exception names from message name.
      p_pmg_error_postfix - Optional postfix for derived exception names from message name.
   */
  procedure merge_message_group(
    p_pmg_name in pit_message_group.pmg_name%type,
    p_pmg_description in pit_message_group.pmg_description%type default null,
    p_pmg_error_prefix in pit_message_group.pmg_error_prefix%type default null,
    p_pmg_error_postfix in pit_message_group.pmg_error_postfix%type default null);
    
    
  /**
    Procedure: merge_message_group
      Procedure to matain a message group. Overload with a row record.
    
    Parameter:
      p_row  Record of a message group
   */
  procedure merge_message_group(
    p_row in out nocopy pit_message_group%rowtype);
    
    
  /** 
    Procedure: delete_message_group
      Procedure to delete a message group. Does not delete a message group if messages exists within that group,
      unless specified by setting the <P_FORCE> parameter to true. Will not commit nor re-create the <MSG> package.
   
    Parameters:
      p_pmg_name - Name of the message group
      p_force - Flag to indicate whether deleting this group should delete all messages of this group.
                Defaults to FALSE: If messages exists, an error is thrown
   */
  procedure delete_message_group(
    p_pmg_name in pit_message_group.pmg_name%type,
    p_force in boolean default false);
    
    
  /**
    Procedure: merge_message
      Procedure to maintain messages. Is used to create or change a PIT message. Will not commit nor re-create the MSG package.
      
    Parameters:
      p_pms_name - Name of the respective pit_message. Must be unique for the default language
      p_pms_text - Message text with replacement anchors in the format #n#, where n is an integer that references up to 50 replacement items
      p_pms_pse_id - Reference to a severity as defined in PIT.LEVEL_<level> constants. Ranges from <PIT.LEVEL_FATAL> to <PIT.LEVEL_VERBOSE> or 20..70
      p_pms_pmg_name - Optional reference to a message group
      p_pms_pml_name - Optional reference to the Oracle supported language names, if null, the default language is used (as defined in pms_pml_name)
      p_error_number - Optional reference to an Oracle system error number. Must not be a number of an Oracle predefined error number. If null
                       and the severity of the message is in <pit.LEVEL_FATAL>|<pit.LEVEL_ERROR>, then an error number from the range -20999..-20000 is used.
   */
  procedure merge_message(
    p_pms_name in pit_message.pms_name%type,
    p_pms_text in pit_message.pms_text%type,
    p_pms_pse_id in pit_message.pms_pse_id%type,
    p_pms_description in pit_message.pms_description%type default null,
    p_pms_pmg_name in pit_message_group.pmg_name%type default null,
    p_pms_pml_name in pit_message_language.pml_name%type default null,
    p_error_number in pit_message.pms_custom_error%type default null);
    
  /**
    Procedure: merge_message
      Procedure to merge a message. Overload with a row record.
      
    Parameter:
      p_row  Record  of PIT_MESSAGE%ROWTYPE
   */
  procedure merge_message(
    p_row in out nocopy pit_message%rowtype);    
    
    
  /**
    Procedure: delete_message
      Procedure to delete a single pit_message. Will delete all translations as well. Is called to remove mistyped
      or unnecessary messages in all languages. Will not commit nor re-create the <MSG> package.
      
    Parameters:
      p_pms_name - Name of the message to delete
      p_pms_pml_name - Optional language of the message to delete. If null, all translations are deleted, otherwise only the translated message
   */
  procedure delete_message(
    p_pms_name in pit_message.pms_name%type,
    p_pms_pml_name in pit_message_language.pml_name%type default null);
    
  
  /**
    Procedure: delete_all_messages
      Procedure to delete all messages. Is called if a new set of messages shall be installed and all old and
      unneeded messages must be thrown away beforehand. Will not commit nor re-create the <MSG> package.
      
    Parameter:
      p_pmg_name - Optional message group to limit deletion to message of this group.
   */
  procedure delete_all_messages(
    p_pmg_name in pit_message_group.pmg_name%type default null);
    
    
  /**
    Procedure: translate_message
      Procedure to translate a given message. Use this procedure as a shortcut for an already existing message,
      if the only task is to translate it.
      
    Parameters:
      p_pms_name - Name of the respective pit_message. Must be unique for the default language
      p_pms_text - Message text with replacement anchors in the format #n#, 
                   where n is an integer that references up to 50 replacement items
      p_pms_pml_name - Reference to the Oracle supported language names
      p_pms_description - Optional description to translate the message description
   */
  procedure translate_message(
    p_pms_name in pit_message.pms_name%type,
    p_pms_text in pit_message.pms_text%type,
    p_pms_pml_name in pit_message_language.pml_name%type,
    p_pms_description in pit_message.pms_description%type default null);
    
  
  /**
   Group: Translatable items maintenance methods
   */
  /** 
    Procedure: validate_translatable_item
      Procedure to validate a translatable item
    
    Parameter:
      p_row - Record of a translatable item
   */
  procedure validate_translatable_item(
    p_row in pit_translatable_item%rowtype);
    
  
  /**
    Procedure: merge_translatable_item
      Procedure to create a or change a translatable item. Is used to create or change a translatable item. 
      Any item may have up to three different text items assotiated with it to allow for short, medium and longer versions of a text item.
   
    Parameters:
      p_pti_id - ID of the translatable item
      p_pit_pml_name - Language of the translatable item
      p_pti_pmg_name - Message group of the translatable item
      p_pti_name - Text of the translatable item
      p_pti_display_name - Optional display name of the translatable item
      p_pti_description - Optional description of the translatable item
   */
  procedure merge_translatable_item(
    p_pti_id in pit_translatable_item.pti_id%type,
    p_pti_pml_name in pit_message_language.pml_name%type,
    p_pti_pmg_name in pit_message_group.pmg_name%type,
    p_pti_name in pit_translatable_item.pti_name%type,
    p_pti_display_name pit_translatable_item.pti_display_name%type default null,
    p_pti_description pit_translatable_item.pti_description%type default null);
    
  
  /**
    Procedure: merge_translatable_item
      Procedure to merge a translatable item. Overloaded version with a row record
      
    Parameter:
      p_row - Record of type <PIT_TRANSLATABLE_ITEM>
   */
  procedure merge_translatable_item(
    p_row in out nocopy pit_translatable_item%rowtype);
    
    
  /** 
    Procedure: delete_translatable_item
      Procedure to create a or change a translatable item and all its translations.
      
    Parameter:
      p_pti_id - ID of the translatable item
      p_pti_pmg_name - Message group of the translatable item
   */
  procedure delete_translatable_item(
    p_pti_id in pit_translatable_item.pti_id%type,
    p_pti_pmg_name in pit_message_group.pmg_name%type);
    
    
  
  /**
    Group: Context maintenance methods
   */
  /**
    Procedure: create_context_toggle
      Procedure to create a context toggle. Is called to have PIT toggle it's context settings based on 
      entering a module or a list of modules. A toggle switches the debug settings if the package or 
      procedure mentioned in the toggle is entered.
      
    Parameters:
      p_toggle_name - Name of the context toggle. Maximum of 20 byte. Don't use umlauts or special chars
      p_module_list - Name of the module to toggle the context for. May be a pipe separated list of modules
                      Two formats are allowed: Name of a package/method or qualified name of a method in a package (without owner)
      p_context_name - Name of the context to switch to. Must be an excisting context
      p_comment - Optional comment to explain the usage of the toggle
   
    Example: 
      Valid examples for the object list parameter are:
      
      - MY_PACKAGE|MY_OTHER_PACKAGE.MY_PROC
   */
  procedure create_context_toggle(
    p_toggle_name in varchar2,
    p_module_list in varchar2,
    p_context_name in varchar2,
    p_comment in varchar2 default null);
    
    
  /**
    Procedure: delete_context_toggle
      Procedure to remove a context toggle
    
    Parameter:
      p_toggle_name - Name of the context toggle to remove
   */
  procedure delete_context_toggle(
    p_toggle_name in varchar2); 
    
    
  /**
    Procedure: create_named_context
      Procedure to create a named context to control debug settings.
      
    Parameters:
      p_context_name - Name of the context. Maximum of 20 byte. Don't use umlauts or special chars
      p_log_level - Log level of the named context. Allowed values: LOG_LEVEL(10,20..70)
      p_trace level - Trace level of the named context. Allowed values: TRACE_LEVEL (10,20..40)
      p_trace_timing - Flag to indicate whether timing information must be captured
      p_module_list - List of colon separated output module names to be used for logging
      p_comment - Optional comment to explain the usage of the named context
   */
  procedure create_named_context(
    p_context_name in varchar2,
    p_log_level in number,
    p_trace_level in number,
    p_trace_timing in boolean,
    p_module_list in varchar2,
    p_comment in varchar2 default null);
  
  
  /**
    Procedure: create_named_context
      Procedure to create a named context. Overload for a settings string.
      
    Parameters:
      p_context_name - Name of the context. Maximum of 20 byte. Don't use umlauts or special chars
      p_settings - Settings string in the format LOG_LEVEL(10,20..70)|TRACE_LEVEL (10,20..40)|TRACE_TIMING_FLAG (Y,N)|MODULE_LIST (MODULE_1:MODULE_2)
      p_comment - Optional comment to explain the usage of the named context
      
    Example:
      Valid examples for the settings parameter are: 
      
      - 30|10|N|PIT_TABLE:PIT_MAIL, 
      - 70|40|Y|PIT_CONSOLE
      -If you want to express that no logging should be used, use 10|10|N|
   */
  procedure create_named_context(
    p_context_name in varchar2,
    p_settings in varchar2,
    p_comment in varchar2 default null);
    
  
  /**
    Procedure: delete_named_context
      Procedure to delete a named context
      
    Parameter:
      p_context_name - Name of the context to delete
   */
  procedure delete_named_context(
    p_context_name in varchar2);
    
  
  /**
    Group: Export and translation methods
   */
  /**
    Procedure: create_installation_script
      Method to get items of a group as a script of API calls to <PIT_ADMIN> package.
      
      Call this method to create a script file that can be used to export all items of this particular group as a SQL script file.
      
    Parameters:
      p_pmg_name - Message group to filter output
      p_target - Type of items to translate <C_TARGET_PMS>|<C_TARGET_PTI>|<C_TARGET_PAR>
      p_file_name - Out parameter that provides the file name for the Script file
      p_script - Out parameter that contains the SQL script created
      p_target_language - Optional target language. Useful, if you need to get all messages in a different default language, if present.
   */
  procedure create_installation_script(
    p_pmg_name in pit_message_group.pmg_name%type,
    p_target in varchar2,
    p_file_name out nocopy pit_util.ora_name_type,
    p_script out nocopy clob,
    p_target_language in pit_message_language.pml_name%type default null);
    
  
  /**
    Procedure: get_installation_script
      Method to get items of a group as a script of API calls to <PIT_ADMIN> package.
      
      Call this method to create a script file that can be used to export all items of this particular group directly from SQL.
      
    Parameters:
      p_pmg_name - Message group to filter output
      p_target - Type of items to translate <C_TARGET_PMS>|<C_TARGET_PTI>|<C_TARGET_PAR>
      
    Returns:
      CLOB instance with the installation script
   */
  function get_installation_script(
    p_pmg_name in pit_message_group.pmg_name%type,
    p_target in varchar2)
    return clob;    
    
    
  /**
    Procedure: create_translation_xml
      Method to generate an XML file in format XLIFF to translate items.
      
      Call this procedure to create an XLIFF-File that can be used to translate
      all members of a target type group to a target language.
      
    Parameters:
      p_target_language - Oracle supported language name to tranlsate the items to
      p_pmg_name - Group to filter the items to translate
      p_target - Type of items to translate <C_TARGET_PMS>|<C_TARGET_PTI>
      p_file_name - Out parameter that provides the file name for the XLIFF file
      p_xliff - Out parameter that contains the XLIFF file created
   */
  procedure create_translation_xml(
    p_target_language in pit_message_language.pml_name%type,
    p_pmg_name in pit_message_group.pmg_name%type default null,
    p_target in varchar2,
    p_file_name out nocopy pit_util.ora_name_type,
    p_xliff out nocopy xmltype);
    
  
  /**
    Function: get_translation_xml
      Method to directly create a translation XLIFF file and return it as CLOB.
      
    Parameters:
      p_target_language - Oracle supported language name to tranlsate the items to
      p_pmg_name - Group to filter the items to translate
      p_target - Type of items to translate <C_TARGET_PMS>|<C_TARGET_PTI>
      
    Returns:
      CLOB in format XLIFF to be opened and edited by an XLIFF-Editor
   */
  function get_translation_xml(
    p_target_language in pit_message_language.pml_name%type,
    p_pmg_name in pit_message_group.pmg_name%type default null,
    p_target in varchar2)
    return clob;
    
    
  /**
    Procedure: apply_translation
      Procedure to import translated items into the database.
      
      If provided with a translated XLIFF-Instance, this procedure creates
      the necessary items for the new language based on it target type.
      
    Parameters:
      p_xliff - XLIFF-instance with the translated messages
      p_target - Type of items to translate <C_TARGET_PMS>|<C_TARGET_PTI>
   */
  procedure apply_translation(
    p_xliff in xmltype,
    p_target in varchar2);
  
  
  /**
    Procedure: delete_translation
      Procedure to delete a translation.   
      
      Is called to remove all items in the given language and target type. Will not commit.
      
    Parameters:
      p_pml_name - Oracle language name of the translation to be removed
      p_target - Type of items to translate <C_TARGET_PMS>|<C_TARGET_PTI>
   */
  procedure delete_translation(
    p_pml_name in pit_message_language.pml_name%type,
    p_target in varchar2);
    
    
  /**
    Procedure: register_translation
      Method to register a translated message, if not yet registered. 
      
      Is called when loading a translation. The translation message is set to one of the available langauges.
      
    Parameter:
      p_pml_name - Oracle language name of the translation to register
   */
  procedure register_translation(
    p_pml_name in pit_message_language.pml_name%type);
    
    
end pit_admin;
/