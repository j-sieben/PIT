# Troubleshooting

As a rule, `PIT` runs stably and does not require any special attention. However, there may be situations where PIT does not work as desired and it seems unclear what the reason for this is.

## During development

`PIT` uses the package `MSG` to provide all messages with a corresponding constant. These constants allow the compiler to check for spelling errors and are therefore an important means of increasing code quality. The use of this package has however also the disadvantage that thereby a dependence of other packages to this package is developed.

This is especially true during development time, when messages are added and the `MSG` package is therefore rebuilt more often. This compilation may not be possible if other packages that use `MSG` are in use during the time of compilation. It is therefore advisable to create new messages when no longer running anwnedes of other developers could delay the creation.

If other components of `PIT` are recompiled, for example the supplied object types, `PIT` may no longer show any reaction. In these cases it is usually helpful to reinitialize `PIT`. This can be done in two ways:

1. By the method `pit.initialize`. This method reloads the central parameters of `PIT` and instantiates all output modules again.
2. by the `utl_context.reset_context(false)` method. This method clears the central memory of `PIT`, so the call of this method should always be followed by the call of the `pit.initialize` method. Calling this method resets `PIT` to a defined initial state. Running sessions that have used different debug settings are reset to the default settings.

Another problem can occur when `PIT` is used with external processes that build a connection pool, such as APEX. These sessions may also use `PIT` and prevent recompilation of the code. In particularly persistent cases, it may be useful to restart these services. In the case of APEX, this would be possible by restarting `ORDS`, which terminates and reestablishes the existing connections. After that the compilation of `PIT` is safely done.

Note that the parameters are stored in a table, but are also cached in global variables by `PIT`. Therefore, it is possible that a parameter change in the table does not immediately affect `PIT`. In these cases it is necessary to reinitialize `PIT`. Thereby all parameter values are read again and considered accordingly. Since the output modules are also newly instantiated in these cases, parameter values of these output modules are also updated by this action.

## During production

On test and production environments, `PIT` is normally not expected to misbehave because the discussed problematic situations do not occur here. No new messages are created and `PIT` components are not recompiled. These two reasons are the most important stressors for the operational readiness of `PIT` that I know of. However, if problems do occur on production environments, the procedure described above is applicable here as well. No data can be lost by the re-initialization, only the parameters and the global context are reinitialized.
