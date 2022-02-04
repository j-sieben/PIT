﻿NDSummary.OnToolTipsLoaded("File:modules/pit_file/packages/pit_file_pkg.pkb",{909:"<div class=\"NDToolTip TClass LSQL\"><div class=\"TTSummary\">Implements MODULE.PIT_FILE output module methods</div></div>",921:"<div class=\"NDToolTip TFunction LSQL\"><div id=\"NDPrototype921\" class=\"NDPrototype\"><div class=\"PSection PPlainSection\"><span class=\"SHKeyword\">procedure</span> initialize</div></div><div class=\"TTSummary\">Initialization method.</div></div>",923:"<div class=\"NDToolTip TFunction LSQL\"><div id=\"NDPrototype923\" class=\"NDPrototype WideForm\"><div class=\"PSection PParameterSection PascalStyle\"><table><tr><td class=\"PBeforeParameters\"><span class=\"SHKeyword\">procedure</span> open_file(</td><td class=\"PParametersParentCell\"><table class=\"PParameters\"><tr><td class=\"PName first\">p_write_mode&nbsp;</td><td class=\"PType last\"><span class=\"SHKeyword\">in char</span></td></tr></table></td><td class=\"PAfterParameters\">)</td></tr></table></div></div><div class=\"TTSummary\">Helper method to open the log file. Is called to prepare the log file for writing.</div></div>",924:"<div class=\"NDToolTip TFunction LSQL\"><div id=\"NDPrototype924\" class=\"NDPrototype\"><div class=\"PSection PPlainSection\"><span class=\"SHKeyword\">procedure</span> close_file</div></div><div class=\"TTSummary\">Helper to close the log file. Is called to close the log file and release the resources.</div></div>",925:"<div class=\"NDToolTip TFunction LSQL\"><div id=\"NDPrototype925\" class=\"NDPrototype WideForm\"><div class=\"PSection PParameterSection PascalStyle\"><table><tr><td class=\"PBeforeParameters\"><span class=\"SHKeyword\">procedure</span> write_call_stack(</td><td class=\"PParametersParentCell\"><table class=\"PParameters\"><tr><td class=\"PName first\">p_call_stack&nbsp;</td><td class=\"PType last\"><span class=\"SHKeyword\">in</span> pit_call_stack_type,</td></tr><tr><td class=\"PName first\">p_template&nbsp;</td><td class=\"PType last\"><span class=\"SHKeyword\">in varchar2</span></td></tr></table></td><td class=\"PAfterParameters\">)</td></tr></table></div></div><div class=\"TTSummary\">Helper to format call stack entries to write them to the log file.</div></div>",927:"<div class=\"NDToolTip TFunction LSQL\"><div id=\"NDPrototype927\" class=\"NDPrototype WideForm\"><div class=\"PSection PParameterSection PascalStyle\"><table><tr><td class=\"PBeforeParameters\"><span class=\"SHKeyword\">procedure</span> log(</td><td class=\"PParametersParentCell\"><table class=\"PParameters\"><tr><td class=\"PName first\">p_message&nbsp;</td><td class=\"PType last\"><span class=\"SHKeyword\">in</span> message_type</td></tr></table></td><td class=\"PAfterParameters\">)</td></tr></table></div></div><div class=\"TTSummary\">see pit_file_pkg.log</div></div>",928:"<div class=\"NDToolTip TFunction LSQL\"><div id=\"NDPrototype928\" class=\"NDPrototype WideForm\"><div class=\"PSection PParameterSection PascalStyle\"><table><tr><td class=\"PBeforeParameters\"><span class=\"SHKeyword\">procedure</span> log(</td><td class=\"PParametersParentCell\"><table class=\"PParameters\"><tr><td class=\"PName first\">p_params&nbsp;</td><td class=\"PType last\"><span class=\"SHKeyword\">in</span> msg_params</td></tr></table></td><td class=\"PAfterParameters\">)</td></tr></table></div></div><div class=\"TTSummary\">see pit_file_pkg.log</div></div>",929:"<div class=\"NDToolTip TFunction LSQL\"><div id=\"NDPrototype929\" class=\"NDPrototype\"><div class=\"PSection PPlainSection\"><span class=\"SHKeyword\">procedure</span> purge</div></div><div class=\"TTSummary\">see pit_file_pkg.purge</div></div>",930:"<div class=\"NDToolTip TFunction LSQL\"><div id=\"NDPrototype930\" class=\"NDPrototype WideForm\"><div class=\"PSection PParameterSection PascalStyle\"><table><tr><td class=\"PBeforeParameters\"><span class=\"SHKeyword\">procedure</span> enter(</td><td class=\"PParametersParentCell\"><table class=\"PParameters\"><tr><td class=\"PName first\">p_call_stack&nbsp;</td><td class=\"PType last\"><span class=\"SHKeyword\">in</span> pit_call_stack_type</td></tr></table></td><td class=\"PAfterParameters\">)</td></tr></table></div></div><div class=\"TTSummary\">see pit_file_pkg.enter</div></div>",931:"<div class=\"NDToolTip TFunction LSQL\"><div id=\"NDPrototype931\" class=\"NDPrototype WideForm\"><div class=\"PSection PParameterSection PascalStyle\"><table><tr><td class=\"PBeforeParameters\"><span class=\"SHKeyword\">procedure</span> leave(</td><td class=\"PParametersParentCell\"><table class=\"PParameters\"><tr><td class=\"PName first\">p_call_stack&nbsp;</td><td class=\"PType last\"><span class=\"SHKeyword\">in</span> pit_call_stack_type</td></tr></table></td><td class=\"PAfterParameters\">)</td></tr></table></div></div><div class=\"TTSummary\">see pit_file_pkg.leave</div></div>",932:"<div class=\"NDToolTip TFunction LSQL\"><div id=\"NDPrototype932\" class=\"NDPrototype WideForm\"><div class=\"PSection PParameterSection PascalStyle\"><table><tr><td class=\"PBeforeParameters\"><span class=\"SHKeyword\">procedure</span> initialize_module(</td><td class=\"PParametersParentCell\"><table class=\"PParameters\"><tr><td class=\"PName first\">self&nbsp;</td><td class=\"PType last\"><span class=\"SHKeyword\">in out</span> pit_file</td></tr></table></td><td class=\"PAfterParameters\">)</td></tr></table></div></div><div class=\"TTSummary\">see pit_file_pkg.initialize_module</div></div>"});