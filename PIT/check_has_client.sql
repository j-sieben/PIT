column script new_value SCRIPT
select case when '&INSTALL_USER.' != '&REMOTE_USER.' 
            then '&1.' 
            else 'null.sql' end script
  from dual;
  
@&script.