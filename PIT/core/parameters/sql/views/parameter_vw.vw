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
               rank() over (partition by par_id order by order_seq) par_rank
         from (select 1 order_seq, 
                      l.par_id,
                      l.par_pgr_id,
					            z.par_description,
                      l.par_string_value,
                      l.par_xml_value,
                      l.par_integer_value,
                      l.par_float_value,
                      l.par_date_value,
                      l.par_timestamp_value,
                      l.par_boolean_value,
                      z.par_is_modifiable,
                      z.par_pat_id,
                      z.par_validation_string,
                      z.par_validation_message
                 from &REMOTE_USER..parameter_local l
				 join &INSTALL_USER..parameter_tab z
				   on l.par_id = z.par_id
				  and l.par_pgr_id = z.par_pgr_id
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
                 from &INSTALL_USER..parameter_tab))
 where par_rank = 1;
 