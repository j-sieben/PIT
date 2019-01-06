create or replace package utl_context
  authid definer
as
  /** Generic maintenance of globally accessed contexts<br>
   *  If a globally accessed context is created in such a way that this package
   *  has write privileges on it, access to the context is achieved by calling
   *  the methods within this helper package.
   */
  
  c_no_value varchar2(10) := 'NOVALUE';

  /* Context Type Constants: Context values are visible ...
   * global: ... for any user and any session
   * force_user: ... only if user matches
   * force_client_id: ... only if client_identifier matches
   * force_user_client_id: ... only if user AND client_identifier matches
   * prefer_client_id: ... if a matching value for that client_identifier exists,
   *                       it is visible, otherwise a default value is provided
   * prefer_user_client_id: ... if a matching value for that user AND client_identifier exists,
   *                            it is visible, otherwise a default value is provided
   * session: ... only within the session that set the value (pseduo local context)
   */
  c_global constant varchar2(20 byte) := 'GLOBAL';
  c_force_user constant varchar2(20 byte) := 'FORCE_USER';
  c_force_client_id constant varchar2(20 byte) := 'FORCE_CLIENT_ID';
  c_force_user_client_id constant varchar2(20 byte) := 'FORCE_USER_CLIENT_ID';
  c_prefer_client_id constant varchar2(20 byte) := 'PREFER_CLIENT_ID';
  c_prefer_user_client_id constant varchar2(25 byte) := 'PREFER_USER_CLIENT_ID';
  c_session constant varchar2(20 byte) := 'SESSION';
  
  
  /* Procedure to set a value in one of the available contexts
   * @param p_context Name of the context to write a value to
   * @param p_attribute Name of the parameter for which a value shall be stored
   * @param p_value Varchar-value of the parameter
   * @param p_client_id optional client id as set at sys_context('USERENV', 'CLIENT_IDENTIFIER')
   * @usage This procedure set a parameter value for a given parameter in the 
   *        context requested. When using the p_client_id attribute, a parameter
   *        may be set for a given session only and be invisible to other sessions
   */
  procedure set_value(
    p_context in varchar2,
    p_attribute in varchar2,
    p_value in varchar2,
    p_client_id varchar2 default null);


  /* Procedure to read a value from one of the available contexts
   * @param p_context Name of the context to write a value to
   * @param p_attribute Name of the parameter for which a value shall be stored
   * @param p_client_id optional client id as set at sys_context('USERENV', 'CLIENT_IDENTIFIER')
   * @return Varchar-value of the parameter
   * @usage This procedure gets a parameter value for a given parameter from the 
   *        context requested. When using the p_client_id attribute, a parameter
   *        may be read that is private for a given session
   */
  function get_value(
    p_context in varchar2,
    p_attribute in varchar2,
    p_client_id varchar2 default null)
    return varchar2;


  /* Procedure to clear a value in one of the available contexts
   * @param p_context Name of the context to write a value to
   * @param p_attribute Name of the parameter for which a value shall be stored
   * @param p_client_id optional client id as set at sys_context('USERENV', 'CLIENT_IDENTIFIER')
   * @usage This procedure clears a parameter value for a given parameter in the 
   *        context requested. When using the p_client_id attribute, a parameter
   *        may be cleared that is private for a given session
   */
  procedure clear_value(
    p_context in varchar2,
    p_attribute in varchar2,
    p_client_id varchar2 default null);
    
  
  /* Function to get a value based on a collection of context attributes
   * %param p_context Name of the context to write a value to
   * @param p_attribute_list List of attributes for which a value shall be retrieved
   * @param p_client_id Optional client id as set at sys_context('USERENV', 'CLIENT_IDENTIFIER')
   * @return Varchar-value of the parameter
   * @usage Tries to find a value for each entered attribute name and returns the
   *        first NOT-NULL-value
   */
  function get_first_match(
    p_context in varchar2,
    p_attribute_list in args,
    p_with_name in boolean default false,
    p_client_id varchar2 default null)
    return varchar2;


  /* Procedure to reset one of the available contexts
   * @param p_context Name of the context to write a value to
   * @usage This procedure resets a context completely, removing any value in it.
   *        If private parameters for sessions exists, they will be cleared as well.
   */
  procedure reset_context(
    p_context in varchar2);
end utl_context;
/