create or replace package pit_util
as

  /* Getter for SYS.STANDARD.USER to avoid environment changes to SQL
   */
  function get_user
    return varchar2;
    
    
  /**** TEXT HELPER ****/
  /* Helper to convert a string with a given separator into an instance of type ARGS
   * %param p_string_value List of items to be split
   * %param p_delimiter character that separates the items in <code>p_string_value</code>
   * %return Array of items (up to 50) of <code>varchar2(50)</code>
   * %usage internal helper to split a string into an array of chars.
   */
  function string_to_table(
    p_string_value in varchar2,
    p_delimiter in varchar2 := ':')
    return args;
  
  
  /* Helper to bulk-replace chunks in a text
   * %param p_string Text with replacement anchors
   * %param p_chunks List of chars for replacement
   * %return p_string with replacements
   * %usage Is called to replace more replacement anchors at once
   */
  function bulk_replace(
    p_string in varchar2,
    p_chunks in char_table)
    return varchar2;

    
  /* Helper to append CLOB.
   * %param p_clob CLOB instance to append P_CHUNK to
   * %param P_CHUNK CLOB instance to append to P_CLOB
   * %usage Wrapper for DBMS_LOB.APPEND that takes care to instantiate P_CLOB if
   *        it's not yet there and append only if P_CHUNK is not null
   */
  procedure clob_append(
    p_clob in out nocopy clob,
    p_chunk in clob);
    
    
  /* Helper to concatenate text
   * %param p_text_list CHAR_TABLE instance with the text chunks to concatenate
   * %param p_delimiter Delimiter to separate the chunks
   * %param p_keep_null Flag to indicate whether NULL values are kept (ie as delimiter
   *        is inserted (default) or not
   */
  function concatenate(
    p_chunk_list char_table,
    p_delimiter varchar2,
    p_keep_null boolean default true)
    return varchar2;
    
  
  /* Helper function to harmonize a given name
   * %param p_name Name to harmonize
   * %param p_prefix Prefix that should exist once before the name
   * %return harmonized name
   * %usage P_NAME will be uppercased and P_PREFIX prefixes P_NAME
   */
  function harmonize_name(
    p_prefix in varchar2,
    p_name in varchar2)
    return varchar2;
    
  
  /**** VALIDATION HELPER ****/
  /* Helper to check whether a predefined Oracle error shall be redefined
   * %param p_error_number Error number for which a PIT message shall be created
   * %usage Is called whenever a new message is inserted into table MESSAGE with an Oracle
   *        error number. The function checks whether the Oracle error number is already
   *        a defined error, such as -1 and DUP_VAL_ON_INDEX.
   *        If so, the procedure throws an error.
   *        Limitation: This procedure can only see Exceptions that are defined in 
   *        packages from SYSTEM or SYS and only exceptions from non wrapped sources.
   */
  procedure check_error(
    p_message_name in message.message_name%type,
    p_error_number in message.custom_error_number%type);
    
    
  /* Helper to validate named context settings
   * %param p_context_name Name of the context to check
   * %param p_settings Settings for the named context
   * %usage Is called to verify that entered settings are correct.
   */
  procedure check_context_settings(
    p_context_name in varchar2,
    p_settings in varchar2);
    
    
  /* Helper to validate toggle settings
   * %param p_toggle_name Name of the toggle to check
   * %param p_module_list List of code blocks which toggle context settings
   * %param p_context_name Name of the named context to toggle to
   * %usage Is called from PIT_ADMIN.CREATE_CONTEXT_TOGGLE to validate settings
   */
  procedure check_toggle_settings(
    p_toggle_name in varchar2,
    p_module_list in varchar2,
    p_context_name in varchar2);
    
end pit_util;
/