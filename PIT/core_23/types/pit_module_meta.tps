create or replace type pit_module_meta force as object(
  /** 
    Type: pit_module_meta
      Provides meta information for output modules to be used in a pipelined function.
      
    Properties:
      module_name - Type name of the output module
      module_available - Flag to indicate whether the module is available
      module_active - Flag to indicate whether the module is currently active
      module_stack - If the module is not available, this property contains information about the reason for this.
   */
  module_name &ORA_NAME_TYPE.,
  module_available boolean,
  module_active boolean,
  module_stack varchar2(2000 byte)
);
/