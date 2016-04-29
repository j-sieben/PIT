# PIT
PL/SQL Instrumentation Toolkit

Hi everybody,
this is the home of PIT, the PL/SQL Instrumentation Toolkit.
This tool is designed to help you manage your 
- exceptions
- debug information
- trace information
- assertion functions
- user messages

within a single package, with a single API and least possible code.

Yet, PIT gives you
- unlimited number of different output channels to write messages to
- full i18n support, messages are translatable using a XLIFF file and an open source editor
- possibility to maintain a full call stack with timing and cpu-timing option
- fully parameterizable, ability to debug a single session within a connection pool environment
- ability to define different debug and tracing settings per session
  
The code is free to use and I hope that you'll enjoy doing so. Should any errors occur, 
feel free to describe them here, I'll do my best to remove them.

## Usage
The use of PIT is straightforward. I took care to create a dense and short interface for working with PIT, as I know that nobody likes to write long package and method names, especially in code areas that you need repeatidly. On the other side, I provide enough explicit methods not to bother you with repeated parameters like severity of a message or similar. Here's a code snippet of a minimal usage of PIT:
```plsql
procedure my_proc(
  p_param1 in varchar2)
as
begin
  -- trace entering and leaving a method
  pit.enter('my_proc');
  <do_something>
  -- internal debugging
  pit.debug(msg.STEP_ONE_COMPLETED, msg_args(p_param1));
  -- pass messages to the view layer
  pit.print(msg.STEP_ONE_VIEW_MESSAGE, msg_args(p_param1));
  <do_something_else>
  -- raise an exception
  pit.error(msg.STEP_TWO_FAILED_EXC);
  pit.leave;
exception
  -- catch predefined Oracle errors as usual
  when NO_DATA_FOUND then
    -- but provide your own exception messages
    pit.sql_exception(msg.NO_ITEMS_IN_STOCK);
  -- catch your own exceptions just the same way
  when msg.STEP_TWO_FAILED_EXC then
    -- and provide the predefined message along with it
    pit.stop(msg.STEP_TWO_FAILED);
end my_proc;
```
As you can see, the code amount for instrumentation is minimal, no need to hardcode any message text, no possibility to mistype a message name. The code remains clean, concise and easy to understand. All delivery problems of the debug and exception messages are taken away from the code.

## How it works
### Messages
PIT is centered around messages. A message basically consists of a message text, a language and a severity.

Severities range from 20 (fatal) to 70 (verbose). Along with the severity there is a custom error number that you can assign to a message. These error numbers may reference Oracle error numbers which do not have a predefined exception, such as NO_DATA_FOUND or similar. By assigning an Oracle error number to a message, the Oracle error is automatically mapped to this message. If you provide no Oracle error number, PIT automatically creates a custom error for you. No more hazzle with -20.000 numbers anymore!

Messages are ready for translation in any target language Oracle supports. To make it convenient to translate messages, all messags can be exported as XLIFF ready to be translated into a target language using any XLIFF editor. After translation, the resulting XLIFF file is simply re-imported into PIT and all messages are automatically translated.

All messages are accessible through a package called MSG that holds all of the messages as constants plus exceptions for all messages with severity 20 or 30. So fi if you create a message called CHILD_RECORD_FOUND, severity 30 to Oracle error number -2292, package MSG will contains entries like this:
```plsql
package MSG
as
  CHILD_RECORD_FOUND constant varchar2(30) := 'CHILD_RECORD_FOUND';
  CHILD_RECORD_FOUND_EXC exception;
  pragma exception_init(CHILD_RECORD_FOUND_EXC, -2292);
...
```
This package is automatically created through a procedure in the PIT_ADMIN-package and can be rebuilt at any time you see fit. As this package will be created during development time only, this package is a »normal« package in production, either deployed like any other package or created dynamically after creating all required messages.

### Using messages
But now, what do you do with messages?
Messages are required in many places of a program. They may be used to
- maintain error messages in the exception block
- provide meaningful messages in assertion-methods
- pass information that is language specific to the view layer of an application
- provide debug information
- ...
 
It turned out in my projects that using PIT for even other purposes does make sense as well. Fi I use PIT along with messages that contain a JSON-Template for success messages. Those messages obviously need no translation but as they are able to take even CLOB parameters and provide a simple way to pass them to the view layer they quickly replaced some of my other helper packages to pass information to the view layer. Output modules which implement the print method take care of properly delivering content to the application of what size ever.
Let's look at the requirements that derive of these use cases a bit closer.
### Output channels
From the list of use cases you can see that there is a requirement to be very flexible in regard to output channels. Storing messages in a table or printing them to the console simply is not enough. PIT is designed from ground up to support any number of output channels such as CONSOLE, TABLE, MAIL, APEX, TRACE FILE and others without the need to change the basic PIT code at all.

When you think of these output channels, other requirements pop up. While it is ok to write any debug message to the console, this is certainly not true for a mail output channel. To cater for this, PIT allows any channel to decide whether and how they process an incoming message. So fi it's possible to parameterize the CONSOLE output channel to write every single message to the screen whereas the MAIL output channel decides to send fatal errors immediately, errors in a list once per day and ignore all other messages.

### Context
It's good practice to include instrumentation code not only in development but in production code as well. Obviously there is a requirement to be very flexible in switching this code off and on. PIT supports this flexibility by a concept of contexts. A context is a set of settings that is used to control the debug and trace level. It consists of four settings:
- DEBUG_LEVEL: Set the maximum severity that gets logged
- TRACE LEVEL: Set the maximum trace level (of which there are four) to trace entering and leaving methods
- TRACE_TIMING: Flag to switch capturing of timing information on and off
- OUTPUT_MODULES: Colon-delimited list of output modules that are required for logging, such as PIT_CONSOLE:PIT_TABLE.

One such context is called the default context. The default context is parameterized and used upon »normal« execution of the code. To change it, change the parameter settings and have PIT initialize again. Besides this default context, it's possible to create an active context. An active context may be set per session (even in an connection pool environment, where only one user is traced, no matter which connection this user utilizes) or globally. If set, the active context overrules the default context. By simply resetting the context, the default context comes into play again.

### Output modules
Another aspect of flexibility is the possibility to easily extend or change output modules. This is accomplished by object oriented programming. PIT uses an object called PIT_MODULE which servers as an abstract class for all output modules. If you install a new output module by inheriting from PIT_MODULE (`create type PIT_CONSOLE under PIT_MODULE` ...) this new module gets known to PIT and may be used immediately without any change to PIT itself.
A big advantage of this approach is that - because PIT_MODULE implements all necessary functionality as stubs - you only need to implement the behaviour you require for this new output module. Say you plan to create a PIT_MAIL output module. It wouldn't make sense to implement a purge method as a sent mails cannot be purged. So if you don't need it for a given output module, you simply don't implement it.

Every output module may have its own set of parameters to control the behaviour of the output module.

## Administration
To administer PIT, a dedicated admin package is provided. It provides methods to
- create or translate messages
- create the MSG package
- create or import an XLIFF file containing all messages ready for translation
- check whether predefined Oracle errors exist to prevent overriding
- create an installation file containing all messages in the database
 
With these methods it's easy to maintain and extend an installation file during development to create new messages on the fly. If you do so, the deplyoment file is created just along with your activities. Alternatively, you may want to have PIT_ADMIN create an installation file containing all messages in the database for you.

## Extensibility
PIT comes ready for usage with a bunch of output modules created for you. You may want to start your changes by reviewing the output modules and adjust their behaviour. Should an output module be missing, it's easy to create a new one based on the other modules that ship with PIT. I decided to create the necessary object types but only implement the bare minimum of functionality within these types, just enough to call helper packages that carry out the heavy lifting. This way you're not exposed to object oriented programming more than absolutely necessary ... ;-)
Other possible extensions refer to the way session identity is detected. It may be sufficient to rely on CLIENT_IDENTIFIER, as this is the case in APEX environments, or to stick to the USER function to detect a specific user. Should this turn out to not be working for you, you may a new SESSION_ADAPTER that implements your method of detecting the session identity. Which SESSION_ADAPTER is used is based on parameters once again.

## What's more?
### Reusable Components
PIT makes havy use of parameters. Parameters are organized in parameter group of which PIT uses the parameter group 'PIT'. These parameters are maintained by separate packages PARAMS and PARAM_ADMIN to retrieve and maintain parameter values in a mandator available way. As this package, along with a generic parameter table, is accessible outsid PIT, this functionality may be used to organize all of your application parameters as well. The administrative package once again allows you to create and maintain parameters and to create a group of parameter files with all parameters including values in a single file per parameter group.
A second component that might be reused is a component to maintain globally managed contexts. It's not a secret that in order to allow for cross-session tracing you need a way to pass information from one session to others. Within PIT, this is achieved by storing the default and active context in a globally accessed context. Whereas this type of context is very nice in that access to its information does not incur context switches from neither PL/SQL nor SQL, it's not all intuitive to use. A separate package allows for a smoother utilization of globally accessible contexts. Being a separate package it's easy to reuse this package for your own context requirements.

### New ideas
One of the areas I'm working upon in regard to PIT is to allow to switch tracing and debugging on and off per code block as well. This requirement may occur when you develop software and have many packages that work well but a newly changed or created package needs some logging. So in order not to overwhelm your log files with tons of non required information, you may be able to maintain a white or black list for packages which will switch logging on or off.
Another option I'm thinking about is named contexts which allow you to predefine context settings and store them under some name, preferably as a parameter. You may then simply call the named context instead of definining every aspect of a non-standard logging yourself.
