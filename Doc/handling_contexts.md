# Handling context
In `PIT`, a context is a small collection of four parameters:
- Log level (`10, 20, .. 70`) or `pit.level_off .. pit.level_debug`
- Trace level (`10, 20, .. 50`) or `pit.trace_off .. pit.trace_detailed`
- Trace timing flag (`Y|N`)
- List of output modules (`PIT_TABLE:PIT_APEX` ...)

You may have any number of contexts defined for your application. To define a context, you create a parameter with the naming convention `CONTEXT_<Name>` and a string value of the four beforementioned parameters, separated by pipe signs (|). Package `pit_admin` provides methods named `pit_admin.create_named_context` to help you create these parameters. The methods are overloaded and give you the choice of passing the four parameters in separately or as a preformatted settings string. Using these methods has the advantage of cross checking the values and giving you exceptions if you define values that are not supported.

Please respect the ranges defined above for log and trace level. Also keep in mind that the list of output modules must be provided as a colon-separated list. All packages check input to assure that no undefined values are used.

One special context is called `CONTEXT_DEFAULT`. It serves as the basic setting for your logging. You may define it differently on development and production systems, but you should make sure that it's always present. If you want to switch off logging completely, you can pass in `10|10|N|` to indicate this, but `PIT` will throw fatal and error log levels anyway. If you don't paramterize at least one output module, danger is that errors may get lost undocumented.

One context name called `CONTEXT_ACTIVE` is reserved and therefore can't be used by you. The active context is used as an alternative to default logging. This makes it possible to log during a certain time period or certain sessions without affecting the log settings for other sessions or the need to adjust the default settings. Any named context you define may be switched active, overwritten by another named context or reset which enables default logging again.

## How `PIT` stores logging options

Logging is controlled by the default context basically. If you simply start your code with `PIT` being installed, the default settings apply. Which options you have in regard to controlling your logging depends on the initial parameters you have set if the `PIT` package initializes.

Log settings need to be stored in a place where any session running `PIT` is able to see it. If the settings were set in a package variable, only the session setting the variables could see the changes. So if you change the log settings in one session, other sessions wouldn't be able to see those changes.

There are basically two places within the database every session has access to: Tables and SGA. I decided to persist all parameters in a parameter table but to copy some of the more important parameters to the SGA. Reason is that I wanted to be able not only to switch logging for a given session on and off without affecting other sessions, but to trace and log activities of a given application user, even if she uses different sessions while working on her application. This in turns makes it necessary to define the focus of visibility of these parameters. Luckily, Oracle provides a structure to maintain those settings on a fine granularity in the SGA: A globally accessed context.

DISCLAIMER: The use of globally accessible contexts require that you have the necessary privileges to create such a context or you need to ask your database administrator to create one for you. If you don't have these rights and can't get them (fi in a cloud environment), `PIT` will install without this functionality. In certain environments, such as APEX, it is nevertheless possible to trace user activities across database sessions. This is possible as APEX switches tracing debugging and tracing on and off and `PIT` follows these settings.

### Globally accessed contexts

A context is a memory structure where SQL as well as PL/SQL have access to without environment switches. This makes access to context information very fast and convenient. On the other side, contexts are limited to short key value pairs of type `varchar2` only. Another downside of a context is that they store their values in the PGA normally, granting access to the actual values to the active session only. This makes them less interesting for inter session purposes. A globally accessed context on the other hand stores it's values in SGA and therefore makes them accessible to all session. Plus, these contexts allow to control the visibility of the information: A parameter value may be visible by certain users only or it may be visible to a broader scope based on how you store the value in the context. Because of this, `PIT` stores all it's cross-session information in a global context.

Changing settings means that all other sessions are aware of these changes immediately without any action. To make this work, `PIT` won't copy these settings into local memory but simply »outsource« it's knowledge upon context status to the context. Changing parameters in the database on the other hand means that you have to re-initialize `PIT` to make it aware of the parameter changes. This can be achieved by calling `pit.initialize`. All parameters that are stored in the context are made visible for all other instances of `PIT` at the same time, but some parameter changes may not be known to any `PIT` instance.

As per Oracle standard, a context may contain information that is visible to every user, to a specific database user only or to a session that has a specific client identifier set. As a matter of fact, these options are not too intuitive to use when using a context out of the box. Fi, it would be highly appreciated to have a »fallback« for a given parameter: If a user does not have a matching client identifier, it would be nice if this user could instead see the more widely visible parameter of the same name. Unfortunately, this is not possible. To allow for this, `PIT` wrapps the usage of the globally accessed context in a helper package called `utl_context`.

### UTL_CONTEXT

`UTL_CONTEXT` is not only interesting for `PIT` but for other uses as well which can accept that this package writes to the context. `UTL_CONTEXT` offers different types of globally accessed contexts to control how the context should behave. Here is a list of the different context modes `UTL_CONTEXT` provides:
- `utl_context.c_global`: ... for any user and any session, no possibility to restrict access based on user or session
- `utl_context.c_force_user`: ... for any session, but only if database username matches
- `utl_context.c_force_client_id`: ... only if client_identifier matches
- `utl_context.c_force_user_client_id`: ... only if user AND client_identifier matches
- `utl_context.c_prefer_client_id`: ... if a matching value for that client_identifier exists, it is visible, otherwise a default value is provided
- `utl_context.c_prefer_user_client_id`: ... if a matching value for that user AND client_identifier exists, it is visible, otherwise a default value is provided
- `utl_context.c_session`: ... only within the session that set the value (pseduo local context)

Of the modes offered, the `C_PREFER_...` options are special as they allow for a fallback solution. The idea is that if a specific setting for a combination of user and client identifier is avaiable, this will be chosen. If not, it »falls back« to a setting for the user if a value exists that has got no dependency to a client identifier. This makes it possible to have a specific log setting which applies to any user which can be overwritten by a specific setting if the client identifier matches. To use one of those context types, you simply choose the constant value as value for `PIT` parameter `PIT_CTX_TYPE`. In an environment with client server connections, you may opt for a `FORCE_USER` if your application users are proxy or database users. If, on the other side, you work in a connection pool environment, you may choose `PREFER_CLIENT_ID` to control logging on a per user basis, even if they utilize different sessions per call. `PIT` defaults to `utl_context.c_prefer_client_id`.

### Logging choices
Now that we understand that the memory of `PIT` is the globally accessed context, we need to understand what options we have to control these settings.

If you want to change the actual log settings, a best practice is to create a named context using the `pit_admin.create_named_context` method and switch to it. This is achieved by calling `pit.set_context(<NAME_OF_CONTEXT>);`, This will work immediately and across all sessions that can see the global context value. Another option is convenient during testing: You can call the overloaded version ot `pit.set_context` which allows you to set all log parameters directly without the need to create a named context upfront. Here's a code snippet to show you how to do it:

```
begin
  pit.set_context('DEBUG');
  -- Alternatively:
  pit.set_context(
    p_log_level => pit.level_all,
    p_trace_level => pit.trace_all,
    p_trace_timing => true,
    p_module_list => 'PIT_CONSOLE:PIT_TEST');
  ...
end;
```

How and when this method is called is up to you. You may bind it to an external toggle or call a script to switch it, as soon as you call the method, it gets switched. What the focus of this switch will be depends on the kind of context you have. There is one exception to this rule: The session adapter, responsible for retrieving session id and username, also has an option to control logging. It may pass the name of a context back and `PIT` will immediately switch to this context. This is useful if you need a way to detect whether the calling environment is set to debug mode and you want `PIT`. Take APEX as an example: You can switch on logging of an APEX application by providing a switch within the URL. The APEX session adapter shipped with the `PIT_APEX` output module will detect this and switch to a context called `CONTEXT_APEX` that contains parameterizable logging settings for APEX. This way, `PIT` can be remotely switched on simply by setting APEX to debug mode.

### Toggle context
Another option to control the log session is to switch logging on and of for a given list of methods or packages. Idea is that you may have packages that are well maintained and tested, whereas other packages need testing and logging. In this case, you can provide a »white list« to switch logging on or a »black list« to switch logging off. You may have any number of toggle switches. Normally, you may provide on toggle per named context you want to toggle to. Assure that this named context is available before creating a toggle to prevent assertion errors.

To enable this option, a global `PIT` parameter called `ALLOW_TOGGLE` needs to be set to `TRUE`. Named contexts to switch to need to be defined and a list of parameters with the naming convention `TOGGLE_<NAME>` need to be generated. Let's make things clearer by providing an example. In an application, packages `UTIL` and method `MAIL.SEND` shall not be traced, whereas packages `BL_FORM`, `BL_MODE` and method `BL_ORDER.SUBMIT` shall be traced. Parameter `ALLOW_TOGGLE` is set to true. 

The following named contexts are defined (by calling `pit_admin.create_named_context(...)`):

- `CONTEXT_LOG_ALL`, settings: `70|50|Y|PIT_CONSOLE`
- `CONTEXT_LOG_OFF`, settings: `10|10|N|`

Now, two parameters to toggle the settings are defined (by calling `pit_admin.create_context_toggle(...)`):

- `TOGGLE_ON`, string value: `BL_FORM:BL_MODE:BL_ORDER.SUBMIT|CONTEXT_LOG_ALL`
- `TOGGLE_OFF`, string value: `UTIL:MAIL.SEND|CONTEXT_LOG_OFF`

Now, your code enters method `FOO`. As no setting is defined for this package, `CONTEXT_DEFAULT` is used. `FOO` calls `BL_FORM`. The context toggles to `CONTEXT_LOG_ALL` and logs anything to output module `PIT_CONSOLE`. Now, `BL_FORM` calls another package `FOO2`. As this does not change the settings, `CONTEXT_LOG_ALL` remains active. If `MAIL.SEND` is called, logging is switched off. But if you leave `MAIL.SEND`, Logging resumes to the last setting that was active before `MAIL.SEND` was called, so in our example it resumes `CONTEXT_LOG_ALL` and logging continues. If you leave `BL_FORM`, logging switches back to `CONTEXT_DEFAULT`, as no active context was active before `BL_FORM` was called.

Switching parameter `ALLOW_TOGGLE` to `TRUE` forces `PIT` to maintain minimal tracing information to gather information about whether a context should be switched or not. Therefore, if you don't need the toggle functionality, switch parameter `ALLOW_TOGGLE` to `FALSE` again to avoid unnecessary work and speed up `PIT`.

## PIT_ADMIN and `PIT`
As you can see throughout this page, `pit_admin` is used to create parameters, whereas `pit` is used to switch between existing parameters. This is by design. it allows to grant execute rights to `pit` only without the grantee having the possibility to call `pit_admin` methods. Nevertheless, `pit_admin` is required on production systems, even if you don't plan to call it there: As a enhanced possibility to speed up `PIT` on production system, it's possible to adjust installation flags within package `pit_admin`. If you don't implement `pit_admin` on production, these flags are not present and compilation errors will occur. See [Performance tuning of `PIT`](performance.md) for details on this.

## Other use cases for the context

`PIT` also offers a method called `pit.set_context_value`. The use case is different, as this method does not aim to maintaining the internal `PIT` memory but to set values in the global context that offer the same possibilities as the other context values, namely being accessible across sessions while at the same time being private per (logical) session. This method allows to set any value within that global context. This comes in handy if you want to set a test flag or if you need to adjust the time for automatic testing. Whatever use case you may have in mind can be achieved within the limits of a global context. These limits are that you can store only alphanumeric values up to 4000 Byte in length. By calling this method and providing a `NULL` value to its `p_value` parameter, the attribute gets deleted from the global context.

If you want to read the content, the official way to do this is to call `sys_context` with the name of the global context and the name of the parameter. Using this method, you can access this information from both SQL and PL/SQL without an environment switch which makes this approach very appealing. Keep in mind though that the optimizer will not be able to select a proper execution plan based on a call to `sys_context` as it is not known at compile time what the value will be. Another disadvantage of this approach is that you need to know the name of the global context `PIT` uses. The name can be deducted, as it is composed of `PIT_CTX_<Onwer of PIT>`, so if the owner of `PIT` is `UTILS`, the context name is `PIT_CTX_UTILS`.

If you can accept calling a PL/SQL method, there is a method called `pit.get_context_value` that expects the attribute name and returns the parameter value. Using this method you don't need to know the context name and it may fit nicely into a PL/SQL program. And even from within SQL you may use this method, but you should wrap the call into a scalar subquery (`select pit.get_context_value('MY_ATTIRUBTE') from dual`) to prevent unnecessary context switches.
