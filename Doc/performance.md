# `PIT` Performance

The design of `PIT` is such that only minimal influence on the overall performance should occur. This is achieved by storing actual settings in globally accessed contexts, minimizing all work that needs to be done by implementing a fine granular parameter system and other enhancements, such as tightly focussed autonomous transactions and the like. Nevertheless, the old performance tuner wisdom "How can I make things go faster ? - Don't!" still applies. So in the context of `PIT` this means: Code with `PIT` is slower than without `PIT`. Code that has switched on every bell and whistle of `PIT` is slower than Code that only uses minimal error logging.

The main question is: Are you able to achieve the same functionality with less influence on performance? By that I mean: Are you able to get translatable messages, clean code, flexible code assertions and user messages, close to complete code instrumentation, enhanced debugging options even on production systems at less cost? If so, use this approach and discard `PIT`. But please let me know ... Of course there may be room for performance enhancements in the actual version of `PIT`. Feel free to inform me about it and I will do my best to implement it.

## `PIT` and conditional compilation
Following the performance tuner wisdom, there's one approach many debug systems take: conditional compilation. Conditional compilation means that portions of the code are compiled only when a boolean expression is met. For the compiler, only simple boolean constants are available to take that decision. Many of you may know conditional compilation to write database version-aware code. This is achieved by referencing package `dbms_db_version` which consists of some boolean constants indicating the version of the databse. I implemented a similar system, located at package specification `pit_admin`. Before I explain how to use it, I would like to share with you some thoughts on whether or not you should use this feature. 

If you implement this feature, you need to recompile those units with different criteria settings. Compiling code on a production system is not easy, as other sessions may be using an instance of your code. Therefore it's not known as a best practice to rely on conditional compilation to switch on or off certain features. It has its place for database version aware coding, as it allows you to use a package that exists in newer versions of the database only and fall back to another piece of code should the version of the database be older. Switching on and off features based on this technology is another story. At least you should take care on limiting the bad influence of recompiling to an absolute minimum and recompile on a production system as seldomly as possible.

That said, `PIT` implements conditional compilation to switch functionality off and on. The flags are defined as boolean constants in package `pit_admin`. This package was chosen because in a production system it is seldomly or never used and may be recompiled without problems. If you change these parameters, you change the specification of a package, which normally causes all packages that reference this package to recompile as well. This is called a dependency chain. Changing `pit_admin` will not have negative impact as no dependency chain exists for this package.

Changing these parameters, on the other hand, does not mean that you already changed the behaviour of `PIT`. If you change the settings in `pit_admin`, you still need to recompile `pit` package body. Important here is that you don't need to recompile the package specification of `pit`, as this package will be heavily referenced throughout your code. We simply change the implementation but not the specification of the package, circumventing any negative dependency chain impact. Nevertheless, you have to make sure that any instances of `pit` get recompiled after changing conditional criteria in `pit_admin`.

## What conditional compilation changes in `PIT`

The idea behind these conditional switches is simple: We replace the implementation of some public API methods of `PIT` with functionless stubs. Settings affect only those methods which can savely be switched off without negatively affecting the code's behaviour. This means that it's possible to switch tracing on and off on any given level, but error logging only from `VERBOSE` to `WARN` but no further. This is to assure that errors still get thrown.

Remember that you can switch on and off all aspects of tracing and logging by setting contexts to the appropriate values. The difference is that in this case `PIT` still needs to decide whether it has to throw an event or not. This requires `PIT` to ask the global context for the active settings and decide based on that. If you choose to switch this functionality off using conditional compilation, the code even don't try to raise a given event, as the public method is implemented as a stub. Obviously, there is not way to switch this functionality on besides recompiling the code with different conditional switches.

Package `pit_admin`defines the following switches to control conditional compilation within `PIT`:

```
c_level_le_warn constant boolean := TRUE;`
c_level_le_info constant boolean := TRUE;
c_level_le_debug constant boolean := TRUE;
c_level_le_all constant boolean := TRUE;
  
c_trace_le_off constant boolean := TRUE;
c_trace_le_mandatory constant boolean := TRUE;
c_trace_le_optional constant boolean := TRUE;
c_trace_le_detailed constant boolean := TRUE;
c_trace_le_all constant boolean := TRUE;
```

If you want to change the standard behaviour which implements all functionality, make sure to change TRUE to FALSE on the level you don't want to implement and any higher level. So fi if you want to discard any tracing that is not mandatory, change flags `c_trace_le_optional`, `c_trace_le_detailed` and `c_trace_le_all` to FALSE, recompile package specification and body of `pit_admin` and package body `pit_admin`.

Methods `pit.enter`and `pit.leave` are seen as level `TRACE_ALL` so make sure that you choose the specialized enter methods `pit.enter_mandatory` etc. over the generic ones to make full use of this functionality. The same applies to `pit.log` instead of `pit.info` and the like. This is because the `pit.log` methods decide upon parameter `p_severity` passed in whether they fire or not. So this means that there is no generic way of implementing conditional compilation for these methods easily. As a result, these methods fire anyway.

## Recommendation for conditional compilation

My recommendation would be to go for the context way as long as performance is acceptable. Only if you encounter serious performance issues which can be deducted to `PIT` method calls, think about switching certain functionality off using conditional compilation. Remember that this decision is global for your `PIT` implementation and can't be overwritten by any context parameter afterwards. So if you need to switch logging on at a later time, this won't be possible without recompiling your code.

## Native Compilation

As reports from the hierarchical profiler proof, `PIT` relies heavily on PL/SQL and less than 5% of it's execution time is spent doing SQL. Measurements vary based on the list of output modules and the work they need to do but they give a good indication on what the general balance between the envrionments is.

Code that prominently works in PL/SQL will benefit from native compilation. Before version 11g, that was a tough one, but now, with `PLSQL_CODE_TYPE` set to `NATIVE`, nothing prevents you from boosting `PIT` performance. I strongly advise you to use this feature for `PIT`. In the installation script, this settings is changed for your session. Also, the installation script sets parameter `PLSQL_OPTIMIZE_LEVEL` to 2 to allow for further code enhancements.
