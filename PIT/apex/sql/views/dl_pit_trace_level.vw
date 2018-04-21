create or replace view &APP_USER..dl_pit_trace_level as
select ptl_id, ptl_name, ptl_display_name
  from &INSTALL_USER..pit_trace_level;
