# Interface changes
For quite a long time, the interface of `PIT` remained mostly unchanged with the exception of some deprecated methods for which I provided better names.

This has changed partly but it will be easy for you to adopt, as most of the changes are only of interest if you developed your own output modules.

## Raising Errors
One point where the interface has changed is when raising errors from within your code. In earlier versions you had a list of methods named after their severity, e.g. `pit.error` to throw an error. 
This has changed as I noticed that for many developers it is hard to guess what the difference between `pit.info` and `pit.notify` is. To make things clearer, raising something is now called
`pit.raise_...`, e.g. `pit.raise_error` to raise an error.

## Severities
One important change is related to error severities. We had a discussion at a project where I learnt that my colleagues had a different understanding of fatal errors then I had: They wanted to be able
to distinguish between expected errors and more severe, but also expected errors. I had an understanding that an error is an expected exception, whereas a fatal is an unexpected, techical error. I learnt that 
there are very good arguments for the position of my colleagues. As I don't use the level `OFF` (errors are always logged and cannot be switched off), I decided to reorder the severities on the most severe end:

-  `FATAL`: This is the most severe error. It replaces `OFF`
-  `SEVERE`: A severe error where you can react to differently
-  `ERROR`: A "normal" error. From here on all severeties remain unchanged.

I also added new communication channels for output modules named `HANDLE_VALIDATION` and `PANIC`. This offers another great advantage, as a message with severeity `ERROR` can now be treated as a validation
and thus being shown on the GUI only but not persisted as a normal exception would. `HANDLE_EXCEPTION` remains the normal channel for writing error to the output modules and `PANIC` is reserved for unexpected,
unrecoverable errors.

## Output Modules
The output modules had overloaded `log` methods in earlier versions, one for logging messages and another for logging state information. As I added even more `log`-variants, I decided to rename those 
methods to `log_exception` and `log_state` respectively. The added method is `log_validation` which serves as a lightweight addendum to `log_exception` to allow output modules to distinguish between
GUI validation and "real" exceptions. Plus, I added a `panic` method for technical, unforeseen errors to make it easy to implement an escalation system for those errors.

I also changed method `purge` to `putge_log` to clearify what the method does.
