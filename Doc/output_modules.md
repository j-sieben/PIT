# Writing your own output module

Writing a new output module is easy. There are two steps to take: Create a new object under `PIT_MODULE` and implement overwrites of the methods you need within that new module.

## Create an object under `PIT_MODULE`

`PIT_MODULE` is an object type that ships with PIT. It is an abstract object, meaning that you can't instantiate it. But it is not final, so it's allowed to create a new object that inherits from `PIT_MODULE`. By this, two goals are achieved:

1.  PIT is able to recognize new modules automatically as they can be found in view `USER_TYPES`. They share the same attribute `PIT_MODULE` as their supertype.

2.  As all output module inherit from `PIT_MODULE`, they all have the methods defined at `PIT_MODULE`. This way, calling any output module automatically implements all relevant `PIT` methods. Only those methods you require are overwritten by you to make sure your output module works as expected.

You start by examining `PIT_MODULE`. Make yourself familiar with the methods available. Here is a short overview:
- `context_changed`
This method is called if a context switch was detected. It is rarely used, but I implement it in a test output module to document that changing the context does call those methods.
- `log`
This method is the core logging methods for all errors, warnings, debug messages and so on. If called, it passes the actual instance of `MESSAGE_TYPE` to allow you to work with the message.
- `print`
This method is called if a message is passed to the UI.
- `notify`
This method is used to pass status messages and notifications. For web application output modules, it was thought to be used with WebSocket servers to immediately pass small information chunks to the frontend.
- `enter` and `leave`
These methods trace entering and leaving a method. They pass an instance of `CALL_STACK_TYPE` with further information on the method.
- `purge`
Use this to purge to log. Two parameters, a date up to which all log entries are to be purged and a severity filter allow for fine grained purging.

To create your own output module, you only overwrite the methods you need. Examine this example to understand how this is done:

```
create or replace type pit_file under pit_module(
  overriding member procedure log(
    p_message in message_type),
  overriding member procedure purge(
    p_purge_date in date,
    p_severity_greater_equal in integer default null),
  overriding member procedure enter(
    p_call_stack in call_stack_type),
  overriding member procedure leave(
    p_call_stack in call_stack_type),
  constructor function pit_file(
    self in out nocopy pit_file)
    return self as result)
  final instantiable;
/
```
Simply replace the module name with your name and make sure that the constructor method returns the correct object type.

## Implementing your own funcitionalty

My approach to implement functionality is to write stubs within the type body that simply call a package with the respective functionality. I do this because the object features are not as strong as the PL/SQL package features. No private methods or attributes are allowed and other restrictions apply. Therefore, delegating the implementation to a separate package does make sense.

So this is the implementation of the `PIT_FILE` output module:

´´´
create or replace type body pit_file
as
  overriding member procedure log(
    p_message in message_type)
  as
  begin
    if p_message.severity <= fire_threshold then
      pit_file_pkg.log(p_message);
    end if;
  end log;

  overriding member procedure purge(
    p_purge_date in date,
    p_severity_greater_equal in integer default null)
  as
  begin
    pit_file_pkg.purge;
  end purge;

  overriding member procedure enter(
    p_call_stack in call_stack_type)
  as
  begin
    pit_file_pkg.enter(p_call_stack);
  end enter;

  overriding member procedure leave(
    p_call_stack in call_stack_type)
  as
  begin
    pit_file_pkg.leave(p_call_stack);
  end leave;

  constructor function pit_file (
    self in out nocopy pit_file)
    return self as result
  as
  begin
    pit_file_pkg.initialize_module(self);
    return;
  end pit_file;
end;
/
´´´

Implementing package `PIT_FILE` is not special by any means. It's a simple PL/SQL package working with the messages. There's only one thing to obey: `PIT` takes care of the transaction context, as it spans an autonomous transaction for each call. So you don't have to and shouldn't include any transaction control within this output module. Write to a table if you like and `PIT` will take care of the `commit` for you.

## Parameters

Any output module should have at least one parameter that controls a fire threshold for that module. Create this parameter by calling `admin_param.merge_parameter` method. But you're free to add any number of parameters to your output module. There is no restriction of what you do with the message. Write an incident at JIRA, send mails, do whatever you like. The only thing to keep in mind is performance. But if a severe error occurs, performance is probable your least problem.

If you want to learn about how output modules are created, simply review the ones delivered with `PIT`. You will quickly get the idea and understand that there's nothing special about it.
