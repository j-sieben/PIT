create or replace type msg_param as object(
  /** Type to be used as a key value pair to pass parameter or variable values along with their value */
  p_param &ORA_NAME_TYPE.,
  p_value varchar2(4000 byte));
/
