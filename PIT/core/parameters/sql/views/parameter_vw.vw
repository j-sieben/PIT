create or replace view parameter_vw as
select parameter_id,
       parameter_group_id,
       parameter_description,
       string_value,
       xml_value,
       integer_value,
       float_value,
       date_value,
       timestamp_value,
       boolean_value,
       is_modifiable,
       parameter_type_id,
       validation_string,
	     validation_message
  from (select parameter_id,
               parameter_group_id,
	             parameter_description,
               string_value,
               xml_value,
               integer_value,
               float_value,
               date_value,
               timestamp_value,
               boolean_value,
               is_modifiable,
               parameter_type_id,
               validation_string,
			         validation_message,
               rank() over (partition by parameter_id order by order_seq) ranking
         from (select 1 order_seq, 
                      l.parameter_id,
                      l.parameter_group_id,
					            z.parameter_description,
                      l.string_value,
                      l.xml_value,
                      l.integer_value,
                      l.float_value,
                      l.date_value,
                      l.timestamp_value,
                      l.boolean_value,
                      z.is_modifiable,
                      z.parameter_type_id,
                      z.validation_string,
                      z.validation_message
                 from &REMOTE_USER..parameter_local l
				 join &INSTALL_USER..parameter_tab z
				   on l.parameter_id = z.parameter_id
				  and l.parameter_group_id = z.parameter_group_id
                union all
               select 2,
                      parameter_id,
                      parameter_group_id,
                      parameter_description,
                      string_value,
                      xml_value,
                      integer_value,
                      float_value,
                      date_value,
                      timestamp_value,
                      boolean_value,
                      is_modifiable,
                      parameter_type_id,
                      validation_string,
                      validation_message
                 from &INSTALL_USER..parameter_tab))
 where ranking = 1;
 