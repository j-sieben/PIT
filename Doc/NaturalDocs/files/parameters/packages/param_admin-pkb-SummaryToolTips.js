﻿NDSummary.OnToolTipsLoaded("File:parameters/packages/param_admin.pkb",{754:"<div class=\"NDToolTip TClass LSQL\"><div class=\"TTSummary\">Package to maintain settings for parameter groups</div></div>",756:"<div class=\"NDToolTip TFunction LSQL\"><div id=\"NDPrototype756\" class=\"NDPrototype WideForm\"><div class=\"PSection PParameterSection PascalStyle\"><table><tr><td class=\"PBeforeParameters\"><span class=\"SHKeyword\">function</span> convert_boolean(</td><td class=\"PParametersParentCell\"><table class=\"PParameters\"><tr><td class=\"PName first\">p_value&nbsp;</td><td class=\"PType last\"><span class=\"SHKeyword\">in boolean</span></td></tr></table></td><td class=\"PAfterParameters\">)</td></tr></table></div><div class=\"PSection PPlainSection\"><span class=\"SHKeyword\">return varchar2</span></div></div><div class=\"TTSummary\">Helper method to cast a boolean value into the given FLAG_TYPE.</div></div>",757:"<div class=\"NDToolTip TFunction LSQL\"><div id=\"NDPrototype757\" class=\"NDPrototype WideForm\"><div class=\"PSection PParameterSection PascalStyle\"><table><tr><td class=\"PBeforeParameters\"><span class=\"SHKeyword\">function</span> get_parameter_group(</td><td class=\"PParametersParentCell\"><table class=\"PParameters\"><tr><td class=\"PName first\">p_pgr_id&nbsp;</td><td class=\"PType last\"><span class=\"SHKeyword\">in</span> parameter_group.pgr_id<span class=\"SHKeyword\">%type</span></td></tr></table></td><td class=\"PAfterParameters\">)</td></tr></table></div><div class=\"PSection PPlainSection\"><span class=\"SHKeyword\">return clob</span></div></div><div class=\"TTSummary\">See &lt;PARAM_ADMIN.get_parameter_group&gt;</div></div>",758:"<div class=\"NDToolTip TFunction LSQL\"><div id=\"NDPrototype758\" class=\"NDPrototype WideForm\"><div class=\"PSection PParameterSection PascalStyle\"><table><tr><td class=\"PBeforeParameters\"><span class=\"SHKeyword\">function</span> get_parameter_realms(</td><td class=\"PParametersParentCell\"><table class=\"PParameters\"><tr><td class=\"PName first\">p_pgr_id&nbsp;</td><td class=\"PType last\"><span class=\"SHKeyword\">in</span> parameter_group.pgr_id<span class=\"SHKeyword\">%type</span></td></tr></table></td><td class=\"PAfterParameters\">)</td></tr></table></div><div class=\"PSection PPlainSection\"><span class=\"SHKeyword\">return clob</span></div></div><div class=\"TTSummary\">Method to create an installation script for all referenced parameter realms of a parameter group.</div></div>",759:"<div class=\"NDToolTip TFunction LSQL\"><div id=\"NDPrototype759\" class=\"NDPrototype WideForm\"><div class=\"PSection PParameterSection PascalStyle\"><table><tr><td class=\"PBeforeParameters\"><span class=\"SHKeyword\">function</span> get_parameters(</td><td class=\"PParametersParentCell\"><table class=\"PParameters\"><tr><td class=\"PName first\">p_pgr_id&nbsp;</td><td class=\"PType last\"><span class=\"SHKeyword\">in</span> parameter_group.pgr_id<span class=\"SHKeyword\">%type</span></td></tr></table></td><td class=\"PAfterParameters\">)</td></tr></table></div><div class=\"PSection PPlainSection\"><span class=\"SHKeyword\">return clob</span></div></div><div class=\"TTSummary\">Method to create an installation script for all parameters of a parameter group.</div></div>",760:"<div class=\"NDToolTip TFunction LSQL\"><div id=\"NDPrototype760\" class=\"NDPrototype WideForm\"><div class=\"PSection PParameterSection PascalStyle\"><table><tr><td class=\"PBeforeParameters\"><span class=\"SHKeyword\">function</span> get_local_parameters(</td><td class=\"PParametersParentCell\"><table class=\"PParameters\"><tr><td class=\"PName first\">p_pgr_id&nbsp;</td><td class=\"PType last\"><span class=\"SHKeyword\">in</span> parameter_group.pgr_id<span class=\"SHKeyword\">%type</span></td></tr></table></td><td class=\"PAfterParameters\">)</td></tr></table></div><div class=\"PSection PPlainSection\"><span class=\"SHKeyword\">return clob</span></div></div><div class=\"TTSummary\">Method to create an installation script for all local parameters of a parameter group.</div></div>",762:"<div class=\"NDToolTip TFunction LSQL\"><div id=\"NDPrototype762\" class=\"NDPrototype WideForm\"><div class=\"PSection PParameterSection PascalStyle\"><table><tr><td class=\"PBeforeParameters\"><span class=\"SHKeyword\">function</span> get_parameter_settings(</td><td class=\"PParametersParentCell\"><table class=\"PParameters\"><tr><td class=\"PName first\">p_par_id&nbsp;</td><td class=\"PType last\"><span class=\"SHKeyword\">in</span> parameter_vw.par_id<span class=\"SHKeyword\">%type</span>,</td></tr><tr><td class=\"PName first\">p_pgr_id&nbsp;</td><td class=\"PType last\"><span class=\"SHKeyword\">in</span> parameter_group.pgr_id<span class=\"SHKeyword\">%type</span></td></tr></table></td><td class=\"PAfterParameters\">)</td></tr></table></div><div class=\"PSection PPlainSection\"><span class=\"SHKeyword\">return</span> parameter_vw<span class=\"SHKeyword\">%rowtype</span></div></div><div class=\"TTSummary\">See PARAM_ADMIN.get_parameter_settings</div></div>",763:"<div class=\"NDToolTip TFunction LSQL\"><div id=\"NDPrototype763\" class=\"NDPrototype WideForm\"><div class=\"PSection PParameterSection PascalStyle\"><table><tr><td class=\"PBeforeParameters\"><span class=\"SHKeyword\">procedure</span> validate_parameter_group(</td><td class=\"PParametersParentCell\"><table class=\"PParameters\"><tr><td class=\"PName first\">p_row&nbsp;</td><td class=\"PType last\"><span class=\"SHKeyword\">in</span> parameter_group<span class=\"SHKeyword\">%rowtype</span></td></tr></table></td><td class=\"PAfterParameters\">)</td></tr></table></div></div><div class=\"TTSummary\">See PARAM_ADMIN.validate_parameter_group</div></div>",764:"<div class=\"NDToolTip TFunction LSQL\"><div id=\"NDPrototype764\" class=\"NDPrototype WideForm\"><div class=\"PSection PParameterSection PascalStyle\"><table><tr><td class=\"PBeforeParameters\"><span class=\"SHKeyword\">procedure</span> edit_parameter_group(</td><td class=\"PParametersParentCell\"><table class=\"PParameters\"><tr><td class=\"PName first\">p_pgr_id&nbsp;</td><td class=\"PType\"><span class=\"SHKeyword\">in</span> parameter_group.pgr_id<span class=\"SHKeyword\">%type</span>,</td><td></td><td class=\"last\"></td></tr><tr><td class=\"PName first\">p_pgr_description&nbsp;</td><td class=\"PType\"><span class=\"SHKeyword\">in</span> parameter_group.pgr_description<span class=\"SHKeyword\">%type</span>,</td><td></td><td class=\"last\"></td></tr><tr><td class=\"PName first\">p_pgr_is_modifiable&nbsp;</td><td class=\"PType\"><span class=\"SHKeyword\">in boolean</span></td><td class=\"PDefaultValueSeparator\">&nbsp;<span class=\"SHKeyword\">default</span>&nbsp;</td><td class=\"PDefaultValue last\">true</td></tr></table></td><td class=\"PAfterParameters\">)</td></tr></table></div></div><div class=\"TTSummary\">See PARAM_ADMIN.edit_parameter_group</div></div>",765:"<div class=\"NDToolTip TFunction LSQL\"><div id=\"NDPrototype765\" class=\"NDPrototype WideForm\"><div class=\"PSection PParameterSection PascalStyle\"><table><tr><td class=\"PBeforeParameters\"><span class=\"SHKeyword\">procedure</span> edit_parameter_group(</td><td class=\"PParametersParentCell\"><table class=\"PParameters\"><tr><td class=\"PName first\">p_row&nbsp;</td><td class=\"PType last\"><span class=\"SHKeyword\">in</span> parameter_group<span class=\"SHKeyword\">%rowtype</span></td></tr></table></td><td class=\"PAfterParameters\">)</td></tr></table></div></div><div class=\"TTSummary\">See PARAM_ADMIN.edit_parameter_group</div></div>",766:"<div class=\"NDToolTip TFunction LSQL\"><div id=\"NDPrototype766\" class=\"NDPrototype WideForm\"><div class=\"PSection PParameterSection PascalStyle\"><table><tr><td class=\"PBeforeParameters\"><span class=\"SHKeyword\">procedure</span> delete_parameter_group(</td><td class=\"PParametersParentCell\"><table class=\"PParameters\"><tr><td class=\"PName first\">p_pgr_id&nbsp;</td><td class=\"PType\"><span class=\"SHKeyword\">in</span> parameter_group.pgr_id<span class=\"SHKeyword\">%type</span>,</td><td></td><td class=\"last\"></td></tr><tr><td class=\"PName first\">p_force&nbsp;</td><td class=\"PType\"><span class=\"SHKeyword\">in boolean</span></td><td class=\"PDefaultValueSeparator\">&nbsp;<span class=\"SHKeyword\">default</span>&nbsp;</td><td class=\"PDefaultValue last\">false</td></tr></table></td><td class=\"PAfterParameters\">)</td></tr></table></div></div><div class=\"TTSummary\">See PARAM_ADMIN.delete_parameter_group</div></div>",767:"<div class=\"NDToolTip TFunction LSQL\"><div id=\"NDPrototype767\" class=\"NDPrototype WideForm\"><div class=\"PSection PParameterSection PascalStyle\"><table><tr><td class=\"PBeforeParameters\"><span class=\"SHKeyword\">procedure</span> edit_parameter_realm(</td><td class=\"PParametersParentCell\"><table class=\"PParameters\"><tr><td class=\"PName first\">p_pre_id&nbsp;</td><td class=\"PType\"><span class=\"SHKeyword\">in</span> parameter_realm.pre_id<span class=\"SHKeyword\">%type</span>,</td><td></td><td class=\"last\"></td></tr><tr><td class=\"PName first\">p_pre_description&nbsp;</td><td class=\"PType\"><span class=\"SHKeyword\">in</span> parameter_realm.pre_description<span class=\"SHKeyword\">%type</span>,</td><td></td><td class=\"last\"></td></tr><tr><td class=\"PName first\">p_pre_is_active&nbsp;</td><td class=\"PType\"><span class=\"SHKeyword\">in boolean</span></td><td class=\"PDefaultValueSeparator\">&nbsp;<span class=\"SHKeyword\">default</span>&nbsp;</td><td class=\"PDefaultValue last\">true</td></tr></table></td><td class=\"PAfterParameters\">)</td></tr></table></div></div><div class=\"TTSummary\">See PARAM_ADMIN.edit_parameter_realm</div></div>",768:"<div class=\"NDToolTip TFunction LSQL\"><div id=\"NDPrototype768\" class=\"NDPrototype WideForm\"><div class=\"PSection PParameterSection PascalStyle\"><table><tr><td class=\"PBeforeParameters\"><span class=\"SHKeyword\">procedure</span> edit_parameter_realm(</td><td class=\"PParametersParentCell\"><table class=\"PParameters\"><tr><td class=\"PName first\">p_row&nbsp;</td><td class=\"PType last\"><span class=\"SHKeyword\">in</span> parameter_realm<span class=\"SHKeyword\">%rowtype</span></td></tr></table></td><td class=\"PAfterParameters\">)</td></tr></table></div></div><div class=\"TTSummary\">See PARAM_ADMIN.edit_parameter_realm</div></div>",769:"<div class=\"NDToolTip TFunction LSQL\"><div id=\"NDPrototype769\" class=\"NDPrototype WideForm\"><div class=\"PSection PParameterSection PascalStyle\"><table><tr><td class=\"PBeforeParameters\"><span class=\"SHKeyword\">procedure</span> delete_parameter_realm(</td><td class=\"PParametersParentCell\"><table class=\"PParameters\"><tr><td class=\"PName first\">p_pre_id&nbsp;</td><td class=\"PType\"><span class=\"SHKeyword\">in</span> parameter_realm.pre_id<span class=\"SHKeyword\">%type</span>,</td><td></td><td class=\"last\"></td></tr><tr><td class=\"PName first\">p_force&nbsp;</td><td class=\"PType\"><span class=\"SHKeyword\">in boolean</span></td><td class=\"PDefaultValueSeparator\">&nbsp;<span class=\"SHKeyword\">default</span>&nbsp;</td><td class=\"PDefaultValue last\">false</td></tr></table></td><td class=\"PAfterParameters\">)</td></tr></table></div></div><div class=\"TTSummary\">See PARAM_ADMIN.delete_parameter_realm</div></div>",770:"<div class=\"NDToolTip TFunction LSQL\"><div id=\"NDPrototype770\" class=\"NDPrototype WideForm\"><div class=\"PSection PParameterSection PascalStyle\"><table><tr><td class=\"PBeforeParameters\"><span class=\"SHKeyword\">procedure</span> edit_parameter_type(</td><td class=\"PParametersParentCell\"><table class=\"PParameters\"><tr><td class=\"PName first\">p_pat_id&nbsp;</td><td class=\"PType last\">parameter_type.pat_id<span class=\"SHKeyword\">%type</span>,</td></tr><tr><td class=\"PName first\">p_pat_description&nbsp;</td><td class=\"PType last\">parameter_type.pat_description<span class=\"SHKeyword\">%type</span></td></tr></table></td><td class=\"PAfterParameters\">)</td></tr></table></div></div><div class=\"TTSummary\">See PARAM_ADMIN.edit_parameter_type</div></div>",771:"<div class=\"NDToolTip TFunction LSQL\"><div id=\"NDPrototype771\" class=\"NDPrototype WideForm\"><div class=\"PSection PParameterSection PascalStyle\"><table><tr><td class=\"PBeforeParameters\"><span class=\"SHKeyword\">procedure</span> validate_parameter(</td><td class=\"PParametersParentCell\"><table class=\"PParameters\"><tr><td class=\"PName first\">p_row&nbsp;</td><td class=\"PType last\"><span class=\"SHKeyword\">in</span> parameter_vw<span class=\"SHKeyword\">%rowtype</span></td></tr></table></td><td class=\"PAfterParameters\">)</td></tr></table></div></div><div class=\"TTSummary\">See PARAM_ADMIN.validate_parameter</div></div>",772:"<div class=\"NDToolTip TFunction LSQL\"><div id=\"NDPrototype772\" class=\"NDPrototype WideForm\"><div class=\"PSection PParameterSection PascalStyle\"><table><tr><td class=\"PBeforeParameters\"><span class=\"SHKeyword\">procedure</span> edit_parameter(</td><td class=\"PParametersParentCell\"><table class=\"PParameters\"><tr><td class=\"PName first\">p_par_id&nbsp;</td><td class=\"PType\"><span class=\"SHKeyword\">in</span> parameter_tab.par_id<span class=\"SHKeyword\">%type</span>,</td><td></td><td class=\"last\"></td></tr><tr><td class=\"PName first\">p_par_pgr_id&nbsp;</td><td class=\"PType\"><span class=\"SHKeyword\">in</span> parameter_tab.par_pgr_id<span class=\"SHKeyword\">%type</span>,</td><td></td><td class=\"last\"></td></tr><tr><td class=\"PName first\">p_par_description&nbsp;</td><td class=\"PType\"><span class=\"SHKeyword\">in</span> parameter_tab.par_description<span class=\"SHKeyword\">%type</span></td><td class=\"PDefaultValueSeparator\">&nbsp;<span class=\"SHKeyword\">default</span>&nbsp;</td><td class=\"PDefaultValue last\"><span class=\"SHKeyword\">null</span>,</td></tr><tr><td class=\"PName first\">p_par_string_value&nbsp;</td><td class=\"PType\"><span class=\"SHKeyword\">in</span> parameter_tab.par_string_value<span class=\"SHKeyword\">%type</span></td><td class=\"PDefaultValueSeparator\">&nbsp;<span class=\"SHKeyword\">default</span>&nbsp;</td><td class=\"PDefaultValue last\"><span class=\"SHKeyword\">null</span>,</td></tr><tr><td class=\"PName first\">p_par_xml_value&nbsp;</td><td class=\"PType\"><span class=\"SHKeyword\">in</span> parameter_tab.par_xml_value<span class=\"SHKeyword\">%type</span></td><td class=\"PDefaultValueSeparator\">&nbsp;<span class=\"SHKeyword\">default</span>&nbsp;</td><td class=\"PDefaultValue last\"><span class=\"SHKeyword\">null</span>,</td></tr><tr><td class=\"PName first\">p_par_integer_value&nbsp;</td><td class=\"PType\"><span class=\"SHKeyword\">in</span> parameter_tab.par_integer_value<span class=\"SHKeyword\">%type</span></td><td class=\"PDefaultValueSeparator\">&nbsp;<span class=\"SHKeyword\">default</span>&nbsp;</td><td class=\"PDefaultValue last\"><span class=\"SHKeyword\">null</span>,</td></tr><tr><td class=\"PName first\">p_par_float_value&nbsp;</td><td class=\"PType\"><span class=\"SHKeyword\">in</span> parameter_tab.par_float_value<span class=\"SHKeyword\">%type</span></td><td class=\"PDefaultValueSeparator\">&nbsp;<span class=\"SHKeyword\">default</span>&nbsp;</td><td class=\"PDefaultValue last\"><span class=\"SHKeyword\">null</span>,</td></tr><tr><td class=\"PName first\">p_par_date_value&nbsp;</td><td class=\"PType\"><span class=\"SHKeyword\">in</span> parameter_tab.par_date_value<span class=\"SHKeyword\">%type</span></td><td class=\"PDefaultValueSeparator\">&nbsp;<span class=\"SHKeyword\">default</span>&nbsp;</td><td class=\"PDefaultValue last\"><span class=\"SHKeyword\">null</span>,</td></tr><tr><td class=\"PName first\">p_par_timestamp_value&nbsp;</td><td class=\"PType\"><span class=\"SHKeyword\">in</span> parameter_tab.par_timestamp_value<span class=\"SHKeyword\">%type</span></td><td class=\"PDefaultValueSeparator\">&nbsp;<span class=\"SHKeyword\">default</span>&nbsp;</td><td class=\"PDefaultValue last\"><span class=\"SHKeyword\">null</span>,</td></tr><tr><td class=\"PName first\">p_par_boolean_value&nbsp;</td><td class=\"PType\"><span class=\"SHKeyword\">in boolean</span></td><td class=\"PDefaultValueSeparator\">&nbsp;<span class=\"SHKeyword\">default</span>&nbsp;</td><td class=\"PDefaultValue last\"><span class=\"SHKeyword\">null</span>,</td></tr><tr><td class=\"PName first\">p_par_is_modifiable&nbsp;</td><td class=\"PType\"><span class=\"SHKeyword\">in boolean</span></td><td class=\"PDefaultValueSeparator\">&nbsp;<span class=\"SHKeyword\">default</span>&nbsp;</td><td class=\"PDefaultValue last\"><span class=\"SHKeyword\">null</span>,</td></tr><tr><td class=\"PName first\">p_par_pat_id&nbsp;</td><td class=\"PType\"><span class=\"SHKeyword\">in</span> parameter_tab.par_pat_id<span class=\"SHKeyword\">%type</span></td><td class=\"PDefaultValueSeparator\">&nbsp;<span class=\"SHKeyword\">default</span>&nbsp;</td><td class=\"PDefaultValue last\"><span class=\"SHKeyword\">null</span>,</td></tr><tr><td class=\"PName first\">p_par_validation_string&nbsp;</td><td class=\"PType\"><span class=\"SHKeyword\">in</span> parameter_tab.par_validation_string<span class=\"SHKeyword\">%type</span></td><td class=\"PDefaultValueSeparator\">&nbsp;<span class=\"SHKeyword\">default</span>&nbsp;</td><td class=\"PDefaultValue last\"><span class=\"SHKeyword\">null</span>,</td></tr><tr><td class=\"PName first\">p_par_validation_message&nbsp;</td><td class=\"PType\"><span class=\"SHKeyword\">in</span> parameter_tab.par_validation_message<span class=\"SHKeyword\">%type</span></td><td class=\"PDefaultValueSeparator\">&nbsp;<span class=\"SHKeyword\">default</span>&nbsp;</td><td class=\"PDefaultValue last\"><span class=\"SHKeyword\">null</span></td></tr></table></td><td class=\"PAfterParameters\">)</td></tr></table></div></div><div class=\"TTSummary\">See PARAM_ADMIN.edit_parameter</div></div>",773:"<div class=\"NDToolTip TFunction LSQL\"><div id=\"NDPrototype773\" class=\"NDPrototype WideForm\"><div class=\"PSection PParameterSection PascalStyle\"><table><tr><td class=\"PBeforeParameters\"><span class=\"SHKeyword\">procedure</span> edit_parameter(</td><td class=\"PParametersParentCell\"><table class=\"PParameters\"><tr><td class=\"PName first\">p_row&nbsp;</td><td class=\"PType last\"><span class=\"SHKeyword\">in</span> parameter_vw<span class=\"SHKeyword\">%rowtype</span></td></tr></table></td><td class=\"PAfterParameters\">)</td></tr></table></div></div><div class=\"TTSummary\">See PARAM_ADMIN.edit_parameter</div></div>",774:"<div class=\"NDToolTip TFunction LSQL\"><div id=\"NDPrototype774\" class=\"NDPrototype WideForm\"><div class=\"PSection PParameterSection PascalStyle\"><table><tr><td class=\"PBeforeParameters\"><span class=\"SHKeyword\">procedure</span> delete_parameter(</td><td class=\"PParametersParentCell\"><table class=\"PParameters\"><tr><td class=\"PName first\">p_par_id&nbsp;</td><td class=\"PType last\"><span class=\"SHKeyword\">in</span> parameter_tab.par_id<span class=\"SHKeyword\">%type</span>,</td></tr><tr><td class=\"PName first\">p_par_pgr_id&nbsp;</td><td class=\"PType last\"><span class=\"SHKeyword\">in</span> parameter_tab.par_pgr_id<span class=\"SHKeyword\">%type</span></td></tr></table></td><td class=\"PAfterParameters\">)</td></tr></table></div></div><div class=\"TTSummary\">See PARAM_ADMIN.delete_parameter</div></div>",775:"<div class=\"NDToolTip TFunction LSQL\"><div id=\"NDPrototype775\" class=\"NDPrototype WideForm\"><div class=\"PSection PParameterSection PascalStyle\"><table><tr><td class=\"PBeforeParameters\"><span class=\"SHKeyword\">procedure</span> validate_realm_parameter(</td><td class=\"PParametersParentCell\"><table class=\"PParameters\"><tr><td class=\"PName first\">p_row&nbsp;</td><td class=\"PType last\"><span class=\"SHKeyword\">in out nocopy</span> parameter_vw<span class=\"SHKeyword\">%rowtype</span></td></tr></table></td><td class=\"PAfterParameters\">)</td></tr></table></div></div><div class=\"TTSummary\">See PARAM_ADMIN.validate_realm_parameter</div></div>",776:"<div class=\"NDToolTip TFunction LSQL\"><div id=\"NDPrototype776\" class=\"NDPrototype WideForm\"><div class=\"PSection PParameterSection PascalStyle\"><table><tr><td class=\"PBeforeParameters\"><span class=\"SHKeyword\">procedure</span> edit_realm_parameter(</td><td class=\"PParametersParentCell\"><table class=\"PParameters\"><tr><td class=\"PName first\">p_par_id&nbsp;</td><td class=\"PType\">parameter_vw.par_id<span class=\"SHKeyword\">%type</span>,</td><td></td><td class=\"last\"></td></tr><tr><td class=\"PName first\">p_par_pgr_id&nbsp;</td><td class=\"PType\">parameter_vw.par_pgr_id<span class=\"SHKeyword\">%type</span>,</td><td></td><td class=\"last\"></td></tr><tr><td class=\"PName first\">p_par_pre_id&nbsp;</td><td class=\"PType\"><span class=\"SHKeyword\">in</span> parameter_realm.pre_id<span class=\"SHKeyword\">%type</span>,</td><td></td><td class=\"last\"></td></tr><tr><td class=\"PName first\">p_par_string_value&nbsp;</td><td class=\"PType\"><span class=\"SHKeyword\">in</span> parameter_vw.par_string_value<span class=\"SHKeyword\">%type</span></td><td class=\"PDefaultValueSeparator\">&nbsp;<span class=\"SHKeyword\">default</span>&nbsp;</td><td class=\"PDefaultValue last\"><span class=\"SHKeyword\">null</span>,</td></tr><tr><td class=\"PName first\">p_par_raw_value&nbsp;</td><td class=\"PType\"><span class=\"SHKeyword\">in</span> parameter_vw.par_raw_value<span class=\"SHKeyword\">%type</span></td><td class=\"PDefaultValueSeparator\">&nbsp;<span class=\"SHKeyword\">default</span>&nbsp;</td><td class=\"PDefaultValue last\"><span class=\"SHKeyword\">null</span>,</td></tr><tr><td class=\"PName first\">p_par_xml_value&nbsp;</td><td class=\"PType\"><span class=\"SHKeyword\">in</span> parameter_vw.par_xml_value<span class=\"SHKeyword\">%type</span></td><td class=\"PDefaultValueSeparator\">&nbsp;<span class=\"SHKeyword\">default</span>&nbsp;</td><td class=\"PDefaultValue last\"><span class=\"SHKeyword\">null</span>,</td></tr><tr><td class=\"PName first\">p_par_integer_value&nbsp;</td><td class=\"PType\"><span class=\"SHKeyword\">in</span> parameter_vw.par_integer_value<span class=\"SHKeyword\">%type</span></td><td class=\"PDefaultValueSeparator\">&nbsp;<span class=\"SHKeyword\">default</span>&nbsp;</td><td class=\"PDefaultValue last\"><span class=\"SHKeyword\">null</span>,</td></tr><tr><td class=\"PName first\">p_par_float_value&nbsp;</td><td class=\"PType\"><span class=\"SHKeyword\">in</span> parameter_vw.par_float_value<span class=\"SHKeyword\">%type</span></td><td class=\"PDefaultValueSeparator\">&nbsp;<span class=\"SHKeyword\">default</span>&nbsp;</td><td class=\"PDefaultValue last\"><span class=\"SHKeyword\">null</span>,</td></tr><tr><td class=\"PName first\">p_par_date_value&nbsp;</td><td class=\"PType\"><span class=\"SHKeyword\">in</span> parameter_vw.par_date_value<span class=\"SHKeyword\">%type</span></td><td class=\"PDefaultValueSeparator\">&nbsp;<span class=\"SHKeyword\">default</span>&nbsp;</td><td class=\"PDefaultValue last\"><span class=\"SHKeyword\">null</span>,</td></tr><tr><td class=\"PName first\">p_par_timestamp_value&nbsp;</td><td class=\"PType\"><span class=\"SHKeyword\">in</span> parameter_vw.par_timestamp_value<span class=\"SHKeyword\">%type</span></td><td class=\"PDefaultValueSeparator\">&nbsp;<span class=\"SHKeyword\">default</span>&nbsp;</td><td class=\"PDefaultValue last\"><span class=\"SHKeyword\">null</span>,</td></tr><tr><td class=\"PName first\">p_par_boolean_value&nbsp;</td><td class=\"PType\"><span class=\"SHKeyword\">in boolean</span></td><td class=\"PDefaultValueSeparator\">&nbsp;<span class=\"SHKeyword\">default</span>&nbsp;</td><td class=\"PDefaultValue last\"><span class=\"SHKeyword\">null</span></td></tr></table></td><td class=\"PAfterParameters\">)</td></tr></table></div></div><div class=\"TTSummary\">See PARAM_ADMIN.edit_realm_parameter</div></div>",777:"<div class=\"NDToolTip TFunction LSQL\"><div id=\"NDPrototype777\" class=\"NDPrototype WideForm\"><div class=\"PSection PParameterSection PascalStyle\"><table><tr><td class=\"PBeforeParameters\"><span class=\"SHKeyword\">procedure</span> edit_realm_parameter(</td><td class=\"PParametersParentCell\"><table class=\"PParameters\"><tr><td class=\"PName first\">p_row&nbsp;</td><td class=\"PType last\"><span class=\"SHKeyword\">in</span> parameter_vw<span class=\"SHKeyword\">%rowtype</span></td></tr></table></td><td class=\"PAfterParameters\">)</td></tr></table></div></div><div class=\"TTSummary\">See PARAM_ADMIN.edit_realm_parameter</div></div>",778:"<div class=\"NDToolTip TFunction LSQL\"><div id=\"NDPrototype778\" class=\"NDPrototype WideForm\"><div class=\"PSection PParameterSection PascalStyle\"><table><tr><td class=\"PBeforeParameters\"><span class=\"SHKeyword\">procedure</span> delete_realm_parameter(</td><td class=\"PParametersParentCell\"><table class=\"PParameters\"><tr><td class=\"PName first\">p_par_id&nbsp;</td><td class=\"PType last\">parameter_vw.par_id<span class=\"SHKeyword\">%type</span>,</td></tr><tr><td class=\"PName first\">p_par_pgr_id&nbsp;</td><td class=\"PType last\">parameter_vw.par_pgr_id<span class=\"SHKeyword\">%type</span>,</td></tr><tr><td class=\"PName first\">p_par_pre_id&nbsp;</td><td class=\"PType last\"><span class=\"SHKeyword\">in</span> parameter_realm.pre_id<span class=\"SHKeyword\">%type</span></td></tr></table></td><td class=\"PAfterParameters\">)</td></tr></table></div></div><div class=\"TTSummary\">See PARAM_ADMIN.delete_realm_parameter</div></div>",779:"<div class=\"NDToolTip TFunction LSQL\"><div id=\"NDPrototype779\" class=\"NDPrototype WideForm\"><div class=\"PSection PParameterSection PascalStyle\"><table><tr><td class=\"PBeforeParameters\"><span class=\"SHKeyword\">function</span> export_parameter_group(</td><td class=\"PParametersParentCell\"><table class=\"PParameters\"><tr><td class=\"PName first\">p_pgr_id&nbsp;</td><td class=\"PType last\"><span class=\"SHKeyword\">in</span> parameter_group.pgr_id<span class=\"SHKeyword\">%type</span></td></tr></table></td><td class=\"PAfterParameters\">)</td></tr></table></div><div class=\"PSection PPlainSection\"><span class=\"SHKeyword\">return clob</span></div></div><div class=\"TTSummary\">See PARAM_ADMIN.export_parameter_group</div></div>"});