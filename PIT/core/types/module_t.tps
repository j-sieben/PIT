create type module_t is object(
    module_name &ORA_NAME_TYPE.,
    is_active &FLAG_TYPE.,
    is_instantiated &FLAG_TYPE.,
    instatiation_error varchar2(4000 byte));
/
