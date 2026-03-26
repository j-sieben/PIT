The central entry point for installation and uninstallation is `pit.sh` or `pit.bat`.
These scripts call the underlying installation and uninstallation scripts by using
an explicit command.

Available commands are:

- install: Install PIT core functionality
- install-client: Set up a client schema
- install-apex: Install the APEX administration application
- install-module: Install a single output module in the PIT owner schema
- install-module-client: Grant a single output module to a client schema
- uninstall: Uninstall PIT core functionality
- uninstall-client: Remove a client schema
- uninstall-module: Uninstall a single output module from the PIT owner schema
- uninstall-module-client: Remove a single output module from a client schema

Examples:

- ./pit.sh install
- ./pit.sh install --owner PIT --service XEPDB1 --default-language AMERICAN
- PIT_OWNER=PIT PIT_OWNER_PW=secret PIT_SERVICE=XEPDB1 ./pit.sh install
- PIT_OWNER=PIT PIT_OWNER_PW=secret PIT_CLIENT=APP PIT_CLIENT_PW=secret PIT_SERVICE=XEPDB1 ./pit.sh install-client
- ./pit.sh install-apex --owner PIT --client APEX_USER --service XEPDB1 --apex-workspace PIT_ADMIN --apex-app-id 100
- ./pit.sh install-module --owner PIT --service XEPDB1 --default-language AMERICAN --module pit_mail
- ./pit.sh install-module-client --owner PIT --client APP --service XEPDB1 --module pit_mail
- ./pit.sh uninstall
- pit.bat install

The underlying batch files or shell scripts are now located in `install_scripts/` and
still support the following installation variants:

1. INSTALL.BAT/SH: Core functionality.
   This must be installed first. It is recommended to use a dedicated user for this,
   e.g. UTILS, and to grant a client access to the schemas that want to use PIT afterwards.
   Alternatively, this client can also be omitted if only one schema is to be equipped with PIT.
   In this case, PIT is ready for use after installation, but has no administrative interface. 
   This is sufficient for test or production environments. 

2. INSTALL_CLIENT.BAT/SH: Client access
   This script sets up access to a PIT installation in a different schema.
   All necessary permissions are granted and appropriate synonyms are created in the client schema.
   This script does not include an administrative interface. If PIT is used in a multi-tier
   schema concept, the installation of a client is sufficient for all schemas except for the
   APEX schema. Only in the APEX schema should the administration application be installed.
   
3. INSTALL_APEX.BAT/SH: Administration application
   This script sets up the administration interface for PIT. The installation
   includes the setup of all necessary permissions and the creation of local synonyms. 
   Therefore, it is not necessary to set up client permissions for the APEX schema in advance.
   The administration application requires two other tools:
   - UTL_TEXT: This tool provides text functions, e.g. a code generator.
   - UTL_APEX: This tool provides APEX related functions.
   These tools have to be installed before the installation of the administration application
   can be executed successfully.

4. INSTALL_MODULE.BAT/SH and INSTALL_MODULE_CLIENT.BAT/SH: Post-installation of output modules
   These scripts add a single output module to an existing PIT installation.
   INSTALL_MODULE.BAT/SH installs the module in the PIT owner schema.
   INSTALL_MODULE_CLIENT.BAT/SH then grants only the privileges required for this module
   to a client schema and creates the related synonyms.
   This installation path is useful if a module was not installed during the initial PIT
   installation and should be added later on.
   
All shell scripts support the same input resolution order:

1. CLI options
2. Environment variables
3. Interactive prompts

Relevant environment variables are:

- PIT_OWNER
- PIT_OWNER_PW
- PIT_CLIENT
- PIT_CLIENT_PW
- PIT_SERVICE
- PIT_DEFAULT_LANGUAGE
- PIT_MODULE
- PIT_APEX_WORKSPACE
- PIT_APEX_APP_ID
- PIT_LOG_DIR

Passwords are intentionally not supported as CLI options. For non-interactive runs,
provide them through environment variables.


- If you plan to use output module PIT_FILE make sure that you have created a 
  directory named PIT_FILE_DIR that points to a path the database has access to:

create or replace directory PIT_FILE_DIR as 'C:\tmp\trace';

Before installation, it is possible to define how Boolean values are stored in the database.
Environment variables can be created for this in the init/settings.sql file. Starting from version 23c this
definition is replaced by the data type BOOLEAN. Please make sure that at a possible recompilation
the initialization parameter PLSQL_IMPLICIT_CONVERSION_BOOL has been set to TRUE, so that the conversion of these
types into PL/SQL using TO_CHAR works.

Linux remarks:
set ORACLE_SID, PATH and ORACLE_HOME:

for information, see /etc/oratab.

ORACLE_HOME=<Info from Oratab-File>
PATH=$ORACLE_HOME/bin:$PATH
ORACLE_SID=<Info from Oratab-File>
export ORACLE_HOME
export PATH
export ORACLE_SID

Direct execution of the specialized scripts is still possible, for example:

- ./install_scripts/install_client.sh
- ./install_scripts/install_module_client.sh

If a shell script is not executable:
chmod +x ./pit.sh
