# How to administer `PIT`

`PIT` does not require intensive administration. Once set up, it is mainly controlled by the contexts set up. The main task of the administration is to manage the messages, parameters and translatable items. This work is facilitated by the available APIs of the ADMIN packages.

## Management of messages, parameter groups and translatable items

Messages may be created and managed either by means of a script file or by means of APEX interface available optionally. Created messages are managed either by calling the method 'PIT_ADMIN.create_installation_script' or by a download via the APEX user interface. As a result, a single CLOB instance (calling the method) or a ZIP directory with all selected message groups is created.

If you call the method, a parameter named `p_target` is expected. Valid values are package constants `C_TARGET_PMS | C_TARGET_PTI | C_TARGET_PAR`, where `PMS` stands for `PIT message`, `PTI` means `PIT translatable item` and `PAR` obviously means `PIT parameter`. All of them are further defined by their respective group name, passed in as parameter `p_pmg_name`. While it is possible to write your own code and call the method, calling it via the APEX front end adds some comfort as it wraps more than one group into a ZIP file ready to be copied into a version control system.

## Maintainig logs

Another area of continouus administration is to control the amount of message that get stored in output modules such as `PIT_TABLE`. It is recommended to create a database job to remove unneeded log entries from persistent message stores such as tables or trace files.

