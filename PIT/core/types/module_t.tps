create type module_t is object(
  /** 
    Type: module_t
      Object to store meta data for an output module.
      
    Properties;
      module_name - Type name of the module
      is_active - Flag to indicate whether this module is in use actually
      is_instantiated - Flag to indicate whether this module could be instantiated.
      instatiation_error - If the module could not be instantiated, this property shows the error message
   */
  module_name &ORA_NAME_TYPE.,
  is_active &FLAG_TYPE.,
  is_instantiated &FLAG_TYPE.,
  instatiation_error varchar2(4000 byte));
/
