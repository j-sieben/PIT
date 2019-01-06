# How to work with `dbms_application_info`

`dbms_application_info` is a leightweight option to share information on the execution of code with the developer during execution. It does not incur performance penalties, as the information gathered is stored in memory only. The information is made available by these performance views:

- `V$SESSION`
- `V$SQLAREA`

Additionally, it is possible to report the status of long lasting operations to the database by using the method `dbms_application_info.set_session_longops`. By using this method, a developer reports how many iterations of a total number of iterations is performed. Information about the process of a long lasting operation is available at `V$SESSION_LONGOPS`.

If you want to use this feature, make sure that tracing is set to at least `pit.trace_mandatory`, as the tracing mechanism is required for this feature.

## Basic usage
PIT supports both mechanisms in a user friendly way:

1. Any call to `pit.enter_mandatory` automatically sets `dbms_application_info` to the actual module and method. PIT does not recommend to set `p_module` and `p_action` manually unless there is a strong reason to do so. Internally, PIT uses the package name and method name to maintain the call stack. If you set those parameters manually, they will overwrite what is sent to `dbms_application_info`, giving you the option to provide a more user friendly status on what the code is executing.

2. Any call to the other `pit.enter_%` methods will update `dbms_application_info` only if `p_module` or `p_action` are set manually. As long as a recursive call to ´pit.enter_%` does not change the settings, the application info will stay the same than set when `pit.enter_mandatory` was called.

3. If an application info was overwritten by a call to any `pit.enter_%` and the execution of the call returns to the former method, the former information is restored.

To make use of the `dbms_application_info.set_session_longops` method, call `pit.long_op` in the environment of a method. Make sure that all executions are processed within that method (i.e. call `pit.long_op` in a loop within the execution context of this method). As a minimum, you provide the method with a short description of what you're doing (up to 64 byte) and a number representing the amount of work you did so far in relation to 100. This is sufficient to provide the necessary information for this functionality.

## Extended usage
Should you require more control over the process, there are several options available.

### Options for `dbms_application_info`
As stated, you may control when `dbms_application_info` changes its state by either

- calling `pit.enter_mandatory`
- calling any other `pit.enter_%` method and explicit `p_module`and/or `p_action` parameters.

Additionally, any `pit.enter_%` method supports a parameter called `p_client_info` that allows for additional information showed at `v$session.client_info`. 

### Options for long ops
Method `pit.long_op` provides a total of 5 parameters:

- `p_target` (mandatory): Describes what is performed
- `p_sofar` (mandatory): Defines the percentage of work done so far. As per default, the percentage is calculated relative to 100, meaning that `p_sofar => 100` means completely processed.
- `p_total` (optional, default 100): If you require a different relation system, define what is perceived to be 100%. If you have a column count, you may set this as the 100% mark and pass the row number of the actually processed row as `p_sofar`.
- `p_units` (optional, defaults to 'iterations'): Option to set the units. If you process rows of a table, a message is produced and shown in `V$SESSION_LONGOPS.message`. This message is create using this template: `<OPNAME>: <TARGET>: <SOFAR> out of <TOTAL> <UNITS> done'.
- `p_op_name` (optional, defaults to `<package>.<method>`): Optional information indicating the broader focus of the task to perform.

Oracle utilizes the different parameter like so:

`p_op_name`: Gather Table's Index Statistics
`p_target`: Table DBMS_LOCK_ALLOCATED
`p_sofar`: Amount of indexes processed
`p_total`: Amount of indexes on that table
`p_unit`: Indexes

This then leads to a message like 'Gather Table's Index Statistics: Table DBMS_LOCK_ALLOCATED : 2 out of 3 Indexes done'
