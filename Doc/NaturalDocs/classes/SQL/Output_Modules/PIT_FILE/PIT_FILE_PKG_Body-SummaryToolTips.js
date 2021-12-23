﻿NDSummary.OnToolTipsLoaded("SQLClass:Output_Modules.PIT_FILE.PIT_FILE_PKG_Body",{548:"<div class=\"NDToolTip TClass LSQL\"><div class=\"TTSummary\">Implements MODULE.PIT_FILE output module methods</div></div>",719:"<div class=\"NDToolTip TFunction LSQL\"><div id=\"NDPrototype719\" class=\"NDPrototype\"><div class=\"PSection PPlainSection\"><span class=\"SHKeyword\">procedure</span> initialize</div></div><div class=\"TTSummary\">Initialization method.</div></div>",721:"<div class=\"NDToolTip TFunction LSQL\"><div id=\"NDPrototype721\" class=\"NDPrototype WideForm\"><div class=\"PSection PParameterSection PascalStyle\"><table><tr><td class=\"PBeforeParameters\"><span class=\"SHKeyword\">procedure</span> open_file(</td><td class=\"PParametersParentCell\"><table class=\"PParameters\"><tr><td class=\"PName first\">p_write_mode&nbsp;</td><td class=\"PType last\"><span class=\"SHKeyword\">in char</span></td></tr></table></td><td class=\"PAfterParameters\">)</td></tr></table></div></div><div class=\"TTSummary\">Helper method to open the log file. Is called to prepare the log file for writing.</div></div>",722:"<div class=\"NDToolTip TFunction LSQL\"><div id=\"NDPrototype722\" class=\"NDPrototype\"><div class=\"PSection PPlainSection\"><span class=\"SHKeyword\">procedure</span> close_file</div></div><div class=\"TTSummary\">Helper to close the log file. Is called to close the log file and release the resources.</div></div>",723:"<div class=\"NDToolTip TFunction LSQL\"><div id=\"NDPrototype723\" class=\"NDPrototype WideForm\"><div class=\"PSection PParameterSection PascalStyle\"><table><tr><td class=\"PBeforeParameters\"><span class=\"SHKeyword\">procedure</span> write_call_stack(</td><td class=\"PParametersParentCell\"><table class=\"PParameters\"><tr><td class=\"PName first\">p_call_stack&nbsp;</td><td class=\"PType last\"><span class=\"SHKeyword\">in</span> pit_call_stack_type,</td></tr><tr><td class=\"PName first\">p_template&nbsp;</td><td class=\"PType last\"><span class=\"SHKeyword\">in varchar2</span></td></tr></table></td><td class=\"PAfterParameters\">)</td></tr></table></div></div><div class=\"TTSummary\">Helper to format call stack entries to write them to the log file.</div></div>",725:"<div class=\"NDToolTip TFunction LSQL\"><div id=\"NDPrototype725\" class=\"NDPrototype WideForm\"><div class=\"PSection PParameterSection PascalStyle\"><table><tr><td class=\"PBeforeParameters\"><span class=\"SHKeyword\">procedure</span> log(</td><td class=\"PParametersParentCell\"><table class=\"PParameters\"><tr><td class=\"PName first\">p_message&nbsp;</td><td class=\"PType last\"><span class=\"SHKeyword\">in</span> message_type</td></tr></table></td><td class=\"PAfterParameters\">)</td></tr></table></div></div><div class=\"TTSummary\">see pit_file_pkg.log</div></div>",726:"<div class=\"NDToolTip TFunction LSQL\"><div id=\"NDPrototype726\" class=\"NDPrototype WideForm\"><div class=\"PSection PParameterSection PascalStyle\"><table><tr><td class=\"PBeforeParameters\"><span class=\"SHKeyword\">procedure</span> log(</td><td class=\"PParametersParentCell\"><table class=\"PParameters\"><tr><td class=\"PName first\">p_params&nbsp;</td><td class=\"PType last\"><span class=\"SHKeyword\">in</span> msg_params</td></tr></table></td><td class=\"PAfterParameters\">)</td></tr></table></div></div><div class=\"TTSummary\">see pit_file_pkg.log</div></div>",727:"<div class=\"NDToolTip TFunction LSQL\"><div id=\"NDPrototype727\" class=\"NDPrototype\"><div class=\"PSection PPlainSection\"><span class=\"SHKeyword\">procedure</span> purge</div></div><div class=\"TTSummary\">see pit_file_pkg.purge</div></div>",728:"<div class=\"NDToolTip TFunction LSQL\"><div id=\"NDPrototype728\" class=\"NDPrototype WideForm\"><div class=\"PSection PParameterSection PascalStyle\"><table><tr><td class=\"PBeforeParameters\"><span class=\"SHKeyword\">procedure</span> enter(</td><td class=\"PParametersParentCell\"><table class=\"PParameters\"><tr><td class=\"PName first\">p_call_stack&nbsp;</td><td class=\"PType last\"><span class=\"SHKeyword\">in</span> pit_call_stack_type</td></tr></table></td><td class=\"PAfterParameters\">)</td></tr></table></div></div><div class=\"TTSummary\">see pit_file_pkg.enter</div></div>",729:"<div class=\"NDToolTip TFunction LSQL\"><div id=\"NDPrototype729\" class=\"NDPrototype WideForm\"><div class=\"PSection PParameterSection PascalStyle\"><table><tr><td class=\"PBeforeParameters\"><span class=\"SHKeyword\">procedure</span> leave(</td><td class=\"PParametersParentCell\"><table class=\"PParameters\"><tr><td class=\"PName first\">p_call_stack&nbsp;</td><td class=\"PType last\"><span class=\"SHKeyword\">in</span> pit_call_stack_type</td></tr></table></td><td class=\"PAfterParameters\">)</td></tr></table></div></div><div class=\"TTSummary\">see pit_file_pkg.leave</div></div>",730:"<div class=\"NDToolTip TFunction LSQL\"><div id=\"NDPrototype730\" class=\"NDPrototype WideForm\"><div class=\"PSection PParameterSection PascalStyle\"><table><tr><td class=\"PBeforeParameters\"><span class=\"SHKeyword\">procedure</span> initialize_module(</td><td class=\"PParametersParentCell\"><table class=\"PParameters\"><tr><td class=\"PName first\">self&nbsp;</td><td class=\"PType last\"><span class=\"SHKeyword\">in out</span> pit_file</td></tr></table></td><td class=\"PAfterParameters\">)</td></tr></table></div></div><div class=\"TTSummary\">see pit_file_pkg.initialize_module</div></div>"});