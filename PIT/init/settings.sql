
-- Choose your FLAG_TYPE datatype to adhere to your local conventions
define FLAG_TYPE="char(1 byte)";
define C_TRUE="'Y'";
define C_FALSE="'N'";

--define FLAG_TYPE="number(1, 0)";
--define C_TRUE=1;
--define C_FALSE=0;
   
col ora_name_type new_val ORA_NAME_TYPE format a128
col ora_max_length new_val ORA_MAX_LENGTH format a128

select 'varchar2(' || data_length || ' byte)' ora_name_type, data_length ora_max_length
  from all_tab_columns
 where table_name = 'USER_TABLES'
   and column_name = 'TABLE_NAME';
   
-- Comment the following query out if you want to assign a specific tablespace for new users
col default_tablespace new_val DEFAULT_TABLESPACE format a128
select property_value default_tablespace
  from database_properties 
 where property_name = 'DEFAULT_PERMANENT_TABLESPACE';
 
-- If you don't want the default permanent tablespace to be the tablespace for new users,
-- provide a name for this parameter here:
-- define DEFAULT_TABLESPACE=#TABLESPACE#
   
-- ADJUST THIS SETTINGS IF YOU WANT ANOTHER ERROR PRE- OR POSTFIX
-- CAVE: Max length per setting is 3 bytes or 1 byte when using pre- and postfix
-- This is because they will be extended by an underscore. Using pre- and postfix will add 2 underscores 
-- and the total length is limited to 4 bytes.
define EXCEPTION_PREFIX=''
define EXCEPTION_POSTFIX='ERR'
   
define INSTALL_ON_DEV = false
