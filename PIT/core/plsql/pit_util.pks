create or replace package pit_util
  authid definer
as

  /**** TYPE DECLARATIONS ****/
  $IF dbms_db_version.ver_le_11 $THEN
  c_max_length constant binary_integer := 30;
  subtype ora_name_type is varchar2(30 byte);
  $ELSIF dbms_db_version.ver_le_12_1 $THEN
  c_max_length constant binary_integer := 30;
  subtype ora_name_type is varchar2(30 byte);
  $ELSE
  c_max_length constant binary_integer := dbms_standard.ORA_MAX_NAME_LEN;
  subtype ora_name_type is dbms_standard.dbms_id;
  $END
  -- As extende char length is stored as a length delimited CLOB, 
  -- MAX_SQL_CHAR is still set to 4000 byte. Use CLOB otherwise
  subtype max_sql_char is varchar2(4000 byte);
  subtype max_char is varchar2(32767 byte);
  subtype flag_type is char(1 byte);

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
  /* Helper to create the name for an exception constant in package MSG.
   * Name is formed on the basis of params ERROR_PREFIX and ERROR_POSTFIX
   * %param  p_pms_name Name of the message to create the exception name for
   * %return Exception name
   */
  function get_error_name(
    p_pms_name in pit_message.pms_name%type)
    return varchar2;
    
    
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
  
  
  /* Procedure to recompile invalid objects
   * %usage Called internally when recreating MSG package to recompile packages
   *        with dependencies on MSG
   */
  procedure recompile_invalid_objects;
    
end pit_util;
/