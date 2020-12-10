create or replace type pit_module_meta as object(
  /** Type provides meta information for output modules to be used in a pipelined function */
  module_name &ORA_NAME_TYPE.,
  module_available &FLAG_TYPE.,
  module_active &FLAG_TYPE.,
  module_stack varchar2(2000 byte)
);
/