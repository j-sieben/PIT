create or replace view parameter_vw as
select par_id,
       par_pgr_id,
       par_description,
       par_string_value,
       par_xml_value,
       par_integer_value,
       par_float_value,
       par_date_value,
       par_timestamp_value,
       par_boolean_value,
       par_is_modifiable,
       par_pat_id,
       par_validation_string,
	     par_validation_message
  from (select par_id,
               par_pgr_id,
               par_description,
               par_string_value,
               par_xml_value,
               par_integer_value,
               par_float_value,
               par_date_value,
               par_timestamp_value,
               par_boolean_value,
               par_is_modifiable,
               par_pat_id,
               par_validation_string,
               par_validation_message,
               rank() over (partition by par_id order by order_seq) ranking
         from (select 1 order_seq, 
                      l.pal_id par_id,
                      l.pal_pgr_id par_pgr_id,
					            z.par_description,
                      l.pal_string_value par_string_value,
                      l.pal_xml_value par_xml_value,
                      l.pal_integer_value par_integer_value,
                      l.pal_float_value par_float_value,
                      l.pal_date_value par_date_value,
                      l.pal_timestamp_value par_timestamp_value,
                      l.pal_boolean_value par_boolean_value,
                      z.par_is_modifiable,
                      z.par_pat_id,
                      z.par_validation_string,
                      z.par_validation_message
                 from parameter_local l
                 join parameter_tab z
                   on l.pal_id = z.par_id
                  and l.pal_pgr_id = z.par_pgr_id
                      -- Unterabfrage liefert aktuelle Umgebung und filtert REALM der lokalen Tabelle
                 join (select to_char(par_string_value) pre_id
                         from parameter_tab
                        where par_pgr_id = 'INTERNAL'
                          and par_id = 'REALM') a
                   on l.pal_pre_id = a.pre_id
                union all
               select 2,
                      par_id,
                      par_pgr_id,
                      par_description,
                      par_string_value,
                      par_xml_value,
                      par_integer_value,
                      par_float_value,
                      par_date_value,
                      par_timestamp_value,
                      par_boolean_value,
                      par_is_modifiable,
                      par_pat_id,
                      par_validation_string,
                      par_validation_message
                 from parameter_tab))
 where ranking = 1;
 
