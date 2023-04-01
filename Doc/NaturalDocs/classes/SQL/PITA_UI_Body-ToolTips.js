﻿NDContentPage.OnToolTipsLoaded({16:"<div class=\"NDToolTip TFunction LSQL\"><div id=\"NDPrototype16\" class=\"NDPrototype\"><div class=\"PSection PPlainSection\"><span class=\"SHKeyword\">function</span> get_default_language</div><div class=\"PSection PPlainSection\"><span class=\"SHKeyword\">return varchar2</span></div></div><div class=\"TTSummary\">Getter method to retrieve the default PIT language. This language is defined upon installation of PIT and cannot be changed.</div></div>",17:"<div class=\"NDToolTip TFunction LSQL\"><div id=\"NDPrototype17\" class=\"NDPrototype\"><div class=\"PSection PPlainSection\"><span class=\"SHKeyword\">function</span> get_realm</div><div class=\"PSection PPlainSection\"><span class=\"SHKeyword\">return varchar2</span></div></div><div class=\"TTSummary\">Getter method to retrieve the actually set realm of the environment</div></div>",18:"<div class=\"NDToolTip TFunction LSQL\"><div id=\"NDPrototype18\" class=\"NDPrototype WideForm\"><div class=\"PSection PParameterSection PascalStyle\"><table><tr><td class=\"PBeforeParameters\"><span class=\"SHKeyword\">procedure</span> harmonize_sql_name(</td><td class=\"PParametersParentCell\"><table class=\"PParameters\"><tr><td class=\"PName first\">p_item_name&nbsp;</td><td class=\"PType\"><span class=\"SHKeyword\">in varchar2</span>,</td><td></td><td class=\"last\"></td></tr><tr><td class=\"PName first\">p_prefix&nbsp;</td><td class=\"PType\"><span class=\"SHKeyword\">in varchar2</span></td><td class=\"PDefaultValueSeparator\">&nbsp;<span class=\"SHKeyword\">default</span>&nbsp;</td><td class=\"PDefaultValue last\"><span class=\"SHKeyword\">null</span></td></tr></table></td><td class=\"PAfterParameters\">)</td></tr></table></div></div><div class=\"TTSummary\">Wrapper around PIT_UTIL.harmonize_sql_name.</div></div>",19:"<div class=\"NDToolTip TFunction LSQL\"><div id=\"NDPrototype19\" class=\"NDPrototype\"><div class=\"PSection PPlainSection\"><span class=\"SHKeyword\">function</span> has_translatable_items</div><div class=\"PSection PPlainSection\"><span class=\"SHKeyword\">return boolean</span></div></div><div class=\"TTSummary\">Method to check whether translatable items are present. Is used to toggle the visibility of a region.</div></div>",20:"<div class=\"NDToolTip TFunction LSQL\"><div id=\"NDPrototype20\" class=\"NDPrototype\"><div class=\"PSection PPlainSection\"><span class=\"SHKeyword\">function</span> has_local_parameters</div><div class=\"PSection PPlainSection\"><span class=\"SHKeyword\">return boolean</span></div></div><div class=\"TTSummary\">Method to check whether local parameters are present. Is used to toggle the visibility of a region.</div></div>",21:"<div class=\"NDToolTip TFunction LSQL\"><div id=\"NDPrototype21\" class=\"NDPrototype\"><div class=\"PSection PPlainSection\"><span class=\"SHKeyword\">function</span> allows_toggles</div><div class=\"PSection PPlainSection\"><span class=\"SHKeyword\">return boolean</span></div></div><div class=\"TTSummary\">Method to check whether toggle feature is switched on. Is used to toggle the visibility of a region.</div></div>",22:"<div class=\"NDToolTip TFunction LSQL\"><div id=\"NDPrototype22\" class=\"NDPrototype\"><div class=\"PSection PPlainSection\"><span class=\"SHKeyword\">procedure</span> set_allow_toggles</div></div><div class=\"TTSummary\">Method to set a new toggle value. Is called by the application via an AJAX call.</div></div>",23:"<div class=\"NDToolTip TFunction LSQL\"><div id=\"NDPrototype23\" class=\"NDPrototype\"><div class=\"PSection PPlainSection\"><span class=\"SHKeyword\">function</span> is_default_context</div><div class=\"PSection PPlainSection\"><span class=\"SHKeyword\">return boolean</span></div></div><div class=\"TTSummary\">Method to check wether the actually selected context is the default context.&nbsp; Is used to control the visibility and editability of page items.</div></div>",24:"<div class=\"NDToolTip TFunction LSQL\"><div id=\"NDPrototype24\" class=\"NDPrototype WideForm\"><div class=\"PSection PParameterSection PascalStyle\"><table><tr><td class=\"PBeforeParameters\"><span class=\"SHKeyword\">function</span> pgr_is_modifiable(</td><td class=\"PParametersParentCell\"><table class=\"PParameters\"><tr><td class=\"PName first\">p_pgr_id&nbsp;</td><td class=\"PType last\"><span class=\"SHKeyword\">in</span> pit_util.ora_name_type</td></tr></table></td><td class=\"PAfterParameters\">)</td></tr></table></div><div class=\"PSection PPlainSection\"><span class=\"SHKeyword\">return</span> pit_util.flag_type</div></div><div class=\"TTSummary\">Method to check wether the actually selected parameter group is modifiable</div></div>",25:"<div class=\"NDToolTip TFunction LSQL\"><div id=\"NDPrototype25\" class=\"NDPrototype WideForm\"><div class=\"PSection PParameterSection PascalStyle\"><table><tr><td class=\"PBeforeParameters\"><span class=\"SHKeyword\">procedure</span> set_language_settings(</td><td class=\"PParametersParentCell\"><table class=\"PParameters\"><tr><td class=\"PName first\">p_pml_list&nbsp;</td><td class=\"PType last\"><span class=\"SHKeyword\">in</span> pit_util.max_sql_char</td></tr></table></td><td class=\"PAfterParameters\">)</td></tr></table></div></div><div class=\"TTSummary\">Procedure for managing the default languages. Used to set the language settings for PIT.</div></div>",26:"<div class=\"NDToolTip TFunction LSQL\"><div id=\"NDPrototype26\" class=\"NDPrototype\"><div class=\"PSection PPlainSection\"><span class=\"SHKeyword\">function</span> edit_context_validate</div><div class=\"PSection PPlainSection\"><span class=\"SHKeyword\">return boolean</span></div></div><div class=\"TTSummary\">Method to validate page EDIT_CONTEXT</div></div>",27:"<div class=\"NDToolTip TFunction LSQL\"><div id=\"NDPrototype27\" class=\"NDPrototype\"><div class=\"PSection PPlainSection\"><span class=\"SHKeyword\">procedure</span> edit_context_process</div></div><div class=\"TTSummary\">Mehod to persist user entries of page EDIT_CONTEXT</div></div>",28:"<div class=\"NDToolTip TFunction LSQL\"><div id=\"NDPrototype28\" class=\"NDPrototype\"><div class=\"PSection PPlainSection\"><span class=\"SHKeyword\">function</span> edit_module_validate</div><div class=\"PSection PPlainSection\"><span class=\"SHKeyword\">return boolean</span></div></div><div class=\"TTSummary\">Method to validate page EDIT_MODULE</div></div>",29:"<div class=\"NDToolTip TFunction LSQL\"><div id=\"NDPrototype29\" class=\"NDPrototype\"><div class=\"PSection PPlainSection\"><span class=\"SHKeyword\">procedure</span> edit_module_process</div></div><div class=\"TTSummary\">Mehod to persist user entries of page EDIT_MODULE</div></div>",30:"<div class=\"NDToolTip TFunction LSQL\"><div id=\"NDPrototype30\" class=\"NDPrototype\"><div class=\"PSection PPlainSection\"><span class=\"SHKeyword\">procedure</span> edit_par_initialize</div></div><div class=\"TTSummary\">Method to initialize page values for page EDIT_PAR</div></div>",31:"<div class=\"NDToolTip TFunction LSQL\"><div id=\"NDPrototype31\" class=\"NDPrototype\"><div class=\"PSection PPlainSection\"><span class=\"SHKeyword\">function</span> edit_par_validate</div><div class=\"PSection PPlainSection\"><span class=\"SHKeyword\">return boolean</span></div></div><div class=\"TTSummary\">Method to validate page EDIT_PAR</div></div>",32:"<div class=\"NDToolTip TFunction LSQL\"><div id=\"NDPrototype32\" class=\"NDPrototype\"><div class=\"PSection PPlainSection\"><span class=\"SHKeyword\">procedure</span> edit_par_process</div></div><div class=\"TTSummary\">Mehod to persist user entries of page EDIT_PAR</div></div>",33:"<div class=\"NDToolTip TFunction LSQL\"><div id=\"NDPrototype33\" class=\"NDPrototype\"><div class=\"PSection PPlainSection\"><span class=\"SHKeyword\">function</span> edit_par_realm_validate</div><div class=\"PSection PPlainSection\"><span class=\"SHKeyword\">return boolean</span></div></div><div class=\"TTSummary\">Method to validate page EDIT_PAR_REALM</div></div>",34:"<div class=\"NDToolTip TFunction LSQL\"><div id=\"NDPrototype34\" class=\"NDPrototype\"><div class=\"PSection PPlainSection\"><span class=\"SHKeyword\">procedure</span> edit_par_realm_process</div></div><div class=\"TTSummary\">Mehod to persist user entries of page EDIT_PAR_REALM</div></div>",35:"<div class=\"NDToolTip TFunction LSQL\"><div id=\"NDPrototype35\" class=\"NDPrototype\"><div class=\"PSection PPlainSection\"><span class=\"SHKeyword\">function</span> edit_pgr_validate</div><div class=\"PSection PPlainSection\"><span class=\"SHKeyword\">return boolean</span></div></div><div class=\"TTSummary\">Method to validate page EDIT_PGR</div></div>",36:"<div class=\"NDToolTip TFunction LSQL\"><div id=\"NDPrototype36\" class=\"NDPrototype\"><div class=\"PSection PPlainSection\"><span class=\"SHKeyword\">procedure</span> edit_pgr_process</div></div><div class=\"TTSummary\">Mehod to persist user entries of page EDIT_PGR</div></div>",37:"<div class=\"NDToolTip TFunction LSQL\"><div id=\"NDPrototype37\" class=\"NDPrototype\"><div class=\"PSection PPlainSection\"><span class=\"SHKeyword\">function</span> edit_pmg_validate</div><div class=\"PSection PPlainSection\"><span class=\"SHKeyword\">return boolean</span></div></div><div class=\"TTSummary\">Method to validate page EDIT_PMG</div></div>",38:"<div class=\"NDToolTip TFunction LSQL\"><div id=\"NDPrototype38\" class=\"NDPrototype\"><div class=\"PSection PPlainSection\"><span class=\"SHKeyword\">procedure</span> edit_pmg_process</div></div><div class=\"TTSummary\">Mehod to persist user entries of page EDIT_PMG</div></div>",39:"<div class=\"NDToolTip TFunction LSQL\"><div id=\"NDPrototype39\" class=\"NDPrototype\"><div class=\"PSection PPlainSection\"><span class=\"SHKeyword\">function</span> edit_pms_validate</div><div class=\"PSection PPlainSection\"><span class=\"SHKeyword\">return boolean</span></div></div><div class=\"TTSummary\">Method to validate page EDIT_PMS</div></div>",40:"<div class=\"NDToolTip TFunction LSQL\"><div id=\"NDPrototype40\" class=\"NDPrototype\"><div class=\"PSection PPlainSection\"><span class=\"SHKeyword\">procedure</span> edit_pms_process</div></div><div class=\"TTSummary\">Mehod to persist user entries of page EDIT_PMS</div></div>",41:"<div class=\"NDToolTip TFunction LSQL\"><div id=\"NDPrototype41\" class=\"NDPrototype\"><div class=\"PSection PPlainSection\"><span class=\"SHKeyword\">function</span> edit_pre_validate</div><div class=\"PSection PPlainSection\"><span class=\"SHKeyword\">return boolean</span></div></div><div class=\"TTSummary\">Method to validate page EDIT_PRE</div></div>",42:"<div class=\"NDToolTip TFunction LSQL\"><div id=\"NDPrototype42\" class=\"NDPrototype\"><div class=\"PSection PPlainSection\"><span class=\"SHKeyword\">procedure</span> edit_pre_process</div></div><div class=\"TTSummary\">Mehod to persist user entries of page EDIT_PRE</div></div>",43:"<div class=\"NDToolTip TFunction LSQL\"><div id=\"NDPrototype43\" class=\"NDPrototype\"><div class=\"PSection PPlainSection\"><span class=\"SHKeyword\">function</span> edit_realm_validate</div><div class=\"PSection PPlainSection\"><span class=\"SHKeyword\">return boolean</span></div></div><div class=\"TTSummary\">Method to validate page EDIT_REALM</div></div>",44:"<div class=\"NDToolTip TFunction LSQL\"><div id=\"NDPrototype44\" class=\"NDPrototype\"><div class=\"PSection PPlainSection\"><span class=\"SHKeyword\">procedure</span> edit_realm_process</div></div><div class=\"TTSummary\">Mehod to persist user entries of page EDIT_REALM</div></div>",45:"<div class=\"NDToolTip TFunction LSQL\"><div id=\"NDPrototype45\" class=\"NDPrototype\"><div class=\"PSection PPlainSection\"><span class=\"SHKeyword\">function</span> edit_toggle_validate</div><div class=\"PSection PPlainSection\"><span class=\"SHKeyword\">return boolean</span></div></div><div class=\"TTSummary\">Method to validate page EDIT_TOGGLE</div></div>",46:"<div class=\"NDToolTip TFunction LSQL\"><div id=\"NDPrototype46\" class=\"NDPrototype\"><div class=\"PSection PPlainSection\"><span class=\"SHKeyword\">procedure</span> edit_toggle_process</div></div><div class=\"TTSummary\">Mehod to persist user entries of page EDIT_TOGGLE</div></div>",47:"<div class=\"NDToolTip TFunction LSQL\"><div id=\"NDPrototype47\" class=\"NDPrototype\"><div class=\"PSection PPlainSection\"><span class=\"SHKeyword\">function</span> export_validate</div><div class=\"PSection PPlainSection\"><span class=\"SHKeyword\">return boolean</span></div></div><div class=\"TTSummary\">Method to validate page EXPORT</div></div>",48:"<div class=\"NDToolTip TFunction LSQL\"><div id=\"NDPrototype48\" class=\"NDPrototype\"><div class=\"PSection PPlainSection\"><span class=\"SHKeyword\">procedure</span> export_process</div></div><div class=\"TTSummary\">Mehod to persist user entries of page EXPORT</div></div>",49:"<div class=\"NDToolTip TFunction LSQL\"><div id=\"NDPrototype49\" class=\"NDPrototype\"><div class=\"PSection PPlainSection\"><span class=\"SHKeyword\">function</span> set_realm_validate</div><div class=\"PSection PPlainSection\"><span class=\"SHKeyword\">return boolean</span></div></div><div class=\"TTSummary\">Method to validate page SET_REALM_VALIDATE</div></div>",50:"<div class=\"NDToolTip TFunction LSQL\"><div id=\"NDPrototype50\" class=\"NDPrototype\"><div class=\"PSection PPlainSection\"><span class=\"SHKeyword\">procedure</span> set_realm_process</div></div><div class=\"TTSummary\">Mehod to persist user entries of page SET_REALM</div></div>",153:"<div class=\"NDToolTip TType LSQL\"><div class=\"TTSummary\">Basic char table, used in many methods</div></div>"});