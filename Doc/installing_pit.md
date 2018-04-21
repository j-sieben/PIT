# PIT Installation

## Installing PIT

PIT installation is straight forward: Simply call a script file and off you go. All you need to do is pass in the name of the owner of PIT and the default language you want to use. Any Oracle supported language name is allowed as the default language. But if you need a language other than AMERICAN or GERMAN, you will need to provide PIT with a translated version of the messages. To add such a file, create a folder located at `PIT/core/messages` named according to your language and copy a translated version of `create_messages.sql´ of the provided folders into it. If you want to add a translation to APEX, such as GERMAN to a PIT installation with AMERICAN default language, simply execute the language script of the desired language. Additionally, you want to adjust the parameters of PIT to choose the newly created language as your preferred language.

As with any software that contains umlauts etc, it's advisable to store the files in UTF-8 encoding. This requires you to take care that this encoding does not get corrupt when editing the script files. But there's another thing to keep in mind: Before starting *SQL*Plus* to install PIT, you need to make sure that your environment is set to UTF-8 as well. This is achieved by setting environment variable  `NLS_LANG` to a value of `AMERICAN_AMERICA.AL32UTF8`. It doesn't matter really which language and territory you choose as long as you make sure that the last parameter is `AL32UTF8`. 

Here's an example on how to install PIT on a windows system:

```
cd C:\temp\PIT
set nls_lang=GERMAN_GERMANY.AL32UTF8
sqlplus <sys_credentials> as sysdba @pit_install DOAG GERMAN
```

PIT is designed such that it can be used in a mandator aware software. This means that in a normal installation one user ownes the PIT software itself, whereas a second user uses the software. If you want to grant another user access to PIT, you install a PIT client by calling the respective script named `pit_install_client.sql`. This script expects to parameters: The name of the owner of PIT and the name of the client.

If you want to maintain messages via a graphic frontend, you can do so by installing the APEX application that ships with PIT. This application allows to control not only PIT messages, but parameters as well. The parameter framework is useful outside PIT and is mandator aware as well. To install the APEX application, call `pit_install_apex.sql` with four parameters:

- name of the owner of PIT
- name of the APEX schema the APEX workspace has access to
- name of the default language
- name of the APEX workspace

## PIT privileges
The script to install PIT requires administrative privileges, as it creates users shouldn't they already exist, grants system and object privileges and so forth. If your administrator needs to have an overview about the rights the PIT installation grants to the respective users, you will find them in file `set_grants.sql` in the installation folder plus in the modules folder for specific output modules. As an example, you will find a file named `user_grants.sql` in folder `modules/pit_file` which assigns execute rights on `utl_file` to the owner of PIT.

Additionally, in script `check_user_exists.sql` quota unlimited on tablespace `users` is granted to the PIT owner and PIT user. Adjust this if you need different settings here.

Starting with Oracle version 12c, a new privilege `inherit privileges` must be obeyed. The installation script will grant `inherit any privilege` from SYS to the owner of PIT. This grant is revoked after installation to assure that no method of PIT abuses privileges if these methods are called by SYS.

## Uninstall PIT
To uninstall PIT, simply call `pit_uninstall.sql` from the installation folder. This script requires a dba account as well, as it removes packages in other schemas. Make sure to pass the name of the owner in.

Here's a sample script of how to uninstall PIT on a windows system:

```
cd C:\temp\PIT
set nls_lang=GERMAN_GERMANY.AL32UTF8
sqlplus <sys_credentials> as sysdba @pit_uninstall.sql DOAG
```

Accordingly, there are scripts to uninstall a PIT client and the PIT APEX application.
