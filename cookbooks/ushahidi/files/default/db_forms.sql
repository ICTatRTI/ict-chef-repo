INSERT INTO form (id,form_title,form_description,form_active) VALUES 
 (102,'VEHICULOS','Vehículos asociados a un incidente',1),
 (103,'VICTIMAS','Información de víctimas',1),
 (104,'HECHOR','Información de hechores',1),
 (105,'VIALES','Información sobre accidentes en la vía pública',1),
 (106,'OTROS','Armas, objetos robados e información adicional',1);
 
# The default definition for the options field needs to be changed to >=600 chars to allow for the vehicle brands
ALTER TABLE form_field MODIFY COLUMN `field_default` VARCHAR(600) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL;
 
INSERT INTO form_field (id,form_id,field_name,field_type,field_required,field_options,field_position,field_default,field_maxlength,field_width,field_height,field_isdate,field_ispublic_visible,field_ispublic_submit) VALUES 
 (101,102,'Tipo',7,0,NULL,1,'Desconocido,Automóvil,Cabezal,Camión,Rastra,Autobus,Motocicleta,Lancha,Pickup,Cuadrimoto',0,0,5,0,0,0),
 (102,102,'Marca',7,0,NULL,2,'Desconocido,Abarth,Acura,Alfa Romeo,Alpina,Artega,Aston Martin,Audi,Bentley,BMW,Bugatti,Cadillac,Chery,Chevrelot,Chysler,Citroen,CHANA,Dacia,Daewoo,Daihatsu,Datsun,Dodge,Dongfeng,Ferrari,Fiat,Fisker,Ford,Honda,Hurtan,Hyundai,Infiniti,Isuzu,Jaguar,Jeep,Kia,KTM,Lamborghini,Lancia,Land Rover,Lexus,Lotus,Mansory,Maserati,Maybach,Mazda,Mercedes Benz,Minis,Mitsubishi,Nissan,Opel,Peugeot,PGO,Porsche,Renault,Rolls Royce,Saab,Santana,Seat,Skoda,Smart,Ssang Yong,Subaru,Suzuski,Tata,Tesla,Toyota,Volvo,Wiesmann,Volkswagen',0,0,5,0,0,0),
 (103,102,'Color',7,0,NULL,3,'Desconocido,Amarillo,Azul,Beige,Blanco,Cafe,Celeste,Champagne,Gris,Morado,Negro,Ocre,Plateado,Rojo,Verde,Multicolor,Otros',0,0,5,0,0,0),
 (104,102,'Año',1,0,NULL,5,NULL,0,0,5,0,0,0),
 (105,102,'Placas',1,0,NULL,5,NULL,0,0,5,0,0,0),
 (106,102,'Clase',7,0,NULL,6,'Desconocido,Diplomatico,Extranjero,Huyo,Juvenil,Liviana,Motocicleta,NoPortaba,Particular,Pesado,Otro',0,0,5,0,0,0),
 (107,103,'Nombres',1,0,NULL,1,NULL,0,0,5,0,0,0),
 (108,103,'Edad',1,0,NULL,2,NULL,0,0,5,0,0,0),
 (109,103,'Sexo',7,0,NULL,3,'Desconocido,Femenino,Masculino',0,0,5,0,0,0),
 (110,103,'Profesión',1,0,NULL,5,NULL,0,0,5,0,0,0),
 (111,103,'Domicilio',1,0,NULL,5,NULL,0,0,5,0,0,0),
 (112,104,'Edad',1,0,NULL,2,NULL,0,0,5,0,0,0),
 (113,104,'Sexo',7,0,NULL,3,'Desconocido,Femenino,Masculino',0,0,5,0,0,0),
 (114,103,'Otra Información',2,0,NULL,6,NULL,0,0,5,0,0,0),
 (121,1,'Informacion Confidencial CAM',2,0,NULL,1,NULL,0,0,5,0,0,0),
 (115,104,'Profesión',1,0,NULL,4,NULL,0,0,5,0,0,0),
 (116,105,'Clase',7,0,NULL,1,'Desconocido,Atropello,Choque,Colision,Otro',0,0,5,0,0,0),
 (117,105,'Causa',7,0,NULL,2,'Desconocido,Adelantamiento,Colision,Contrasentido,Deslumbramiento,Distancia,Distraccion,Ebriedad,Falla Mecanica,Giro Incorrecto,Imprudencia Peaton,Inexperiencia,Invadir Carril,No Respeta Señal,Reversa',0,0,5,0,0,0),
 (118,105,'Estado Conductor',7,0,NULL,3,'Desconocido,Normal,Ebrio,Ingesta Alcohol,Huyo,Otro',0,0,5,0,0,0),
 (119,105,'Notas',2,0,NULL,5,NULL,0,0,5,0,0,0),
 (120,105,'Heridos',7,0,NULL,4,'Desconocido,Lesionados,Fallecidos,Lesionados y Fallecidos',0,0,5,0,0,0),
 (122,1,'Informacion Confidencial PNC',2,0,NULL,2,NULL,0,0,5,0,0,0),
 (123,106,'Tipo de Arma',7,0,NULL,1,'Desconocido,Blanca,Fuego,Otra',0,0,5,0,0,0),
 (124,106,'Clase de Arma',7,0,NULL,2,'Desconocido,Corvo,Cuchillo,Escopeta,Fuerza,Fusil,Pistola,Revolver,Otro',0,0,5,0,0,0),
 (125,106,'Tipo de Objeto Robado',1,0,NULL,3,NULL,0,0,5,0,0,0),
 (126,106,'Detalle Objetos Robados',2,0,NULL,4,NULL,0,0,5,0,0,0),
 (127,104,'Nombre Hechor',1,0,NULL,1,NULL,0,0,5,0,0,0);

INSERT INTO form_field_option (form_field_id,option_name,option_value) VALUES 
 (104,'field_datatype','numeric'),
 (104,'field_hidden','0'),
 (105,'field_datatype','text'),
 (105,'field_hidden','0'),
 (107,'field_datatype','text'),
 (107,'field_hidden','0'),
 (108,'field_datatype','numeric'),
 (108,'field_hidden','0'),
 (110,'field_datatype','text'),
 (110,'field_hidden','0'),
 (111,'field_datatype','text'),
 (111,'field_hidden','0'),
 (112,'field_datatype','numeric'),
 (112,'field_hidden','0'),
 (114,'field_datatype','text'),
 (115,'field_datatype','text'),
 (115,'field_hidden','0'),
 (119,'field_datatype','text'),
 (121,'field_datatype','text'),
 (122,'field_datatype','text'),
 (125,'field_datatype','text'),
 (125,'field_hidden','0'),
 (126,'field_datatype','text');

