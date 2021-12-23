﻿NDSummary.OnToolTipsLoaded("File:modules/pit_mail/packages/mail.pkb",{672:"<div class=\"NDToolTip TClass LSQL\"><div class=\"TTSummary\">Package to wrap sending mails via UTL_SMTP</div></div>",741:"<div class=\"NDToolTip TFunction LSQL\"><div id=\"NDPrototype741\" class=\"NDPrototype\"><div class=\"PSection PPlainSection\"><span class=\"SHKeyword\">function</span> mail_server_access_granted</div><div class=\"PSection PPlainSection\"><span class=\"SHKeyword\">return boolean</span></div></div><div class=\"TTSummary\">Checks whether a mail server has granted access succesfully.</div></div>",742:"<div class=\"NDToolTip TFunction LSQL\"><div id=\"NDPrototype742\" class=\"NDPrototype\"><div class=\"PSection PPlainSection\"><span class=\"SHKeyword\">function</span> mail_server_accessible</div><div class=\"PSection PPlainSection\"><span class=\"SHKeyword\">return boolean</span></div></div><div class=\"TTSummary\">Checks whether a mail server can be contacted over the net succesfully.</div></div>",743:"<div class=\"NDToolTip TFunction LSQL\"><div id=\"NDPrototype743\" class=\"NDPrototype WideForm\"><div class=\"PSection PParameterSection PascalStyle\"><table><tr><td class=\"PBeforeParameters\"><span class=\"SHKeyword\">function</span> encode_item(</td><td class=\"PParametersParentCell\"><table class=\"PParameters\"><tr><td class=\"PName first\">p_item&nbsp;</td><td class=\"PType last\"><span class=\"SHKeyword\">in varchar2</span></td></tr></table></td><td class=\"PAfterParameters\">)</td></tr></table></div><div class=\"PSection PPlainSection\"><span class=\"SHKeyword\">return varchar2</span></div></div><div class=\"TTSummary\">Method to convert text to an encoded data island.</div></div>",744:"<div class=\"NDToolTip TFunction LSQL\"><div id=\"NDPrototype744\" class=\"NDPrototype WideForm\"><div class=\"PSection PParameterSection PascalStyle\"><table><tr><td class=\"PBeforeParameters\"><span class=\"SHKeyword\">function</span> create_address_list(</td><td class=\"PParametersParentCell\"><table class=\"PParameters\"><tr><td class=\"PName first\">p_address_list&nbsp;</td><td class=\"PType last\"><span class=\"SHKeyword\">in varchar2</span></td></tr></table></td><td class=\"PAfterParameters\">)</td></tr></table></div><div class=\"PSection PPlainSection\"><span class=\"SHKeyword\">return</span> address_tab</div></div><div class=\"TTSummary\">Method to convert a semicolon-delimited list of email addresses into an instance of &lt;ADDRESS_TAB&gt;.</div></div>",745:"<div class=\"NDToolTip TFunction LSQL\"><div id=\"NDPrototype745\" class=\"NDPrototype WideForm\"><div class=\"PSection PParameterSection PascalStyle\"><table><tr><td class=\"PBeforeParameters\"><span class=\"SHKeyword\">function</span> extract_mail_address(</td><td class=\"PParametersParentCell\"><table class=\"PParameters\"><tr><td class=\"PName first\">p_address&nbsp;</td><td class=\"PType last\"><span class=\"SHKeyword\">in varchar2</span></td></tr></table></td><td class=\"PAfterParameters\">)</td></tr></table></div><div class=\"PSection PPlainSection\"><span class=\"SHKeyword\">return varchar2</span></div></div><div class=\"TTSummary\">Method to extract the mail address from an address of form &quot;user.name &lt;email_address&gt;&quot; or &quot;email_address&quot;.</div></div>",746:"<div class=\"NDToolTip TFunction LSQL\"><div id=\"NDPrototype746\" class=\"NDPrototype WideForm\"><div class=\"PSection PParameterSection PascalStyle\"><table><tr><td class=\"PBeforeParameters\"><span class=\"SHKeyword\">function</span> encode_mail_address(</td><td class=\"PParametersParentCell\"><table class=\"PParameters\"><tr><td class=\"PName first\">p_address&nbsp;</td><td class=\"PType last\"><span class=\"SHKeyword\">in varchar2</span></td></tr></table></td><td class=\"PAfterParameters\">)</td></tr></table></div><div class=\"PSection PPlainSection\"><span class=\"SHKeyword\">return varchar2</span></div></div><div class=\"TTSummary\">Method to encode the mail address</div></div>",747:"<div class=\"NDToolTip TFunction LSQL\"><div id=\"NDPrototype747\" class=\"NDPrototype WideForm\"><div class=\"PSection PParameterSection PascalStyle\"><table><tr><td class=\"PBeforeParameters\"><span class=\"SHKeyword\">procedure</span> write_log(</td><td class=\"PParametersParentCell\"><table class=\"PParameters\"><tr><td class=\"PName first\">p_text&nbsp;</td><td class=\"PType last\"><span class=\"SHKeyword\">in varchar2</span></td></tr></table></td><td class=\"PAfterParameters\">)</td></tr></table></div></div><div class=\"TTSummary\">Method to write connection or process steps to g_trace_text</div></div>",748:"<div class=\"NDToolTip TFunction LSQL\"><div id=\"NDPrototype748\" class=\"NDPrototype WideForm\"><div class=\"PSection PParameterSection PascalStyle\"><table><tr><td class=\"PBeforeParameters\"><span class=\"SHKeyword\">procedure</span> write_header(</td><td class=\"PParametersParentCell\"><table class=\"PParameters\"><tr><td class=\"PName first\">p_conn&nbsp;</td><td class=\"PType last\"><span class=\"SHKeyword\">in out nocopy</span> utl_smtp.connection,</td></tr><tr><td class=\"PName first\">p_item&nbsp;</td><td class=\"PType last\"><span class=\"SHKeyword\">in varchar2</span>,</td></tr><tr><td class=\"PName first\">p_text&nbsp;</td><td class=\"PType last\"><span class=\"SHKeyword\">in varchar2</span></td></tr></table></td><td class=\"PAfterParameters\">)</td></tr></table></div></div><div class=\"TTSummary\">Method to write header information in the correct format</div></div>",749:"<div class=\"NDToolTip TFunction LSQL\"><div id=\"NDPrototype749\" class=\"NDPrototype WideForm\"><div class=\"PSection PParameterSection PascalStyle\"><table><tr><td class=\"PBeforeParameters\"><span class=\"SHKeyword\">procedure</span> write_body(</td><td class=\"PParametersParentCell\"><table class=\"PParameters\"><tr><td class=\"PName first\">p_conn&nbsp;</td><td class=\"PType last\"><span class=\"SHKeyword\">in out nocopy</span> utl_smtp.connection,</td></tr><tr><td class=\"PName first\">p_text&nbsp;</td><td class=\"PType last\"><span class=\"SHKeyword\">in varchar2</span></td></tr></table></td><td class=\"PAfterParameters\">)</td></tr></table></div></div><div class=\"TTSummary\">Method to write body text to the &lt;UTL_SMTP&gt; connection</div></div>",750:"<div class=\"NDToolTip TFunction LSQL\"><div id=\"NDPrototype750\" class=\"NDPrototype WideForm\"><div class=\"PSection PParameterSection PascalStyle\"><table><tr><td class=\"PBeforeParameters\"><span class=\"SHKeyword\">procedure</span> write_boundary(</td><td class=\"PParametersParentCell\"><table class=\"PParameters\"><tr><td class=\"PName first\">p_conn&nbsp;</td><td class=\"PType\"><span class=\"SHKeyword\">in out nocopy</span> utl_smtp.connection,</td><td></td><td class=\"last\"></td></tr><tr><td class=\"PName first\">p_last_boundary&nbsp;</td><td class=\"PType\"><span class=\"SHKeyword\">in boolean</span></td><td class=\"PDefaultValueSeparator\">&nbsp;<span class=\"SHKeyword\">default</span>&nbsp;</td><td class=\"PDefaultValue last\">false</td></tr></table></td><td class=\"PAfterParameters\">)</td></tr></table></div></div><div class=\"TTSummary\">Method to write boundary text to the &lt;UTL_SMTP&gt; connection</div></div>",751:"<div class=\"NDToolTip TFunction LSQL\"><div id=\"NDPrototype751\" class=\"NDPrototype WideForm\"><div class=\"PSection PParameterSection PascalStyle\"><table><tr><td class=\"PBeforeParameters\"><span class=\"SHKeyword\">procedure</span> authenticate_via_login(</td><td class=\"PParametersParentCell\"><table class=\"PParameters\"><tr><td class=\"PName first\">p_conn&nbsp;</td><td class=\"PType last\"><span class=\"SHKeyword\">in out nocopy</span> utl_smtp.connection</td></tr></table></td><td class=\"PAfterParameters\">)</td></tr></table></div></div><div class=\"TTSummary\">Method to authenticate at the mail server. User credentials are taken from g_usr and g_pwd global variables.</div></div>",752:"<div class=\"NDToolTip TFunction LSQL\"><div id=\"NDPrototype752\" class=\"NDPrototype WideForm\"><div class=\"PSection PParameterSection PascalStyle\"><table><tr><td class=\"PBeforeParameters\"><span class=\"SHKeyword\">procedure</span> authenticate_via_plain(</td><td class=\"PParametersParentCell\"><table class=\"PParameters\"><tr><td class=\"PName first\">p_conn&nbsp;</td><td class=\"PType last\"><span class=\"SHKeyword\">in out nocopy</span> utl_smtp.connection</td></tr></table></td><td class=\"PAfterParameters\">)</td></tr></table></div></div><div class=\"TTSummary\">Method to authenticate at the mail server via AUTH PLAIN mechanism.&nbsp; User credentials are taken from g_usr and g_pwd global variables.</div></div>",753:"<div class=\"NDToolTip TFunction LSQL\"><div id=\"NDPrototype753\" class=\"NDPrototype WideForm\"><div class=\"PSection PParameterSection PascalStyle\"><table><tr><td class=\"PBeforeParameters\"><span class=\"SHKeyword\">procedure</span> connect_mail_server(</td><td class=\"PParametersParentCell\"><table class=\"PParameters\"><tr><td class=\"PName first\">p_conn&nbsp;</td><td class=\"PType last\"><span class=\"SHKeyword\">out nocopy</span> utl_smtp.connection</td></tr></table></td><td class=\"PAfterParameters\">)</td></tr></table></div></div><div class=\"TTSummary\">Method to connect the mail server and authenticate.</div></div>",754:"<div class=\"NDToolTip TFunction LSQL\"><div id=\"NDPrototype754\" class=\"NDPrototype WideForm\"><div class=\"PSection PParameterSection PascalStyle\"><table><tr><td class=\"PBeforeParameters\"><span class=\"SHKeyword\">procedure</span> set_recipient_list(</td><td class=\"PParametersParentCell\"><table class=\"PParameters\"><tr><td class=\"PName first\">p_conn&nbsp;</td><td class=\"PType last\"><span class=\"SHKeyword\">in out nocopy</span> utl_smtp.connection,</td></tr><tr><td class=\"PName first\">p_sender&nbsp;</td><td class=\"PType last\"><span class=\"SHKeyword\">in varchar2</span>,</td></tr><tr><td class=\"PName first\">p_subject&nbsp;</td><td class=\"PType last\"><span class=\"SHKeyword\">in varchar2</span>,</td></tr><tr><td class=\"PName first\">p_recipients&nbsp;</td><td class=\"PType last\"><span class=\"SHKeyword\">in</span> mail.address_tab,</td></tr><tr><td class=\"PName first\">p_cc_recipients&nbsp;</td><td class=\"PType last\"><span class=\"SHKeyword\">in</span> mail.address_tab</td></tr></table></td><td class=\"PAfterParameters\">)</td></tr></table></div></div><div class=\"TTSummary\">Method to set the recipients list for the mail.</div></div>",755:"<div class=\"NDToolTip TFunction LSQL\"><div id=\"NDPrototype755\" class=\"NDPrototype WideForm\"><div class=\"PSection PParameterSection PascalStyle\"><table><tr><td class=\"PBeforeParameters\"><span class=\"SHKeyword\">procedure</span> set_content_type(</td><td class=\"PParametersParentCell\"><table class=\"PParameters\"><tr><td class=\"PName first\">p_conn&nbsp;</td><td class=\"PType last\"><span class=\"SHKeyword\">in out nocopy</span> utl_smtp.connection</td></tr></table></td><td class=\"PAfterParameters\">)</td></tr></table></div></div><div class=\"TTSummary\">Method to set the content type of the mail according to g_is_multipart_mail.</div></div>",756:"<div class=\"NDToolTip TFunction LSQL\"><div id=\"NDPrototype756\" class=\"NDPrototype WideForm\"><div class=\"PSection PParameterSection PascalStyle\"><table><tr><td class=\"PBeforeParameters\"><span class=\"SHKeyword\">procedure</span> send_mail_body(</td><td class=\"PParametersParentCell\"><table class=\"PParameters\"><tr><td class=\"PName first\">p_conn&nbsp;</td><td class=\"PType last\"><span class=\"SHKeyword\">in out nocopy</span> utl_smtp.connection,</td></tr><tr><td class=\"PName first\">p_message&nbsp;</td><td class=\"PType last\"><span class=\"SHKeyword\">in varchar2</span></td></tr></table></td><td class=\"PAfterParameters\">)</td></tr></table></div></div><div class=\"TTSummary\">Sends the mail body, taking the content type into account.</div></div>",757:"<div class=\"NDToolTip TFunction LSQL\"><div id=\"NDPrototype757\" class=\"NDPrototype WideForm\"><div class=\"PSection PParameterSection PascalStyle\"><table><tr><td class=\"PBeforeParameters\"><span class=\"SHKeyword\">procedure</span> send_attachment(</td><td class=\"PParametersParentCell\"><table class=\"PParameters\"><tr><td class=\"PName first\">p_conn&nbsp;</td><td class=\"PType last\"><span class=\"SHKeyword\">in out nocopy</span> utl_smtp.connection,</td></tr><tr><td class=\"PName first\">p_file_name&nbsp;</td><td class=\"PType last\"><span class=\"SHKeyword\">in varchar2</span>,</td></tr><tr><td class=\"PName first\">p_mime_type&nbsp;</td><td class=\"PType last\"><span class=\"SHKeyword\">in varchar2</span>,</td></tr><tr><td class=\"PName first\">p_attachment&nbsp;</td><td class=\"PType last\"><span class=\"SHKeyword\">in blob</span></td></tr></table></td><td class=\"PAfterParameters\">)</td></tr></table></div></div><div class=\"TTSummary\">Sends the mail attachment.</div></div>",758:"<div class=\"NDToolTip TFunction LSQL\"><div id=\"NDPrototype758\" class=\"NDPrototype WideForm\"><div class=\"PSection PParameterSection PascalStyle\"><table><tr><td class=\"PBeforeParameters\"><span class=\"SHKeyword\">procedure</span> disconnect_mail_server(</td><td class=\"PParametersParentCell\"><table class=\"PParameters\"><tr><td class=\"PName first\">p_conn&nbsp;</td><td class=\"PType last\"><span class=\"SHKeyword\">in out nocopy</span> utl_smtp.connection</td></tr></table></td><td class=\"PAfterParameters\">)</td></tr></table></div></div><div class=\"TTSummary\">Disconnects from the mail server.</div></div>",760:"<div class=\"NDToolTip TFunction LSQL\"><div id=\"NDPrototype760\" class=\"NDPrototype\"><div class=\"PSection PPlainSection\"><span class=\"SHKeyword\">procedure</span> initialize</div></div><div class=\"TTSummary\">see MAIL.initialize</div></div>",761:"<div class=\"NDToolTip TFunction LSQL\"><div id=\"NDPrototype761\" class=\"NDPrototype\"><div class=\"PSection PPlainSection\"><span class=\"SHKeyword\">function</span> pkg_is_working</div><div class=\"PSection PPlainSection\"><span class=\"SHKeyword\">return boolean</span></div></div><div class=\"TTSummary\">see MAIL.pkg_is_working</div></div>",762:"<div class=\"NDToolTip TFunction LSQL\"><div id=\"NDPrototype762\" class=\"NDPrototype WideForm\"><div class=\"PSection PParameterSection PascalStyle\"><table><tr><td class=\"PBeforeParameters\"><span class=\"SHKeyword\">procedure</span> set_credentials(</td><td class=\"PParametersParentCell\"><table class=\"PParameters\"><tr><td class=\"PName first\">p_host&nbsp;</td><td class=\"PType last\"><span class=\"SHKeyword\">in varchar2</span>,</td></tr><tr><td class=\"PName first\">p_port&nbsp;</td><td class=\"PType last\"><span class=\"SHKeyword\">in pls_integer</span>,</td></tr><tr><td class=\"PName first\">p_user&nbsp;</td><td class=\"PType last\"><span class=\"SHKeyword\">in varchar2</span>,</td></tr><tr><td class=\"PName first\">p_password&nbsp;</td><td class=\"PType last\"><span class=\"SHKeyword\">in varchar2</span></td></tr></table></td><td class=\"PAfterParameters\">)</td></tr></table></div></div><div class=\"TTSummary\">see MAIL.set_credentials</div></div>",763:"<div class=\"NDToolTip TFunction LSQL\"><div id=\"NDPrototype763\" class=\"NDPrototype WideForm\"><div class=\"PSection PParameterSection PascalStyle\"><table><tr><td class=\"PBeforeParameters\"><span class=\"SHKeyword\">procedure</span> send_mail(</td><td class=\"PParametersParentCell\"><table class=\"PParameters\"><tr><td class=\"PName first\">p_sender&nbsp;</td><td class=\"PType last\"><span class=\"SHKeyword\">in varchar2</span>,</td></tr><tr><td class=\"PName first\">p_recipients&nbsp;</td><td class=\"PType last\"><span class=\"SHKeyword\">in</span> mail.address_tab,</td></tr><tr><td class=\"PName first\">p_cc_recipients&nbsp;</td><td class=\"PType last\"><span class=\"SHKeyword\">in</span> mail.address_tab,</td></tr><tr><td class=\"PName first\">p_subject&nbsp;</td><td class=\"PType last\"><span class=\"SHKeyword\">in varchar2</span>,</td></tr><tr><td class=\"PName first\">p_message&nbsp;</td><td class=\"PType last\"><span class=\"SHKeyword\">in varchar2</span>,</td></tr><tr><td class=\"PName first\">p_file_name&nbsp;</td><td class=\"PType last\"><span class=\"SHKeyword\">in varchar2</span>,</td></tr><tr><td class=\"PName first\">p_mime_type&nbsp;</td><td class=\"PType last\"><span class=\"SHKeyword\">in varchar2</span>,</td></tr><tr><td class=\"PName first\">p_attachment&nbsp;</td><td class=\"PType last\"><span class=\"SHKeyword\">in blob</span></td></tr></table></td><td class=\"PAfterParameters\">)</td></tr></table></div></div><div class=\"TTSummary\">see MAIL.send_mail</div></div>",764:"<div class=\"NDToolTip TFunction LSQL\"><div id=\"NDPrototype764\" class=\"NDPrototype WideForm\"><div class=\"PSection PParameterSection PascalStyle\"><table><tr><td class=\"PBeforeParameters\"><span class=\"SHKeyword\">procedure</span> send_mail(</td><td class=\"PParametersParentCell\"><table class=\"PParameters\"><tr><td class=\"PName first\">p_sender&nbsp;</td><td class=\"PType last\"><span class=\"SHKeyword\">in varchar2</span>,</td></tr><tr><td class=\"PName first\">p_recipients&nbsp;</td><td class=\"PType last\"><span class=\"SHKeyword\">in</span> mail.address_tab,</td></tr><tr><td class=\"PName first\">p_cc_recipients&nbsp;</td><td class=\"PType last\"><span class=\"SHKeyword\">in</span> mail.address_tab,</td></tr><tr><td class=\"PName first\">p_subject&nbsp;</td><td class=\"PType last\"><span class=\"SHKeyword\">in varchar2</span>,</td></tr><tr><td class=\"PName first\">p_message&nbsp;</td><td class=\"PType last\"><span class=\"SHKeyword\">in varchar2</span></td></tr></table></td><td class=\"PAfterParameters\">)</td></tr></table></div></div><div class=\"TTSummary\">see MAIL.send_mail</div></div>",765:"<div class=\"NDToolTip TFunction LSQL\"><div id=\"NDPrototype765\" class=\"NDPrototype WideForm\"><div class=\"PSection PParameterSection PascalStyle\"><table><tr><td class=\"PBeforeParameters\"><span class=\"SHKeyword\">procedure</span> send_mail(</td><td class=\"PParametersParentCell\"><table class=\"PParameters\"><tr><td class=\"PName first\">p_sender&nbsp;</td><td class=\"PType\"><span class=\"SHKeyword\">in varchar2</span>,</td><td></td><td class=\"last\"></td></tr><tr><td class=\"PName first\">p_recipient&nbsp;</td><td class=\"PType\"><span class=\"SHKeyword\">in varchar2</span>,</td><td></td><td class=\"last\"></td></tr><tr><td class=\"PName first\">p_subject&nbsp;</td><td class=\"PType\"><span class=\"SHKeyword\">in varchar2</span>,</td><td></td><td class=\"last\"></td></tr><tr><td class=\"PName first\">p_message&nbsp;</td><td class=\"PType\"><span class=\"SHKeyword\">in varchar2</span>,</td><td></td><td class=\"last\"></td></tr><tr><td class=\"PName first\">p_file_name&nbsp;</td><td class=\"PType\"><span class=\"SHKeyword\">in varchar2</span></td><td class=\"PDefaultValueSeparator\">&nbsp;<span class=\"SHKeyword\">default</span>&nbsp;</td><td class=\"PDefaultValue last\"><span class=\"SHKeyword\">null</span>,</td></tr><tr><td class=\"PName first\">p_mime_type&nbsp;</td><td class=\"PType\"><span class=\"SHKeyword\">in varchar2</span></td><td class=\"PDefaultValueSeparator\">&nbsp;<span class=\"SHKeyword\">default</span>&nbsp;</td><td class=\"PDefaultValue last\"><span class=\"SHKeyword\">null</span>,</td></tr><tr><td class=\"PName first\">p_attachment&nbsp;</td><td class=\"PType\"><span class=\"SHKeyword\">in blob</span></td><td class=\"PDefaultValueSeparator\">&nbsp;<span class=\"SHKeyword\">default</span>&nbsp;</td><td class=\"PDefaultValue last\"><span class=\"SHKeyword\">null</span></td></tr></table></td><td class=\"PAfterParameters\">)</td></tr></table></div></div><div class=\"TTSummary\">see MAIL.send_mail</div></div>"});