# Views using GEOMETRY objects:

CREATE OR REPLACE VIEW `incidente_breve` AS 
select `i`.`id` AS `id_incidente`,
`i`.`incident_title` AS `titulo`,
`i`.`incident_dateadd` AS `fecha`,
`i`.`incident_active` AS `aprobado`,
`l`.`location_name` AS `ubicacion`,
`l`.`location_point` AS `punto_geografico`,
`c`.`category_description` AS `categoria` 
FROM ((`incident` `i` join `location` `l` on((`i`.`location_id` = `l`.`id`))) join (`incident_category` `ic` join `category` `c` on((`ic`.`category_id` = `c`.`id`))) on((`i`.`id` = `ic`.`incident_id`)));

CREATE OR REPLACE VIEW `incidente_completo` AS 
SELECT `i`.`id` AS `id_incidente`,
`i`.`incident_title` AS `titulo`,
`i`.`incident_dateadd` AS `fecha`,
YEAR(incident_dateadd) AS `anho`,
MONTH(incident_dateadd) AS `mes`,
DAY(incident_dateadd) AS `dia`,
HOUR(incident_dateadd) AS `hora`,
MINUTE(incident_dateadd) AS `minuto`,
`i`.`incident_active` AS `aprobado`,
`i`.`incident_description` AS `descripcion`,
`l`.`location_name` AS `ubicacion`,
`l`.`location_point` AS `punto_geografico`,
`c`.`id` AS `id_categoria`,
`c`.`category_description` AS `categoria`
FROM (((`incident` `i` join `location` `l` on((`i`.`location_id` = `l`.`id`))) join (`incident_category` `ic` join `category` `c` on((`ic`.`category_id` = `c`.`id`))) on((`i`.`id` = `ic`.`incident_id`))) join `incident_person` `p` on((`i`.`id` = `p`.`incident_id`)));
