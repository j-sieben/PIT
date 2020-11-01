-- Script to set the folder structure
-- Parameters
-- install folder containing the install.sql file to execute without trailing slash

define install_dir=&1./
define tools=tools/
define pkg_dir=&install_dir.packages/
define view_dir=&install_dir.views/
define table_dir=&install_dir.tables/
define type_dir=&install_dir.types/
define seq_dir=&install_dir.sequences/
define script_dir=&install_dir.scripts/
define msg_dir=&install_dir.messages/&DEFAULT_LANGUAGE./