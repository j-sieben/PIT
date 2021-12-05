/**
  Type: pit_args
    Array of up to 50 entries of type <ora_name_type>.
    Is used to pass in a variable  list of parameter values
 */
create or replace type pit_args is varray(50) of &ORA_NAME_TYPE.;
/
