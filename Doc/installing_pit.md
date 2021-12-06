# `PIT` Installation


## Changes in this release
Up to this version, `PIT` was intended to be installed by a user with a DBA role. This made it easy to grant missing system or object privileges and to centrally grant object privileges on `PIT` objects to other schemas and create synonyms for the granted objects on the remote side in one go.

As a matter of fact, a DBA role install is not always possible, fi in cloud hosted databases or in an company setting that does not allow for these forms of installation. Therefore I decided to recreate the installation process to make it possible to install `PIT` without a DBA role. As a direct consequence, you don't pass the name of the owner into the installation script anymore, as you are connected as that user anyway.

There are some drawbacks to this approach though:

- `PIT` stores the actual log settings in a globally accessible context. Often, the right to create such a context is not granted.
- In order to grant access to `PIT` for a client user, it is now necessary to run two scripts for each of the respective schemas.

In regard to the context, `PIT` was changed to support either a context or to store the log information internally. The reason for the context was that in a connection pool environment it is mandatory to be able to pass log settings between sessions. This can be achieved by a globally accessed context. There is an alternative which stores this information in a central table, but [evidence] (http://www.oracle-developer.net/display.php?id=424) has shown that this approach incurs a performance impact. Therefore, I didn't want to move into this direction.

In the vicinity of APEX though, logging is controlled by setting the log level at URL level, so APEX itself carries this information to any session working for the actual user. It is therefore possible in this environment to achieve the same goal without using a context.

This lead me to the idea of making the context optional. If it is there, it will be used, if not, a fallback to a local solution is used. At the time being, this means that without a context and outside of APEX, it may fall short when you try to log in a session pool environment and your session adapter is unable to detect whether it should log or not.

Based on this, two installation scenarios are possible:

1. A DBA grants you permission to create a globally accessed context. Plus, a `READ` grant on `DBA_CONTEXT` is necessary.
2. A DBA creates a globally accessed context namen `PIT_CTX_<schema name>` for you, maintained by package `UTL_CONTEXT`. Even in this setup, a `READ` grant on `DBA_CONTEXT` is necessary.

If neither the grant nor the context is present, `PIT` falls back to a local solution. This is achieved with conditional compilation. Plus, it won't install the `UTL_CONTEXT` package and therefore does not support working with global contexts at all. If you change the setup later, it is required to reinstall `PIT` as well.

## Installing `PIT`

 `PIT` installation is split into three processes to make it easy to adjust `PIT` to your specific needs:

- Core installation, installs the core `PIT` packages and data structures. The owner of `PIT` can work with `PIT`, no additional installation is required
- Client installation, grants all necessary rights to a adifferent user to allow for centralized deployment of `PIT` for many schemas.
- APEX maintenance application installation, installs the APEX application to maintain `PIT`. This is recommended on development machines only, as all generated messages can be deployed by exporting them from the development server on production systems.

Each installation step is possible by means of a script file (`.bat` or `.sh`) that asks for any parameters it requires and a set of direct installation files ready for your own batching. As this release does not rely on DBA roles for the installation user anymore, there are more single steps to execute because I had to split client grants and respective synonym creation into two scripts, executed as different database users.

As with any software that contains umlauts etc, it's advisable to store the files in UTF-8 encoding. This requires you to take care that this encoding does not get corrupt when editing the script files. But there's another thing to keep in mind: Before starting *SQL\*Plus* to install `PIT`, you need to make sure that your environment is set to UTF-8 as well. This is achieved by setting environment variable  `NLS_LANG` to a value of `AMERICAN_AMERICA.AL32UTF8`. It doesn't matter really which language and territory you choose as long as you make sure that the last parameter is `AL32UTF8`. The batch files take care of that so you may investigate them if you are unsure on how to do this yourself.

## Adjust `PIT` to your wishes
### Choose the default language

It is possible to adjust some settings before installing `PIT`. First, `PIT` is designed to be internationalized from ground up. As a basis, you need to define a default language for `PIT`. It is important to understand that any message you create must exists in this default language at least. You may translate it to other languages later, but you won't be able to just have a message in a language other than the default language. So, as a best practice, choose the best language for your needs and make this the default language. `PIT` supports `AMERICAN` adn `GERMAN` as languages out of the box. You adjust your default language by passing it in as a parameter when installing `PIT`. 

### Choose the default tablespace

Starting with this release, the installation files expect that you created the users owning `PIT` to be present, including a tablespace quota and a default tablespace. To adjust the tablespace, there is the option to pass in the desired tablespace for the tables and indexes `PIT` installs as a second parameter. If you omit this second parameter, the installation file falls back to the default tablespace of the user.

### Choose your flag type

As storing boolean values in a data model is no easy thing to do in Oracle, many different best practiceses are used to circumvent the lack of a boolean data type in Oracle tables. I found it cumbersome to work with more than one of these best practices at a time, so I made `PIT` adjustable in this regard. In file `PIT/PIT/init/settings.sql` you will find the following replacement variables:

```
-- ADJUST THIS SETTING IF YOU WANT ANOTHER TYPE 
define FLAG_TYPE="char(1 byte)";
define C_TRUE="'Y'";
define C_FALSE="'N'";
```

Using these replacement variables, you can adjust the boolean type to your local preference, may it be `1|0` or any other setting. In the file you will find the respective settings as an alternative. Be aware though that this is a one time decision, as this will be burned into the table declarations. Changing these settings is only possible by completely re-installing `PIT`. This is something you have to plan, as many other packages may depend on `PIT` and the flag type you chose.

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

The script to install `PIT` requires a set of system privileges. Actually, the following privileges are required for the core `PIT` functionality:

- `CREATE TABLE`
- `CREATE VIEW`
- `CREATE PROCEDURE`
- `CREATE SEQUENCE`
- `CREATE TYPE`

Additionally, if you want to use a globally accessible context, you need:

- `CREATE ANY CONTEXT`
- `READ` privilege on `DBA_CONTEXT`

If your DBA creates the context for you, provide him with the following script to achieve that (replace `<schema>` with the name of the user you are connected to):
```
create context pit_ctx_<schema> using <schema>.utl_context accessed globally;
```
Plus, you need the `READ` privilege on the view `DBA_CONTEXT`. The context has to be present before you can install `PIT`, as the script searches for it and decides upon the result whether to install `UTL_CONTEXT` or not.

## Install `PIT`

You may run the installation scripts directly from a command line or use the predefined batch scripts provided for Windows and Unix. The batch scripts set the environment accordingly and ask for the respective parameters interactively.

I recommend installing `PIT` in a dedicated utility owner and grant access to other schemas using the `pit_install_client` script. This way you don't multiply your codebase. The downside to this is a certain mixture of message definitions at one database user, as all messages are stored within table `PIT_MESSAGE` within that user. Plus, as you are allowed to map an Oracle server error number to a `exception` variable only once, you have to make sure that all mappings are dealt with in a way that makes them reusable for other schemas.

`PIT` internal messages are delivered in `GERMAN` and `AMERICAN`. Messages are located in various folders under `message/<LANGUAGE>/MessageGroup_PIT.sql` and can be translated or changed as you like. You can also use the built in translation service to translate the internal messages. How to do this is described [here](https://github.com/j-sieben/PIT/blob/master/Doc/translating_messages.md).

The installation scripts expects two parameters:

- `DEFAULT_LANGUAGE`: Oracle language name of the default language for all messages.
- `[DEFAULT_TABLESPACE]`: Optional tablespace name to install the tables to. If omitted, the default tablespace is used. Make sure the required tablespace exists and you have sufficient quota on it.

So here's an example on how to install `PIT` on a windows system:

```
rem always make sure that the console is set to UTF-8
set nls_lang=AMERICAN_AMERICA.AL32UTF8

rem switch to the directory where you copied the git repository to
cd C:\temp\PIT\PIT

sqlplus <pit_owner>/<pwd>@database
SQL> @pit_install AMERICAN
```

This example will install `PIT` with `AMERICAN` as the default language for messages, the tables are stored in the derfault tablespace of the actual user. All parameters are case insensitive.

## Uninstall `PIT`
To uninstall `PIT`, simply call `pit_uninstall.sql` from the installation folder. This script requires you to connect to the `PIT` owner and to all granted client users to avoid having to connect as a DBA user. No parameters are required.

```
rem switch to the directory where you copied the git repository to
cd C:\temp\PIT\PIT

sqlplus <pit_owner>/<pwd>@database
SQL> @pit_uninstall
```

## Granting access to `PIT` to a client

To grant a different schema access to `PIT` is a two step process. First, you call script `pit_install_client.sql`, connected as the `PIT` owner. This scripts expects the name of the user to grant access to as a parameter. Here's an example on how to call this script:

```
rem switch to the directory where you copied the git repository to
cd C:\temp\PIT\PIT
sqlplus <pit_owner>/<pwd>@database
SQL> @pit_grant_client <CLIENT_USER>
```

Then, you call a script to register the granted objects from `PIT` as local synonyms:

```
sqlplus <pit_client>/<pwd>@database
SQL> @pit_register_client
```

## Uninstalling `PIT` client
To uninstall a `PIT` client, you need to call the respective scripts `pit_revoke_client.sql` at the `PIT` owner and `pit_unregister_client.sql` at the client user:

```
rem switch to the directory where you copied the git repository to
cd C:\temp\PIT\PIT

sqlplus <pit_client>/<pwd>@database
SQL> @pit_unregister_client

sqlplus <pit_owner>/<pwd>@database
SQL> @pit_revoke_client <CLIENT_USER>
```

## Installing the supporting APEX application

`PIT` ships with an APEX application that allows you to manage `PIT` messages and global application parameters. For some it is easier to set parameters and create messages graphically than to use PL/SQL API calls. To install the supporting APEX application, it is expected that you have an APEX workspace. The workspace schema is referenced as the `PIT_APP` lateron, as this should be a schema different to the owner of `PIT`. Basically, there is no difference in a `PIT` client user and the APEX schema user, as both are simply using `PIT`. By installing the maintenance application, the client grants and some additional grants required are set.

The APEX application is available with a German UI and an American UI starting with the APEX version 20.2 only.

Writing APEX applications covering a wide range of APEX versions is a challenge for developers. The reason is that APIs change, new functions appear while others disappear. A possible solution would be to use only functions that were already available in the eraliest supported version and just leave the application as it is. But if you want to use newer functions of APEX, such as new form regions from version 19.1 on, the challenge will be that your API won't work the way it used to.

Therefore I decided to rely on my utilities named `UTL_TEXT` and `UTL_APEX` to sort out those issues. They will stabilze the API and remove most dependencies to APEX from the the controller logic within the APEX schema. Unfortunately, this will make installation a bit more complex. Before installing the APEX application, you need to install those utilities.

So you need to start downloading [`UTL_TEXT`](https://github.com/j-sieben/UTL_TEXT) and [`UTL_APEX`](https://github.com/j-sieben/UTL_APEX) first. I'm sure you benefit from those libraries even outside the context of `PIT`.`UTL_TEXT` for instance contains a very powerful and flexible code generator you may want to have a look at.

### Installing `UTL_TEXT`

Start by installing `UTL_TEXT` first. Ideally, it lives in the same utility user that owns `PIT`. After installing it, you grant access to the APEX schema user. Here's a sample script on how to achieve that:

```
rem always make sure that the console is set to UTF-8
set nls_lang=AMERICAN_AMERICA.AL32UTF8

rem switch to the directory where you copied the git repository to
cd C:\temp\UTL_TEXT\UTL_TEXT

sqlplus <utility_owner>/<pwd>@database
SQL> @utl_text_install AMERICAN
SQL> @utl_text_grant_client <PIT_APP>

sqlplus <pit_app>/<pwd>@database
SQL> @utl_text_register_client
```

### Installation of `UTL_APEX`

`UTL_APEX` is a library to wrap some commonly required APEX related functionality. Main focus is to centralize dependencies from the APEX API at one place. It also stabilizes the ever changing APEX API as good as it can. So for instance there is a method call `utl_apex.UPDATING` returning a boolean flag that analyzes the request, a button action or the value of `APEX$ROW_ACTION` to find out whether APEX wants to update a record.

Plus, another utility called `UTL_DEV_APEX` is installed. This package is useful only on develpment machines, as it is used to generate stubs for the controller level and other utilities to help you test your code.

As this is an APEX library, it lives in the `PIT_APP` schema directly and therefore does not require any client grants. Additionally, it grabs the default langauge from the `PIT` installation, so no need to adjust it here:

```
rem always make sure that the console is set to UTF-8
set nls_lang=AMERICAN_AMERICA.AL32UTF8

rem switch to the directory where you copied the git repository to
cd C:\temp\UTL_APEX\UTL_APEX

sqlplus <pit_app>/<pwd>@database
SQL> @utl_apex_install
```

That's it, you're now prepared to install the `PIT` application. Obviously, the steps above are required only once for all your APEX applications of that workspace that want to make use of those libraries.

If you want to see how `UTL_APEX`can make your live easier as an APEX developer, have a look a the controller package `pit_ui`. This package interacts with the pages based on their page alias, so for each page there is a matching method that reads the user entered data and controls how to write those to the `XAPI` layer owned by the `PIT` owner. Also note that no code is placed on the APEX pages directly other than calls to this package.

### Install the `PIT` administration application

Script `pit_install_apex.sql` will install the appliation itself. The script will make sure that the schema owner of this APEX workspace is granted all necessary object rights to maintain `PIT`. It expects four parameters:

- `APEX_USER`: database user who has access to `PIT` and `UTL_TEXT`, owns `UTL_APEX` and is the schema of the APEX-Workspace you install into
- `APEX_WORKSPACE`: Name of the APEX workspace
- `ALIAS`: Alias name of the APEX-application
- `APP_ID`: ID of the APEX-application

As with the other tools that rely on `PIT` to be present, the default language is taken from there. Here's an example on how to install the supporting APEX application for user `PIT_APP` in Workspace `DEV_TOOLS`. The application will be available at http://<your_apex_server>/ords/f?p=PIT:

```
rem always make sure that the console is set to UTF-8
set nls_lang=AMERICAN_AMERICA.AL32UTF8

rem switch to the directory where you copied the git repository to
cd C:\temp\PIT\PIT
sqlplus <pit_owner>/<pwd>@database
SQL> @pit_install_apex PIT_APP DEV_TOOLS `PIT` 123
```

Installing the supporting APEX application includes the registration of a `PIT` client.

## Uninstalling the supporting APEX application
To uninstall the supporting APEX application, call `pit_uninstall_apex` with a total of four parameters:

- `PIT_OWNER`: database user who own `PIT`
- `APEX_USER`: database user who owns `PIT_UI` (Schema of the APEX-Workspace you install into)
- `APEX_WORKSPACE`: Name of the APEX workspace
- `ALIAS`: Alias name of the APEX-application.

Here's a sample deinstallation script:

```
cd C:\temp\PIT\PIT
sqlplus <pit_app>/<pwd>@database

SQL> @pit_uninstall_apex PIT PIT_APP DEV_TOOLS PIT
```

As a second step, you may want to revoke the client grants from that user:
