﻿NDContentPage.OnToolTipsLoaded({736:"<div class=\"NDToolTip TFunction LSQL\"><div id=\"NDPrototype736\" class=\"NDPrototype WideForm\"><div class=\"PSection PParameterSection PascalStyle\"><table><tr><td class=\"PBeforeParameters\"><span class=\"SHKeyword\">function</span> get_parameter_settings(</td><td class=\"PParametersParentCell\"><table class=\"PParameters\"><tr><td class=\"PName first\">p_par_id&nbsp;</td><td class=\"PType last\"><span class=\"SHKeyword\">in</span> parameter_vw.par_id<span class=\"SHKeyword\">%type</span>,</td></tr><tr><td class=\"PName first\">p_pgr_id&nbsp;</td><td class=\"PType last\"><span class=\"SHKeyword\">in</span> parameter_group.pgr_id<span class=\"SHKeyword\">%type</span></td></tr></table></td><td class=\"PAfterParameters\">)</td></tr></table></div><div class=\"PSection PPlainSection\"><span class=\"SHKeyword\">return</span> parameter_vw<span class=\"SHKeyword\">%rowtype</span></div></div><div class=\"TTSummary\">Reads metadata for parameters. Is called to read settings regarding modifiability etc. Is used internally and from PARAM pkg</div></div>",737:"<div class=\"NDToolTip TFunction LSQL\"><div id=\"NDPrototype737\" class=\"NDPrototype WideForm\"><div class=\"PSection PParameterSection PascalStyle\"><table><tr><td class=\"PBeforeParameters\"><span class=\"SHKeyword\">procedure</span> validate_parameter_group(</td><td class=\"PParametersParentCell\"><table class=\"PParameters\"><tr><td class=\"PName first\">p_row&nbsp;</td><td class=\"PType last\"><span class=\"SHKeyword\">in</span> parameter_group<span class=\"SHKeyword\">%rowtype</span></td></tr></table></td><td class=\"PAfterParameters\">)</td></tr></table></div></div><div class=\"TTSummary\">Method to validate a parameter group entry prior to writing it to db</div></div>",738:"<div class=\"NDToolTip TFunction LSQL\"><div id=\"NDPrototype738\" class=\"NDPrototype WideForm\"><div class=\"PSection PParameterSection PascalStyle\"><table><tr><td class=\"PBeforeParameters\"><span class=\"SHKeyword\">procedure</span> edit_parameter_group(</td><td class=\"PParametersParentCell\"><table class=\"PParameters\"><tr><td class=\"PName first\">p_pgr_id&nbsp;</td><td class=\"PType\"><span class=\"SHKeyword\">in</span> parameter_group.pgr_id<span class=\"SHKeyword\">%type</span>,</td><td></td><td class=\"last\"></td></tr><tr><td class=\"PName first\">p_pgr_description&nbsp;</td><td class=\"PType\"><span class=\"SHKeyword\">in</span> parameter_group.pgr_description<span class=\"SHKeyword\">%type</span>,</td><td></td><td class=\"last\"></td></tr><tr><td class=\"PName first\">p_pgr_is_modifiable&nbsp;</td><td class=\"PType\"><span class=\"SHKeyword\">in boolean</span></td><td class=\"PDefaultValueSeparator\">&nbsp;<span class=\"SHKeyword\">default</span>&nbsp;</td><td class=\"PDefaultValue last\">true</td></tr></table></td><td class=\"PAfterParameters\">)</td></tr></table></div></div><div class=\"TTSummary\">Method to change the definition of a parameter group.</div></div>",740:"<div class=\"NDToolTip TFunction LSQL\"><div id=\"NDPrototype740\" class=\"NDPrototype WideForm\"><div class=\"PSection PParameterSection PascalStyle\"><table><tr><td class=\"PBeforeParameters\"><span class=\"SHKeyword\">procedure</span> delete_parameter_group(</td><td class=\"PParametersParentCell\"><table class=\"PParameters\"><tr><td class=\"PName first\">p_pgr_id&nbsp;</td><td class=\"PType\"><span class=\"SHKeyword\">in</span> parameter_group.pgr_id<span class=\"SHKeyword\">%type</span>,</td><td></td><td class=\"last\"></td></tr><tr><td class=\"PName first\">p_force&nbsp;</td><td class=\"PType\"><span class=\"SHKeyword\">in boolean</span></td><td class=\"PDefaultValueSeparator\">&nbsp;<span class=\"SHKeyword\">default</span>&nbsp;</td><td class=\"PDefaultValue last\">false</td></tr></table></td><td class=\"PAfterParameters\">)</td></tr></table></div></div><div class=\"TTSummary\">Method to delete a parameter group.</div></div>",741:"<div class=\"NDToolTip TFunction LSQL\"><div id=\"NDPrototype741\" class=\"NDPrototype WideForm\"><div class=\"PSection PParameterSection PascalStyle\"><table><tr><td class=\"PBeforeParameters\"><span class=\"SHKeyword\">procedure</span> edit_parameter_realm(</td><td class=\"PParametersParentCell\"><table class=\"PParameters\"><tr><td class=\"PName first\">p_pre_id&nbsp;</td><td class=\"PType\"><span class=\"SHKeyword\">in</span> parameter_realm.pre_id<span class=\"SHKeyword\">%type</span>,</td><td></td><td class=\"last\"></td></tr><tr><td class=\"PName first\">p_pre_description&nbsp;</td><td class=\"PType\"><span class=\"SHKeyword\">in</span> parameter_realm.pre_description<span class=\"SHKeyword\">%type</span>,</td><td></td><td class=\"last\"></td></tr><tr><td class=\"PName first\">p_pre_is_active&nbsp;</td><td class=\"PType\"><span class=\"SHKeyword\">in boolean</span></td><td class=\"PDefaultValueSeparator\">&nbsp;<span class=\"SHKeyword\">default</span>&nbsp;</td><td class=\"PDefaultValue last\">true</td></tr></table></td><td class=\"PAfterParameters\">)</td></tr></table></div></div><div class=\"TTSummary\">Method to change the definition of a parameter realm.</div></div>",743:"<div class=\"NDToolTip TFunction LSQL\"><div id=\"NDPrototype743\" class=\"NDPrototype WideForm\"><div class=\"PSection PParameterSection PascalStyle\"><table><tr><td class=\"PBeforeParameters\"><span class=\"SHKeyword\">procedure</span> delete_parameter_realm(</td><td class=\"PParametersParentCell\"><table class=\"PParameters\"><tr><td class=\"PName first\">p_pre_id&nbsp;</td><td class=\"PType\"><span class=\"SHKeyword\">in</span> parameter_realm.pre_id<span class=\"SHKeyword\">%type</span>,</td><td></td><td class=\"last\"></td></tr><tr><td class=\"PName first\">p_force&nbsp;</td><td class=\"PType\"><span class=\"SHKeyword\">in boolean</span></td><td class=\"PDefaultValueSeparator\">&nbsp;<span class=\"SHKeyword\">default</span>&nbsp;</td><td class=\"PDefaultValue last\">false</td></tr></table></td><td class=\"PAfterParameters\">)</td></tr></table></div></div><div class=\"TTSummary\">Method to delete a parameter realm</div></div>",744:"<div class=\"NDToolTip TFunction LSQL\"><div id=\"NDPrototype744\" class=\"NDPrototype WideForm\"><div class=\"PSection PParameterSection PascalStyle\"><table><tr><td class=\"PBeforeParameters\"><span class=\"SHKeyword\">procedure</span> edit_parameter_type(</td><td class=\"PParametersParentCell\"><table class=\"PParameters\"><tr><td class=\"PName first\">p_pat_id&nbsp;</td><td class=\"PType last\"><span class=\"SHKeyword\">in</span> parameter_type.pat_id<span class=\"SHKeyword\">%type</span>,</td></tr><tr><td class=\"PName first\">p_pat_description&nbsp;</td><td class=\"PType last\"><span class=\"SHKeyword\">in</span> parameter_type.pat_description<span class=\"SHKeyword\">%type</span></td></tr></table></td><td class=\"PAfterParameters\">)</td></tr></table></div></div><div class=\"TTSummary\">Method to edit the definition of a parameter type.</div></div>",745:"<div class=\"NDToolTip TFunction LSQL\"><div id=\"NDPrototype745\" class=\"NDPrototype WideForm\"><div class=\"PSection PParameterSection PascalStyle\"><table><tr><td class=\"PBeforeParameters\"><span class=\"SHKeyword\">procedure</span> validate_parameter(</td><td class=\"PParametersParentCell\"><table class=\"PParameters\"><tr><td class=\"PName first\">p_row&nbsp;</td><td class=\"PType last\"><span class=\"SHKeyword\">in</span> parameter_vw<span class=\"SHKeyword\">%rowtype</span></td></tr></table></td><td class=\"PAfterParameters\">)</td></tr></table></div></div><div class=\"TTSummary\">Method to validate a parameter if a validation string exists</div></div>",746:"<div class=\"NDToolTip TFunction LSQL\"><div id=\"NDPrototype746\" class=\"NDPrototype WideForm\"><div class=\"PSection PParameterSection PascalStyle\"><table><tr><td class=\"PBeforeParameters\"><span class=\"SHKeyword\">procedure</span> edit_parameter(</td><td class=\"PParametersParentCell\"><table class=\"PParameters\"><tr><td class=\"PName first\">p_par_id&nbsp;</td><td class=\"PType\"><span class=\"SHKeyword\">in</span> parameter_tab.par_id<span class=\"SHKeyword\">%type</span>,</td><td></td><td class=\"last\"></td></tr><tr><td class=\"PName first\">p_par_pgr_id&nbsp;</td><td class=\"PType\"><span class=\"SHKeyword\">in</span> parameter_tab.par_pgr_id<span class=\"SHKeyword\">%type</span>,</td><td></td><td class=\"last\"></td></tr><tr><td class=\"PName first\">p_par_description&nbsp;</td><td class=\"PType\"><span class=\"SHKeyword\">in</span> parameter_tab.par_description<span class=\"SHKeyword\">%type</span></td><td class=\"PDefaultValueSeparator\">&nbsp;<span class=\"SHKeyword\">default</span>&nbsp;</td><td class=\"PDefaultValue last\"><span class=\"SHKeyword\">null</span>,</td></tr><tr><td class=\"PName first\">p_par_string_value&nbsp;</td><td class=\"PType\"><span class=\"SHKeyword\">in</span> parameter_tab.par_string_value<span class=\"SHKeyword\">%type</span></td><td class=\"PDefaultValueSeparator\">&nbsp;<span class=\"SHKeyword\">default</span>&nbsp;</td><td class=\"PDefaultValue last\"><span class=\"SHKeyword\">null</span>,</td></tr><tr><td class=\"PName first\">p_par_xml_value&nbsp;</td><td class=\"PType\"><span class=\"SHKeyword\">in</span> parameter_tab.par_xml_value<span class=\"SHKeyword\">%type</span></td><td class=\"PDefaultValueSeparator\">&nbsp;<span class=\"SHKeyword\">default</span>&nbsp;</td><td class=\"PDefaultValue last\"><span class=\"SHKeyword\">null</span>,</td></tr><tr><td class=\"PName first\">p_par_integer_value&nbsp;</td><td class=\"PType\"><span class=\"SHKeyword\">in</span> parameter_tab.par_integer_value<span class=\"SHKeyword\">%type</span></td><td class=\"PDefaultValueSeparator\">&nbsp;<span class=\"SHKeyword\">default</span>&nbsp;</td><td class=\"PDefaultValue last\"><span class=\"SHKeyword\">null</span>,</td></tr><tr><td class=\"PName first\">p_par_float_value&nbsp;</td><td class=\"PType\"><span class=\"SHKeyword\">in</span> parameter_tab.par_float_value<span class=\"SHKeyword\">%type</span></td><td class=\"PDefaultValueSeparator\">&nbsp;<span class=\"SHKeyword\">default</span>&nbsp;</td><td class=\"PDefaultValue last\"><span class=\"SHKeyword\">null</span>,</td></tr><tr><td class=\"PName first\">p_par_date_value&nbsp;</td><td class=\"PType\"><span class=\"SHKeyword\">in</span> parameter_tab.par_date_value<span class=\"SHKeyword\">%type</span></td><td class=\"PDefaultValueSeparator\">&nbsp;<span class=\"SHKeyword\">default</span>&nbsp;</td><td class=\"PDefaultValue last\"><span class=\"SHKeyword\">null</span>,</td></tr><tr><td class=\"PName first\">p_par_timestamp_value&nbsp;</td><td class=\"PType\"><span class=\"SHKeyword\">in</span> parameter_tab.par_timestamp_value<span class=\"SHKeyword\">%type</span></td><td class=\"PDefaultValueSeparator\">&nbsp;<span class=\"SHKeyword\">default</span>&nbsp;</td><td class=\"PDefaultValue last\"><span class=\"SHKeyword\">null</span>,</td></tr><tr><td class=\"PName first\">p_par_boolean_value&nbsp;</td><td class=\"PType\"><span class=\"SHKeyword\">in boolean</span></td><td class=\"PDefaultValueSeparator\">&nbsp;<span class=\"SHKeyword\">default</span>&nbsp;</td><td class=\"PDefaultValue last\"><span class=\"SHKeyword\">null</span>,</td></tr><tr><td class=\"PName first\">p_par_is_modifiable&nbsp;</td><td class=\"PType\"><span class=\"SHKeyword\">in boolean</span></td><td class=\"PDefaultValueSeparator\">&nbsp;<span class=\"SHKeyword\">default</span>&nbsp;</td><td class=\"PDefaultValue last\"><span class=\"SHKeyword\">null</span>,</td></tr><tr><td class=\"PName first\">p_par_pat_id&nbsp;</td><td class=\"PType\"><span class=\"SHKeyword\">in</span> parameter_tab.par_pat_id<span class=\"SHKeyword\">%type</span></td><td class=\"PDefaultValueSeparator\">&nbsp;<span class=\"SHKeyword\">default</span>&nbsp;</td><td class=\"PDefaultValue last\"><span class=\"SHKeyword\">null</span>,</td></tr><tr><td class=\"PName first\">p_par_validation_string&nbsp;</td><td class=\"PType\"><span class=\"SHKeyword\">in</span> parameter_tab.par_validation_string<span class=\"SHKeyword\">%type</span></td><td class=\"PDefaultValueSeparator\">&nbsp;<span class=\"SHKeyword\">default</span>&nbsp;</td><td class=\"PDefaultValue last\"><span class=\"SHKeyword\">null</span>,</td></tr><tr><td class=\"PName first\">p_par_validation_message&nbsp;</td><td class=\"PType\"><span class=\"SHKeyword\">in</span> parameter_tab.par_validation_message<span class=\"SHKeyword\">%type</span></td><td class=\"PDefaultValueSeparator\">&nbsp;<span class=\"SHKeyword\">default</span>&nbsp;</td><td class=\"PDefaultValue last\"><span class=\"SHKeyword\">null</span></td></tr></table></td><td class=\"PAfterParameters\">)</td></tr></table></div></div><div class=\"TTSummary\">Method to edit a parameter</div></div>",748:"<div class=\"NDToolTip TFunction LSQL\"><div id=\"NDPrototype748\" class=\"NDPrototype WideForm\"><div class=\"PSection PParameterSection PascalStyle\"><table><tr><td class=\"PBeforeParameters\"><span class=\"SHKeyword\">procedure</span> delete_parameter(</td><td class=\"PParametersParentCell\"><table class=\"PParameters\"><tr><td class=\"PName first\">p_par_id&nbsp;</td><td class=\"PType last\"><span class=\"SHKeyword\">in</span> parameter_tab.par_id<span class=\"SHKeyword\">%type</span>,</td></tr><tr><td class=\"PName first\">p_par_pgr_id&nbsp;</td><td class=\"PType last\"><span class=\"SHKeyword\">in</span> parameter_tab.par_pgr_id<span class=\"SHKeyword\">%type</span></td></tr></table></td><td class=\"PAfterParameters\">)</td></tr></table></div></div><div class=\"TTSummary\">Method to delete a parameter</div></div>",749:"<div class=\"NDToolTip TFunction LSQL\"><div id=\"NDPrototype749\" class=\"NDPrototype WideForm\"><div class=\"PSection PParameterSection PascalStyle\"><table><tr><td class=\"PBeforeParameters\"><span class=\"SHKeyword\">procedure</span> validate_realm_parameter(</td><td class=\"PParametersParentCell\"><table class=\"PParameters\"><tr><td class=\"PName first\">p_row&nbsp;</td><td class=\"PType last\"><span class=\"SHKeyword\">in out nocopy</span> parameter_vw<span class=\"SHKeyword\">%rowtype</span></td></tr></table></td><td class=\"PAfterParameters\">)</td></tr></table></div></div><div class=\"TTSummary\">Method to validate a realm based parameter if a validation string exists.</div></div>",750:"<div class=\"NDToolTip TFunction LSQL\"><div id=\"NDPrototype750\" class=\"NDPrototype WideForm\"><div class=\"PSection PParameterSection PascalStyle\"><table><tr><td class=\"PBeforeParameters\"><span class=\"SHKeyword\">procedure</span> edit_realm_parameter(</td><td class=\"PParametersParentCell\"><table class=\"PParameters\"><tr><td class=\"PName first\">p_par_id&nbsp;</td><td class=\"PType\">parameter_vw.par_id<span class=\"SHKeyword\">%type</span>,</td><td></td><td class=\"last\"></td></tr><tr><td class=\"PName first\">p_par_pgr_id&nbsp;</td><td class=\"PType\">parameter_vw.par_pgr_id<span class=\"SHKeyword\">%type</span>,</td><td></td><td class=\"last\"></td></tr><tr><td class=\"PName first\">p_par_pre_id&nbsp;</td><td class=\"PType\"><span class=\"SHKeyword\">in</span> parameter_realm.pre_id<span class=\"SHKeyword\">%type</span>,</td><td></td><td class=\"last\"></td></tr><tr><td class=\"PName first\">p_par_string_value&nbsp;</td><td class=\"PType\"><span class=\"SHKeyword\">in</span> parameter_vw.par_string_value<span class=\"SHKeyword\">%type</span></td><td class=\"PDefaultValueSeparator\">&nbsp;<span class=\"SHKeyword\">default</span>&nbsp;</td><td class=\"PDefaultValue last\"><span class=\"SHKeyword\">null</span>,</td></tr><tr><td class=\"PName first\">p_par_raw_value&nbsp;</td><td class=\"PType\"><span class=\"SHKeyword\">in</span> parameter_vw.par_raw_value<span class=\"SHKeyword\">%type</span></td><td class=\"PDefaultValueSeparator\">&nbsp;<span class=\"SHKeyword\">default</span>&nbsp;</td><td class=\"PDefaultValue last\"><span class=\"SHKeyword\">null</span>,</td></tr><tr><td class=\"PName first\">p_par_xml_value&nbsp;</td><td class=\"PType\"><span class=\"SHKeyword\">in</span> parameter_vw.par_xml_value<span class=\"SHKeyword\">%type</span></td><td class=\"PDefaultValueSeparator\">&nbsp;<span class=\"SHKeyword\">default</span>&nbsp;</td><td class=\"PDefaultValue last\"><span class=\"SHKeyword\">null</span>,</td></tr><tr><td class=\"PName first\">p_par_integer_value&nbsp;</td><td class=\"PType\"><span class=\"SHKeyword\">in</span> parameter_vw.par_integer_value<span class=\"SHKeyword\">%type</span></td><td class=\"PDefaultValueSeparator\">&nbsp;<span class=\"SHKeyword\">default</span>&nbsp;</td><td class=\"PDefaultValue last\"><span class=\"SHKeyword\">null</span>,</td></tr><tr><td class=\"PName first\">p_par_float_value&nbsp;</td><td class=\"PType\"><span class=\"SHKeyword\">in</span> parameter_vw.par_float_value<span class=\"SHKeyword\">%type</span></td><td class=\"PDefaultValueSeparator\">&nbsp;<span class=\"SHKeyword\">default</span>&nbsp;</td><td class=\"PDefaultValue last\"><span class=\"SHKeyword\">null</span>,</td></tr><tr><td class=\"PName first\">p_par_date_value&nbsp;</td><td class=\"PType\"><span class=\"SHKeyword\">in</span> parameter_vw.par_date_value<span class=\"SHKeyword\">%type</span></td><td class=\"PDefaultValueSeparator\">&nbsp;<span class=\"SHKeyword\">default</span>&nbsp;</td><td class=\"PDefaultValue last\"><span class=\"SHKeyword\">null</span>,</td></tr><tr><td class=\"PName first\">p_par_timestamp_value&nbsp;</td><td class=\"PType\"><span class=\"SHKeyword\">in</span> parameter_vw.par_timestamp_value<span class=\"SHKeyword\">%type</span></td><td class=\"PDefaultValueSeparator\">&nbsp;<span class=\"SHKeyword\">default</span>&nbsp;</td><td class=\"PDefaultValue last\"><span class=\"SHKeyword\">null</span>,</td></tr><tr><td class=\"PName first\">p_par_boolean_value&nbsp;</td><td class=\"PType\"><span class=\"SHKeyword\">in boolean</span></td><td class=\"PDefaultValueSeparator\">&nbsp;<span class=\"SHKeyword\">default</span>&nbsp;</td><td class=\"PDefaultValue last\"><span class=\"SHKeyword\">null</span></td></tr></table></td><td class=\"PAfterParameters\">)</td></tr></table></div></div><div class=\"TTSummary\">Sets a realm parameter value.</div></div>",752:"<div class=\"NDToolTip TFunction LSQL\"><div id=\"NDPrototype752\" class=\"NDPrototype WideForm\"><div class=\"PSection PParameterSection PascalStyle\"><table><tr><td class=\"PBeforeParameters\"><span class=\"SHKeyword\">procedure</span> delete_realm_parameter(</td><td class=\"PParametersParentCell\"><table class=\"PParameters\"><tr><td class=\"PName first\">p_par_id&nbsp;</td><td class=\"PType last\">parameter_vw.par_id<span class=\"SHKeyword\">%type</span>,</td></tr><tr><td class=\"PName first\">p_par_pgr_id&nbsp;</td><td class=\"PType last\">parameter_vw.par_pgr_id<span class=\"SHKeyword\">%type</span>,</td></tr><tr><td class=\"PName first\">p_par_pre_id&nbsp;</td><td class=\"PType last\"><span class=\"SHKeyword\">in</span> parameter_realm.pre_id<span class=\"SHKeyword\">%type</span></td></tr></table></td><td class=\"PAfterParameters\">)</td></tr></table></div></div><div class=\"TTSummary\">Resets a realm parameter to the default value</div></div>",753:"<div class=\"NDToolTip TFunction LSQL\"><div id=\"NDPrototype753\" class=\"NDPrototype WideForm\"><div class=\"PSection PParameterSection PascalStyle\"><table><tr><td class=\"PBeforeParameters\"><span class=\"SHKeyword\">function</span> export_parameter_group(</td><td class=\"PParametersParentCell\"><table class=\"PParameters\"><tr><td class=\"PName first\">p_pgr_id&nbsp;</td><td class=\"PType last\"><span class=\"SHKeyword\">in</span> parameter_group.pgr_id<span class=\"SHKeyword\">%type</span></td></tr></table></td><td class=\"PAfterParameters\">)</td></tr></table></div><div class=\"PSection PPlainSection\"><span class=\"SHKeyword\">return clob</span></div></div><div class=\"TTSummary\">Method to create a script for all parameters within a parameter group as a clob instance.</div></div>"});