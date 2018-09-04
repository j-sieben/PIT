create or replace type pit_module_meta as object(
  module_name varchar2(30 byte),
  module_available char(1 byte),
  module_active char(1 byte)
);
/