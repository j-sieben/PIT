whenever sqlerror continue
create or replace type msg_args_char force is 
  /** 
    Type: msg_args_char
      CHAR based version of <MSG_ARGS>. Required if params are to be saved in a table.
   */
  varray(20) of varchar2(4000 byte)
/
whenever sqlerror exit