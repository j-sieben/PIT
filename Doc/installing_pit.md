# PIT Installation

## Installing PIT

PIT installation is split into three installation files to make it easy to adjust PIT to your specific needs:

- Core installation file, installs the core PIT packages and data structures. The owner of PIT can work with PIT, no additional installation is required
- Client installation file, grants all necessary rights to a adifferent user to allow for centralized deployment of PIT for many schemas
- APEX installation file, installs the APEX application to maintain PIT. This is recommended on development machines only, as all generated messages can be deployed by exporting them from the development server on production systems.

As with any software that contains umlauts etc, it's advisable to store the files in UTF-8 encoding. This requires you to take care that this encoding does not get corrupt when editing the script files. But there's another thing to keep in mind: Before starting *SQL*Plus* to install PIT, you need to make sure that your environment is set to UTF-8 as well. This is achieved by setting environment variable  `NLS_LANG` to a value of `AMERICAN_AMERICA.AL32UTF8`. It doesn't matter really which language and territory you choose as long as you make sure that the last parameter is `AL32UTF8`. 

## PIT privileges
The script to install PIT requires administrative privileges, as it creates users shouldn't they already exist, grants system and object privileges and so forth. If your administrator needs to have an overview about the rights the PIT installation grants to the respective users, you will find them in file `set_grants.sql` in the installation folder plus in the modules folder for specific output modules. As an example, you will find a file named `user_grants.sql` in folder `modules/pit_file` which assigns execute rights on `utl_file` to the owner of PIT.

Additionally, in script `check_user_exists.sql` quota unlimited on tablespace `users` is granted to the PIT owner and PIT user. Adjust this if you need different settings here.

Starting with Oracle version 12c, a new privilege `inherit privileges` must be obeyed. The installation script will grant `inherit any privilege` from SYS to the owner of PIT. This grant is revoked after installation to assure that no method of PIT abuses privileges if these methods are called by SYS.

So finally, here's an example on how to install PIT on a windows system:

```
cd C:\temp\PIT
set nls_lang=GERMAN_GERMANY.AL32UTF8
sqlplus <sys_credentials> as sysdba @pit_install PIT_OWNER AMERICAN
```

This example will install PIT within user `PIT_OWNER` and set `AMERICAN` as the default language for messages.

## Granting access to PIT to a client

To grant a different schema access to PIT, you call script `pit_install_client.sql`. This scripts expects to parameters, the owner installed PIT and the schema you want to grant access to PIT to. Here's an example on how to call this script:

```
cd C:\temp\PIT
sqlplus <sys_credentials> as sysdba @pit_install_client PIT_OWNER PIT_USER
```

## Installing the supporting APEX application

To install the supporting APEX application, it is expected that you have an APEX workspace. Script `pit_install_apex.sql` will install an APEX application within that workspace that allows you to manage PIT messages and global application parameters, which PIT uses to store its configuration settings at. The script will make sure that the schema owner of this APEX workspace is granted all necessary object rights to maintain PIT. This script expects four parameters:

  - INSTALL_USER: database schema that owns PIT
  - APP_USER: database user who owns PIT_UI (Schema of the APEX-Workspace you install into)
  - DEFAULT_LANGUAGE: Oracle language name of the default language for all messages.
  - APEX_WORKSPACE: Name of the APEX workspace INSTALL_USER has granted all rights to admin PIT to

Here's an example on how to install the supporting APEX application:

```
cd C:\temp\PIT
sqlplus <sys_credentials> as sysdba @pit_install_apex PIT_OWNER DEV_TOOL_OWNER AMERICAN DEV_TOOLS
```

## Uninstall PIT
To uninstall PIT, simply call `uninstall_pit.sql` from the installation folder. This script requires a dba account as well, as it removes packages in other schemas. Make sure to pass both shemata, owner and user, in to assure that anything gets uninstalled properly. Here's a sample script of how to uninstall PIT on a windows system:

```
cd C:\temp\PIT
set nls_lang=GERMAN_GERMANY.AL32UTF8
sqlplus <sys_credentials> as sysdba @pit_uninstall DOAG DOAG
```

## Client installation (under construction, script will be aviable soon)
The idea behind running PIT in a mandatory aware environment is to maintain a seperate set of parameters and log tables per user. To achieve this, parameters are stored in a central table at PIT owner but may be overwritten by a local parameter table at PIT user. A view combines both tables, giving the local table precedence over the central parameter table. If a parameter is changed on PIT user side, the change is written into the local table. By using this approach, it's easy to reuse parameters which are defined centrally but overwrite any settings locally which require different settings. On the other hand, no local settings influence other PIT clients.

If PIT is installed and a new client shall be added, this is accomplished by running script `pit_install_client.sql`. This script requires dba privileges and two parameters: The owner of PIT and the name of the client that shall use PIT. It installs all necessary components in the client schema to use PIT and assigns just enough privileges for this purpose. Basicall, only `create session`is granted as a system privilege, but a quota on a tablespace must be provided to make output module `PIT_TABLE` work. All other privileges are granted by PIT. 
