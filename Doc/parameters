# Working with Parameters

`PIT` encloses a parameter package that is capable of handling your parameter settings even outside the scope of `PIT`. The basic principle behind the parameter package is to provide a solution that enables you to store parameter values at a central place while at the same time maintain mandator specific parameter values. Plus, it allows to provide parameter values per environment, giving you the possibility to maintain different URLs or other parameter values for development, test, pre-prod and prod environments for example.

Parameters are named entities, organized into parameter groups. Each parameter may have a string(CLOB), XMLType, raw, integer, float, date, timestamp or boolean value. Their names must be unique within the parameter group. To allow for mandator-aware parameters, two tables exist to persist the parameter values. The default values of a parameter are stored in table `PARAMETER_TAB`, located at the installation user of `PIT`. If you install a `PIT` client, there will also be a table `PARAMETER_LOCAL` created for the client user. A view called `PARAMTER_VW` integrates those two tables, giving a local parameter precedence over the default parameter value. This way, you can savely deploy all your default parameter values because those won't overwrite the local parameter settings made by the client.

However, the `PIT`owner also has access to a `PARAMETER_LOCAL` table which will work as explained for the client. This is necessary in case you don't want to install a `PIT` client but simply work from one user. But there is another functionality added to the `PARAMETER_LOCAL` table of the `PIT` owner. It allows to store realm-aware parameter values. A realm in the context of `PIT` is a way of organizing layered structures, such as a development, test, pre-prod or prod environment. You are free to choose any structure you like but those four values come predefined with `PIT`. You can rename them, throw them away or do whatever you like with them. The idea behind a realm is that this way you can provide different parameter values from a central place to various environments, e.g. for a WebService URL or similar.

To make an environment active, you simply adjust the value of parameter `REALM` in parameter group `PIT` to one of the predefined values. The changes take place immediately.

## `PARAM_ADMIN` vs. `PARAM` packages

Parameters are maintained using package `PARAM_ADMIN`. This package allows you to create, maintain and export parameter values. If you use the `PIT` APEX application, you have the possibility to declare parameters and their values using this UI. It also allows to select one or more parameter groups to be exported. This will create a zip file containing scripts for the parameters. If you defined realm values for a given parameter, those will be included in the download file as well.

The `PARAM` package on the other hand is used to handle local parametes. There is no UI support for setting those local parameters yet, but you can export all local parameters using the UI. Be aware thought that this will only export the parameters which are locally defined at the user of the APEX workspace running the UI, so this will not be the right place to export them probably. Instead, you simply call the `param.set_<datype>` methods to set a local parameter and the `param.get_<datatype>` to retrieve the actually valid value (local or default). Plus, you can call method `param.get_parameters` at any `PIT` client to retrieve all locally defined parameters as a CLOB script file.

## Parameter views

In a relational database, it is a perfect idea to access parameter values using a view. This view is called `PARAMETER_VW` and is installed with any `PIT` (client) installation. This view will give you the most accurate parameter value for your environment, giving precedence to local parameters, obtaining the realm you have set or the default value, should no other option apply.

Alternatively, you can access parameter values via the `param.get_<datatype>` methods from within PL/SQL. 
