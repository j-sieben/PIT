﻿NDSummary.OnToolTipsLoaded("SQLClass:PIT_CONTEXT_Body",{174:"<div class=\"NDToolTip TClass LSQL\"><div class=\"TTSummary\">Implementation of generic utitilies for PIT.</div></div>",194:"<div class=\"NDToolTip TFunction LSQL\"><div id=\"NDPrototype194\" class=\"NDPrototype WideForm\"><div class=\"PSection PParameterSection PascalStyle\"><table><tr><td class=\"PBeforeParameters\"><span class=\"SHKeyword\">function</span> module_to_meta(</td><td class=\"PParametersParentCell\"><table class=\"PParameters\"><tr><td class=\"PName first\">p_module&nbsp;</td><td class=\"PType last\"><span class=\"SHKeyword\">in</span> pit_util.ora_name_type</td></tr></table></td><td class=\"PAfterParameters\">)</td></tr></table></div><div class=\"PSection PPlainSection\"><span class=\"SHKeyword\">return</span> pit_module_meta</div></div><div class=\"TTSummary\">Method to instantiate an instance of pit_module_meta from a given module.&nbsp; Is used to present an overview of the module status for the installed modules</div></div>",195:"<div class=\"NDToolTip TFunction LSQL\"><div id=\"NDPrototype195\" class=\"NDPrototype\"><div class=\"PSection PPlainSection\"><span class=\"SHKeyword\">procedure</span> get_context_list</div></div><div class=\"TTSummary\">Reads all predefined context and toggles from parameters and stores it in globally accessed context.&nbsp; Method is invoked during initialization to copy parameter settings for access across sessions.</div></div>",196:"<div class=\"NDToolTip TFunction LSQL\"><div id=\"NDPrototype196\" class=\"NDPrototype\"><div class=\"PSection PPlainSection\"><span class=\"SHKeyword\">procedure</span> set_active_modules</div></div><div class=\"TTSummary\">Copies all requested and available output module instances into g_active_modules.&nbsp; These modules will then be used to log to.</div></div>",197:"<div class=\"NDToolTip TFunction LSQL\"><div id=\"NDPrototype197\" class=\"NDPrototype\"><div class=\"PSection PPlainSection\"><span class=\"SHKeyword\">procedure</span> get_active_context</div></div><div class=\"TTSummary\">Method to read the actually chosen context from the global context. Is used to read the actual settings, as they may have changed based on settings in other sessions.</div></div>",198:"<div class=\"NDToolTip TFunction LSQL\"><div id=\"NDPrototype198\" class=\"NDPrototype\"><div class=\"PSection PPlainSection\"><span class=\"SHKeyword\">procedure</span> initialize</div></div><div class=\"TTSummary\">See pit_context.initialize</div></div>",199:"<div class=\"NDToolTip TFunction LSQL\"><div id=\"NDPrototype199\" class=\"NDPrototype WideForm\"><div class=\"PSection PParameterSection PascalStyle\"><table><tr><td class=\"PBeforeParameters\"><span class=\"SHKeyword\">function</span> get_context(</td><td class=\"PParametersParentCell\"><table class=\"PParameters\"><tr><td class=\"PName first\">p_context_name&nbsp;</td><td class=\"PType\"><span class=\"SHKeyword\">in</span> pit_util.ora_name_type</td><td class=\"PDefaultValueSeparator\">&nbsp;<span class=\"SHKeyword\">default</span>&nbsp;</td><td class=\"PDefaultValue last\"><span class=\"SHKeyword\">null</span></td></tr></table></td><td class=\"PAfterParameters\">)</td></tr></table></div><div class=\"PSection PPlainSection\"><span class=\"SHKeyword\">return</span> pit_context_type</div></div><div class=\"TTSummary\">See pit_context.get_context</div></div>",200:"<div class=\"NDToolTip TFunction LSQL\"><div id=\"NDPrototype200\" class=\"NDPrototype WideForm\"><div class=\"PSection PParameterSection PascalStyle\"><table><tr><td class=\"PBeforeParameters\"><span class=\"SHKeyword\">function</span> get_toggle_context(</td><td class=\"PParametersParentCell\"><table class=\"PParameters\"><tr><td class=\"PName first\">p_module&nbsp;</td><td class=\"PType last\"><span class=\"SHKeyword\">in</span> pit_util.ora_name_type,</td></tr><tr><td class=\"PName first\">p_action&nbsp;</td><td class=\"PType last\"><span class=\"SHKeyword\">in</span> pit_util.ora_name_type</td></tr></table></td><td class=\"PAfterParameters\">)</td></tr></table></div><div class=\"PSection PPlainSection\"><span class=\"SHKeyword\">return</span> pit_context_type</div></div><div class=\"TTSummary\">See pit_context.get_toggle_context</div></div>",201:"<div class=\"NDToolTip TFunction LSQL\"><div id=\"NDPrototype201\" class=\"NDPrototype WideForm\"><div class=\"PSection PParameterSection PascalStyle\"><table><tr><td class=\"PBeforeParameters\"><span class=\"SHKeyword\">procedure</span> set_context(</td><td class=\"PParametersParentCell\"><table class=\"PParameters\"><tr><td class=\"PName first\">p_context_name&nbsp;</td><td class=\"PType last\"><span class=\"SHKeyword\">in varchar2</span>,</td></tr><tr><td class=\"PName first\">p_context_has_changed&nbsp;</td><td class=\"PType last\"><span class=\"SHKeyword\">out boolean</span></td></tr></table></td><td class=\"PAfterParameters\">)</td></tr></table></div></div><div class=\"TTSummary\">See pit_context.set_context</div></div>",202:"<div class=\"NDToolTip TFunction LSQL\"><div id=\"NDPrototype202\" class=\"NDPrototype WideForm\"><div class=\"PSection PParameterSection PascalStyle\"><table><tr><td class=\"PBeforeParameters\"><span class=\"SHKeyword\">procedure</span> set_context(</td><td class=\"PParametersParentCell\"><table class=\"PParameters\"><tr><td class=\"PName first\">p_log_level&nbsp;</td><td class=\"PType last\"><span class=\"SHKeyword\">in integer</span>,</td></tr><tr><td class=\"PName first\">p_trace_level&nbsp;</td><td class=\"PType last\"><span class=\"SHKeyword\">in integer</span>,</td></tr><tr><td class=\"PName first\">p_trace_timing&nbsp;</td><td class=\"PType last\"><span class=\"SHKeyword\">in</span> pit_util.flag_type,</td></tr><tr><td class=\"PName first\">p_log_modules&nbsp;</td><td class=\"PType last\"><span class=\"SHKeyword\">in varchar2</span>,</td></tr><tr><td class=\"PName first\">p_context_has_changed&nbsp;</td><td class=\"PType last\"><span class=\"SHKeyword\">out boolean</span></td></tr></table></td><td class=\"PAfterParameters\">)</td></tr></table></div></div><div class=\"TTSummary\">See pit_context.set_context</div></div>",203:"<div class=\"NDToolTip TFunction LSQL\"><div id=\"NDPrototype203\" class=\"NDPrototype WideForm\"><div class=\"PSection PParameterSection PascalStyle\"><table><tr><td class=\"PBeforeParameters\"><span class=\"SHKeyword\">procedure</span> set_context(</td><td class=\"PParametersParentCell\"><table class=\"PParameters\"><tr><td class=\"PName first\">p_settings&nbsp;</td><td class=\"PType last\"><span class=\"SHKeyword\">in varchar2</span>,</td></tr><tr><td class=\"PName first\">p_context_has_changed&nbsp;</td><td class=\"PType last\"><span class=\"SHKeyword\">out boolean</span></td></tr></table></td><td class=\"PAfterParameters\">)</td></tr></table></div></div><div class=\"TTSummary\">See pit_context.set_context</div></div>",204:"<div class=\"NDToolTip TFunction LSQL\"><div id=\"NDPrototype204\" class=\"NDPrototype WideForm\"><div class=\"PSection PParameterSection PascalStyle\"><table><tr><td class=\"PBeforeParameters\"><span class=\"SHKeyword\">procedure</span> set_context(</td><td class=\"PParametersParentCell\"><table class=\"PParameters\"><tr><td class=\"PName first\">p_context&nbsp;</td><td class=\"PType last\"><span class=\"SHKeyword\">in</span> pit_context_type,</td></tr><tr><td class=\"PName first\">p_context_has_changed&nbsp;</td><td class=\"PType last\"><span class=\"SHKeyword\">out boolean</span></td></tr></table></td><td class=\"PAfterParameters\">)</td></tr></table></div></div><div class=\"TTSummary\">See pit_context.set_context</div></div>",205:"<div class=\"NDToolTip TFunction LSQL\"><div id=\"NDPrototype205\" class=\"NDPrototype WideForm\"><div class=\"PSection PParameterSection PascalStyle\"><table><tr><td class=\"PBeforeParameters\"><span class=\"SHKeyword\">function</span> get_value(</td><td class=\"PParametersParentCell\"><table class=\"PParameters\"><tr><td class=\"PName first\">p_attribute&nbsp;</td><td class=\"PType\"><span class=\"SHKeyword\">in varchar2</span>,</td><td></td><td class=\"last\"></td></tr><tr><td class=\"PName first\">p_client_id&nbsp;</td><td class=\"PType\"><span class=\"SHKeyword\">varchar2</span></td><td class=\"PDefaultValueSeparator\">&nbsp;<span class=\"SHKeyword\">default</span>&nbsp;</td><td class=\"PDefaultValue last\"><span class=\"SHKeyword\">null</span></td></tr></table></td><td class=\"PAfterParameters\">)</td></tr></table></div><div class=\"PSection PPlainSection\"><span class=\"SHKeyword\">return varchar2</span></div></div><div class=\"TTSummary\">See &lt;pit_context.get_value&gt;</div></div>",206:"<div class=\"NDToolTip TFunction LSQL\"><div id=\"NDPrototype206\" class=\"NDPrototype WideForm\"><div class=\"PSection PParameterSection PascalStyle\"><table><tr><td class=\"PBeforeParameters\"><span class=\"SHKeyword\">procedure</span> set_value(</td><td class=\"PParametersParentCell\"><table class=\"PParameters\"><tr><td class=\"PName first\">p_attribute&nbsp;</td><td class=\"PType\"><span class=\"SHKeyword\">in varchar2</span>,</td><td></td><td class=\"last\"></td></tr><tr><td class=\"PName first\">p_value&nbsp;</td><td class=\"PType\"><span class=\"SHKeyword\">in varchar2</span>,</td><td></td><td class=\"last\"></td></tr><tr><td class=\"PName first\">p_client_id&nbsp;</td><td class=\"PType\"><span class=\"SHKeyword\">varchar2</span></td><td class=\"PDefaultValueSeparator\">&nbsp;<span class=\"SHKeyword\">default</span>&nbsp;</td><td class=\"PDefaultValue last\"><span class=\"SHKeyword\">null</span></td></tr></table></td><td class=\"PAfterParameters\">)</td></tr></table></div></div><div class=\"TTSummary\">See pit_context.set_value</div></div>",207:"<div class=\"NDToolTip TFunction LSQL\"><div id=\"NDPrototype207\" class=\"NDPrototype WideForm\"><div class=\"PSection PParameterSection PascalStyle\"><table><tr><td class=\"PBeforeParameters\"><span class=\"SHKeyword\">function</span> log_me(</td><td class=\"PParametersParentCell\"><table class=\"PParameters\"><tr><td class=\"PName first\">p_severity&nbsp;</td><td class=\"PType last\"><span class=\"SHKeyword\">in</span> pit_message.pms_pse_id<span class=\"SHKeyword\">%type</span></td></tr></table></td><td class=\"PAfterParameters\">)</td></tr></table></div><div class=\"PSection PPlainSection\"><span class=\"SHKeyword\">return boolean</span></div></div><div class=\"TTSummary\">See pit_context.log_me</div></div>",208:"<div class=\"NDToolTip TFunction LSQL\"><div id=\"NDPrototype208\" class=\"NDPrototype WideForm\"><div class=\"PSection PParameterSection PascalStyle\"><table><tr><td class=\"PBeforeParameters\"><span class=\"SHKeyword\">function</span> trace_me(</td><td class=\"PParametersParentCell\"><table class=\"PParameters\"><tr><td class=\"PName first\">p_trace_level&nbsp;</td><td class=\"PType last\"><span class=\"SHKeyword\">in integer</span></td></tr></table></td><td class=\"PAfterParameters\">)</td></tr></table></div><div class=\"PSection PPlainSection\"><span class=\"SHKeyword\">return boolean</span></div></div><div class=\"TTSummary\">See pit_context.trace_me</div></div>",209:"<div class=\"NDToolTip TFunction LSQL\"><div id=\"NDPrototype209\" class=\"NDPrototype\"><div class=\"PSection PPlainSection\"><span class=\"SHKeyword\">function</span> trace_timing</div><div class=\"PSection PPlainSection\"><span class=\"SHKeyword\">return boolean</span></div></div><div class=\"TTSummary\">See pit_context.trace_timing</div></div>",210:"<div class=\"NDToolTip TFunction LSQL\"><div id=\"NDPrototype210\" class=\"NDPrototype\"><div class=\"PSection PPlainSection\"><span class=\"SHKeyword\">function</span> allows_toggle</div><div class=\"PSection PPlainSection\"><span class=\"SHKeyword\">return boolean</span></div></div><div class=\"TTSummary\">See pit_context.allows_toggle</div></div>",211:"<div class=\"NDToolTip TFunction LSQL\"><div id=\"NDPrototype211\" class=\"NDPrototype\"><div class=\"PSection PPlainSection\"><span class=\"SHKeyword\">function</span> get_log_level</div><div class=\"PSection PPlainSection\"><span class=\"SHKeyword\">return</span> binary_integer</div></div><div class=\"TTSummary\">See PIT_CONTEXT.get_log_level</div></div>",212:"<div class=\"NDToolTip TFunction LSQL\"><div id=\"NDPrototype212\" class=\"NDPrototype\"><div class=\"PSection PPlainSection\"><span class=\"SHKeyword\">function</span> get_trace_level</div><div class=\"PSection PPlainSection\"><span class=\"SHKeyword\">return</span> binary_integer</div></div><div class=\"TTSummary\">See PIT_CONTEXT.get_trace_level</div></div>",213:"<div class=\"NDToolTip TFunction LSQL\"><div id=\"NDPrototype213\" class=\"NDPrototype WideForm\"><div class=\"PSection PParameterSection PascalStyle\"><table><tr><td class=\"PBeforeParameters\"><span class=\"SHKeyword\">function</span> get_modules(</td><td class=\"PParametersParentCell\"><table class=\"PParameters\"><tr><td class=\"PName first\">p_focus&nbsp;</td><td class=\"PType last\"><span class=\"SHKeyword\">in binary_integer</span></td></tr></table></td><td class=\"PAfterParameters\">)</td></tr></table></div><div class=\"PSection PPlainSection\"><span class=\"SHKeyword\">return</span> pit_module_list</div></div><div class=\"TTSummary\">See &lt;pit_context.get_modules&gt;</div></div>",214:"<div class=\"NDToolTip TFunction LSQL\"><div id=\"NDPrototype214\" class=\"NDPrototype\"><div class=\"PSection PPlainSection\"><span class=\"SHKeyword\">function</span> get_available_modules</div><div class=\"PSection PPlainSection\"><span class=\"SHKeyword\">return</span> pit_module_tab</div></div><div class=\"TTSummary\">See &lt;PIT_INTERNAL.get_available_modules&gt;</div></div>",215:"<div class=\"NDToolTip TFunction LSQL\"><div id=\"NDPrototype215\" class=\"NDPrototype\"><div class=\"PSection PPlainSection\"><span class=\"SHKeyword\">function</span> get_active_modules</div><div class=\"PSection PPlainSection\"><span class=\"SHKeyword\">return</span> pit_module_tab</div></div><div class=\"TTSummary\">See &lt;PIT_INTERNAL.get_active_modules&gt;</div></div>",216:"<div class=\"NDToolTip TFunction LSQL\"><div id=\"NDPrototype216\" class=\"NDPrototype\"><div class=\"PSection PPlainSection\"><span class=\"SHKeyword\">function</span> report_module_status</div><div class=\"PSection PPlainSection\"><span class=\"SHKeyword\">return</span> pit_args <span class=\"SHMetadata\">pipelined</span></div></div><div class=\"TTSummary\">See &lt;PIT_INTERNAL.report_module_status&gt;</div></div>",217:"<div class=\"NDToolTip TFunction LSQL\"><div id=\"NDPrototype217\" class=\"NDPrototype WideForm\"><div class=\"PSection PParameterSection PascalStyle\"><table><tr><td class=\"PBeforeParameters\"><span class=\"SHKeyword\">procedure</span> validate_context(</td><td class=\"PParametersParentCell\"><table class=\"PParameters\"><tr><td class=\"PName first\">p_settings&nbsp;</td><td class=\"PType last\"><span class=\"SHKeyword\">in varchar2</span></td></tr></table></td><td class=\"PAfterParameters\">)</td></tr></table></div></div><div class=\"TTSummary\">See &lt;PIT_INTERNAL.validate_context&gt;</div></div>",218:"<div class=\"NDToolTip TFunction LSQL\"><div id=\"NDPrototype218\" class=\"NDPrototype WideForm\"><div class=\"PSection PParameterSection PascalStyle\"><table><tr><td class=\"PBeforeParameters\"><span class=\"SHKeyword\">procedure</span> instantiate_pit_context_type(</td><td class=\"PParametersParentCell\"><table class=\"PParameters\"><tr><td class=\"PName first\">p_self&nbsp;</td><td class=\"PType\"><span class=\"SHKeyword\">in out nocopy</span> pit_context_type,</td><td></td><td class=\"last\"></td></tr><tr><td class=\"PName first\">p_settings&nbsp;</td><td class=\"PType\"><span class=\"SHKeyword\">in varchar2</span>,</td><td></td><td class=\"last\"></td></tr><tr><td class=\"PName first\">p_context_name&nbsp;</td><td class=\"PType\"><span class=\"SHKeyword\">in varchar2</span></td><td class=\"PDefaultValueSeparator\">&nbsp;<span class=\"SHKeyword\">default</span>&nbsp;</td><td class=\"PDefaultValue last\"><span class=\"SHKeyword\">null</span></td></tr></table></td><td class=\"PAfterParameters\">)</td></tr></table></div></div><div class=\"TTSummary\">See pit_context.instantiate_pit_context_type</div></div>"});