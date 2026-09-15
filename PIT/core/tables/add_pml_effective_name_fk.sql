alter table pit_message_language add constraint pml_effective_name_fk
  foreign key (pml_effective_name) references pit_message_language(pml_name);
