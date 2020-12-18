create or replace view pit_ui_edit_pre as
select pre_id,
       pre_description,
       pre_is_active
  from parameter_realm;
    
comment on table pit_ui_edit_pre is 'UI-View for APEX page EDIT_PRE (EDIT Parameter REalm)';