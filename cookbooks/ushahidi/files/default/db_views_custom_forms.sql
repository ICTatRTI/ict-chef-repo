# Views para incluir información de campos custom
# Incluyen campos GEOMETRY 
# Created by the Santa Tecla Crime Observatory

CREATE OR REPLACE VIEW victimas AS
SELECT a.id AS id_victima,
GROUP_CONCAT(IF(c.form_field_id= 107, c.form_response, NULL)) AS 'Nombre_Victima',
GROUP_CONCAT(IF(c.form_field_id= 109, c.form_response, NULL)) AS 'Sexo_Victima',
GROUP_CONCAT(IF(c.form_field_id= 108, c.form_response, NULL)) AS 'Edad_Victima',
GROUP_CONCAT(IF(c.form_field_id= 111, c.form_response, NULL)) AS 'Domicilio_Victima',
GROUP_CONCAT(IF(c.form_field_id= 110, c.form_response, NULL)) AS 'Profesion_Victima',
GROUP_CONCAT(IF(c.form_field_id= 114, c.form_response, NULL)) AS 'Notas_Victima'
FROM incident a INNER JOIN form_response c ON c.incident_id = a.id
GROUP BY a.id;

CREATE OR REPLACE VIEW vehiculos AS 
SELECT a.id AS id_vehiculo,
GROUP_CONCAT(IF(c.form_field_id= 102, c.form_response, NULL)) AS 'Marca',
GROUP_CONCAT(IF(c.form_field_id= 101, c.form_response, NULL)) AS 'Tipo',
GROUP_CONCAT(IF(c.form_field_id= 103, c.form_response, NULL)) AS 'Color',
GROUP_CONCAT(IF(c.form_field_id= 104, c.form_response, NULL)) AS 'Año',
GROUP_CONCAT(IF(c.form_field_id= 106, c.form_response, NULL)) AS 'Clase',
GROUP_CONCAT(IF(c.form_field_id= 105, c.form_response, NULL)) AS 'Placa'
FROM incident a INNER JOIN form_response c ON c.incident_id=a.id 
GROUP BY a.id;

CREATE OR REPLACE VIEW armas AS 
SELECT a.id AS id_arma,
GROUP_CONCAT(IF(c.form_field_id= 123, c.form_response, NULL)) AS 'Tipo de Arma',
GROUP_CONCAT(IF(c.form_field_id= 124, c.form_response, NULL)) AS 'Clase de Arma'
FROM incident a INNER JOIN form_response c ON c.incident_id=a.id 
GROUP BY a.id;

CREATE OR REPLACE VIEW objetos AS 
SELECT a.id AS id_objeto,
GROUP_CONCAT(IF(c.form_field_id= 125, c.form_response, NULL)) AS 'Objeto',
GROUP_CONCAT(IF(c.form_field_id= 126, c.form_response, NULL)) AS 'Detalle'
FROM incident a INNER JOIN form_response c ON c.incident_id=a.id  
GROUP BY a.id;

CREATE OR REPLACE VIEW hechores AS
SELECT a.id AS id_hechor,
GROUP_CONCAT(IF(c.form_field_id= 127, c.form_response, NULL)) AS 'Nombre',
GROUP_CONCAT(IF(c.form_field_id= 112, c.form_response, NULL)) AS 'Edad',
GROUP_CONCAT(IF(c.form_field_id= 113, c.form_response, NULL)) AS 'Sexo',
GROUP_CONCAT(IF(c.form_field_id= 115, c.form_response, NULL)) AS 'Profesion'
FROM incident a INNER JOIN form_response c ON c.incident_id=a.id 
GROUP BY a.id;

CREATE OR REPLACE VIEW incidente_victimas AS
SELECT * FROM incidente_completo i
LEFT JOIN victimas v
ON i.id_incidente = v.id_victima;

CREATE OR REPLACE VIEW incidente_vehiculos AS 
SELECT * FROM incidente_completo i
LEFT JOIN vehiculos e
ON i.id_incidente = e.id_vehiculo;

CREATE OR REPLACE VIEW incidente_armas AS 
SELECT * FROM incidente_completo i
LEFT JOIN armas a
ON i.id_incidente = a.id_arma;

CREATE OR REPLACE VIEW incidente_objetos AS 
SELECT * FROM incidente_completo i
LEFT JOIN objetos o
ON i.id_incidente = o.id_objeto;

CREATE OR REPLACE VIEW incidente_hechores AS
SELECT * FROM incidente_completo i
LEFT JOIN hechores h
ON i.id_incidente = h.id_hechor;

CREATE OR REPLACE VIEW incidente_todos AS
SELECT * FROM incidente_victimas v
LEFT JOIN vehiculos AS e
ON v.id_incidente = e.id_vehiculo
LEFT JOIN armas AS a
ON v.id_incidente = a.id_arma
LEFT JOIN objetos AS o
ON v.id_incidente = o.id_objeto
LEFT JOIN hechores AS h
ON v.id_incidente = h.id_hechor;


