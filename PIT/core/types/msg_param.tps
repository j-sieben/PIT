create or replace type msg_param as object(
  /** Type to be used as a key value pair to pass parameter or variable values along with their value */
  p_param &ORA_NAME_TYPE.,
  p_value varchar2(4000 byte),
  constructor function msg_param(
    self in out nocopy msg_param,
    p_param in varchar2,
    p_value in varchar2)
    return self as result
);
/
