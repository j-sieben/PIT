# PIT Installation

## Installing PIT

PIT installation is split into three installation files to make it easy to adjust PIT to your specific needs:

- Core installation file, installs the core PIT packages and data structures. The owner of PIT can work with PIT, no additional installation is required
- Client installation file, grants all necessary rights to a adifferent user to allow for centralized deployment of PIT for many schemas
- APEX installation file, installs the APEX application to maintain PIT. This is recommended on development machines only, as all generated messages can be deployed by exporting them from the development server on production systems.

As with any software that contains umlauts etc, it's advisable to store the files in UTF-8 encoding. This requires you to take care that this encoding does not get corrupt when editing the script files. But there's another thing to keep in mind: Before starting *SQL*Plus* to install PIT, you need to make sure that your environment is set to UTF-8 as well. This is achieved by setting environment variable  `NLS_LANG` to a value of `AMERICAN_AMERICA.AL32UTF8`. It doesn't matter really which language and territory you choose as long as you make sure that the last parameter is `AL32UTF8`. 

## PIT privileges
The script to install PIT requires administrative privileges, as it creates users shouldn't they already exist, grants system and object privileges and so forth. If your administrator needs to have an overview about the rights the PIT installation grants to the respective users, you will find them in file `set_grants.sql` in the installation folder plus in the modules folder for specific output modules. As an example, you will find a file named `user_grants.sql` in folder `modules/pit_file/scripts` which assigns execute rights on `utl_file` to the owner of PIT.

Additionally, in script `check_user_exists.sql` system privilege `quota unlimited on tablespace users` is granted to the PIT owner and PIT user. Adjust this if you need different settings here.

Starting with Oracle version 12c, a new privilege `inherit privileges` must be obeyed. The installation script will grant `inherit any privilege` from SYS to the owner of PIT. This grant is revoked after installation to assure that no method of PIT abuses privileges if these methods are called by SYS.

## Install PIT

You may run the installation scripts directly from a command line or use the predefined batch scripts provided for Windows and Unix. The batch scripts set the environment accordingly and ask for the respective parameters interactively.

I recommend installing PIT in a dedicated Utility owner and grant access to other schemas using the `pit_install_client` script. This way you don't multiply your codebase. The downside to this is a certain mixture of message definitions at one database user, as all messages are stored within table `PIT_MESSAGE` within that user. Plus, as you are allowed to map an Oracle server error number to a `exception`variable only once, you have to make sure that all mappings are dealt with in a way that makes them reusable for other schemas.

Messages are delivered in my mother tongue, `GERMAN` and in `AMERICAN`. Messages are located in various folders under `message/<LANGUAGE>/create_messages.sql` and can be translated or changed as you like.

The installation scripts expects two parameters:

- `PIT_OWNER`: database user who owns PIT_UI (Schema of the APEX-Workspace you install into)
- `DEFAULT_LANGUAGE`: Oracle language name of the default language for all messages.

So here's an example on how to install PIT on a windows system:

```
cd C:\temp\PIT
set nls_lang=AMERICAN_AMERICA.AL32UTF8
sqlplus <sys_credentials> as sysdba @pit_install PIT_OWNER AMERICAN
```

This example will install PIT within user `PIT_OWNER` and set `AMERICAN` as the default language for messages. All parameters are case insensitive.


## Uninstall PIT
To uninstall PIT, simply call `pit_uninstall.sql` from the installation folder. This script requires a dba account as well, as it removes packages in other schemas. To make life a bit easier for me, you have to pass in the same parameters as you did when installing PIT, meaning the PIT-owner and the default language.

```
cd C:\temp\PIT
set nls_lang=GERMAN_GERMANY.AL32UTF8
sqlplus <sys_credentials> as sysdba @pit_uninstall PIT_OWNER AMERICAN
```

## Granting access to PIT to a client

To grant a different schema access to PIT, you call script `pit_install_client.sql`. This scripts expects two parameters:

- `PIT_OWNER`: database user who own PIT
- `PIT_USER`: the schema you want to grant access to PIT to. 

Here's an example on how to call this script:

```
cd C:\temp\PIT
sqlplus <sys_credentials> as sysdba @pit_install_client PIT_OWNER PIT_USER
```

## Uninstalling PIT client
To uninstall a PIT client, simply call `pit_uninstall_client.sql` with the PIT owner and the PIT client user name as parameters:

```
cd C:\temp\PIT
set nls_lang=GERMAN_GERMANY.AL32UTF8
sqlplus <sys_credentials> as sysdba @pit_uninstall_client PIT_OWNER PIT_USER
```

## Installing the supporting APEX application

To install the supporting APEX application, it is expected that you have an APEX workspace. Script `pit_install_apex.sql` will install an APEX application within that workspace that allows you to manage PIT messages and global application parameters, which PIT uses to store its configuration settings at. The script will make sure that the schema owner of this APEX workspace is granted all necessary object rights to maintain PIT. This script expects five parameters:

- `APEX_USER`: database user who owns PIT_UI (Schema of the APEX-Workspace you install into)
- `APEX_WORKSPACE`: Name of the APEX workspace
- `ALIAS`: Alias name of the APEX-application.
- `APP_ID`: ID of the APEX-application.
- `DEFAULT_LANGUAGE`: Oracle language name of the default language for all messages.

Here's an example on how to install the supporting APEX application:

```
cd C:\temp\PIT
sqlplus <sys_credentials> as sysdba @pit_install_apex PIT_USER DEV_TOOLS PIT 123 AMERICAN
```

Installing the supporting APEX application encloses the installation of a PIT client for that user. Should the `APEX_USER` match the owner name of PIT, no client installation takes place, as the APEX application is allowed to access all necessary database objects anyway.

## Uninstalling the supporting APEX application
To uninstall the supporting APEX application, call `pit_uninstall_apex` with a total of  four parameters:

- `PIT_OWNER`: database user who own PIT
- `APEX_USER`: database user who owns PIT_UI (Schema of the APEX-Workspace you install into)
- `APEX_WORKSPACE`: Name of the APEX workspace
- `ALIAS`: Alias name of the APEX-application.

Here's a sample deinstallation script:

```
cd C:\temp\PIT
sqlplus <sys_credentials> as sysdba @pit_uninstall_apex PIT_OWNER PIT_USER DEV_TOOLS PIT
```
Deinstalling the supporting APEX application will deinstall the PIT client for that user, too. So if you don't want to use the supprting apex application anymore but want to have access to PIT, install a PIT client after deinstalling the supporting APEX application.