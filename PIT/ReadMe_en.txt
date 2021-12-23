The batch files or shell scripts install PIT in three different forms:

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
   
All scripts interactively request the required parameters. Follow the instructions of the scripts.


- If you plan to use output module PIT_FILE make sure that you have created a 
  directory named PIT_FILE_DIR that points to a path the database has access to:

create or replace directory PIT_FILE_DIR as 'C:\tmp\trace';


Linux remarks:
set ORACLE_SID, PATH and ORACLE_HOME:

for information, see /etc/oratab.

ORACLE_HOME=<Info from Oratab-File>
PATH=$ORACLE_HOME/bin:$PATH
ORACLE_SID=<Info from Oratab-File>
export ORACLE_HOME
export PATH
export ORACLE_SID

Should install.sh don’t run:
chmod +x ./install.sh