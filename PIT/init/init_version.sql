-- Capture arguments before nested SQL*Plus scripts overwrite positional values.
set define on
set verify off
whenever oserror exit failure rollback
whenever sqlerror exit failure rollback
define PIT_VERSION=&1.
define PIT_GIT_COMMIT=&2.

begin
  if '&PIT_VERSION.' is null or '&PIT_GIT_COMMIT.' is null
     or not regexp_like('&PIT_VERSION.', '^(0|[1-9][0-9]*)\.(0|[1-9][0-9]*)\.(0|[1-9][0-9]*)$')
     or not regexp_like('&PIT_GIT_COMMIT.', '^([0-9a-f]{40}|[0-9a-f]{64})$', 'c') then
    raise_application_error(-20000, 'Invalid PIT version or full Git commit hash. Use the installation starter.');
  end if;
end;
/
prompt PIT version: &PIT_VERSION. Git commit: &PIT_GIT_COMMIT.
