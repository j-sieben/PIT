# `PIT` Installation

## Installing `PIT`

 `PIT` installation is split into three installation files to make it easy to adjust `PIT` to your specific needs:

- Core installation file, installs the core `PIT` packages and data structures. The owner of `PIT` can work with `PIT`, no additional installation is required
- Client installation file, grants all necessary rights to a adifferent user to allow for centralized deployment of `PIT` for many schemas
- APEX installation file, installs the APEX application to maintain `PIT`. This is recommended on development machines only, as all generated messages can be deployed by exporting them from the development server on production systems.

As with any software that contains umlauts etc, it's advisable to store the files in UTF-8 encoding. This requires you to take care that this encoding does not get corrupt when editing the script files. But there's another thing to keep in mind: Before starting *SQL\*Plus* to install `PIT`, you need to make sure that your environment is set to UTF-8 as well. This is achieved by setting environment variable  `NLS_LANG` to a value of `AMERICAN_AMERICA.AL32UTF8`. It doesn't matter really which language and territory you choose as long as you make sure that the last parameter is `AL32UTF8`.

## Adjust `PIT` to your wishes

### Choose the default language

It is possible to adjust some settings before installing `PIT`. First, `PIT` is designed to be internationalized from ground up. You adjust your default language by passing it in as the second parameter when installing `PIT`. It is important to understand that any message you create must exists in this default language at least. You may translate it to other languages later, but you won't be able to just have a message in a language other than the default language. So, as a best practice, choose the best language for your needs and make this the default language. `PIT` supports `AMERICAN` adn `GERMAN` as languages out of the box.

### Choose your flag type

As storing boolean values in a data model is no easy thing to do in Oracle, many different best practiceses are used to circumvent the lack of a boolean data type in Oracle tables. I found it cumbersome to work with more than one of these best practices at a time, so I made `PIT` adjustable in this regard. In file `PIT/PIT/init/settings.sql` you will find the following replacement variables:

```
-- ADJUST THIS SETTING IF YOU WANT ANOTHER TYPE 
define FLAG_TYPE="char(1 byte)";
define C_TRUE="'Y'";
define C_FALSE="'N'";
```
Using these replacement variables, you can adjust the boolean type to your local preference, may it be `1|0` or any other setting. Be aware though that this is a one time decision, as this will be burned into the table declarations. Changing these settings is only possible by completely re-installing `PIT`. This is something you have to plan, as many other packages may depend on `PIT` and the flag type you chose.

### Choose the tablespace to install `PIT` data objects into

If you need full control over where `PIT` puts its data objects, it is advisable to create the users for `PIT` upfront and assign tablespace and the respective quotas. The installation relies on a default tablespace to be present and does not explicitly stores data objects in a fixed tablespace. If you leave it up to `PIT` to create the users, the following rules apply:

- The `DEFAULT_TABLESPACE` parameter is set in the `PIT/PIT/init/settings.sql` file. As per default, the default tablespace of the database is chosen, but you can choose to override this setting by defining the `DEFAULT_TABLESPACE` parameter manually.
- If the user to install `PIT` into already exists, it does nothing but uses the default tablespace of that user
- If the user exists but has no tablespace quota on any tablespace, it grants quota unlimited on the tablespace identified by the `DEFAULT_TABLESPACE` parameter.
- If the user does not exist, the install script will generate her and assign quota unlimited on the tablespace identified by the `DEFAULT_TABLESPACE` parameter.

### Choose your exception pre- and/or postfix

A message is identified by a unique name. If the severity of this message is `ERROR` or even `FATAL_ERROR`, `PIT` automatically creates user defined exceptions for it. To distinguish them from the message, `PIT` automatically extends the name by a pre- or postfix. You can freely choose, what pre- or postix to use by setting those in the `settings.sql` file from the previous paragraph:

```
-- ADJUST THIS SETTINGS IF YOU WANT ANOTHER ERROR PRE- OR POSTFIX
-- CAVE: Max length per setting is 3 bytes or 1 byte when using pre- and postfix
-- This is because they will be extended by an underscore. Using pre- and postfix will add 2 underscores 
-- and the total length is limited to 4 bytes.
define EXCEPTION_PREFIX=
define EXCEPTION_POSTFIX=ERR
```

The total length of pre- and postfix is 4 bytes, but you need to add one underscore for the pre- and one for the postfix. So, if you use a pre- and a postfix, only 1 byte is left for those. If you choose a pre- or postfix, there are up to 3 bytes avaiable.

## `PIT` privileges

The script to install `PIT` requires administrative privileges, as it creates users shouldn't they already exist, grants system and object privileges and so forth. If your administrator needs to have an overview about the rights the `PIT` installation grants to the respective users, you will find them in file `set_grants.sql` in the installation folder plus in the modules folder for specific output modules. As an example, you will find a file named `user_grants.sql` in folder `modules/pit_file/scripts` which assigns execute rights on `utl_file` to the owner of `PIT`. Plus, in script `check_user_exists.sql` system privilege `quota unlimited on tablespace users` is granted to the `PIT` owner and `PIT` user. Adjust this if you need different settings here.

Additionally, `PIT` requires a publicy accessible context to store the log related information to. This is a grant that the `PIT` owner does not require, but the installing user must have in order to create it for the `PIT` owner.

There were thoughts on providing a version of the `PIT` installation files that run under the privileges of the `PIT` owner. This is obviously possible only if all necessary database grants are present. One of the challenges then would be to grant access to other users, as this normally includes granting the rights and creating synonyms on the client side. At the moment, this is done by calling a script file `tools/check_has_object_privilege.sql` which is called by the respecitve installation scripts. If you install as the owner of `PIT`, this will be one of the issues to address.

Starting with Oracle version 12c, a new privilege `inherit privileges` must be obeyed. The installation script will grant `inherit any privilege` from `SYS` to the owner of `PIT`. This grant is revoked after installation to assure that no method of `PIT` abuses privileges if these methods are called by `SYS`.

## Install `PIT`

You may run the installation scripts directly from a command line or use the predefined batch scripts provided for Windows and Unix. The batch scripts set the environment accordingly and ask for the respective parameters interactively.

I recommend installing `PIT` in a dedicated utility owner and grant access to other schemas using the `pit_install_client` script. This way you don't multiply your codebase. The downside to this is a certain mixture of message definitions at one database user, as all messages are stored within table `PIT_MESSAGE` within that user. Plus, as you are allowed to map an Oracle server error number to a `exception` variable only once, you have to make sure that all mappings are dealt with in a way that makes them reusable for other schemas.

Messages are delivered in my mother tongue, `GERMAN` and in `AMERICAN`. Messages are located in various folders under `message/<LANGUAGE>/MessageGroup_PIT.sql` and can be translated or changed as you like. You can also use the built in translation service to translate the internal messages. How to do this is described [here](https://github.com/j-sieben/PIT/blob/master/Doc/translating_messages.md).

The installation scripts expects two parameters:

- `PIT_OWNER`: database user who owns `PIT` (ideally a dedicated utility owner)
- `DEFAULT_LANGUAGE`: Oracle language name of the default language for all messages.

So here's an example on how to install `PIT` on a windows system:

```
rem always make sure that the console is set to UTF-8
set nls_lang=AMERICAN_AMERICA.AL32UTF8

rem switch to the directory where you copied the git repository to
cd C:\temp\PIT\PIT

sqlplus system/syspwd@database
SQL> @pit_install PIT_OWNER AMERICAN
```

This example will install `PIT` within user `PIT_OWNER` and set `AMERICAN` as the default language for messages. All parameters are case insensitive.


## Uninstall `PIT`
To uninstall `PIT`, simply call `pit_uninstall.sql` from the installation folder. This script requires a dba account as well, as it removes packages in other schemas. To make life a bit easier for me, you have to pass in the same parameters as you did when installing `PIT`, meaning the `PIT` owner and the default language.

```
rem switch to the directory where you copied the git repository to
cd C:\temp\PIT\PIT

sqlplus <sys_credentials> as sysdba 
SQL> @pit_uninstall PIT_OWNER AMERICAN
```

## Granting access to `PIT` to a client

To grant a different schema access to `PIT`, you call script `pit_install_client.sql`. This scripts expects two parameters:

- `PIT_OWNER`: database user who own `PIT`
- `PIT_USER`: the schema you want to grant access to `PIT` to. 

Here's an example on how to call this script:

```
rem switch to the directory where you copied the git repository to
cd C:\temp\PIT\PIT
sqlplus <sys_credentials> as sysdba 
SQL> @pit_install_client `PIT`_OWNER PIT_USER
```

## Uninstalling `PIT` client
To uninstall a `PIT` client, simply call `pit_uninstall_client.sql` with the `PIT` owner and the `PIT` client user name as parameters:

```
rem switch to the directory where you copied the git repository to
cd C:\temp\PIT\PIT

sqlplus <sys_credentials> as sysdba 
SQL> @pit_uninstall_client PIT_OWNER `PIT`_USER
```

## Installing the supporting APEX application

`PIT` ships with an APEX application that allows you to manage `PIT` messages and global application parameters. For some it is easier to set parameters and create messages graphically than to use PL/SQL API calls. To install the supporting APEX application, it is expected that you have an APEX workspace. The workspace schema is referenced as the `PIT_APP` lateron, as this should be a schema different to the owner of `PIT`. Basically, there is no difference in a `PIT` client user and the APEX schema user, as both are simply using `PIT`. By installing the maintenance application, the client grants and some additional grants required are set.

The APEX application is available with a German UI and an American UI for the APEX version 20.2 only. I'm sorry for that, but translating the APEX application is quite some work and the result may not be satisfying. But as with all APEX applications, translations are possible and you can do this as you like. I recommend to have [DeepL](https://www.deepl.com/translator) at your side to get started.

There has been a changed approach in regard to the APEX application maintaining `PIT`. It used to be a very basic application in earlier releases. To be honest, I didn't use it too much as I normaly work with the installation files directly. But I wanted to improve on the application, partly because I plan to create a second Oracle Jet-based interface for it. I want to use this small application as a proof of concept for a broader architecture problem, namely writing database applications that are UI-independent.

Writing APEX applications covering a wide range of APEX versions (from 5.1 to 20.x) is a challenge for developers. The reason is that APIs change, new functions appear while others disappear. A possible solution would be to use only functions that were already available in version 5.1 and just leave the application as it is. But if you want to use newer functions of APEX, such as new form regions from version 19.1 on, the challenge will be that your API won't work the way it used to. This is especially true if you don't have direct write access to tables but use a `XAPI` based approach instead. This makes all DML-processes built into APEX useless as they require direct write access. The problem for you as a developer: The way to get access to the session state changes, forcing you to recode your controller packages.

Therefore I decided to rely on my utilities named `UTL_TEXT` and `UTL_APEX` to sort out those issues. They will stabilze the API and remove most dependencies to APEX from the the controller logic within the APEX schema. Unfortunately, this will make installation a bit more complex. Before installing the APEX application, you need to install those utilities. I could have included them in the download, but that would have meant copying code between git repositories with all related problems such as newer versions etc. I don't want to do that.

So you need to start downloading [`UTL_TEXT`](https://github.com/j-sieben/UTL_TEXT) and [`UTL_APEX`](https://github.com/j-sieben/UTL_APEX) first. I'm sure you benefit from those libraries even outside the context of `PIT`. `UTL_TEXT` for instance contains a very powerful and flexible code generator you may want to have a look at.

### Installing `UTL_TEXT`

Start by installing `UTL_TEXT` first. Ideally, it lives in the same utility user that owns `PIT`. After installing it, you grant access to the APEX schema user. Here's a sample script on how to achieve that:

```
rem always make sure that the console is set to UTF-8
set nls_lang=AMERICAN_AMERICA.AL32UTF8

rem switch to the directory where you copied the git repository to
cd C:\temp\UTL_TEXT\UTL_TEXT

sqlplus <sys_credentials> as sysdba 
SQL> @utl_text_install PIT_OWNER AMERICAN
SQL> @utl_text_install_client PIT_OWNER PIT_USER
```

### Installation of `UTL_APEX`

`UTL_APEX` is a library to wrap some commonly required APEX related functionality. Main focus is to centralize dependencies from the APEX API at one place. It also stabilizes the ever changing APEX API as good as it can. So for instance there is a method call `utl_apex.UPDATING` returning a boolean flag that analyzes the request, a button action or the value of `APEX$ROW_ACTION` to find out whether APEX wants to update a record.

Plus, another utility called `UTL_DEV_APEX` is installed. This package is useful only on develpment machines, as it is used to generate stubs for the controller level and other utilities to help you test your code.

As this is an APEX library, it lives in the `PIT_APP` schema directly and therefore does not require any client grants:

```
rem always make sure that the console is set to UTF-8
set nls_lang=AMERICAN_AMERICA.AL32UTF8

rem switch to the directory where you copied the git repository to
cd C:\temp\UTL_APEX\UTL_APEX

sqlplus <sys_credentials> as sysdba 
SQL> @utl_apex_install PIT_APP AMERICAN
```

If you want to separate the `PIT_USER` schema from the APEX workspace schema, you can. Simply make sure that the APEX workspace schema (`APEX_APP` in our case) also has access to `PIT` and `UTL_TEXT` by running the client scripts for this user.

That's it, you're now prepared to install the `PIT` application. Obviously, the steps above are required only once for all your APEX applications of that workspace that want to make use of those libraries.

If you want to see how `UTL_APEX`can make your live easier as an APEX developer, have a look a the controller package `pit_ui`. This package interacts with the pages based on their page alias, so for each page there is a matching method that reads the user entered data and controls how to write those to the `XAPI` layer owned by the `PIT` owner. Also note that no code is placed on the APEX pages directly other than calls to this package.

### Install the `PIT` administration application

Script `pit_install_apex.sql` will install the appliation itself. The script will make sure that the schema owner of this APEX workspace is granted all necessary object rights to maintain `PIT`. It expects five parameters:

- `APEX_USER`: database user who has access to  `PIT` and `UTL_TEXT`, owns `UTL_APEX` and is the schema of the APEX-Workspace you install into
- `APEX_WORKSPACE`: Name of the APEX workspace
- `ALIAS`: Alias name of the APEX-application
- `APP_ID`: ID of the APEX-application
- `DEFAULT_LANGUAGE`: Oracle language name of the default language for all messages

Here's an example on how to install the supporting APEX application for user `PIT_APP` in Workspace `DEV_TOOLS`. The application will be available at http://<your_apex_server>/ords/f?p=PIT:

```
rem always make sure that the console is set to UTF-8
set nls_lang=AMERICAN_AMERICA.AL32UTF8

rem switch to the directory where you copied the git repository to
cd C:\temp\PIT\PIT
sqlplus <sys_credentials> as sysdba 
SQL> @pit_install_apex PIT_APP DEV_TOOLS `PIT` 123 AMERICAN
```

Installing the supporting APEX application extends the installation of a `PIT` client for that user if necessary. If you install the APEX application in the same user that owns `PIT`, all grants are in place naturally.

## Uninstalling the supporting APEX application
To uninstall the supporting APEX application, call `pit_uninstall_apex` with a total of  four parameters:

- `PIT_OWNER`: database user who own `PIT`
- `APEX_USER`: database user who owns `PIT_UI` (Schema of the APEX-Workspace you install into)
- `APEX_WORKSPACE`: Name of the APEX workspace
- `ALIAS`: Alias name of the APEX-application.

Here's a sample deinstallation script:

```
cd C:\temp\PIT\PIT
sqlplus <sys_credentials> as sysdba

SQL> @pit_uninstall_apex PIT PIT_APP DEV_TOOLS PIT
```
Deinstalling the supporting APEX application will deinstall the `PIT` client for that user, too. So if you don't want to use the supprting apex application anymore but want to have access to `PIT`, install a `PIT` client after deinstalling the supporting APEX application.
