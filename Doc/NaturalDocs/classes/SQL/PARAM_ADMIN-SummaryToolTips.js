﻿NDSummary.OnToolTipsLoaded("SQLClass:PARAM_ADMIN",{776:"<div class=\"NDToolTip TClass LSQL\"><div class=\"TTSummary\">Package to maintain settings for parameter groups</div></div>",778:"<div class=\"NDToolTip TFunction LSQL\"><div id=\"NDPrototype778\" class=\"NDPrototype WideForm\"><div class=\"PSection PParameterSection PascalStyle\"><table><tr><td class=\"PBeforeParameters\"><span class=\"SHKeyword\">procedure</span> set_import_mode(</td><td class=\"PParametersParentCell\"><table class=\"PParameters\"><tr><td class=\"PName first\">p_mode&nbsp;</td><td class=\"PType last\"><span class=\"SHKeyword\">in boolean</span></td></tr></table></td><td class=\"PAfterParameters\">)</td></tr></table></div></div><div class=\"TTSummary\">Method sets the package to import mode to allow for import of non modifiable parameters.</div></div>",779:"<div class=\"NDToolTip TFunction LSQL\"><div id=\"NDPrototype779\" class=\"NDPrototype WideForm\"><div class=\"PSection PParameterSection PascalStyle\"><table><tr><td class=\"PBeforeParameters\"><span class=\"SHKeyword\">function</span> get_parameter_settings(</td><td class=\"PParametersParentCell\"><table class=\"PParameters\"><tr><td class=\"PName first\">p_par_id&nbsp;</td><td class=\"PType last\"><span class=\"SHKeyword\">in</span> parameter_v.par_id<span class=\"SHKeyword\">%type</span>,</td></tr><tr><td class=\"PName first\">p_pgr_id&nbsp;</td><td class=\"PType last\"><span class=\"SHKeyword\">in</span> parameter_group.pgr_id<span class=\"SHKeyword\">%type</span></td></tr></table></td><td class=\"PAfterParameters\">)</td></tr></table></div><div class=\"PSection PPlainSection\"><span class=\"SHKeyword\">return</span> parameter_v<span class=\"SHKeyword\">%rowtype</span></div></div><div class=\"TTSummary\">Reads metadata for parameters. Is called to read settings regarding modifiability etc. Is used internally and from PARAM pkg</div></div>",780:"<div class=\"NDToolTip TFunction LSQL\"><div id=\"NDPrototype780\" class=\"NDPrototype WideForm\"><div class=\"PSection PParameterSection PascalStyle\"><table><tr><td class=\"PBeforeParameters\"><span class=\"SHKeyword\">procedure</span> validate_parameter_group(</td><td class=\"PParametersParentCell\"><table class=\"PParameters\"><tr><td class=\"PName first\">p_row&nbsp;</td><td class=\"PType last\"><span class=\"SHKeyword\">in</span> parameter_group<span class=\"SHKeyword\">%rowtype</span></td></tr></table></td><td class=\"PAfterParameters\">)</td></tr></table></div></div><div class=\"TTSummary\">Method to validate a parameter group entry prior to writing it to db</div></div>",781:"<div class=\"NDToolTip TFunction LSQL\"><div id=\"NDPrototype781\" class=\"NDPrototype WideForm\"><div class=\"PSection PParameterSection PascalStyle\"><table><tr><td class=\"PBeforeParameters\"><span class=\"SHKeyword\">procedure</span> edit_parameter_group(</td><td class=\"PParametersParentCell\"><table class=\"PParameters\"><tr><td class=\"PName first\">p_pgr_id&nbsp;</td><td class=\"PType\"><span class=\"SHKeyword\">in</span> parameter_group.pgr_id<span class=\"SHKeyword\">%type</span>,</td><td></td><td class=\"last\"></td></tr><tr><td class=\"PName first\">p_pgr_description&nbsp;</td><td class=\"PType\"><span class=\"SHKeyword\">in</span> parameter_group.pgr_description<span class=\"SHKeyword\">%type</span>,</td><td></td><td class=\"last\"></td></tr><tr><td class=\"PName first\">p_pgr_is_modifiable&nbsp;</td><td class=\"PType\"><span class=\"SHKeyword\">in boolean</span></td><td class=\"PDefaultValueSeparator\">&nbsp;<span class=\"SHKeyword\">default</span>&nbsp;</td><td class=\"PDefaultValue last\">true</td></tr></table></td><td class=\"PAfterParameters\">)</td></tr></table></div></div><div class=\"TTSummary\">Method to change the definition of a parameter group.</div></div>",782:"<div class=\"NDToolTip TFunction LSQL\"><div id=\"NDPrototype782\" class=\"NDPrototype WideForm\"><div class=\"PSection PParameterSection PascalStyle\"><table><tr><td class=\"PBeforeParameters\"><span class=\"SHKeyword\">procedure</span> edit_parameter_group(</td><td class=\"PParametersParentCell\"><table class=\"PParameters\"><tr><td class=\"PName first\">p_row&nbsp;</td><td class=\"PType last\"><span class=\"SHKeyword\">in</span> parameter_group<span class=\"SHKeyword\">%rowtype</span></td></tr></table></td><td class=\"PAfterParameters\">)</td></tr></table></div></div><div class=\"TTSummary\">Method to change the definition of a parameter group.</div></div>",783:"<div class=\"NDToolTip TFunction LSQL\"><div id=\"NDPrototype783\" class=\"NDPrototype WideForm\"><div class=\"PSection PParameterSection PascalStyle\"><table><tr><td class=\"PBeforeParameters\"><span class=\"SHKeyword\">procedure</span> delete_parameter_group(</td><td class=\"PParametersParentCell\"><table class=\"PParameters\"><tr><td class=\"PName first\">p_pgr_id&nbsp;</td><td class=\"PType\"><span class=\"SHKeyword\">in</span> parameter_group.pgr_id<span class=\"SHKeyword\">%type</span>,</td><td></td><td class=\"last\"></td></tr><tr><td class=\"PName first\">p_force&nbsp;</td><td class=\"PType\"><span class=\"SHKeyword\">in boolean</span></td><td class=\"PDefaultValueSeparator\">&nbsp;<span class=\"SHKeyword\">default</span>&nbsp;</td><td class=\"PDefaultValue last\">false</td></tr></table></td><td class=\"PAfterParameters\">)</td></tr></table></div></div><div class=\"TTSummary\">Method to delete a parameter group.</div></div>",784:"<div class=\"NDToolTip TFunction LSQL\"><div id=\"NDPrototype784\" class=\"NDPrototype WideForm\"><div class=\"PSection PParameterSection PascalStyle\"><table><tr><td class=\"PBeforeParameters\"><span class=\"SHKeyword\">procedure</span> harmonize_parameter_group(</td><td class=\"PParametersParentCell\"><table class=\"PParameters\"><tr><td class=\"PName first\">p_pgr_id&nbsp;</td><td class=\"PType last\"><span class=\"SHKeyword\">in</span> parameter_group.pgr_id<span class=\"SHKeyword\">%type</span></td></tr></table></td><td class=\"PAfterParameters\">)</td></tr></table></div></div><div class=\"TTSummary\">Method to harmonize local and default parameters after import.</div></div>",785:"<div class=\"NDToolTip TFunction LSQL\"><div id=\"NDPrototype785\" class=\"NDPrototype WideForm\"><div class=\"PSection PParameterSection PascalStyle\"><table><tr><td class=\"PBeforeParameters\"><span class=\"SHKeyword\">procedure</span> edit_parameter_realm(</td><td class=\"PParametersParentCell\"><table class=\"PParameters\"><tr><td class=\"PName first\">p_pre_id&nbsp;</td><td class=\"PType\"><span class=\"SHKeyword\">in</span> parameter_realm.pre_id<span class=\"SHKeyword\">%type</span>,</td><td></td><td class=\"last\"></td></tr><tr><td class=\"PName first\">p_pre_description&nbsp;</td><td class=\"PType\"><span class=\"SHKeyword\">in</span> parameter_realm.pre_description<span class=\"SHKeyword\">%type</span>,</td><td></td><td class=\"last\"></td></tr><tr><td class=\"PName first\">p_pre_is_active&nbsp;</td><td class=\"PType\"><span class=\"SHKeyword\">in boolean</span></td><td class=\"PDefaultValueSeparator\">&nbsp;<span class=\"SHKeyword\">default</span>&nbsp;</td><td class=\"PDefaultValue last\">true</td></tr></table></td><td class=\"PAfterParameters\">)</td></tr></table></div></div><div class=\"TTSummary\">Method to change the definition of a parameter realm.</div></div>",786:"<div class=\"NDToolTip TFunction LSQL\"><div id=\"NDPrototype786\" class=\"NDPrototype WideForm\"><div class=\"PSection PParameterSection PascalStyle\"><table><tr><td class=\"PBeforeParameters\"><span class=\"SHKeyword\">procedure</span> edit_parameter_realm(</td><td class=\"PParametersParentCell\"><table class=\"PParameters\"><tr><td class=\"PName first\">p_row&nbsp;</td><td class=\"PType last\"><span class=\"SHKeyword\">in</span> parameter_realm<span class=\"SHKeyword\">%rowtype</span></td></tr></table></td><td class=\"PAfterParameters\">)</td></tr></table></div></div><div class=\"TTSummary\">Method to change the definition of a parameter realm.</div></div>",787:"<div class=\"NDToolTip TFunction LSQL\"><div id=\"NDPrototype787\" class=\"NDPrototype WideForm\"><div class=\"PSection PParameterSection PascalStyle\"><table><tr><td class=\"PBeforeParameters\"><span class=\"SHKeyword\">procedure</span> delete_parameter_realm(</td><td class=\"PParametersParentCell\"><table class=\"PParameters\"><tr><td class=\"PName first\">p_pre_id&nbsp;</td><td class=\"PType\"><span class=\"SHKeyword\">in</span> parameter_realm.pre_id<span class=\"SHKeyword\">%type</span>,</td><td></td><td class=\"last\"></td></tr><tr><td class=\"PName first\">p_force&nbsp;</td><td class=\"PType\"><span class=\"SHKeyword\">in boolean</span></td><td class=\"PDefaultValueSeparator\">&nbsp;<span class=\"SHKeyword\">default</span>&nbsp;</td><td class=\"PDefaultValue last\">false</td></tr></table></td><td class=\"PAfterParameters\">)</td></tr></table></div></div><div class=\"TTSummary\">Method to delete a parameter realm</div></div>",788:"<div class=\"NDToolTip TFunction LSQL\"><div id=\"NDPrototype788\" class=\"NDPrototype WideForm\"><div class=\"PSection PParameterSection PascalStyle\"><table><tr><td class=\"PBeforeParameters\"><span class=\"SHKeyword\">procedure</span> edit_parameter_type(</td><td class=\"PParametersParentCell\"><table class=\"PParameters\"><tr><td class=\"PName first\">p_pat_id&nbsp;</td><td class=\"PType last\"><span class=\"SHKeyword\">in</span> parameter_type.pat_id<span class=\"SHKeyword\">%type</span>,</td></tr><tr><td class=\"PName first\">p_pat_description&nbsp;</td><td class=\"PType last\"><span class=\"SHKeyword\">in</span> parameter_type.pat_description<span class=\"SHKeyword\">%type</span></td></tr></table></td><td class=\"PAfterParameters\">)</td></tr></table></div></div><div class=\"TTSummary\">Method to edit the definition of a parameter type.</div></div>",789:"<div class=\"NDToolTip TFunction LSQL\"><div id=\"NDPrototype789\" class=\"NDPrototype WideForm\"><div class=\"PSection PParameterSection PascalStyle\"><table><tr><td class=\"PBeforeParameters\"><span class=\"SHKeyword\">procedure</span> validate_parameter(</td><td class=\"PParametersParentCell\"><table class=\"PParameters\"><tr><td class=\"PName first\">p_row&nbsp;</td><td class=\"PType last\"><span class=\"SHKeyword\">in</span> parameter_v<span class=\"SHKeyword\">%rowtype</span></td></tr></table></td><td class=\"PAfterParameters\">)</td></tr></table></div></div><div class=\"TTSummary\">Method to validate a parameter if a validation string exists</div></div>",790:"<div class=\"NDToolTip TFunction LSQL\"><div id=\"NDPrototype790\" class=\"NDPrototype WideForm\"><div class=\"PSection PParameterSection PascalStyle\"><table><tr><td class=\"PBeforeParameters\"><span class=\"SHKeyword\">procedure</span> edit_parameter(</td><td class=\"PParametersParentCell\"><table class=\"PParameters\"><tr><td class=\"PName first\">p_par_id&nbsp;</td><td class=\"PType\"><span class=\"SHKeyword\">in</span> parameter_tab.par_id<span class=\"SHKeyword\">%type</span>,</td><td></td><td class=\"last\"></td></tr><tr><td class=\"PName first\">p_par_pgr_id&nbsp;</td><td class=\"PType\"><span class=\"SHKeyword\">in</span> parameter_tab.par_pgr_id<span class=\"SHKeyword\">%type</span>,</td><td></td><td class=\"last\"></td></tr><tr><td class=\"PName first\">p_par_description&nbsp;</td><td class=\"PType\"><span class=\"SHKeyword\">in</span> parameter_tab.par_description<span class=\"SHKeyword\">%type</span></td><td class=\"PDefaultValueSeparator\">&nbsp;<span class=\"SHKeyword\">default</span>&nbsp;</td><td class=\"PDefaultValue last\"><span class=\"SHKeyword\">null</span>,</td></tr><tr><td class=\"PName first\">p_par_string_value&nbsp;</td><td class=\"PType\"><span class=\"SHKeyword\">in</span> parameter_tab.par_string_value<span class=\"SHKeyword\">%type</span></td><td class=\"PDefaultValueSeparator\">&nbsp;<span class=\"SHKeyword\">default</span>&nbsp;</td><td class=\"PDefaultValue last\"><span class=\"SHKeyword\">null</span>,</td></tr><tr><td class=\"PName first\">p_par_xml_value&nbsp;</td><td class=\"PType\"><span class=\"SHKeyword\">in</span> parameter_tab.par_xml_value<span class=\"SHKeyword\">%type</span></td><td class=\"PDefaultValueSeparator\">&nbsp;<span class=\"SHKeyword\">default</span>&nbsp;</td><td class=\"PDefaultValue last\"><span class=\"SHKeyword\">null</span>,</td></tr><tr><td class=\"PName first\">p_par_integer_value&nbsp;</td><td class=\"PType\"><span class=\"SHKeyword\">in</span> parameter_tab.par_integer_value<span class=\"SHKeyword\">%type</span></td><td class=\"PDefaultValueSeparator\">&nbsp;<span class=\"SHKeyword\">default</span>&nbsp;</td><td class=\"PDefaultValue last\"><span class=\"SHKeyword\">null</span>,</td></tr><tr><td class=\"PName first\">p_par_float_value&nbsp;</td><td class=\"PType\"><span class=\"SHKeyword\">in</span> parameter_tab.par_float_value<span class=\"SHKeyword\">%type</span></td><td class=\"PDefaultValueSeparator\">&nbsp;<span class=\"SHKeyword\">default</span>&nbsp;</td><td class=\"PDefaultValue last\"><span class=\"SHKeyword\">null</span>,</td></tr><tr><td class=\"PName first\">p_par_date_value&nbsp;</td><td class=\"PType\"><span class=\"SHKeyword\">in</span> parameter_tab.par_date_value<span class=\"SHKeyword\">%type</span></td><td class=\"PDefaultValueSeparator\">&nbsp;<span class=\"SHKeyword\">default</span>&nbsp;</td><td class=\"PDefaultValue last\"><span class=\"SHKeyword\">null</span>,</td></tr><tr><td class=\"PName first\">p_par_timestamp_value&nbsp;</td><td class=\"PType\"><span class=\"SHKeyword\">in</span> parameter_tab.par_timestamp_value<span class=\"SHKeyword\">%type</span></td><td class=\"PDefaultValueSeparator\">&nbsp;<span class=\"SHKeyword\">default</span>&nbsp;</td><td class=\"PDefaultValue last\"><span class=\"SHKeyword\">null</span>,</td></tr><tr><td class=\"PName first\">p_par_boolean_value&nbsp;</td><td class=\"PType\"><span class=\"SHKeyword\">in boolean</span></td><td class=\"PDefaultValueSeparator\">&nbsp;<span class=\"SHKeyword\">default</span>&nbsp;</td><td class=\"PDefaultValue last\"><span class=\"SHKeyword\">null</span>,</td></tr><tr><td class=\"PName first\">p_par_is_modifiable&nbsp;</td><td class=\"PType\"><span class=\"SHKeyword\">in boolean</span></td><td class=\"PDefaultValueSeparator\">&nbsp;<span class=\"SHKeyword\">default</span>&nbsp;</td><td class=\"PDefaultValue last\"><span class=\"SHKeyword\">null</span>,</td></tr><tr><td class=\"PName first\">p_par_pat_id&nbsp;</td><td class=\"PType\"><span class=\"SHKeyword\">in</span> parameter_tab.par_pat_id<span class=\"SHKeyword\">%type</span></td><td class=\"PDefaultValueSeparator\">&nbsp;<span class=\"SHKeyword\">default</span>&nbsp;</td><td class=\"PDefaultValue last\"><span class=\"SHKeyword\">null</span>,</td></tr><tr><td class=\"PName first\">p_par_validation_string&nbsp;</td><td class=\"PType\"><span class=\"SHKeyword\">in</span> parameter_tab.par_validation_string<span class=\"SHKeyword\">%type</span></td><td class=\"PDefaultValueSeparator\">&nbsp;<span class=\"SHKeyword\">default</span>&nbsp;</td><td class=\"PDefaultValue last\"><span class=\"SHKeyword\">null</span>,</td></tr><tr><td class=\"PName first\">p_par_validation_message&nbsp;</td><td class=\"PType\"><span class=\"SHKeyword\">in</span> parameter_tab.par_validation_message<span class=\"SHKeyword\">%type</span></td><td class=\"PDefaultValueSeparator\">&nbsp;<span class=\"SHKeyword\">default</span>&nbsp;</td><td class=\"PDefaultValue last\"><span class=\"SHKeyword\">null</span></td></tr></table></td><td class=\"PAfterParameters\">)</td></tr></table></div></div><div class=\"TTSummary\">Method to edit a parameter</div></div>",791:"<div class=\"NDToolTip TFunction LSQL\"><div id=\"NDPrototype791\" class=\"NDPrototype WideForm\"><div class=\"PSection PParameterSection PascalStyle\"><table><tr><td class=\"PBeforeParameters\"><span class=\"SHKeyword\">procedure</span> edit_parameter(</td><td class=\"PParametersParentCell\"><table class=\"PParameters\"><tr><td class=\"PName first\">p_row&nbsp;</td><td class=\"PType last\"><span class=\"SHKeyword\">in</span> parameter_v<span class=\"SHKeyword\">%rowtype</span></td></tr></table></td><td class=\"PAfterParameters\">)</td></tr></table></div></div><div class=\"TTSummary\">Method to edit a parameter</div></div>",792:"<div class=\"NDToolTip TFunction LSQL\"><div id=\"NDPrototype792\" class=\"NDPrototype WideForm\"><div class=\"PSection PParameterSection PascalStyle\"><table><tr><td class=\"PBeforeParameters\"><span class=\"SHKeyword\">procedure</span> delete_parameter(</td><td class=\"PParametersParentCell\"><table class=\"PParameters\"><tr><td class=\"PName first\">p_par_id&nbsp;</td><td class=\"PType last\"><span class=\"SHKeyword\">in</span> parameter_tab.par_id<span class=\"SHKeyword\">%type</span>,</td></tr><tr><td class=\"PName first\">p_par_pgr_id&nbsp;</td><td class=\"PType last\"><span class=\"SHKeyword\">in</span> parameter_tab.par_pgr_id<span class=\"SHKeyword\">%type</span></td></tr></table></td><td class=\"PAfterParameters\">)</td></tr></table></div></div><div class=\"TTSummary\">Method to delete a parameter</div></div>",793:"<div class=\"NDToolTip TFunction LSQL\"><div id=\"NDPrototype793\" class=\"NDPrototype WideForm\"><div class=\"PSection PParameterSection PascalStyle\"><table><tr><td class=\"PBeforeParameters\"><span class=\"SHKeyword\">procedure</span> validate_realm_parameter(</td><td class=\"PParametersParentCell\"><table class=\"PParameters\"><tr><td class=\"PName first\">p_row&nbsp;</td><td class=\"PType last\"><span class=\"SHKeyword\">in out nocopy</span> parameter_v<span class=\"SHKeyword\">%rowtype</span></td></tr></table></td><td class=\"PAfterParameters\">)</td></tr></table></div></div><div class=\"TTSummary\">Method to validate a realm based parameter if a validation string exists.</div></div>",794:"<div class=\"NDToolTip TFunction LSQL\"><div id=\"NDPrototype794\" class=\"NDPrototype WideForm\"><div class=\"PSection PParameterSection PascalStyle\"><table><tr><td class=\"PBeforeParameters\"><span class=\"SHKeyword\">procedure</span> edit_realm_parameter(</td><td class=\"PParametersParentCell\"><table class=\"PParameters\"><tr><td class=\"PName first\">p_par_id&nbsp;</td><td class=\"PType\">parameter_v.par_id<span class=\"SHKeyword\">%type</span>,</td><td></td><td class=\"last\"></td></tr><tr><td class=\"PName first\">p_par_pgr_id&nbsp;</td><td class=\"PType\">parameter_v.par_pgr_id<span class=\"SHKeyword\">%type</span>,</td><td></td><td class=\"last\"></td></tr><tr><td class=\"PName first\">p_par_pre_id&nbsp;</td><td class=\"PType\"><span class=\"SHKeyword\">in</span> parameter_realm.pre_id<span class=\"SHKeyword\">%type</span>,</td><td></td><td class=\"last\"></td></tr><tr><td class=\"PName first\">p_par_string_value&nbsp;</td><td class=\"PType\"><span class=\"SHKeyword\">in</span> parameter_v.par_string_value<span class=\"SHKeyword\">%type</span></td><td class=\"PDefaultValueSeparator\">&nbsp;<span class=\"SHKeyword\">default</span>&nbsp;</td><td class=\"PDefaultValue last\"><span class=\"SHKeyword\">null</span>,</td></tr><tr><td class=\"PName first\">p_par_xml_value&nbsp;</td><td class=\"PType\"><span class=\"SHKeyword\">in</span> parameter_v.par_xml_value<span class=\"SHKeyword\">%type</span></td><td class=\"PDefaultValueSeparator\">&nbsp;<span class=\"SHKeyword\">default</span>&nbsp;</td><td class=\"PDefaultValue last\"><span class=\"SHKeyword\">null</span>,</td></tr><tr><td class=\"PName first\">p_par_integer_value&nbsp;</td><td class=\"PType\"><span class=\"SHKeyword\">in</span> parameter_v.par_integer_value<span class=\"SHKeyword\">%type</span></td><td class=\"PDefaultValueSeparator\">&nbsp;<span class=\"SHKeyword\">default</span>&nbsp;</td><td class=\"PDefaultValue last\"><span class=\"SHKeyword\">null</span>,</td></tr><tr><td class=\"PName first\">p_par_float_value&nbsp;</td><td class=\"PType\"><span class=\"SHKeyword\">in</span> parameter_v.par_float_value<span class=\"SHKeyword\">%type</span></td><td class=\"PDefaultValueSeparator\">&nbsp;<span class=\"SHKeyword\">default</span>&nbsp;</td><td class=\"PDefaultValue last\"><span class=\"SHKeyword\">null</span>,</td></tr><tr><td class=\"PName first\">p_par_date_value&nbsp;</td><td class=\"PType\"><span class=\"SHKeyword\">in</span> parameter_v.par_date_value<span class=\"SHKeyword\">%type</span></td><td class=\"PDefaultValueSeparator\">&nbsp;<span class=\"SHKeyword\">default</span>&nbsp;</td><td class=\"PDefaultValue last\"><span class=\"SHKeyword\">null</span>,</td></tr><tr><td class=\"PName first\">p_par_timestamp_value&nbsp;</td><td class=\"PType\"><span class=\"SHKeyword\">in</span> parameter_v.par_timestamp_value<span class=\"SHKeyword\">%type</span></td><td class=\"PDefaultValueSeparator\">&nbsp;<span class=\"SHKeyword\">default</span>&nbsp;</td><td class=\"PDefaultValue last\"><span class=\"SHKeyword\">null</span>,</td></tr><tr><td class=\"PName first\">p_par_boolean_value&nbsp;</td><td class=\"PType\"><span class=\"SHKeyword\">in boolean</span></td><td class=\"PDefaultValueSeparator\">&nbsp;<span class=\"SHKeyword\">default</span>&nbsp;</td><td class=\"PDefaultValue last\"><span class=\"SHKeyword\">null</span></td></tr></table></td><td class=\"PAfterParameters\">)</td></tr></table></div></div><div class=\"TTSummary\">Sets a realm parameter value.</div></div>",795:"<div class=\"NDToolTip TFunction LSQL\"><div id=\"NDPrototype795\" class=\"NDPrototype WideForm\"><div class=\"PSection PParameterSection PascalStyle\"><table><tr><td class=\"PBeforeParameters\"><span class=\"SHKeyword\">procedure</span> edit_realm_parameter(</td><td class=\"PParametersParentCell\"><table class=\"PParameters\"><tr><td class=\"PName first\">p_row&nbsp;</td><td class=\"PType last\"><span class=\"SHKeyword\">in</span> parameter_v<span class=\"SHKeyword\">%rowtype</span></td></tr></table></td><td class=\"PAfterParameters\">)</td></tr></table></div></div><div class=\"TTSummary\">Sets a realm parameter value.</div></div>",796:"<div class=\"NDToolTip TFunction LSQL\"><div id=\"NDPrototype796\" class=\"NDPrototype WideForm\"><div class=\"PSection PParameterSection PascalStyle\"><table><tr><td class=\"PBeforeParameters\"><span class=\"SHKeyword\">procedure</span> delete_realm_parameter(</td><td class=\"PParametersParentCell\"><table class=\"PParameters\"><tr><td class=\"PName first\">p_par_id&nbsp;</td><td class=\"PType last\">parameter_v.par_id<span class=\"SHKeyword\">%type</span>,</td></tr><tr><td class=\"PName first\">p_par_pgr_id&nbsp;</td><td class=\"PType last\">parameter_v.par_pgr_id<span class=\"SHKeyword\">%type</span>,</td></tr><tr><td class=\"PName first\">p_par_pre_id&nbsp;</td><td class=\"PType last\"><span class=\"SHKeyword\">in</span> parameter_realm.pre_id<span class=\"SHKeyword\">%type</span></td></tr></table></td><td class=\"PAfterParameters\">)</td></tr></table></div></div><div class=\"TTSummary\">Resets a realm parameter to the default value</div></div>",797:"<div class=\"NDToolTip TFunction LSQL\"><div id=\"NDPrototype797\" class=\"NDPrototype WideForm\"><div class=\"PSection PParameterSection PascalStyle\"><table><tr><td class=\"PBeforeParameters\"><span class=\"SHKeyword\">function</span> export_parameter_group(</td><td class=\"PParametersParentCell\"><table class=\"PParameters\"><tr><td class=\"PName first\">p_pgr_id&nbsp;</td><td class=\"PType last\"><span class=\"SHKeyword\">in</span> parameter_group.pgr_id<span class=\"SHKeyword\">%type</span></td></tr></table></td><td class=\"PAfterParameters\">)</td></tr></table></div><div class=\"PSection PPlainSection\"><span class=\"SHKeyword\">return clob</span></div></div><div class=\"TTSummary\">Method to create a script for all parameters within a parameter group as a clob instance.</div></div>"});