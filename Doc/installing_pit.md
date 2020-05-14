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
sqlplus <sys_credentials> as sysdba 
SQL> @pit_install PIT_OWNER AMERICAN
```

This example will install PIT within user `PIT_OWNER` and set `AMERICAN` as the default language for messages. All parameters are case insensitive.


## Uninstall PIT
To uninstall PIT, simply call `pit_uninstall.sql` from the installation folder. This script requires a dba account as well, as it removes packages in other schemas. To make life a bit easier for me, you have to pass in the same parameters as you did when installing PIT, meaning the PIT-owner and the default language.

```
cd C:\temp\PIT
set nls_lang=GERMAN_GERMANY.AL32UTF8
sqlplus <sys_credentials> as sysdba 
SQL> @pit_uninstall PIT_OWNER AMERICAN
```

## Granting access to PIT to a client

To grant a different schema access to PIT, you call script `pit_install_client.sql`. This scripts expects two parameters:

- `PIT_OWNER`: database user who own PIT
- `PIT_USER`: the schema you want to grant access to PIT to. 

Here's an example on how to call this script:

```
cd C:\temp\PIT
sqlplus <sys_credentials> as sysdba 
SQL> @pit_install_client PIT_OWNER PIT_USER
```

## Uninstalling PIT client
To uninstall a PIT client, simply call `pit_uninstall_client.sql` with the PIT owner and the PIT client user name as parameters:

```
cd C:\temp\PIT
set nls_lang=GERMAN_GERMANY.AL32UTF8
sqlplus <sys_credentials> as sysdba 
SQL> @pit_uninstall_client PIT_OWNER PIT_USER
```

## Installing the supporting APEX application

PIT ships with an APEX application allows you to manage PIT messages and global application parameters, which PIT uses to store its configuration settings at. For some it is easier to set parameters and create messages graphically as opposite to PL/SQL API calls. To install the supporting APEX application, it is expected that you have an APEX workspace. The workspace schema is referenced as the `PIT_USER` lateron, as this should be a schema different to the owner of `PIT`. Basically, there is no difference in a PIT client user and the APEX schema user, as both are simply using `PIT`. By installing the maintenance application, some additional grants are required, though. The script takes care for that.

There has been a changed approach in regard to the APEX application maintaining PIT. Writing APEX applications which span a wide range of APEX versions (from 5.1 to 20.x) poses a challenge on the developer. Reason ist that APIs are changing, new features pop up while others disappear. One possible solution would be to only utilize functionality that was available back in version 5.1 and simply leave the application as is. If you want to take advantage of newer features of APEX though, such as the new form regions starting with version 19.1, challenges are that your API will not work as it worked before. This is especially true if you're bound to a `XAPI` approach. In such an environment, no direct write access to the tables is granted, rendering all built in DML processes of APEX useless.

Therefore I decided to rely on my utilities named `UTL_TEXT` and `UTL_APEX` to sort out those issues. They will stabilze the API and remove most dependencies to APEX from the the controller logic within the APEX schema. Unfortunately, this will make installation a bit more complex. Before installing the APEX application, you need to install those utilities. I could have included them in the download, but that would have meant copying code between git repositories with all related problems such as newer versions etc. I don't want to do that.

So you need to start downloading [https://github.com/j.sieben/UTL_TEXT](`UTL_TEXT`) and [https://github.com/j.sieben/UTL_APEX](`UTL_APEX`) first. I'm sure you benefit from those libraries even outside the context of `PIT`. `UTL_TEXT` for instance contains a very powerful and flexible code generator you may want to look at.

### Installing `UTL_TEXT`

Start by installing `UTL_TEXT` first. Ideally, it lives in the same utility user that owns `PIT`. After installing it, you grant access to the APEX schema user. Here's a sample script on how to achieve that:

```
cd C:\temp\UTL_TEXT\UTL_TEXT
sqlplus <sys_credentials> as sysdba 
SQL> @utl_text_install PIT_OWNER AMERICAN
SQL> @utl_text_install_client PIT_OWNER PIT_USER
```

### Installation of `UTL_APEX`

`UTL_APEX` is a library to wrap some commonly required APEX related functionality. Main focus is to cnetralize dependencies from the APEX API at one place. It also stabilizes the ever changing APEX API as good as it can. So for instance there is a method call `utl_apex.UPDATING` returning a boolean flag that analyzes the request, a button action or the value of `APEX$ROW_ACTION` to find out whether APEX wants to update a record. 

As this is an APEX library, it lives in the `PIT_USER` schema directly and does therefore not require any client grants:

```
cd C:\temp\UTL_APEX\UTL_APEX
sqlplus <sys_credentials> as sysdba 
SQL> @utl_apex_install PIT_USER AMERICAN
```

That's it, you're now prepared to install the PIT application. Obviously, the steps above are required only once for all your APEX applications of that workspace that want to make use of those libraries.

### Install the PIT maintenace application

Script `pit_install_apex.sql` will install the appliation itself. The script will make sure that the schema owner of this APEX workspace is granted all necessary object rights to maintain PIT. It expects five parameters:

- `APEX_USER`: database user who owns PIT_UI (Schema of the APEX-Workspace you install into)
- `APEX_WORKSPACE`: Name of the APEX workspace
- `ALIAS`: Alias name of the APEX-application.
- `APP_ID`: ID of the APEX-application.
- `DEFAULT_LANGUAGE`: Oracle language name of the default language for all messages.

Here's an example on how to install the supporting APEX application:

```
cd C:\temp\PIT\PIT
sqlplus <sys_credentials> as sysdba 
SQL> @pit_install_apex PIT_USER DEV_TOOLS PIT 123 AMERICAN
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
sqlplus <sys_credentials> as sysdba 
SQL> @pit_uninstall_apex PIT_OWNER PIT_USER DEV_TOOLS PIT
```
Deinstalling the supporting APEX application will deinstall the PIT client for that user, too. So if you don't want to use the supprting apex application anymore but want to have access to PIT, install a PIT client after deinstalling the supporting APEX application.
