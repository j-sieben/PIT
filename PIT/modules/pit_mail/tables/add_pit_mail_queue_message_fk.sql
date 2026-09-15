alter table pit_mail_queue add constraint fk_pmq_pms_id
  foreign key(pmq_pms_id) references pit_message(pms_name) on delete cascade;
