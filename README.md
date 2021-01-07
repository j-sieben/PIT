# `PIT`
PL/SQL Instrumentation Toolkit

Hi everybody,
this is the home of `PIT`, the PL/SQL Instrumentation Toolkit.
This tool is designed to help you manage your 
- exceptions
- debug information
- trace information
- assertion functions
- user messages

within a single package, with a single API and least possible code.

Yet, `PIT` gives you
- unlimited number of different output channels to write messages to
- full i18n support, messages are translatable using a XLIFF file and an open source editor
- possibility to maintain a full call stack with timing and cpu-timing option
- fully parameterizable, ability to debug a single session within a connection pool environment
- ability to define different debug and tracing settings per session
  
The code is free to use and I hope that you'll enjoy doing so. Should any errors occur, 
feel free to describe them here, I'll do my best to remove them.

## Usage
The use of `PIT` is straightforward. I took care to create a dense and short interface for working with `PIT`, as I know that nobody likes to write long package and method names, especially in code areas that you need repeatidly. On the other side, I provide enough explicit methods not to bother you with repeated parameters like severity of a message or similar. Here's a code snippet of a minimal usage of `PIT`:
```plsql
procedure my_proc(
  p_param1 in varchar2)
as
begin
  -- trace entering and leaving a method
  pit.enter;
  <do_something>
  -- internal debugging
  pit.debug(msg.STEP_ONE_COMPLETED, msg_args(p_param1));
  -- pass messages to the view layer
  pit.print(msg.STEP_ONE_VIEW_MESSAGE, msg_args(p_param1));
  <do_something_else>
  -- raise an exception
  pit.error(msg.STEP_TWO_FAILED);
  pit.leave;
exception
  -- catch predefined Oracle errors as usual
  when NO_DATA_FOUND then
    -- but provide your own exception messages
    pit.sql_exception(msg.NO_ITEMS_IN_STOCK);
  -- catch your own exceptions just the same way
  when msg.STEP_TWO_FAILED_ERR then
    -- log, re-raise your custom exception
    pit.stop;
end my_proc;
```

As you can see, the code amount for instrumentation is minimal, no need to hardcode any message text, no possibility to mistype a message name. The code remains clean, concise and easy to understand. All delivery problems of the debug and exception messages are taken away from the code.

## How it works
### Messages
`PIT` is centered around messages. A message basically consists of a message text, a language and a severity, optionally along with an Oracle exception number.

Severities range from 20 (`LEVEL_FATAL`) to 70 (`LEVEL_VERBOSE`)or from `20` (`TRACEL_MANDATORY`) to `50` (`TRACE_ALL`) to track methods calls. Along with the severity there is a custom error number that you can assign to a message. These error numbers may reference Oracle error numbers with the exception of all those that have a predefined exception already, such as `NO_DATA_FOUND` or similar. By assigning an Oracle error number to a message, the Oracle error is automatically mapped to this message. If you provide no Oracle error number, `PIT` automatically creates a custom error for you, so you don't have to deal with `-20.000` numbers anymore!

Messages support being translated to any target language Oracle supports. To make this convenient, `PIT` supports translating all messages by exporting them as XLIFF files ready to be translated using any XLIFF editor. After translation, the resulting XLIFF file is simply re-imported into `PIT` and you're done. Translating a single message is possible by calling method `pit_admin.translate_message`.

The messages are accessible through a package called MSG that holds them as constants plus exceptions for all messages with severity `LEVEL_ERROR` or `LEVEL_FATAL`. So if you create a message called `CHILD_RECORD_FOUND`, severity `LEVEL_ERROR` with Oracle error number `-2292`, package `MSG` will contain entries like this:
```plsql
package MSG
as
  CHILD_RECORD_FOUND constant `PIT`_util.ora_name_type := 'CHILD_RECORD_FOUND';
  CHILD_RECORD_FOUND_ERR exception;
  pragma exception_init(CHILD_RECORD_FOUND_ERR, -2292);
...
```
This package is generated by a procedure called `pit_admin.create_message_package` and can be rebuilt at any time. As this package will be created during development time only, this package behves like a »normal« package in production and may be either deployed like any other package or created dynamically after having created all required messages. To learn more about the creation of messages, read [Using `PIT`](Doc/using_pit.md)

As a powerful extension to this concept, `PIT` now supports messages in ICU format. Read [more](Doc/icu_messages.md)

### Using messages
But now, what do you do with messages?
Messages are required in many places of a program. They may be used to
- maintain error messages in the exception block
- provide meaningful messages in assertion-methods
- pass information that is language specific to the view layer of an application
- provide debug information
- ...
 
Being creative will lead to further use cases for `PIT`. I use messages containing a JSON template like `{"status":"#1#","message":"#2#"}`. Those messages obviously need no translation. But as they are able to replace anchors within the message with CLOB parameters, they can be used to write the outcome of even complex calculations to the view layer (by calling `pit.print(msg.JSON_MSG, msg_args(clob_param));`), replacing helper packages for the same purpose. Output modules which implement the print method take care of properly delivering content to the application regardeless of their size.
Let's look at the requirements that derive from these use cases a bit closer.

### Output channels

From the list of use cases you can see that there is a requirement to be very flexible in regard to output channels. Storing messages in a table or printing them to the console simply is not enough. `PIT` is designed from ground up to support any number of output channels such as `PIT_CONSOLE`, `PIT_TABLE`, `PIT_MAIL`, `PIT_APEX`, `PIT_FILE` and others without the need to change the basic `PIT` code at all. Plus, all of these output module may be present but which one will be actually used to debugging is switched on and off using a context concept. This allows for the least possible logging activities and thus preserving performance.

When you think about these output channels, other requirements pop up. While it is ok to write any debug message to the console, this is certainly not true for a mail output channel. To cater for this, `PIT` allows any channel to decide whether and how they process an incoming message. So it's possible to parameterize the `PIT_CONSOLE` output channel to write every single message to the screen whereas the `PIT_MAIL` output channel decides to send message of severity `LEVEL_FATAL` immediately, collecting messages of severity `LEVEL_ERROR` in a list and send them once a day and ignore all other messages.

### Context

It's good practice to include instrumentation code not only in development but in production code as well. Obviously there's a need to be very flexible in switching this code off and on. `PIT` supports this flexibility by a concept of contexts. A context is a set of settings that is used to control the debug and trace level. It consists of four settings:
- `DEBUG_LEVEL`: Set the maximum severity that gets logged
- `TRACE LEVEL`: Set the maximum trace level (of which there are four) to trace entering and leaving methods
- `TRACE_TIMING`: Flag to switch capturing of timing information on and off
- `OUTPUT_MODULES`: Colon-delimited list of output modules that are required for logging, such as `PIT_CONSOLE:PIT_TABLE`.

One such context is called `CONTEXT_DEFAULT`. The default context is parameterized and used upon »normal« execution of the code. To change it, change the parameter settings and have `PIT` initialize again. Besides this default context, it's possible to create any number of named contextes by using parameters with a naming convention of `CONTEXT_<Name>`. With such a context, you're free to predefine any combination of logging settings and output modules and easily switch to that context later. Plus, you can call a `pit.set_context` method and define a new context on the fly. Any named context may be activated per session (even in an connection pool environment, where only one user is traced, no matter which connection this user utilizes) or globally. If set, the activated context overrules the default. By resetting the context, you switch back to you `CONTEXT_DEFAULT` settings.

Using the context concept, you have the choice to control the debugging by:
- Parameterizing the default control and adjust the generic debug settings
- Overrule the default settings with predefined context settings
- Dynamically define a new context setting for immediate debug activities
- Trace the complete code, a defined session or a defined user, even in connection pools

More information on contexts can be found [here](Doc/handling_contexts.md).

### Toggle logging on and off based on package or method names

With `PIT`, it's possible to create a white or black list of code units which toggle logging on or off. Imagine a predefined context `CONTEXT_ALL` which defines complete logging (`70|50|Y|PIT_CONSOLE:PIT_FILE`). As per default, logging is set to no logging at all, as you are in production environment. Then you can create a parameter called `TOGGLE_<Name>` with a value of `MY_PACKAGE|MY_OTHER_PACKAGE:CONTEXT_ALL`. If you enter one of these packages, `PIT` will set the context to `CONTEXT_ALL`, tracing anything from now on. Once you leave these packages, context will be switched back to defaut settings.

This will create a white list. By switching to a to be defined context `CONTEXT_OFF` you can realize a black list, preventing logging for certain package even if default logging is switched on.

You may have as many toggle parameters as you like. Plus, `PIT` offers a set of methods in the `pit_admin` package to create toggles for your code to avoid having to manually format the parameters accordingly.

### Collect messages and exceptions and handle them in bulk

Often, UI forms require you to validate the user's input. Those validation methods are placed in a package, probably as part of a transaction API, near the tables. If you validate your code, those methods typically stop validating upon the first exception that occurs. To the end user, this is very unfriendly, you want to see all validation issues there are. 

To avoid this, you could 
- recode all validation methods in packages which are closer to the UI and implement your own way of validating all aspects and collect the exceptions
- break up to validation logic into many trivial methods which only implement the validation of one aspect at a time and construct something around it that collects the upcoming validation issues.

Both scenarios can be avoided by using `PIT` in collect mode. To set this mode, you simply call `PIT.start_message_collection` prior to calling the validation logic. Any `PIT` message that is raised during processing of the validation code are not raised immediately but stored in an internal collection within `PIT`.

You stop this mode by calling `PIT.stop_message_collection`. `PIT` now examines the list of collected messages, looking for a message with severity `FATAL` or `ERROR`, whatever is worse. Based on the worst severity, `PIT` now throws an exception called `PIT_BULK_FATAL` or `PIT_BULK_ERROR` respectively. If you catch those, you get access to the collected messages using `PIT.get_message_collection` and can now iterate through all messages collected and present them to the end user.

Of course you can omit the call to `PIT.stop_message_collection` and directly work with the collected messages. If you do so, `PIT` automatically switches off collection mode. `PIT.get_message_collection` will include all collected messages of all severities you have parameterized to fire, so calling this method will even be useful if no exception was raised after stopping collect mode.

More details on working in collect mode can be found [here](Doc/collect_messages.md).

### Output modules
Another aspect of flexibility is the possibility to easily extend or change output modules. This is accomplished by object oriented programming. `PIT` uses an object called `PIT_MODULE` as an abstract class for all output modules. If you install a new output module by inheriting from `PIT_MODULE` (`create type `PIT`_CONSOLE under `PIT`_MODULE ...`) this new module gets known to `PIT` and may be used immediately without having to change `PIT` itself.
A big advantage of this approach is that `PIT_MODULE` implements all necessary functionality as stubs. Because of this you only need to implement the behaviour you require for your new output module and leave all other moethods out. Say you plan to create a `PIT_MAIL` output module. It wouldn't make sense to implement a `purge` method as a sent mail cannot be purged. So if you don't need it, you simply don't implement it.

Every output module may have its own set of parameters to control the behaviour of the output module. Obviously, output modules may have their own database objects, such as tables or helper packages, depending on their complexity. A `PIT_MAIL` module may have a table to buffer messages that need to be sent later, some helper packages to actually send a mail etc. The only connection to `PIT` is the inherited output module `PIT_MAIL`. Because it inherits from `PIT_MODULE`, `PIT` is secure to call any method for `PIT_MAIL` that `PIT_MODULE` implements. What happens with the provided messages is up to the output module.

## Administration
To administer `PIT`, a dedicated administration package is provided. It provides methods to
- create or translate messages
- create the MSG package
- create or import an XLIFF file containing all messages ready for translation
- check whether predefined Oracle errors exist to prevent overriding
- Helper methods to create named contexts and context toggles
- create an installation file containing all messages in the database
 
With these methods it's easy to maintain and extend an installation file during development to create new messages on the fly. If you do so, the deplyoment file is created just along with your activities. Alternatively, you may want to have `PIT_ADMIN` create an installation file containing all messages in the database for you.

To make it even more convenient for you, I also added an APEX application that allows to maintain (create, edit, translate) messages and parameters, export their values by creating a downloadable script file withs calls to the `PIT_ADMIN`-API and see where any given message is referenced in the code.

## Extensibility
PIT comes ready to use with a bunch of output modules. You may want to start your changes by reviewing the output modules and adjust their behaviour. Should an output module be missing, it's easy to create a new one based on the other modules that ship with `PIT`. I decided to create the necessary object types but only implement the bare minimum of functionality within these types, just enough to call helper packages that carry out the heavy lifting. This way you're not exposed to object oriented programming in PL/SQL more than absolutely necessary ... ;-)

Other possible extensions refer to the way session identity is detected. It may be sufficient to rely on `CLIENT_IDENTIFIER`, as this is the case in APEX environments, or to stick to the `USER` function to detect a specific user. Should this turn out to not be working for you (e.g. in a proxy user environment), you may provide a new `SESSION_ADAPTER` that implements your method of detecting the session identity. Which `SESSION_ADAPTER` is used is parameterizable.

The session adapter serves for another purpose as well: If the calling environment is set to debug, as this is possible within APEX, the session adapter will switch `PIT` to debug modus as well. This way, `PIT` automatically follows the application in this regard.

## What's more?

### Reusable Components

PIT makes havy use of parameters. Parameters are organized in parameter groups of which `PIT` uses the parameter group `PIT`. These parameters are maintained by separate packages `PARAM` and `PARAM_ADMIN` to retrieve and maintain parameter values in a mandator aware way. Plus, the parameter package supports a concept called `REALM` that allows to store different parameter settings depending on the realm they are defined for. This allows for storing different parameter values per realm, say a list of URLs for development, testing and production use.

As this package, along with a generic parameter table, is accessible outside `PIT`, the parameter package may be used to organize all of your application parameters as well. The administrative package once again allows you to create and maintain parameters and to export parameters by reating a group of parameter files with all parameters and their values in a file per parameter group. Read more about parameter support [using parameters](Doc/parameters.md)

A second component that might be reused is a component to maintain globally managed contexts. In order to store parameters in a way that they are accessible cross-session, you need a globally accessed context. Whereas this type of context is very nice in that access to its information does not incur context switches from neither PL/SQL nor SQL, it's not all intuitive to use. A separate package `UTL_CONTEXT` allows for a smoother utilization of globally accessible contexts. Being a separate package it's easy to reuse this package for your own context requirements.

### APEX administration app for various APEX versions

`PIT` ships with an administrative APEX application to easily create and maintain parameters, messages and `PIT` related settings such as contexts or context toggles. An export page allows you to export parameters, messages and translatable items as ZIP files. You may export as many message or paramter groups as you like. For messages and translatable items, there is also a possibility to generate and import XLIFF translation files in any Oracle supported target language. For a brief introduction to the APEX application, continue reading [here](Doc/administration_app.md)

## Further reading

If you need assistance in installing `PIT`, read [Installing `PIT`](Doc/installing_pit.md)

To get familiar with `PIT`, read [Using `PIT`](Doc/using_pit.md)

Details to throwing and catching Exceptions can be found [here](Doc/exceptions.md)

To learn more about the concept of *Context* and *Toggles* read [Context and Toggles](Doc/handling_contexts.md)

Some advice on how to keep execution speed high with `PIT` can be found [here](Doc/performance.md)

If you need to write your own output module, continue reading [Output Modules](Doc/output_modules.md)
