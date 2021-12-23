column script new_value SCRIPT
select case when user != '&REMOTE_USER.' 
            then '&1.' 
            else 'tools/null.sql' end script
  from dual;
  
@&script.