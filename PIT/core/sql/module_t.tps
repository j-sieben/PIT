create type module_t is object(
    module_name varchar2(30),
    is_active number,
    is_instantiated number,
    instatiation_error varchar2(4000));
/
