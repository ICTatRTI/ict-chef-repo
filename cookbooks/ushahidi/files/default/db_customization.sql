# Customize Ushahidi instance

DELETE FROM incident;
DELETE FROM incident_category;
DELETE FROM location;
DELETE FROM category WHERE category_trusted = 0;

UPDATE category SET category_visible = 0 WHERE category_trusted = 1;
UPDATE plugin SET plugin_active = 1 WHERE plugin_name = 'linkreports';

# The settings table format has changed in Ushahidi 2.5
UPDATE settings SET value = 209 WHERE settings.key = 'default_country';
UPDATE settings SET value = 0 WHERE settings.key = 'multi_country';
UPDATE settings SET value = 0 WHERE settings.key = 'manually_approve_users';
UPDATE settings SET value = 'San Salvador' WHERE settings.key = 'default_city';
UPDATE settings SET value = 13.70065 WHERE settings.key = 'default_lat';
UPDATE settings SET value = -89.21626 WHERE settings.key = 'default_lon';
UPDATE settings SET value = 'America/El_Salvador' WHERE settings.key = 'site_timezone';
UPDATE settings SET value = 1 WHERE settings.key = 'manually_approve_users';
UPDATE settings SET value = 1 WHERE settings.key = 'private_deployment';
UPDATE settings SET value = 0 WHERE settings.key = 'allow_alerts';
UPDATE settings SET value = 1 WHERE settings.key = 'allow_reports';
UPDATE settings SET value = 'Nueva Instancia - Por favor cambie este título' WHERE settings.key = 'site_name';
UPDATE settings SET value = 'Nueva Instancia' WHERE settings.key = 'site_tagline';
UPDATE settings SET value = 'observatorio.amss@gmail.com' WHERE settings.key = 'site_email';
UPDATE settings SET value = 'es_AR' WHERE settings.key = 'site_language';
UPDATE settings SET value = 'SI2' WHERE settings.key = 'site_style';
UPDATE settings SET value = 0 WHERE settings.key = 'site_contact_page';
UPDATE settings SET value = 0 WHERE settings.key = 'allow_stat_sharing';
UPDATE settings SET value = 'UA-31086455-1' WHERE settings.key = 'google_analytics';
UPDATE settings SET value = '$CURRENT_TIME' WHERE settings.key = 'date_modify';
UPDATE settings SET value = 12 WHERE settings.key = 'default_zoom';
UPDATE settings SET value = 'osm_mapnik' WHERE settings.key = 'default_map';
UPDATE settings SET value = 1 WHERE settings.key = 'enable_timeline';
UPDATE settings SET value = 0 WHERE settings.key = 'allow_clustering';

# Categories as defined on 20120716
INSERT INTO `category` (id, parent_id, locale, category_position, category_title, category_description, category_color, category_visible) VALUES 
(10,0,'es_AR',1,'Homicidio','Homicidio','ff0000',1),
(11,30,'es_AR',14,'Atención ciudadana','Atención ciudadana','d6f0ff',1),
(12,30,'es_AR',2,'Denuncias','Denuncias','d6f0ff',1),
(13,30,'es_AR',13,'Esquelas','Esquelas','d6f0ff',1),
(14,30,'es_AR',15,'Rescates','Rescates','d6f0ff',1),
(15,30,'es_AR',16,'Violencia Intrafamiliar','Violencia Intrafamiliar','e6a6e1',1),
(16,0,'es_AR',7,'Robo','Robo','dbcc00',1),
(17,0,'en_US',9,'Hurto','Hurto','3300ff',1),
(18,0,'es_AR',8,'Robo de Vehículo','Robo de Vehículo','b3002a',1),
(19,0,'es_AR',10,'Hurto de Vehículo','Hurto de Vehículo','00cded',1),
(20,0,'es_AR',2,'Homicidio Culp. Acc. Tto','Homicidio Culp. Acc. Tto','11ff00',1),
(21,0,'es_AR',3,'Extorsión','Extorsión','9e9e9e',1),
(22,0,'es_AR',4,'Secuestro','Secuestro','000000',1),
(23,0,'es_AR',5,'Lesiones','Lesiones','ff6021',1),
(24,0,'es_AR',6,'Violación','Violación','ff0099',1),
(25,0,'es_AR',11,'RH Vehículo c/Merc','Robo y Hurto de Vehículo con Mercadería','c791c7',1),
(26,0,'es_AR',12,'Otros Delitos','Otros Delitos','ffff00',1),
(27,0,'es_AR',17,'Persona Desaparecida','Persona Desaparecida','000000',1),
(28,0,'es_AR',6,'Lesiones Culposas','Lesiones Culposas','ff6021',1),
(30,0,'es_AR',0,'CAM','CAM','ffffff',1);

UPDATE category SET category_description = 'Reportes sin Categorizar', category_visible = 0 WHERE category_title = 'NONE';
UPDATE category SET category_description = 'Reportes Aprobados Automáticamente', category_visible = 0 WHERE category_title = 'Trusted Reports';
    
# Default passwords:

#admin 			= capital45cortar
#rtiadmin 		= cinta94aunque
#pncadmin       = cama83doce
#camadmin       = bosque21cuba
#pncrevision 	= ataque09sacar
#pnccarga 		= discurso74cama
#camrevision 	= demanda18maldad
#camcarga 		= carro03venta
#observatorio 	= cuentas38lobo

# Roles
# Defaults: superadmin, admin, login, member
INSERT INTO `roles` (`name`,`description`,`access_level`) VALUES 
 ('Observatorio','Acceso sin edición. Sin acceso a datos confidenciales. Nivel=20',20),
 ('PNCRevision','Carga y revisión de datos, con visualización de información confidencial - Sólo PNC. Nivel=85',85),
 ('PNCCarga','Carga de datos. Acceso información confidencial - Sólo PNC. Nivel=80',80),
 ('CAMCarga','Carga de datos sin visualización de información confidencial. Nivel=50',50),
 ('CAMRevision','Carga y revisión de datos, sin visualización de información confidencial. Nivel=55',55);
 
UPDATE roles SET description = 'Administrador general' WHERE name = 'superadmin';
UPDATE roles SET description = 'Administrador local' WHERE name = 'admin';

# Assign permissions to roles
INSERT INTO `permissions_roles` VALUES 
(6,1),
(6,2),
(6,4),
(6,5),
(6,9),
(6,17),
(6,18),
(6,19),
(7,1),
(7,2),
(7,9),
(7,18),
(7,19),
(8,1),
(8,2),
(8,9),
(8,18),
(8,19),
(9,1),
(9,2),
(9,4),
(9,5),
(9,9),
(9,17),
(9,18),
(9,19);

# Users
INSERT INTO `users` (`name`,`email`,`username`,`password`,`notify`,`updated`,`color`,`code`,`confirmed`,`public_profile`,`approved`,`needinfo`) VALUES 
 ('Administrador RTI','apreston@rti.org','rtiadmin','0988eb336a4676edfbe6c0f5ea88a63d98c229131346e2eea0',0,NOW(),'FF0000',NULL,1,0,1,0),
 ('Administrador PNC','pncadmin@observatorio.gob.sv','pncadmin','4f9e9f264b9b92987c697cac0314e43ae40e45b534accb4662',0,NOW(),'FF0000',NULL,1,0,1,0),
 ('Administrador CAM','camadmin@observatorio.gob.sv','camadmin','ded110689e1ddcc20597e73cee1547136f2bd87d58f7f4e07a',0,NOW(),'FF0000',NULL,1,0,1,0),
 ('Observatorio','mapas@observatorio.gob.sv','observatorio','9c227fd0bac2f5e6c49b5c0111bc4b65e1bbeb1c4377c23aef',0,NOW(),'FF0000',NULL,1,0,1,0),
 ('CAM - Carga de Datos','cam-carga@observatorio.gob.sv','camcarga','3f3b777bcf5affee8fd2bf9cd8bc4872ea5131684d0ea33b61',0,NOW(),'FF0000',NULL,1,0,1,0),
 ('CAM - Revisión de Datos','cam-revision@observatorio.gob.sv','camrevision','4a469d466dfbebf121171700934378460ad2de0873b146aeae',0,NOW(),'FF0000',NULL,1,0,1,0),
 ('PNC - Carga','pnc-carga@observatorio.gob.sv','pnccarga','afee3b0d75a094b265bf6856364fb91f08410e788cfba31f2d',0,NOW(),'FF0000',NULL,1,0,1,0),
 ('PNC - Revisión','pnc-revision@observatorio.gob.sv','pncrevision','138a444ae08c54af69b7ba38a4478cc8a91085119313e48a98',0,NOW(),'FF0000',NULL,1,0,1,0);

# admin user password defaults to 'admin', here we change it to our default
UPDATE users SET password = 'ed87f90b6574ad4d73707be9bc465511509809c5ae721c6218' WHERE username = 'admin';
 
# Links between users and roles
# Every user needs role id=1 (login)
INSERT INTO roles_users (user_id,role_id) SELECT users.id, roles.id FROM users, roles WHERE users.username = 'rtiadmin' and roles.name = 'login';
INSERT INTO roles_users (user_id,role_id) SELECT users.id, roles.id FROM users, roles WHERE users.username = 'rtiadmin' and roles.name = 'admin';
INSERT INTO roles_users (user_id,role_id) SELECT users.id, roles.id FROM users, roles WHERE users.username = 'pncadmin' and roles.name = 'login';
INSERT INTO roles_users (user_id,role_id) SELECT users.id, roles.id FROM users, roles WHERE users.username = 'pncadmin' and roles.name = 'admin';
INSERT INTO roles_users (user_id,role_id) SELECT users.id, roles.id FROM users, roles WHERE users.username = 'camadmin' and roles.name = 'login';
INSERT INTO roles_users (user_id,role_id) SELECT users.id, roles.id FROM users, roles WHERE users.username = 'camadmin' and roles.name = 'admin';
INSERT INTO roles_users (user_id,role_id) SELECT users.id, roles.id FROM users, roles WHERE users.username = 'observatorio' and roles.name = 'login';
INSERT INTO roles_users (user_id,role_id) SELECT users.id, roles.id FROM users, roles WHERE users.username = 'observatorio' and roles.name = 'Observatorio';
INSERT INTO roles_users (user_id,role_id) SELECT users.id, roles.id FROM users, roles WHERE users.username = 'camcarga' and roles.name = 'login';
INSERT INTO roles_users (user_id,role_id) SELECT users.id, roles.id FROM users, roles WHERE users.username = 'camcarga' and roles.name = 'CAMCarga';
INSERT INTO roles_users (user_id,role_id) SELECT users.id, roles.id FROM users, roles WHERE users.username = 'camrevision' and roles.name = 'login';
INSERT INTO roles_users (user_id,role_id) SELECT users.id, roles.id FROM users, roles WHERE users.username = 'camrevision' and roles.name = 'CAMRevision';
INSERT INTO roles_users (user_id,role_id) SELECT users.id, roles.id FROM users, roles WHERE users.username = 'pnccarga' and roles.name = 'login';
INSERT INTO roles_users (user_id,role_id) SELECT users.id, roles.id FROM users, roles WHERE users.username = 'pnccarga' and roles.name = 'PNCCarga';
INSERT INTO roles_users (user_id,role_id) SELECT users.id, roles.id FROM users, roles WHERE users.username = 'pncrevision' and roles.name = 'login';
INSERT INTO roles_users (user_id,role_id) SELECT users.id, roles.id FROM users, roles WHERE users.username = 'pncrevision' and roles.name = 'PNCRevision';
