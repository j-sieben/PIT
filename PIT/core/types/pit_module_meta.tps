create or replace type pit_module_meta as object(
  module_name &ORA_NAME_TYPE.,
  module_available &FLAG_TYPE.,
  module_active &FLAG_TYPE.
);
/