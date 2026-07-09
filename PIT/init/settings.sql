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

-- Choose the view implementation.
-- I18N resolves translations through PIT_PMG_LANGUAGE_V.
-- MONOLINGUAL filters PIT_MESSAGE_V and PIT_TRANSLATABLE_ITEM_V directly on DEFAULT_LANGUAGE.
col pit_pmg_language_view new_val PIT_PMG_LANGUAGE_VIEW format a128
col pit_message_view new_val PIT_MESSAGE_VIEW format a128
col pit_translatable_item_view new_val PIT_TRANSLATABLE_ITEM_VIEW format a128

with mode as (
       select upper('&1.') install_mode
         from dual)
select case install_mode
         when 'MONOLINGUAL' then 'pit_pmg_default_language_v'
         else 'pit_pmg_language_v'
       end pit_pmg_language_view,
       case install_mode
         when 'MONOLINGUAL' then 'pit_message_default_language_v'
         else 'pit_message_v'
       end pit_message_view,
       case install_mode
         when 'MONOLINGUAL' then 'pit_translatable_item_default_language_v'
         else 'pit_translatable_item_v'
       end pit_translatable_item_view
  from mode;

begin
  if upper('&1.') not in ('I18N', 'MONOLINGUAL') then
    raise_application_error(-20000, 'Installation mode &1. is not supported, please use I18N or MONOLINGUAL');
  end if;
end;
/

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
prompt &s1.Boolean type: &FLAG_TYPE., &C_TRUE.|&C_FALSE.
