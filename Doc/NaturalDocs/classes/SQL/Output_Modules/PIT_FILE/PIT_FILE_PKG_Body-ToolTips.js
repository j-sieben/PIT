﻿NDContentPage.OnToolTipsLoaded({130:"<div class=\"NDToolTip TType LSQL\"><div class=\"TTSummary\">Is used to collect a call stack entry</div></div>",156:"<div class=\"NDToolTip TType LSQL\"><div class=\"TTSummary\">Table of msg_param instances.</div></div>",178:"<div class=\"NDToolTip TType LSQL\"><div class=\"TTSummary\">Core message type. Is used to collect the message, severity and other useful information around messages</div></div>",432:"<div class=\"NDToolTip TClass LSQL\"><div class=\"TTSummary\">Helper package to implement the Call Stack functionality for PIT.</div></div>",548:"<div class=\"NDToolTip TClass LSQL\"><div class=\"TTSummary\">PIT-API package. Declares the API that is required to use PIT.</div></div>",894:"<div class=\"NDToolTip TClass LSQL\"><div class=\"TTSummary\">Output module to write information to a trace file. Extends PIT_MODULE.</div></div>",903:"<div class=\"NDToolTip TFunction LSQL\"><div id=\"NDPrototype903\" class=\"NDPrototype WideForm\"><div class=\"PSection PParameterSection PascalStyle\"><table><tr><td class=\"PBeforeParameters\"><span class=\"SHKeyword\">procedure</span> log (</td><td class=\"PParametersParentCell\"><table class=\"PParameters\"><tr><td class=\"PName first\">p_message&nbsp;</td><td class=\"PType last\"><span class=\"SHKeyword\">in</span> message_type</td></tr></table></td><td class=\"PAfterParameters\">)</td></tr></table></div></div><div class=\"TTSummary\">Method to write log information to a trace file.</div></div>",905:"<div class=\"NDToolTip TFunction LSQL\"><div id=\"NDPrototype905\" class=\"NDPrototype\"><div class=\"PSection PPlainSection\"><span class=\"SHKeyword\">procedure</span> purge</div></div><div class=\"TTSummary\">Method to purge log information from tables PIT_TABLE_LOG, PIT_TABLE_CALL_STACK and PIT_TABLE_PARAMS.</div></div>",906:"<div class=\"NDToolTip TFunction LSQL\"><div id=\"NDPrototype906\" class=\"NDPrototype WideForm\"><div class=\"PSection PParameterSection PascalStyle\"><table><tr><td class=\"PBeforeParameters\"><span class=\"SHKeyword\">procedure</span> enter(</td><td class=\"PParametersParentCell\"><table class=\"PParameters\"><tr><td class=\"PName first\">p_call_stack&nbsp;</td><td class=\"PType last\"><span class=\"SHKeyword\">in</span> pit_call_stack_type</td></tr></table></td><td class=\"PAfterParameters\">)</td></tr></table></div></div><div class=\"TTSummary\">Method to write call stack information on enter to a trace file</div></div>",907:"<div class=\"NDToolTip TFunction LSQL\"><div id=\"NDPrototype907\" class=\"NDPrototype WideForm\"><div class=\"PSection PParameterSection PascalStyle\"><table><tr><td class=\"PBeforeParameters\"><span class=\"SHKeyword\">procedure</span> leave(</td><td class=\"PParametersParentCell\"><table class=\"PParameters\"><tr><td class=\"PName first\">p_call_stack&nbsp;</td><td class=\"PType last\"><span class=\"SHKeyword\">in</span> pit_call_stack_type</td></tr></table></td><td class=\"PAfterParameters\">)</td></tr></table></div></div><div class=\"TTSummary\">Method to write call stack information on leave to a trace file</div></div>",908:"<div class=\"NDToolTip TFunction LSQL\"><div id=\"NDPrototype908\" class=\"NDPrototype WideForm\"><div class=\"PSection PParameterSection PascalStyle\"><table><tr><td class=\"PBeforeParameters\"><span class=\"SHKeyword\">procedure</span> initialize_module(</td><td class=\"PParametersParentCell\"><table class=\"PParameters\"><tr><td class=\"PName first\">self&nbsp;</td><td class=\"PType last\"><span class=\"SHKeyword\">in out</span> pit_file</td></tr></table></td><td class=\"PAfterParameters\">)</td></tr></table></div></div><div class=\"TTSummary\">Method implements the parameterless pit_file constructor of type PIT_FILE. The output module is available if it is possible to open the trace file.</div></div>",932:"<div class=\"NDToolTip TFunction LSQL\"><div id=\"NDPrototype932\" class=\"NDPrototype WideForm\"><div class=\"PSection PParameterSection PascalStyle\"><table><tr><td class=\"PBeforeParameters\"><span class=\"SHKeyword\">procedure</span> initialize_module(</td><td class=\"PParametersParentCell\"><table class=\"PParameters\"><tr><td class=\"PName first\">self&nbsp;</td><td class=\"PType last\"><span class=\"SHKeyword\">in out</span> pit_file</td></tr></table></td><td class=\"PAfterParameters\">)</td></tr></table></div></div><div class=\"TTSummary\">see pit_file_pkg.initialize_module</div></div>"});