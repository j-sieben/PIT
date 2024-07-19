set termout off
-- Choose your FLAG_TYPE datatype to adhere to your local conventions
-- When using database version 23c and later, this will be ignored and BOOLEAN will be used instead
define FLAG_TYPE="char(1 byte)";
define C_TRUE="'Y'";
define C_FALSE="'N'";

-- define FLAG_TYPE="number(1, 0)";
-- define C_TRUE=1;
-- define C_FALSE=0;
   
   
-- ADJUST THIS SETTINGS IF YOU WANT ANOTHER ERROR PRE- OR POSTFIX
-- CAVE: Max length per setting is 3 bytes or 1 byte when using pre- and postfix
-- This is because they will be extended by an underscore. Using pre- and postfix will add 2 underscores 
-- and the total length is limited to 4 bytes.
define EXCEPTION_PREFIX=''
define EXCEPTION_POSTFIX='ERR'

-- Don't change these
col err_pre new_val ERR_PRE format a30
col err_post new_val ERR_POST format a30

select ltrim('&EXCEPTION_PREFIX.' || '_', '_') err_pre,
       rtrim('_' || '&EXCEPTION_POSTFIX.', '_') err_post
  from dual;

col flag_type new_val FLAG_TYPE format a30
col c_true new_val C_TRUE format a30
col c_false new_val C_FALSE format a30
col folder_extension new_val FOLDER_EXTENSION format a30
select 'boolean' FLAG_TYPE, 'true' C_TRUE, 'false' C_FALSE, '_23' folder_extension
  from v$version
 where to_number(substr(banner, instr(banner, 'Release') + 8, 2)) >= 23;
 
set termout on
prompt Boolean type: &FLAG_TYPE., &C_TRUE.|&C_FALSE.