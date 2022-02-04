﻿NDSummary.OnToolTipsLoaded("SQLClass:pit_context",{640:"<div class=\"NDToolTip TClass LSQL\"><div class=\"TTSummary\">Helper package to implement the Context functionality for PIT.</div></div>",642:"<div class=\"NDToolTip TType LSQL\"><div class=\"TTSummary\">PL/SQL-table indexed by pit_util.ora_name_type to hold a list of output modules</div></div>",117:"<div class=\"NDToolTip TFunction LSQL\"><div id=\"NDPrototype117\" class=\"NDPrototype WideForm\"><div class=\"PSection PParameterSection PascalStyle\"><table><tr><td class=\"PBeforeParameters\"><span class=\"SHKeyword\">procedure</span> set_value(</td><td class=\"PParametersParentCell\"><table class=\"PParameters\"><tr><td class=\"PName first\">p_context&nbsp;</td><td class=\"PType\"><span class=\"SHKeyword\">in varchar2</span>,</td><td></td><td class=\"last\"></td></tr><tr><td class=\"PName first\">p_attribute&nbsp;</td><td class=\"PType\"><span class=\"SHKeyword\">in varchar2</span>,</td><td></td><td class=\"last\"></td></tr><tr><td class=\"PName first\">p_value&nbsp;</td><td class=\"PType\"><span class=\"SHKeyword\">in varchar2</span>,</td><td></td><td class=\"last\"></td></tr><tr><td class=\"PName first\">p_client_id&nbsp;</td><td class=\"PType\"><span class=\"SHKeyword\">varchar2</span></td><td class=\"PDefaultValueSeparator\">&nbsp;<span class=\"SHKeyword\">default</span>&nbsp;</td><td class=\"PDefaultValue last\"><span class=\"SHKeyword\">null</span></td></tr></table></td><td class=\"PAfterParameters\">)</td></tr></table></div></div><div class=\"TTSummary\">Sets a parameter value for a given parameter in the context requested. When using the &lt;p_client_id&gt; attribute, a parameter may be set for a given session only and be invisible to other sessions.</div></div>",118:"<div class=\"NDToolTip TFunction LSQL\"><div class=\"TTSummary\">Reads a parameter value for a given parameter from the context requested. When using the &lt;p_client_id&gt; attribute, a parameter may be read that is private for a given session.</div></div>",119:"<div class=\"NDToolTip TFunction LSQL\"><div id=\"NDPrototype119\" class=\"NDPrototype WideForm\"><div class=\"PSection PParameterSection PascalStyle\"><table><tr><td class=\"PBeforeParameters\"><span class=\"SHKeyword\">procedure</span> reset_context(</td><td class=\"PParametersParentCell\"><table class=\"PParameters\"><tr><td class=\"PName first\">p_context&nbsp;</td><td class=\"PType last\"><span class=\"SHKeyword\">in varchar2</span></td></tr></table></td><td class=\"PAfterParameters\">)</td></tr></table></div></div><div class=\"TTSummary\">Procedure to reset one of the available contexts.</div></div>",652:"<div class=\"NDToolTip TFunction LSQL\"><div id=\"NDPrototype652\" class=\"NDPrototype\"><div class=\"PSection PPlainSection\"><span class=\"SHKeyword\">procedure</span> initialize</div></div><div class=\"TTSummary\">Initialization method, called during &lt;PIT_INTERNAL&gt; package initialization.</div></div>",653:"<div class=\"NDToolTip TFunction LSQL\"><div id=\"NDPrototype653\" class=\"NDPrototype WideForm\"><div class=\"PSection PParameterSection PascalStyle\"><table><tr><td class=\"PBeforeParameters\"><span class=\"SHKeyword\">function</span> get_context(</td><td class=\"PParametersParentCell\"><table class=\"PParameters\"><tr><td class=\"PName first\">p_context_name&nbsp;</td><td class=\"PType\"><span class=\"SHKeyword\">in</span> pit_util.ora_name_type</td><td class=\"PDefaultValueSeparator\">&nbsp;<span class=\"SHKeyword\">default</span>&nbsp;</td><td class=\"PDefaultValue last\"><span class=\"SHKeyword\">null</span></td></tr></table></td><td class=\"PAfterParameters\">)</td></tr></table></div><div class=\"PSection PPlainSection\"><span class=\"SHKeyword\">return</span> pit_context_type</div></div><div class=\"TTSummary\">Returns the actually active context.</div></div>",654:"<div class=\"NDToolTip TFunction LSQL\"><div id=\"NDPrototype654\" class=\"NDPrototype WideForm\"><div class=\"PSection PParameterSection PascalStyle\"><table><tr><td class=\"PBeforeParameters\"><span class=\"SHKeyword\">function</span> get_toggle_context(</td><td class=\"PParametersParentCell\"><table class=\"PParameters\"><tr><td class=\"PName first\">p_module&nbsp;</td><td class=\"PType last\"><span class=\"SHKeyword\">in</span> pit_util.ora_name_type,</td></tr><tr><td class=\"PName first\">p_action&nbsp;</td><td class=\"PType last\"><span class=\"SHKeyword\">in</span> pit_util.ora_name_type</td></tr></table></td><td class=\"PAfterParameters\">)</td></tr></table></div><div class=\"PSection PPlainSection\"><span class=\"SHKeyword\">return</span> pit_context_type</div></div><div class=\"TTSummary\">Returns the required context, either the actually active context if no toggle could be found, or the context as required by the toggle.</div></div>",655:"<div class=\"NDToolTip TFunction LSQL\"><div id=\"NDPrototype655\" class=\"NDPrototype WideForm\"><div class=\"PSection PParameterSection PascalStyle\"><table><tr><td class=\"PBeforeParameters\"><span class=\"SHKeyword\">procedure</span> set_context(</td><td class=\"PParametersParentCell\"><table class=\"PParameters\"><tr><td class=\"PName first\">p_context_name&nbsp;</td><td class=\"PType last\"><span class=\"SHKeyword\">in varchar2</span>,</td></tr><tr><td class=\"PName first\">p_context_has_changed&nbsp;</td><td class=\"PType last\"><span class=\"SHKeyword\">out boolean</span></td></tr></table></td><td class=\"PAfterParameters\">)</td></tr></table></div></div><div class=\"TTSummary\">Make the context passed in the actual context.</div></div>",656:"<div class=\"NDToolTip TFunction LSQL\"><div id=\"NDPrototype656\" class=\"NDPrototype WideForm\"><div class=\"PSection PParameterSection PascalStyle\"><table><tr><td class=\"PBeforeParameters\"><span class=\"SHKeyword\">procedure</span> set_value(</td><td class=\"PParametersParentCell\"><table class=\"PParameters\"><tr><td class=\"PName first\">p_attribute&nbsp;</td><td class=\"PType\"><span class=\"SHKeyword\">in varchar2</span>,</td><td></td><td class=\"last\"></td></tr><tr><td class=\"PName first\">p_value&nbsp;</td><td class=\"PType\"><span class=\"SHKeyword\">in varchar2</span>,</td><td></td><td class=\"last\"></td></tr><tr><td class=\"PName first\">p_client_id&nbsp;</td><td class=\"PType\"><span class=\"SHKeyword\">varchar2</span></td><td class=\"PDefaultValueSeparator\">&nbsp;<span class=\"SHKeyword\">default</span>&nbsp;</td><td class=\"PDefaultValue last\"><span class=\"SHKeyword\">null</span></td></tr></table></td><td class=\"PAfterParameters\">)</td></tr></table></div></div><div class=\"TTSummary\">Sets a value in the PIT context. When using the &lt;p_client_id&gt; attribute, a parameter may be set for a given session only and be invisible to other sessions</div></div>",657:"<div class=\"NDToolTip TFunction LSQL\"><div id=\"NDPrototype657\" class=\"NDPrototype WideForm\"><div class=\"PSection PParameterSection PascalStyle\"><table><tr><td class=\"PBeforeParameters\"><span class=\"SHKeyword\">function</span> log_me(</td><td class=\"PParametersParentCell\"><table class=\"PParameters\"><tr><td class=\"PName first\">p_severity&nbsp;</td><td class=\"PType last\"><span class=\"SHKeyword\">in</span> pit_message.pms_pse_id<span class=\"SHKeyword\">%type</span></td></tr></table></td><td class=\"PAfterParameters\">)</td></tr></table></div><div class=\"PSection PPlainSection\"><span class=\"SHKeyword\">return boolean</span></div></div><div class=\"TTSummary\">Decides whether a message has to be logged.</div></div>",658:"<div class=\"NDToolTip TFunction LSQL\"><div id=\"NDPrototype658\" class=\"NDPrototype WideForm\"><div class=\"PSection PParameterSection PascalStyle\"><table><tr><td class=\"PBeforeParameters\"><span class=\"SHKeyword\">function</span> trace_me(</td><td class=\"PParametersParentCell\"><table class=\"PParameters\"><tr><td class=\"PName first\">p_trace_level&nbsp;</td><td class=\"PType last\"><span class=\"SHKeyword\">in integer</span></td></tr></table></td><td class=\"PAfterParameters\">)</td></tr></table></div><div class=\"PSection PPlainSection\"><span class=\"SHKeyword\">return boolean</span></div></div><div class=\"TTSummary\">Decides whether a message has to be traced.</div></div>",659:"<div class=\"NDToolTip TFunction LSQL\"><div id=\"NDPrototype659\" class=\"NDPrototype\"><div class=\"PSection PPlainSection\"><span class=\"SHKeyword\">function</span> trace_timing</div><div class=\"PSection PPlainSection\"><span class=\"SHKeyword\">return boolean</span></div></div><div class=\"TTSummary\">Decides whether timing information has to be captured</div></div>",660:"<div class=\"NDToolTip TFunction LSQL\"><div id=\"NDPrototype660\" class=\"NDPrototype\"><div class=\"PSection PPlainSection\"><span class=\"SHKeyword\">function</span> allows_toggle</div><div class=\"PSection PPlainSection\"><span class=\"SHKeyword\">return boolean</span></div></div><div class=\"TTSummary\">Decides whether toggles are set active actually</div></div>",661:"<div class=\"NDToolTip TFunction LSQL\"><div id=\"NDPrototype661\" class=\"NDPrototype\"><div class=\"PSection PPlainSection\"><span class=\"SHKeyword\">function</span> get_log_level</div><div class=\"PSection PPlainSection\"><span class=\"SHKeyword\">return</span> binary_integer</div></div><div class=\"TTSummary\">Method returns the actually set log level.</div></div>",662:"<div class=\"NDToolTip TFunction LSQL\"><div id=\"NDPrototype662\" class=\"NDPrototype\"><div class=\"PSection PPlainSection\"><span class=\"SHKeyword\">function</span> get_trace_level</div><div class=\"PSection PPlainSection\"><span class=\"SHKeyword\">return</span> binary_integer</div></div><div class=\"TTSummary\">Method returns the actually set trace level.</div></div>",664:"<div class=\"NDToolTip TFunction LSQL\"><div id=\"NDPrototype664\" class=\"NDPrototype\"><div class=\"PSection PPlainSection\"><span class=\"SHKeyword\">function</span> get_available_modules</div><div class=\"PSection PPlainSection\"><span class=\"SHKeyword\">return</span> pit_module_tab</div></div><div class=\"TTSummary\">Getter Function for the available modules list</div></div>",665:"<div class=\"NDToolTip TFunction LSQL\"><div id=\"NDPrototype665\" class=\"NDPrototype\"><div class=\"PSection PPlainSection\"><span class=\"SHKeyword\">function</span> get_active_modules</div><div class=\"PSection PPlainSection\"><span class=\"SHKeyword\">return</span> pit_module_tab</div></div><div class=\"TTSummary\">Getter Function for the active modules list</div></div>",666:"<div class=\"NDToolTip TFunction LSQL\"><div id=\"NDPrototype666\" class=\"NDPrototype\"><div class=\"PSection PPlainSection\"><span class=\"SHKeyword\">function</span> report_module_status</div><div class=\"PSection PPlainSection\"><span class=\"SHKeyword\">return</span> pit_args <span class=\"SHMetadata\">pipelined</span></div></div><div class=\"TTSummary\">Function to retrieve status of all modules</div></div>",667:"<div class=\"NDToolTip TFunction LSQL\"><div id=\"NDPrototype667\" class=\"NDPrototype WideForm\"><div class=\"PSection PParameterSection PascalStyle\"><table><tr><td class=\"PBeforeParameters\"><span class=\"SHKeyword\">procedure</span> validate_context(</td><td class=\"PParametersParentCell\"><table class=\"PParameters\"><tr><td class=\"PName first\">p_settings&nbsp;</td><td class=\"PType last\"><span class=\"SHKeyword\">in varchar2</span></td></tr></table></td><td class=\"PAfterParameters\">)</td></tr></table></div></div><div class=\"TTSummary\">Method to validate the context parameters. Is called from within the constructor method with a pre-populated instance of a context type.</div></div>",668:"<div class=\"NDToolTip TFunction LSQL\"><div id=\"NDPrototype668\" class=\"NDPrototype WideForm\"><div class=\"PSection PParameterSection PascalStyle\"><table><tr><td class=\"PBeforeParameters\"><span class=\"SHKeyword\">procedure</span> instantiate_pit_context_type(</td><td class=\"PParametersParentCell\"><table class=\"PParameters\"><tr><td class=\"PName first\">p_self&nbsp;</td><td class=\"PType\"><span class=\"SHKeyword\">in out nocopy</span> pit_context_type,</td><td></td><td class=\"last\"></td></tr><tr><td class=\"PName first\">p_settings&nbsp;</td><td class=\"PType\"><span class=\"SHKeyword\">in varchar2</span>,</td><td></td><td class=\"last\"></td></tr><tr><td class=\"PName first\">p_context_name&nbsp;</td><td class=\"PType\"><span class=\"SHKeyword\">in varchar2</span></td><td class=\"PDefaultValueSeparator\">&nbsp;<span class=\"SHKeyword\">default</span>&nbsp;</td><td class=\"PDefaultValue last\"><span class=\"SHKeyword\">null</span></td></tr></table></td><td class=\"PAfterParameters\">)</td></tr></table></div></div><div class=\"TTSummary\">Constructor Function for a pit_context_type instance, overload with a string settings parameter.</div></div>"});