create or replace type msg_args_char is 
  /** CHAR based version of MSG_ARGS. Required if params are to be saved in a table */
  varray(20) of varchar2(4000 byte)
/