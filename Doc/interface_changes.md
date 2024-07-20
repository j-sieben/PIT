# Interface changes
For quite a long time, the interface of `PIT` remained mostly unchanged with the exception of some deprecated methods for which I provided better names.

This has changed partly but it will be easy for you to adopt, as most of the changes are only of interest if you developed your own output modules.

## Raising Errors
One point where the interface has changed is when raising errors from within your code. In earlier versions you had a list of methods named after their severity, e.g. `pit.error` to throw an error. 
This has changed as I noticed that for many developers it is hard to guess what the difference between `pit.info` and `pit.notify` is. To make things clearer, raising something is now called
`pit.raise_...`, e.g. `pit.raise_error` to raise an error.

## Output Modules
The output modules had overloaded `log` methods in earlier versions, one for logging messages and another for logging state information. As I added even more `log`-variants, I decided to rename those 
methods to `log_exception` and `log_state` respectively. The added method is `log_validation` which serves as a lightweight addendum to `log_exception` to allow output modules to distinguish between
GUI validation and "real" exceptions. Plus, I added a `panic` method for technical, unforeseen errors to make it easy to implement an escalation system for those errors.

I also changed method `purge` to `putge_log` to clearify what the method does.
