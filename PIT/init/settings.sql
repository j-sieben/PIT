set termout off
-- Choose your FLAG_TYPE datatype to adhere to your local conventions
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
set termout on