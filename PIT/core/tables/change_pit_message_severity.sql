alter table pit_message_severity add (
  pse_requires_exception varchar2(10 byte) default on null 'NONE' constraint pse_requires_exception_chk check(pse_requires_exception in ('NONE', 'OPTIONAL', 'MANDATORY')));
  
comment on column pit_message_severity.pse_requires_exception is 'Flag to indicate whether the severity requires that an exception is created for it. Possible values: NONE - No exception, OPTIONAL - may have an exception, MONADATORY - must have an exception';
