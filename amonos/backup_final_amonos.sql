-- ÁMONOS FINAL DATABASE DUMP
SET FOREIGN_KEY_CHECKS = 0;

-- Table: categorias_destino
CREATE TABLE `categorias_destino` (
  `id_categoria` int NOT NULL AUTO_INCREMENT,
  `nombre_categoria` varchar(100) NOT NULL,
  PRIMARY KEY (`id_categoria`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

INSERT INTO categorias_destino (id_categoria, nombre_categoria) VALUES ('1', 'aventura');
INSERT INTO categorias_destino (id_categoria, nombre_categoria) VALUES ('2', 'cultura');
INSERT INTO categorias_destino (id_categoria, nombre_categoria) VALUES ('3', 'playa');
INSERT INTO categorias_destino (id_categoria, nombre_categoria) VALUES ('4', 'gastronomia');
INSERT INTO categorias_destino (id_categoria, nombre_categoria) VALUES ('5', 'montana');
INSERT INTO categorias_destino (id_categoria, nombre_categoria) VALUES ('6', 'naturaleza');
INSERT INTO categorias_destino (id_categoria, nombre_categoria) VALUES ('7', 'pueblos vivos');


-- Table: destinos
CREATE TABLE `destinos` (
  `id_destino` int NOT NULL AUTO_INCREMENT,
  `nombre` varchar(150) NOT NULL,
  `departamento` varchar(100) NOT NULL,
  `descripcion` text,
  `precio_entrada` decimal(10,2) DEFAULT '0.00',
  `precio_comida` decimal(10,2) DEFAULT '0.00',
  `precio_parqueo` decimal(10,2) DEFAULT '0.00',
  `precio_hospedaje` decimal(10,2) DEFAULT '0.00',
  `id_categoria` int DEFAULT NULL,
  `puntaje` decimal(3,1) DEFAULT '0.0',
  PRIMARY KEY (`id_destino`),
  KEY `id_categoria` (`id_categoria`),
  CONSTRAINT `destinos_ibfk_1` FOREIGN KEY (`id_categoria`) REFERENCES `categorias_destino` (`id_categoria`) ON DELETE SET NULL
) ENGINE=InnoDB AUTO_INCREMENT=68 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

INSERT INTO destinos (id_destino, nombre, departamento, descripcion, precio_entrada, precio_comida, precio_parqueo, precio_hospedaje, id_categoria, puntaje) VALUES ('1', 'Parque Nacional El Imposible', 'Tacuba, Ahuachapán, El Salvador', 'Una de las reservas naturales más importantes de Centroamérica. Se caracteriza por su bosque tropical seco y una biodiversidad extraordinaria, siendo el refugio de numerosas especies de aves y mamíferos. Es un destino ideal para el senderismo y la observación de la naturaleza en estado puro.', '3.00', '6.00', '8.00', '0.00', '1', '4.5');
INSERT INTO destinos (id_destino, nombre, departamento, descripcion, precio_entrada, precio_comida, precio_parqueo, precio_hospedaje, id_categoria, puntaje) VALUES ('2', 'Concepción de Ataco', 'Ahuachapán, El Salvador', 'Encantador pueblo colonial ubicado en la Ruta de las Flores. Es reconocido mundialmente por sus coloridos murales artísticos que adornan sus calles, sus plantaciones de café de altura y una vibrante oferta de galerías de arte y artesanías locales.', '2.40', '9.60', '6.00', '0.00', '7', '4.5');
INSERT INTO destinos (id_destino, nombre, departamento, descripcion, precio_entrada, precio_comida, precio_parqueo, precio_hospedaje, id_categoria, puntaje) VALUES ('3', 'Apaneca', 'Ahuachapán, El Salvador', 'Destino montañoso famoso por su clima fresco y paisajes verdes. Es el corazón de la producción de café de especialidad en la región y ofrece actividades como el "estirón" en rutas de senderismo y la exploración de sus bosques nubosos.', '3.07', '12.27', '7.67', '0.00', '4', '4.5');
INSERT INTO destinos (id_destino, nombre, departamento, descripcion, precio_entrada, precio_comida, precio_parqueo, precio_hospedaje, id_categoria, puntaje) VALUES ('4', 'Laguna Verde', 'Ahuachapán, El Salvador', 'La Laguna Verde es un espejo de agua rodeado de vegetación exuberante, ideal para quienes buscan paz y contacto directo con la naturaleza.', '1.69', '4.23', '5.08', '0.00', '1', '4.5');
INSERT INTO destinos (id_destino, nombre, departamento, descripcion, precio_entrada, precio_comida, precio_parqueo, precio_hospedaje, id_categoria, puntaje) VALUES ('5', 'Lago de Coatepeque', 'El Congo, Santa Ana, El Salvador', 'Un impresionante lago de origen volcánico situado en un cráter. Sus aguas cristalinas y los acantilados que lo rodean lo convierten en uno de los paisajes más icónicos de El Salvador, ideal para el descanso, la navegación y el turismo sostenible.', '2.27', '11.36', '11.36', '0.00', '6', '4.5');
INSERT INTO destinos (id_destino, nombre, departamento, descripcion, precio_entrada, precio_comida, precio_parqueo, precio_hospedaje, id_categoria, puntaje) VALUES ('6', 'Volcán de Santa Ana (Ilamatepec)', 'Parque Nacional Los Volcanes, Santa Ana, El Salvador', 'El pico más alto del país. El ascenso a través del bosque pluvial conduce a un cráter activo con una laguna de color turquesa intenso, ofreciendo una de las vistas más espectaculares y desafiantes de la geografía salvadoreña.', '1.77', '9.44', '11.79', '0.00', '6', '4.5');
INSERT INTO destinos (id_destino, nombre, departamento, descripcion, precio_entrada, precio_comida, precio_parqueo, precio_hospedaje, id_categoria, puntaje) VALUES ('7', 'Parque Natural Cerro Verde', 'Santa Ana, El Salvador', 'Una reserva forestal que ofrece una vista panorámica privilegiada del Volcán de Santa Ana y el Volcán de Izalco. Sus senderos permiten recorrer bosques nubosos y aprender sobre la historia volcánica de la zona en un entorno de paz absoluta.', '1.54', '8.21', '10.26', '0.00', '1', '4.5');
INSERT INTO destinos (id_destino, nombre, departamento, descripcion, precio_entrada, precio_comida, precio_parqueo, precio_hospedaje, id_categoria, puntaje) VALUES ('8', 'Juayúa', 'Sonsonate, El Salvador', 'Juayúa es la capital gastronómica de la Ruta de las Flores, famosa por su festival gastronómico y sus cascadas cercanas.', '2.35', '11.76', '5.88', '0.00', '2', '4.5');
INSERT INTO destinos (id_destino, nombre, departamento, descripcion, precio_entrada, precio_comida, precio_parqueo, precio_hospedaje, id_categoria, puntaje) VALUES ('9', 'Nahuizalco', 'Sonsonate, El Salvador', 'Nahuizalco es un pueblo tradicional donde destacan las artesanías en madera, mimbre y el ambiente colonial.', '2.40', '9.60', '6.00', '0.00', '7', '4.5');
INSERT INTO destinos (id_destino, nombre, departamento, descripcion, precio_entrada, precio_comida, precio_parqueo, precio_hospedaje, id_categoria, puntaje) VALUES ('10', 'Playa Los Cóbanos', 'Acajutla, Sonsonate, El Salvador', 'Playa Los Cóbanos es un lugar único donde la montaña se encuentra con el mar, creando bahías pequeñas y tranquilas.', '2.73', '13.64', '13.64', '0.00', '3', '4.5');
INSERT INTO destinos (id_destino, nombre, departamento, descripcion, precio_entrada, precio_comida, precio_parqueo, precio_hospedaje, id_categoria, puntaje) VALUES ('11', 'Izalco', 'Sonsonate, El Salvador', 'Izalco es conocido como la ciudad del volcán, con una rica historia agrícola y vistas impresionantes al volcán inactivo.', '1.73', '6.93', '4.33', '0.00', '2', '4.5');
INSERT INTO destinos (id_destino, nombre, departamento, descripcion, precio_entrada, precio_comida, precio_parqueo, precio_hospedaje, id_categoria, puntaje) VALUES ('12', 'Playa El Tunco', 'Tamanique, La Libertad, El Salvador', 'El epicentro del surf en El Salvador. Famosa por sus olas constantes y la icónica roca que divide la playa, es un destino que combina el deporte extremo con una variada oferta gastronómica y una vida nocturna vibrante.', '3.53', '17.65', '8.82', '0.00', '3', '4.5');
INSERT INTO destinos (id_destino, nombre, departamento, descripcion, precio_entrada, precio_comida, precio_parqueo, precio_hospedaje, id_categoria, puntaje) VALUES ('13', 'Puerto de La Libertad', 'La Libertad Costa, La Libertad, El Salvador', 'El Puerto de La Libertad es la puerta de entrada al océano, famoso por su mercado de pescado y sus paseos en lancha.', '2.35', '11.76', '5.88', '0.00', '4', '4.5');
INSERT INTO destinos (id_destino, nombre, departamento, descripcion, precio_entrada, precio_comida, precio_parqueo, precio_hospedaje, id_categoria, puntaje) VALUES ('14', 'Parque Nacional Walter Thilo Deininger', 'San Diego, La Libertad, El Salvador', 'El Parque Nacional Walter Thilo Deininger es un santuario de paz con bosques primarios y una fauna diversa.', '2.00', '10.00', '5.00', '0.00', '1', '4.5');
INSERT INTO destinos (id_destino, nombre, departamento, descripcion, precio_entrada, precio_comida, precio_parqueo, precio_hospedaje, id_categoria, puntaje) VALUES ('15', 'Parque Nacional El Boquerón', 'Santa Tecla, La Libertad, El Salvador', 'Ubicado en el cráter del volcán de San Salvador, este parque es un pulmón verde para la capital. Sus senderos permiten explorar la vegetación nativa y contemplar la inmensidad del cráter desde miradores naturales.', '2.00', '10.00', '5.00', '0.00', '1', '4.5');
INSERT INTO destinos (id_destino, nombre, departamento, descripcion, precio_entrada, precio_comida, precio_parqueo, precio_hospedaje, id_categoria, puntaje) VALUES ('16', 'Ruta de las Flores', 'Ahuachapán y Sonsonate, El Salvador', 'La Ruta de las Flores es un recorrido por pueblos pintorescos, cafetales y paisajes montañosos.', '2.27', '11.36', '11.36', '0.00', '2', '4.5');
INSERT INTO destinos (id_destino, nombre, departamento, descripcion, precio_entrada, precio_comida, precio_parqueo, precio_hospedaje, id_categoria, puntaje) VALUES ('17', 'Bahía de Jiquilisco', 'Usulután, El Salvador', 'Un ecosistema vital compuesto por extensos manglares y esteros. Es un santuario crítico para la biodiversidad marina y aves migratorias, además de ser un centro fundamental para la pesca artesanal y la conservación ambiental.', '2.00', '8.00', '8.00', '0.00', '1', '4.5');
INSERT INTO destinos (id_destino, nombre, departamento, descripcion, precio_entrada, precio_comida, precio_parqueo, precio_hospedaje, id_categoria, puntaje) VALUES ('18', 'Cerro El Pital', 'San Ignacio, Chalatenango, El Salvador', 'El punto geográfico más alto de El Salvador. Se distingue por sus temperaturas bajas, la presencia de bosques de pinos y una vista impresionante que permite observar gran parte del territorio nacional en días despejados.', '2.27', '11.36', '11.36', '0.00', '1', '4.5');
INSERT INTO destinos (id_destino, nombre, departamento, descripcion, precio_entrada, precio_comida, precio_parqueo, precio_hospedaje, id_categoria, puntaje) VALUES ('19', 'La Palma', 'La Palma, Chalatenango, El Salvador', 'La Palma es un pueblo artístico en las montañas, conocido por sus murales y la tranquilidad de su ambiente.', '2.27', '11.36', '11.36', '0.00', '2', '4.5');
INSERT INTO destinos (id_destino, nombre, departamento, descripcion, precio_entrada, precio_comida, precio_parqueo, precio_hospedaje, id_categoria, puntaje) VALUES ('20', 'Mirador de La Montañona', 'La Palma, Chalatenango, El Salvador', 'El Mirador de la Montañona ofrece una de las mejores vistas aéreas de la región, ideal para el descanso.', '2.00', '10.00', '10.00', '0.00', '1', '4.5');
INSERT INTO destinos (id_destino, nombre, departamento, descripcion, precio_entrada, precio_comida, precio_parqueo, precio_hospedaje, id_categoria, puntaje) VALUES ('22', 'Playa El Espino', 'Jucuarán, Usulután', 'Playa El Espino es un paraíso para los surfistas y quienes buscan playas vírgenes y tranquilas.', '2.00', '8.00', '8.00', '0.00', '3', '4.5');
INSERT INTO destinos (id_destino, nombre, departamento, descripcion, precio_entrada, precio_comida, precio_parqueo, precio_hospedaje, id_categoria, puntaje) VALUES ('23', 'Laguna de Olomega', 'El Carmen, Usulután', 'La Laguna de Olomega es un espejo de agua rodeada de colinas, perfecta para un día de campo.', '2.00', '8.00', '8.00', '0.00', '1', '4.5');
INSERT INTO destinos (id_destino, nombre, departamento, descripcion, precio_entrada, precio_comida, precio_parqueo, precio_hospedaje, id_categoria, puntaje) VALUES ('24', 'Volcán de San Vicente (Chinchontepec)', 'San Vicente, El Salvado', 'El Volcán de San Vicente ofrece una experiencia de ascenso challenging con vistas panorámicas del oriente.', '2.00', '8.00', '5.00', '0.00', '1', '4.5');
INSERT INTO destinos (id_destino, nombre, departamento, descripcion, precio_entrada, precio_comida, precio_parqueo, precio_hospedaje, id_categoria, puntaje) VALUES ('25', 'Turicentro Amapulapa', 'San Vicente, El Salvador', 'El Turicentro Amapulapa es un lugar familiar con piscinas y áreas verdes ideales para el descanso.', '1.00', '8.00', '5.00', '0.00', '1', '4.5');
INSERT INTO destinos (id_destino, nombre, departamento, descripcion, precio_entrada, precio_comida, precio_parqueo, precio_hospedaje, id_categoria, puntaje) VALUES ('26', 'Iglesia del Pilar', 'San Vicente, El Salvador', 'La Iglesia del Pilar es un monumento histórico con una arquitectura colonial impresionante.', '2.00', '5.00', '5.00', '0.00', '1', '4.5');
INSERT INTO destinos (id_destino, nombre, departamento, descripcion, precio_entrada, precio_comida, precio_parqueo, precio_hospedaje, id_categoria, puntaje) VALUES ('27', 'Suchitoto', 'Suchitoto, Cuscatlán, El Salvador', 'Conocida como la ciudad del arte y la cultura, Suchitoto conserva una arquitectura colonial impecable. Sus calles empedradas y su ubicación junto al Lago de Suchitlán la convierten en un refugio de tranquilidad y un centro de artesanías en barro.', '2.40', '9.60', '6.00', '0.00', '7', '4.5');
INSERT INTO destinos (id_destino, nombre, departamento, descripcion, precio_entrada, precio_comida, precio_parqueo, precio_hospedaje, id_categoria, puntaje) VALUES ('28', 'Lago de Suchitlán', 'Suchitoto, Cuscatlán, El Salvador', 'El Lago de Suchitlán es un espejo de agua tranquilo, ideal para la observación de aves y el descanso.', '2.40', '9.60', '6.00', '0.00', '1', '4.5');
INSERT INTO destinos (id_destino, nombre, departamento, descripcion, precio_entrada, precio_comida, precio_parqueo, precio_hospedaje, id_categoria, puntaje) VALUES ('29', 'Cascada Los Tercios', 'Suchitoto, Cuscatlán, El Salvador', 'La Cascada Los Tercios es una maravilla natural con tres caídas de agua sobre formaciones rocosas.', '2.00', '5.00', '5.00', '0.00', '1', '4.5');
INSERT INTO destinos (id_destino, nombre, departamento, descripcion, precio_entrada, precio_comida, precio_parqueo, precio_hospedaje, id_categoria, puntaje) VALUES ('30', 'Playa Costa del Sol', 'San Luis La Herradura, La Paz, El Salvador', 'Playa Costa del Sol es un destino turístico moderno con resorts y actividades náuticas.', '2.40', '9.60', '6.00', '0.00', '3', '4.5');
INSERT INTO destinos (id_destino, nombre, departamento, descripcion, precio_entrada, precio_comida, precio_parqueo, precio_hospedaje, id_categoria, puntaje) VALUES ('31', 'Estero de Jaltepeque', 'San Luis La Herradura, La Paz, El Salvador', 'El Estero de Jaltepeque es un laberinto de manglares y canales, ideal para conocer la vida costera.', '2.40', '9.60', '6.00', '0.00', '6', '4.5');
INSERT INTO destinos (id_destino, nombre, departamento, descripcion, precio_entrada, precio_comida, precio_parqueo, precio_hospedaje, id_categoria, puntaje) VALUES ('32', 'Miradores de San Juan Tepezontes', 'San Juan Tepezontes, La Paz, El Salvador', 'Los Miradores de San Juan Tepezontes ofrecen una vista panorámica de la ciudad y el valle.', '2.00', '5.00', '5.00', '0.00', '6', '4.5');
INSERT INTO destinos (id_destino, nombre, departamento, descripcion, precio_entrada, precio_comida, precio_parqueo, precio_hospedaje, id_categoria, puntaje) VALUES ('33', 'Ilobasco', 'Ilobasco, Cabañas, El Salvador', 'Ilobasco es la cuna de la artesanía en barro, famoso por sus figuras detalladas y coloridas.', '2.40', '9.60', '6.00', '0.00', '7', '4.5');
INSERT INTO destinos (id_destino, nombre, departamento, descripcion, precio_entrada, precio_comida, precio_parqueo, precio_hospedaje, id_categoria, puntaje) VALUES ('34', 'Sensuntepeque', 'Sensuntepeque, Cabañas, El Salvador', 'Sensuntepeque es una ciudad colonial con una arquitectura colonial y un clima agradable.', '2.40', '9.60', '6.00', '0.00', '7', '4.5');
INSERT INTO destinos (id_destino, nombre, departamento, descripcion, precio_entrada, precio_comida, precio_parqueo, precio_hospedaje, id_categoria, puntaje) VALUES ('35', 'Eco-Parque Heliconia', 'Ilobasco, Cabañas, El Salvador', 'El Eco-Parque Heliconia es un espacio dedicado a la conservación y la educación ambiental.', '2.00', '5.00', '5.00', '0.00', '6', '4.5');
INSERT INTO destinos (id_destino, nombre, departamento, descripcion, precio_entrada, precio_comida, precio_parqueo, precio_hospedaje, id_categoria, puntaje) VALUES ('36', 'Volcán de San Miguel (Chaparrastique', 'San Miguel, El Salvador', 'El Volcán de San Miguel es uno de los más activos y espectaculares, con un cráter impresionante.', '2.00', '8.00', '8.00', '0.00', '5', '4.5');
INSERT INTO destinos (id_destino, nombre, departamento, descripcion, precio_entrada, precio_comida, precio_parqueo, precio_hospedaje, id_categoria, puntaje) VALUES ('37', 'Parque Recreativo Montegrande', 'San Miguel, El Salvador', 'El Parque Recreativo Montegrande es un espacio familiar con actividades al aire libre.', '2.00', '8.00', '3.00', '0.00', '6', '4.5');
INSERT INTO destinos (id_destino, nombre, departamento, descripcion, precio_entrada, precio_comida, precio_parqueo, precio_hospedaje, id_categoria, puntaje) VALUES ('38', 'Catedral Basílica Nuestra Señora de la Paz', 'San Miguel, El Salvador', 'La Catedral Basílica es la máxima expresión religiosa y arquitectónica del centro histórico.', '2.00', '5.00', '3.00', '0.00', '2', '4.5');
INSERT INTO destinos (id_destino, nombre, departamento, descripcion, precio_entrada, precio_comida, precio_parqueo, precio_hospedaje, id_categoria, puntaje) VALUES ('39', 'Museo de la Revolución', 'Perquín, Morazán', 'El Museo de la Revolución cuenta la historia política y social de El Salvador.', '2.00', '8.00', '10.00', '0.00', '2', '4.5');
INSERT INTO destinos (id_destino, nombre, departamento, descripcion, precio_entrada, precio_comida, precio_parqueo, precio_hospedaje, id_categoria, puntaje) VALUES ('40', 'El Llano del Muerto', 'Perquín, Morazán', 'El Llano del Muerto es un área natural poco explorada, ideal para el senderismo solitario.', '2.00', '8.00', '10.00', '0.00', '1', '4.5');
INSERT INTO destinos (id_destino, nombre, departamento, descripcion, precio_entrada, precio_comida, precio_parqueo, precio_hospedaje, id_categoria, puntaje) VALUES ('41', 'Cascada El Salto', 'Arambala, Morazán', 'La Cascada El Salto es un salto de agua natural rodeado de bosque tropical.', '2.00', '8.00', '10.00', '0.00', '6', '4.5');
INSERT INTO destinos (id_destino, nombre, departamento, descripcion, precio_entrada, precio_comida, precio_parqueo, precio_hospedaje, id_categoria, puntaje) VALUES ('42', 'Golfo de Fonseca', 'La Unión, El Salvador', 'El Golfo de Fonseca es un área marina compartida, famosa por sus islas y biodiversidad.', '2.00', '8.00', '10.00', '0.00', '6', '4.5');
INSERT INTO destinos (id_destino, nombre, departamento, descripcion, precio_entrada, precio_comida, precio_parqueo, precio_hospedaje, id_categoria, puntaje) VALUES ('43', 'Isla Conchagüita', 'Golfo de Fonseca, La Unión', 'La Isla Conchagüita es un paraíso tropical con playas tranquilas y aguas cálidas.', '2.00', '8.00', '10.00', '0.00', '3', '4.5');
INSERT INTO destinos (id_destino, nombre, departamento, descripcion, precio_entrada, precio_comida, precio_parqueo, precio_hospedaje, id_categoria, puntaje) VALUES ('44', 'Conchagua', 'Conchagua, La Unión', 'Conchagua es un pueblo en la cima de una montaña con vistas espectaculares al golfo.', '2.00', '8.00', '10.00', '0.00', '7', '4.5');
INSERT INTO destinos (id_destino, nombre, departamento, descripcion, precio_entrada, precio_comida, precio_parqueo, precio_hospedaje, id_categoria, puntaje) VALUES ('45', 'Olocuilta', 'Cuscatlán', 'Olocuilta es famoso por sus pupusas y sus talleres de artesanías en barro.', '0.00', '12.00', '2.00', '0.00', '4', '4.8');
INSERT INTO destinos (id_destino, nombre, departamento, descripcion, precio_entrada, precio_comida, precio_parqueo, precio_hospedaje, id_categoria, puntaje) VALUES ('46', 'Volcán de Izalco', 'Sonsonate', 'El Volcán de Izalco es el volcán más icónico del país, con una silueta perfecta.', '3.00', '10.00', '5.00', '0.00', '5', '4.7');
INSERT INTO destinos (id_destino, nombre, departamento, descripcion, precio_entrada, precio_comida, precio_parqueo, precio_hospedaje, id_categoria, puntaje) VALUES ('47', 'Parque Nacional Montecristo', 'Ocotepeque/Chalatenango', 'El Parque Nacional Montecristo es el bosque más nublado y diverso del país.', '5.00', '12.00', '3.00', '0.00', '6', '4.9');
INSERT INTO destinos (id_destino, nombre, departamento, descripcion, precio_entrada, precio_comida, precio_parqueo, precio_hospedaje, id_categoria, puntaje) VALUES ('48', 'Mercado Central de San Salvador', 'San Salvador', 'El Mercado Central es el corazón comercial de la capital, lleno de colores y sabores.', '0.00', '8.00', '2.00', '0.00', '4', '4.5');
INSERT INTO destinos (id_destino, nombre, departamento, descripcion, precio_entrada, precio_comida, precio_parqueo, precio_hospedaje, id_categoria, puntaje) VALUES ('49', 'Centro Histórico de San Salvador', 'San Salvador', 'El Centro Histórico es la zona más emblemática de la ciudad, con plazas y monumentos.', '0.00', '15.00', '3.00', '0.00', '4', '4.7');
INSERT INTO destinos (id_destino, nombre, departamento, descripcion, precio_entrada, precio_comida, precio_parqueo, precio_hospedaje, id_categoria, puntaje) VALUES ('50', 'Pupusería La Tradicional', 'Cuscatlán', 'Pupusería La Tradicional ofrece el sabor más auténtico de las pupusas salvadoreñas.', '0.00', '6.00', '1.00', '0.00', '4', '4.9');
INSERT INTO destinos (id_destino, nombre, departamento, descripcion, precio_entrada, precio_comida, precio_parqueo, precio_hospedaje, id_categoria, puntaje) VALUES ('51', 'Restaurante El Jardín', 'La Libertad', 'Restaurante El Jardín combina la alta cocina con un ambiente natural relajante.', '0.00', '20.00', '2.00', '0.00', '4', '4.6');
INSERT INTO destinos (id_destino, nombre, departamento, descripcion, precio_entrada, precio_comida, precio_parqueo, precio_hospedaje, id_categoria, puntaje) VALUES ('52', 'Cafetería la Montaña', 'Sonsonate', 'Cafetería la Montaña es el lugar ideal para disfrutar de un café recién tostado.', '0.00', '7.00', '1.00', '0.00', '4', '4.8');
INSERT INTO destinos (id_destino, nombre, departamento, descripcion, precio_entrada, precio_comida, precio_parqueo, precio_hospedaje, id_categoria, puntaje) VALUES ('53', 'Mercado de Comidas Típicas', 'San Salvador', 'El Mercado de Comidas Típicas es un festival de sabores tradicionales salvadoreños.', '0.00', '5.00', '2.00', '0.00', '4', '4.4');
INSERT INTO destinos (id_destino, nombre, departamento, descripcion, precio_entrada, precio_comida, precio_parqueo, precio_hospedaje, id_categoria, puntaje) VALUES ('54', 'Cerro Verde', 'Santa Ana', 'El Cerro Verde es la puerta de entrada a los volcanes, con senderos y vistas únicas.', '4.00', '12.00', '3.00', '0.00', '5', '4.8');
INSERT INTO destinos (id_destino, nombre, departamento, descripcion, precio_entrada, precio_comida, precio_parqueo, precio_hospedaje, id_categoria, puntaje) VALUES ('56', 'Volcán de San Salvador', 'La Libertad', 'El Volcán de San Salvador es un destino ideal para quienes buscan aventura y vistas urbanas.', '3.00', '10.00', '3.00', '0.00', '5', '4.7');
INSERT INTO destinos (id_destino, nombre, departamento, descripcion, precio_entrada, precio_comida, precio_parqueo, precio_hospedaje, id_categoria, puntaje) VALUES ('60', 'Cascada la Concordia', 'La Libertad', 'La Cascada la Concordia es una caída de agua impresionante en medio de la selva.', '5.00', '10.00', '3.00', '0.00', '6', '4.8');
INSERT INTO destinos (id_destino, nombre, departamento, descripcion, precio_entrada, precio_comida, precio_parqueo, precio_hospedaje, id_categoria, puntaje) VALUES ('61', 'Santuario de Peregrinos', 'San Salvador', 'El Santuario de Peregrinos es un lugar de retiro espiritual y paz absoluta.', '0.00', '5.00', '2.00', '0.00', '6', '4.5');
INSERT INTO destinos (id_destino, nombre, departamento, descripcion, precio_entrada, precio_comida, precio_parqueo, precio_hospedaje, id_categoria, puntaje) VALUES ('62', 'Joyas de Cerén', 'La Libertad', 'Patrimonio de la Humanidad por la UNESCO, es conocida como la "Pompeya de América". Sus excavaciones revelan la vida cotidiana de una aldea maya que quedó sepultada por las cenizas volcánicas, preservando estructuras y utensilios originales.', '10.00', '12.00', '3.00', '0.00', '2', '4.9');
INSERT INTO destinos (id_destino, nombre, departamento, descripcion, precio_entrada, precio_comida, precio_parqueo, precio_hospedaje, id_categoria, puntaje) VALUES ('63', 'Teatro Nacional de San Salvador', 'San Salvador', 'El Teatro Nacional es el centro de las artes escénicas con una arquitectura imponente.', '0.00', '15.00', '5.00', '0.00', '2', '4.7');
INSERT INTO destinos (id_destino, nombre, departamento, descripcion, precio_entrada, precio_comida, precio_parqueo, precio_hospedaje, id_categoria, puntaje) VALUES ('64', 'Iglesia El Rosario', 'San Salvador', 'La Iglesia El Rosario es una obra maestra de la arquitectura moderna y la luz.', '0.00', '8.00', '3.00', '0.00', '2', '4.6');
INSERT INTO destinos (id_destino, nombre, departamento, descripcion, precio_entrada, precio_comida, precio_parqueo, precio_hospedaje, id_categoria, puntaje) VALUES ('65', 'Ruta de las Pupusas en Olocuilta', 'La Libertad', 'La Ruta de las Pupusas en Olocuilta es la experiencia culinaria definitiva del país.', '0.00', '7.00', '2.00', '0.00', '4', '4.9');
INSERT INTO destinos (id_destino, nombre, departamento, descripcion, precio_entrada, precio_comida, precio_parqueo, precio_hospedaje, id_categoria, puntaje) VALUES ('66', 'Mercados Gastronómicos de San Miguel', 'San Miguel', 'Los Mercados Gastronómicos de San Miguel ofrecen la esencia del oriente salvadoreño.', '0.00', '12.00', '3.00', '0.00', '4', '4.4');
INSERT INTO destinos (id_destino, nombre, departamento, descripcion, precio_entrada, precio_comida, precio_parqueo, precio_hospedaje, id_categoria, puntaje) VALUES ('67', 'Juquila', 'Ahuachapán', 'Juquila es un pueblo colonial tranquilo con una arquitectura colonial muy bien preservada.', '0.00', '10.00', '2.00', '25.00', '7', '4.7');


-- Table: imagenes_destino
CREATE TABLE `imagenes_destino` (
  `id_imagen` int NOT NULL AUTO_INCREMENT,
  `id_destino` int NOT NULL,
  `imagen_url` varchar(255) NOT NULL,
  `orden` int NOT NULL DEFAULT '1',
  PRIMARY KEY (`id_imagen`),
  KEY `id_destino` (`id_destino`),
  CONSTRAINT `imagenes_destino_ibfk_1` FOREIGN KEY (`id_destino`) REFERENCES `destinos` (`id_destino`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=78 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

INSERT INTO imagenes_destino (id_imagen, id_destino, imagen_url, orden) VALUES ('1', '1', 'https://images.unsplash.com/photo-1501785888041-af3ef285b470?auto=format&fit=crop&w=800&q=80', '1');
INSERT INTO imagenes_destino (id_imagen, id_destino, imagen_url, orden) VALUES ('2', '1', 'https://images.unsplash.com/photo-1441974231531-c6227db76b6e?auto=format&fit=crop&w=800&q=80', '1');
INSERT INTO imagenes_destino (id_imagen, id_destino, imagen_url, orden) VALUES ('3', '3', 'https://images.unsplash.com/photo-1464822759023-af6d269c235f?auto=format&fit=crop&w=800&q=80', '1');
INSERT INTO imagenes_destino (id_imagen, id_destino, imagen_url, orden) VALUES ('4', '4', 'https://images.unsplash.com/photo-1506744038136-46286d3abf9d?auto=format&fit=crop&w=800&q=80', '1');
INSERT INTO imagenes_destino (id_imagen, id_destino, imagen_url, orden) VALUES ('5', '6', 'imagenes/volcan-santa-ana.webp', '1');
INSERT INTO imagenes_destino (id_imagen, id_destino, imagen_url, orden) VALUES ('6', '7', 'https://images.unsplash.com/photo-1441974231531-c6227db76b6e?auto=format&fit=crop&w=800&q=80', '1');
INSERT INTO imagenes_destino (id_imagen, id_destino, imagen_url, orden) VALUES ('7', '14', 'https://images.unsplash.com/photo-1470071459604-3b5ec3a7fe05?auto=format&fit=crop&w=800&q=80', '1');
INSERT INTO imagenes_destino (id_imagen, id_destino, imagen_url, orden) VALUES ('8', '15', 'https://images.unsplash.com/photo-1464822759023-af6d269c235f?auto=format&fit=crop&w=800&q=80', '1');
INSERT INTO imagenes_destino (id_imagen, id_destino, imagen_url, orden) VALUES ('9', '18', 'https://images.unsplash.com/photo-1464822759023-af6d269c235f?auto=format&fit=crop&w=800&q=80', '1');
INSERT INTO imagenes_destino (id_imagen, id_destino, imagen_url, orden) VALUES ('10', '20', 'https://images.unsplash.com/photo-1470071459604-3b5ec3a7fe05?auto=format&fit=crop&w=800&q=80', '1');
INSERT INTO imagenes_destino (id_imagen, id_destino, imagen_url, orden) VALUES ('11', '24', 'https://images.unsplash.com/photo-1542332213-31f87348055f?auto=format&fit=crop&w=800&q=80', '1');
INSERT INTO imagenes_destino (id_imagen, id_destino, imagen_url, orden) VALUES ('12', '29', 'https://images.unsplash.com/photo-1433086566608-e935355272ed?auto=format&fit=crop&w=800&q=80', '1');
INSERT INTO imagenes_destino (id_imagen, id_destino, imagen_url, orden) VALUES ('13', '35', 'https://images.unsplash.com/photo-1441974231531-c6227db76b6e?auto=format&fit=crop&w=800&q=80', '1');
INSERT INTO imagenes_destino (id_imagen, id_destino, imagen_url, orden) VALUES ('14', '36', 'https://images.unsplash.com/photo-1464822759023-af6d269c235f?auto=format&fit=crop&w=800&q=80', '1');
INSERT INTO imagenes_destino (id_imagen, id_destino, imagen_url, orden) VALUES ('15', '40', 'https://images.unsplash.com/photo-1441974231531-c6227db76b6e?auto=format&fit=crop&w=800&q=80', '1');
INSERT INTO imagenes_destino (id_imagen, id_destino, imagen_url, orden) VALUES ('16', '2', 'https://images.unsplash.com/photo-1518709268805-4c998f626650?auto=format&fit=crop&w=800&q=80', '1');
INSERT INTO imagenes_destino (id_imagen, id_destino, imagen_url, orden) VALUES ('17', '2', 'https://images.unsplash.com/photo-1523906834658-6e24ef2386f9?auto=format&fit=crop&w=800&q=80', '1');
INSERT INTO imagenes_destino (id_imagen, id_destino, imagen_url, orden) VALUES ('18', '8', 'https://images.unsplash.com/photo-1582719478250-c89cae4dc85b?auto=format&fit=crop&w=800&q=80', '1');
INSERT INTO imagenes_destino (id_imagen, id_destino, imagen_url, orden) VALUES ('19', '9', 'https://images.unsplash.com/photo-1518709268805-4c998f626650?auto=format&fit=crop&w=800&q=80', '1');
INSERT INTO imagenes_destino (id_imagen, id_destino, imagen_url, orden) VALUES ('20', '11', 'https://images.unsplash.com/photo-1582719478250-c89cae4dc85b?auto=format&fit=crop&w=800&q=80', '1');
INSERT INTO imagenes_destino (id_imagen, id_destino, imagen_url, orden) VALUES ('21', '16', 'https://images.unsplash.com/photo-1518709268805-4c998f626650?auto=format&fit=crop&w=800&q=80', '1');
INSERT INTO imagenes_destino (id_imagen, id_destino, imagen_url, orden) VALUES ('22', '19', 'https://images.unsplash.com/photo-1518709268805-4c998f626650?auto=format&fit=crop&w=800&q=80', '1');
INSERT INTO imagenes_destino (id_imagen, id_destino, imagen_url, orden) VALUES ('23', '27', 'https://images.unsplash.com/photo-1523906834658-6e24ef2386f9?auto=format&fit=crop&w=800&q=80', '1');
INSERT INTO imagenes_destino (id_imagen, id_destino, imagen_url, orden) VALUES ('24', '27', 'https://images.unsplash.com/photo-1518709268805-4c998f626650?auto=format&fit=crop&w=800&q=80', '1');
INSERT INTO imagenes_destino (id_imagen, id_destino, imagen_url, orden) VALUES ('25', '33', 'https://images.unsplash.com/photo-1582719478250-c89cae4dc85b?auto=format&fit=crop&w=800&q=80', '1');
INSERT INTO imagenes_destino (id_imagen, id_destino, imagen_url, orden) VALUES ('26', '34', 'https://images.unsplash.com/photo-1518709268805-4c998f626650?auto=format&fit=crop&w=800&q=80', '1');
INSERT INTO imagenes_destino (id_imagen, id_destino, imagen_url, orden) VALUES ('27', '38', 'https://images.unsplash.com/photo-1548013146-72479768bdee?auto=format&fit=crop&w=800&q=80', '1');
INSERT INTO imagenes_destino (id_imagen, id_destino, imagen_url, orden) VALUES ('28', '39', 'https://images.unsplash.com/photo-1505664194779-8bebfcbb9829?auto=format&fit=crop&w=800&q=80', '1');
INSERT INTO imagenes_destino (id_imagen, id_destino, imagen_url, orden) VALUES ('29', '43', 'https://images.unsplash.com/photo-1518709268805-4c998f626650?auto=format&fit=crop&w=800&q=80', '1');
INSERT INTO imagenes_destino (id_imagen, id_destino, imagen_url, orden) VALUES ('30', '44', 'https://images.unsplash.com/photo-1518709268805-4c998f626650?auto=format&fit=crop&w=800&q=80', '1');
INSERT INTO imagenes_destino (id_imagen, id_destino, imagen_url, orden) VALUES ('31', '5', 'imagenes/lago-coatepeque.webp', '1');
INSERT INTO imagenes_destino (id_imagen, id_destino, imagen_url, orden) VALUES ('32', '5', 'imagenes/lago-coatepeque.webp', '1');
INSERT INTO imagenes_destino (id_imagen, id_destino, imagen_url, orden) VALUES ('33', '10', 'https://images.unsplash.com/photo-1507525428034-b723a96a487a?auto=format&fit=crop&w=800&q=80', '1');
INSERT INTO imagenes_destino (id_imagen, id_destino, imagen_url, orden) VALUES ('34', '12', 'imagenes/playa-el-tunco.webp', '1');
INSERT INTO imagenes_destino (id_imagen, id_destino, imagen_url, orden) VALUES ('35', '12', 'imagenes/playa-el-tunco.webp', '1');
INSERT INTO imagenes_destino (id_imagen, id_destino, imagen_url, orden) VALUES ('36', '13', 'https://images.unsplash.com/photo-1507525428034-b723a96a487a?auto=format&fit=crop&w=800&q=80', '1');
INSERT INTO imagenes_destino (id_imagen, id_destino, imagen_url, orden) VALUES ('37', '17', 'https://images.unsplash.com/photo-1507525428034-b723a96a487a?auto=format&fit=crop&w=800&q=80', '1');
INSERT INTO imagenes_destino (id_imagen, id_destino, imagen_url, orden) VALUES ('39', '22', 'https://images.unsplash.com/photo-1507525428034-b723a96a487a?auto=format&fit=crop&w=800&q=80', '1');
INSERT INTO imagenes_destino (id_imagen, id_destino, imagen_url, orden) VALUES ('40', '23', 'https://images.unsplash.com/photo-1506744038136-46286d3abf9d?auto=format&fit=crop&w=800&q=80', '1');
INSERT INTO imagenes_destino (id_imagen, id_destino, imagen_url, orden) VALUES ('41', '28', 'https://images.unsplash.com/photo-1501785888041-af3ef285b470?auto=format&fit=crop&w=800&q=80', '1');
INSERT INTO imagenes_destino (id_imagen, id_destino, imagen_url, orden) VALUES ('42', '30', 'imagenes/costa-del-sol.webp', '1');
INSERT INTO imagenes_destino (id_imagen, id_destino, imagen_url, orden) VALUES ('43', '31', 'https://images.unsplash.com/photo-1507525428034-b723a96a487a?auto=format&fit=crop&w=800&q=80', '1');
INSERT INTO imagenes_destino (id_imagen, id_destino, imagen_url, orden) VALUES ('44', '42', 'https://images.unsplash.com/photo-1507525428034-b723a96a487a?auto=format&fit=crop&w=800&q=80', '1');
INSERT INTO imagenes_destino (id_imagen, id_destino, imagen_url, orden) VALUES ('45', '43', 'https://images.unsplash.com/photo-1507525428034-b723a96a487a?auto=format&fit=crop&w=800&q=80', '1');
INSERT INTO imagenes_destino (id_imagen, id_destino, imagen_url, orden) VALUES ('46', '25', 'https://images.unsplash.com/photo-1470071459604-3b5ec3a7fe05?auto=format&fit=crop&w=800&q=80', '1');
INSERT INTO imagenes_destino (id_imagen, id_destino, imagen_url, orden) VALUES ('47', '26', 'https://images.unsplash.com/photo-1470071459604-3b5ec3a7fe05?auto=format&fit=crop&w=800&q=80', '1');
INSERT INTO imagenes_destino (id_imagen, id_destino, imagen_url, orden) VALUES ('48', '32', 'https://images.unsplash.com/photo-1470071459604-3b5ec3a7fe05?auto=format&fit=crop&w=800&q=80', '1');
INSERT INTO imagenes_destino (id_imagen, id_destino, imagen_url, orden) VALUES ('49', '37', 'https://images.unsplash.com/photo-1470071459604-3b5ec3a7fe05?auto=format&fit=crop&w=800&q=80', '1');
INSERT INTO imagenes_destino (id_imagen, id_destino, imagen_url, orden) VALUES ('50', '41', 'https://images.unsplash.com/photo-1470071459604-3b5ec3a7fe05?auto=format&fit=crop&w=800&q=80', '1');
INSERT INTO imagenes_destino (id_imagen, id_destino, imagen_url, orden) VALUES ('53', '45', 'https://images.unsplash.com/photo-1565299624946-b28f40a0ae38?auto=format&fit=crop&w=800&q=80', '1');
INSERT INTO imagenes_destino (id_imagen, id_destino, imagen_url, orden) VALUES ('54', '45', 'https://images.unsplash.com/photo-1512621776951-a57141f2eefd?auto=format&fit=crop&w=800&q=80', '1');
INSERT INTO imagenes_destino (id_imagen, id_destino, imagen_url, orden) VALUES ('55', '46', 'https://images.unsplash.com/photo-1464822759023-af6d269c235f?auto=format&fit=crop&w=800&q=80', '1');
INSERT INTO imagenes_destino (id_imagen, id_destino, imagen_url, orden) VALUES ('56', '46', 'https://images.unsplash.com/photo-1542332213-31f87348055f?auto=format&fit=crop&w=800&q=80', '1');
INSERT INTO imagenes_destino (id_imagen, id_destino, imagen_url, orden) VALUES ('57', '47', 'https://images.unsplash.com/photo-1441974231531-c6227db76b6e?auto=format&fit=crop&w=800&q=80', '1');
INSERT INTO imagenes_destino (id_imagen, id_destino, imagen_url, orden) VALUES ('58', '47', 'https://images.unsplash.com/photo-1470071459604-3b5ec3a7fe05?auto=format&fit=crop&w=800&q=80', '1');
INSERT INTO imagenes_destino (id_imagen, id_destino, imagen_url, orden) VALUES ('59', '48', 'https://images.unsplash.com/photo-1533900277566-777227bc3675?auto=format&fit=crop&w=800&q=80', '1');
INSERT INTO imagenes_destino (id_imagen, id_destino, imagen_url, orden) VALUES ('60', '48', 'https://images.unsplash.com/photo-1506807803067-675f7677bc56?auto=format&fit=crop&w=800&q=80', '1');
INSERT INTO imagenes_destino (id_imagen, id_destino, imagen_url, orden) VALUES ('61', '49', 'https://images.unsplash.com/photo-1518709268805-4c998f626650?auto=format&fit=crop&w=800&q=80', '1');
INSERT INTO imagenes_destino (id_imagen, id_destino, imagen_url, orden) VALUES ('62', '49', 'https://images.unsplash.com/photo-1523906834658-6e24ef2386f9?auto=format&fit=crop&w=800&q=80', '1');
INSERT INTO imagenes_destino (id_imagen, id_destino, imagen_url, orden) VALUES ('63', '50', 'https://images.unsplash.com/photo-1565299624946-b28f40a0ae38?auto=format&fit=crop&w=800&q=80', '1');
INSERT INTO imagenes_destino (id_imagen, id_destino, imagen_url, orden) VALUES ('64', '51', 'https://images.unsplash.com/photo-1517248135467-4c76095a8dee?auto=format&fit=crop&w=800&q=80', '1');
INSERT INTO imagenes_destino (id_imagen, id_destino, imagen_url, orden) VALUES ('65', '52', 'https://images.unsplash.com/photo-1495474472287-4d71bcbc738f?auto=format&fit=crop&w=800&q=80', '1');
INSERT INTO imagenes_destino (id_imagen, id_destino, imagen_url, orden) VALUES ('66', '53', 'https://images.unsplash.com/photo-1533900277566-777227bc3675?auto=format&fit=crop&w=800&q=80', '1');
INSERT INTO imagenes_destino (id_imagen, id_destino, imagen_url, orden) VALUES ('67', '54', 'https://images.unsplash.com/photo-1464822759023-af6d269c235f?auto=format&fit=crop&w=800&q=80', '1');
INSERT INTO imagenes_destino (id_imagen, id_destino, imagen_url, orden) VALUES ('69', '56', 'https://images.unsplash.com/photo-1542332213-31f87348055f?auto=format&fit=crop&w=800&q=80', '1');
INSERT INTO imagenes_destino (id_imagen, id_destino, imagen_url, orden) VALUES ('73', '67', 'imagenes/juquila-1.webp', '1');
INSERT INTO imagenes_destino (id_imagen, id_destino, imagen_url, orden) VALUES ('74', '67', 'imagenes/juquila-2.webp', '2');
INSERT INTO imagenes_destino (id_imagen, id_destino, imagen_url, orden) VALUES ('75', '67', 'imagenes/juquila-3.webp', '3');
INSERT INTO imagenes_destino (id_imagen, id_destino, imagen_url, orden) VALUES ('76', '67', 'imagenes/juquila-4.webp', '4');
INSERT INTO imagenes_destino (id_imagen, id_destino, imagen_url, orden) VALUES ('77', '67', 'imagenes/juquila-5.webp', '5');


-- Table: usuarios
CREATE TABLE `usuarios` (
  `id_usuario` int NOT NULL AUTO_INCREMENT,
  `nombre` varchar(100) NOT NULL,
  `correo` varchar(150) NOT NULL,
  `password_hash` varchar(255) NOT NULL,
  `estado` varchar(20) DEFAULT 'activo',
  PRIMARY KEY (`id_usuario`),
  UNIQUE KEY `correo` (`correo`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

INSERT INTO usuarios (id_usuario, nombre, correo, password_hash, estado) VALUES ('1', 'Dexter Morgan', 'dex@gmail.com', '$2y$10$J4O24FBtM7ewN5vt6GF0ZO3KjlwamPAgwBF8X4Imv1f4TzQxrkYPm', 'activo');
INSERT INTO usuarios (id_usuario, nombre, correo, password_hash, estado) VALUES ('2', 'María López', 'maria@example.com', '$2y$10$PeAPXLlMoko22mhJ4DclDuf6nsO6a7d.hDkwDABpX7hTBYEIgwudW', 'activo');
INSERT INTO usuarios (id_usuario, nombre, correo, password_hash, estado) VALUES ('3', 'Carlos Ruiz', 'carlos@example.com', '$2y$10$KxLJWFIqYN.4CLK9kqIoRuoSTIO4yrpDvYLBoX9iBd5u/gps0K.BW', 'activo');
INSERT INTO usuarios (id_usuario, nombre, correo, password_hash, estado) VALUES ('4', 'Ana García', 'ana@example.com', '$2y$10$SAzU14t78Pop0ktYOHOd/eDwBNnFRx7LNLoj8aqeSVKUQ8FCHn70C', 'activo');
INSERT INTO usuarios (id_usuario, nombre, correo, password_hash, estado) VALUES ('5', 'Luis Méndez', 'luis@example.com', '$2y$10$5IfgQCSOKcr3sXfClr6W9..YWQYEU0ZxSMwzYCAKk7qmLFK9qZDKO', 'activo');


-- Table: visitados
CREATE TABLE `visitados` (
  `id_visita` int NOT NULL AUTO_INCREMENT,
  `id_usuario` int NOT NULL,
  `id_destino` int NOT NULL,
  `fecha_visita` datetime DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id_visita`),
  UNIQUE KEY `usuario_destino` (`id_usuario`,`id_destino`),
  KEY `visitados_ibfk_2` (`id_destino`),
  CONSTRAINT `visitados_ibfk_1` FOREIGN KEY (`id_usuario`) REFERENCES `usuarios` (`id_usuario`) ON DELETE CASCADE,
  CONSTRAINT `visitados_ibfk_2` FOREIGN KEY (`id_destino`) REFERENCES `destinos` (`id_destino`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

INSERT INTO visitados (id_visita, id_usuario, id_destino, fecha_visita) VALUES ('1', '1', '66', '2026-10-04 18:51:46');
INSERT INTO visitados (id_visita, id_usuario, id_destino, fecha_visita) VALUES ('2', '1', '65', '2026-10-04 19:00:19');
INSERT INTO visitados (id_visita, id_usuario, id_destino, fecha_visita) VALUES ('3', '1', '43', '2026-10-04 18:53:47');
INSERT INTO visitados (id_visita, id_usuario, id_destino, fecha_visita) VALUES ('6', '1', '30', '2026-10-04 19:12:57');


-- Table: favoritos
CREATE TABLE `favoritos` (
  `id_favorito` int NOT NULL AUTO_INCREMENT,
  `id_usuario` int NOT NULL,
  `id_destino` int NOT NULL,
  `fecha_guardado` datetime DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id_favorito`),
  UNIQUE KEY `id_usuario` (`id_usuario`,`id_destino`),
  KEY `id_destino` (`id_destino`),
  CONSTRAINT `favoritos_ibfk_1` FOREIGN KEY (`id_usuario`) REFERENCES `usuarios` (`id_usuario`) ON DELETE CASCADE,
  CONSTRAINT `favoritos_ibfk_2` FOREIGN KEY (`id_destino`) REFERENCES `destinos` (`id_destino`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;



-- Table: actividades
CREATE TABLE `actividades` (
  `id_actividad` int NOT NULL AUTO_INCREMENT,
  `id_destino` int NOT NULL,
  `nombre` varchar(150) NOT NULL,
  PRIMARY KEY (`id_actividad`),
  KEY `id_destino` (`id_destino`),
  CONSTRAINT `actividades_ibfk_1` FOREIGN KEY (`id_destino`) REFERENCES `destinos` (`id_destino`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=408 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

INSERT INTO actividades (id_actividad, id_destino, nombre) VALUES ('1', '1', 'Recorrer senderos ecológicos.');
INSERT INTO actividades (id_actividad, id_destino, nombre) VALUES ('2', '1', 'Observar aves y otros animales silvestres.');
INSERT INTO actividades (id_actividad, id_destino, nombre) VALUES ('3', '1', 'Visitar cascadas y ríos.');
INSERT INTO actividades (id_actividad, id_destino, nombre) VALUES ('4', '1', 'Acampar en áreas autorizadas.');
INSERT INTO actividades (id_actividad, id_destino, nombre) VALUES ('5', '1', 'Fotografía de naturaleza.');
INSERT INTO actividades (id_actividad, id_destino, nombre) VALUES ('6', '2', 'Recorrer las calles con murales.');
INSERT INTO actividades (id_actividad, id_destino, nombre) VALUES ('7', '2', 'Comprar artesanías.');
INSERT INTO actividades (id_actividad, id_destino, nombre) VALUES ('8', '2', 'Visitar cafeterías y restaurantes.');
INSERT INTO actividades (id_actividad, id_destino, nombre) VALUES ('9', '2', 'Disfrutar del parque central.');
INSERT INTO actividades (id_actividad, id_destino, nombre) VALUES ('10', '2', 'Tomar fotografías.');
INSERT INTO actividades (id_actividad, id_destino, nombre) VALUES ('11', '3', 'Paseos en cuatrimoto.');
INSERT INTO actividades (id_actividad, id_destino, nombre) VALUES ('12', '3', 'Recorrer fincas cafetaleras.');
INSERT INTO actividades (id_actividad, id_destino, nombre) VALUES ('13', '3', 'Visitar la iglesia y el parque central.');
INSERT INTO actividades (id_actividad, id_destino, nombre) VALUES ('14', '3', 'Disfrutar de la gastronomía local.');
INSERT INTO actividades (id_actividad, id_destino, nombre) VALUES ('15', '3', 'Realizar caminatas.');
INSERT INTO actividades (id_actividad, id_destino, nombre) VALUES ('16', '4', 'Caminatas por los alrededores.');
INSERT INTO actividades (id_actividad, id_destino, nombre) VALUES ('17', '4', 'Observación del paisaje.');
INSERT INTO actividades (id_actividad, id_destino, nombre) VALUES ('18', '4', 'Fotografía de naturaleza.');
INSERT INTO actividades (id_actividad, id_destino, nombre) VALUES ('19', '4', 'Descanso en áreas verdes.');
INSERT INTO actividades (id_actividad, id_destino, nombre) VALUES ('20', '4', 'Observación de aves.');
INSERT INTO actividades (id_actividad, id_destino, nombre) VALUES ('21', '5', 'Paseos en lancha.');
INSERT INTO actividades (id_actividad, id_destino, nombre) VALUES ('22', '5', 'Practicar kayak o jet ski.');
INSERT INTO actividades (id_actividad, id_destino, nombre) VALUES ('23', '5', 'Nadar en zonas autorizadas.');
INSERT INTO actividades (id_actividad, id_destino, nombre) VALUES ('24', '5', 'Disfrutar de restaurantes con vista al lago.');
INSERT INTO actividades (id_actividad, id_destino, nombre) VALUES ('25', '5', 'Tomar fotografías del paisaje.');
INSERT INTO actividades (id_actividad, id_destino, nombre) VALUES ('26', '6', 'Senderismo guiado.');
INSERT INTO actividades (id_actividad, id_destino, nombre) VALUES ('27', '6', 'Observar el cráter.');
INSERT INTO actividades (id_actividad, id_destino, nombre) VALUES ('28', '6', 'Fotografía panorámica.');
INSERT INTO actividades (id_actividad, id_destino, nombre) VALUES ('29', '6', 'Disfrutar de la flora y fauna del parque.');
INSERT INTO actividades (id_actividad, id_destino, nombre) VALUES ('30', '7', 'Recorrer senderos.');
INSERT INTO actividades (id_actividad, id_destino, nombre) VALUES ('31', '7', 'Disfrutar de los miradores.');
INSERT INTO actividades (id_actividad, id_destino, nombre) VALUES ('32', '7', 'Observar aves.');
INSERT INTO actividades (id_actividad, id_destino, nombre) VALUES ('33', '7', 'Realizar caminatas.');
INSERT INTO actividades (id_actividad, id_destino, nombre) VALUES ('34', '7', 'Descansar en áreas verdes.');
INSERT INTO actividades (id_actividad, id_destino, nombre) VALUES ('35', '8', 'Paseos en lancha.');
INSERT INTO actividades (id_actividad, id_destino, nombre) VALUES ('36', '8', 'Practicar kayak o jet ski.');
INSERT INTO actividades (id_actividad, id_destino, nombre) VALUES ('37', '8', 'Nadar en zonas autorizadas.');
INSERT INTO actividades (id_actividad, id_destino, nombre) VALUES ('38', '8', 'Disfrutar de restaurantes con vista al lago.');
INSERT INTO actividades (id_actividad, id_destino, nombre) VALUES ('39', '8', 'Tomar fotografías del paisaje.');
INSERT INTO actividades (id_actividad, id_destino, nombre) VALUES ('40', '9', 'Visitar el mercado nocturno.');
INSERT INTO actividades (id_actividad, id_destino, nombre) VALUES ('41', '9', 'Comprar artesanías.');
INSERT INTO actividades (id_actividad, id_destino, nombre) VALUES ('42', '9', 'Conocer el Museo Conmemorativo Náhuatl Pipil.');
INSERT INTO actividades (id_actividad, id_destino, nombre) VALUES ('43', '9', 'Probar la gastronomía local.');
INSERT INTO actividades (id_actividad, id_destino, nombre) VALUES ('44', '9', 'Recorrer la iglesia San Juan Bautista.');
INSERT INTO actividades (id_actividad, id_destino, nombre) VALUES ('45', '10', 'Practicar snorkel.');
INSERT INTO actividades (id_actividad, id_destino, nombre) VALUES ('46', '10', 'Bucear en el arrecife.');
INSERT INTO actividades (id_actividad, id_destino, nombre) VALUES ('47', '10', 'Paseos en lancha.');
INSERT INTO actividades (id_actividad, id_destino, nombre) VALUES ('48', '10', 'Observación de fauna marina.');
INSERT INTO actividades (id_actividad, id_destino, nombre) VALUES ('49', '10', 'Disfrutar de la playa y los restaurantes.');
INSERT INTO actividades (id_actividad, id_destino, nombre) VALUES ('50', '11', 'Recorrer el centro histórico.');
INSERT INTO actividades (id_actividad, id_destino, nombre) VALUES ('51', '11', 'Visitar la iglesia.');
INSERT INTO actividades (id_actividad, id_destino, nombre) VALUES ('52', '11', 'Conocer la cultura local.');
INSERT INTO actividades (id_actividad, id_destino, nombre) VALUES ('53', '11', 'Disfrutar de la gastronomía típica.');
INSERT INTO actividades (id_actividad, id_destino, nombre) VALUES ('54', '11', 'Tomar fotografías.');
INSERT INTO actividades (id_actividad, id_destino, nombre) VALUES ('55', '12', 'Practicar surf.');
INSERT INTO actividades (id_actividad, id_destino, nombre) VALUES ('56', '12', 'Disfrutar del atardecer.');
INSERT INTO actividades (id_actividad, id_destino, nombre) VALUES ('57', '12', 'Visitar restaurantes y cafés frente al mar.');
INSERT INTO actividades (id_actividad, id_destino, nombre) VALUES ('58', '12', 'Caminar por la playa.');
INSERT INTO actividades (id_actividad, id_destino, nombre) VALUES ('59', '13', 'Recorrer el malecón.');
INSERT INTO actividades (id_actividad, id_destino, nombre) VALUES ('60', '13', 'Visitar el Mercado del Mar.');
INSERT INTO actividades (id_actividad, id_destino, nombre) VALUES ('61', '13', 'Degustar mariscos frescos.');
INSERT INTO actividades (id_actividad, id_destino, nombre) VALUES ('62', '13', 'Tomar fotografías del muelle y el océano.');
INSERT INTO actividades (id_actividad, id_destino, nombre) VALUES ('63', '14', 'Realizar caminatas por senderos.');
INSERT INTO actividades (id_actividad, id_destino, nombre) VALUES ('64', '14', 'Observar aves y fauna silvestre.');
INSERT INTO actividades (id_actividad, id_destino, nombre) VALUES ('65', '14', 'Disfrutar de miradores.');
INSERT INTO actividades (id_actividad, id_destino, nombre) VALUES ('66', '14', 'Tomar fotografías de la naturaleza.');
INSERT INTO actividades (id_actividad, id_destino, nombre) VALUES ('67', '15', 'Recorrer los senderos.');
INSERT INTO actividades (id_actividad, id_destino, nombre) VALUES ('68', '15', 'Observar el cráter.');
INSERT INTO actividades (id_actividad, id_destino, nombre) VALUES ('69', '15', 'Tomar fotografías.');
INSERT INTO actividades (id_actividad, id_destino, nombre) VALUES ('70', '15', 'Disfrutar de la naturaleza.');
INSERT INTO actividades (id_actividad, id_destino, nombre) VALUES ('71', '16', 'Visitar los pueblos.');
INSERT INTO actividades (id_actividad, id_destino, nombre) VALUES ('72', '16', 'Degustar gastronomía típica.');
INSERT INTO actividades (id_actividad, id_destino, nombre) VALUES ('73', '16', 'Comprar artesanías.');
INSERT INTO actividades (id_actividad, id_destino, nombre) VALUES ('74', '16', 'Tomar fotografías del paisaje.');
INSERT INTO actividades (id_actividad, id_destino, nombre) VALUES ('75', '17', 'Paseos en lancha.');
INSERT INTO actividades (id_actividad, id_destino, nombre) VALUES ('76', '17', 'Observación de aves.');
INSERT INTO actividades (id_actividad, id_destino, nombre) VALUES ('77', '17', 'Visitar los manglares.');
INSERT INTO actividades (id_actividad, id_destino, nombre) VALUES ('78', '17', 'Disfrutar de la gastronomía local.');
INSERT INTO actividades (id_actividad, id_destino, nombre) VALUES ('79', '18', 'Realizar caminatas.');
INSERT INTO actividades (id_actividad, id_destino, nombre) VALUES ('80', '18', 'Acampar.');
INSERT INTO actividades (id_actividad, id_destino, nombre) VALUES ('81', '18', 'Disfrutar del paisaje.');
INSERT INTO actividades (id_actividad, id_destino, nombre) VALUES ('82', '18', 'Tomar fotografías.');
INSERT INTO actividades (id_actividad, id_destino, nombre) VALUES ('83', '19', 'Comprar artesanías.');
INSERT INTO actividades (id_actividad, id_destino, nombre) VALUES ('84', '19', 'Recorrer el centro del pueblo.');
INSERT INTO actividades (id_actividad, id_destino, nombre) VALUES ('85', '19', 'Visitar talleres artesanales.');
INSERT INTO actividades (id_actividad, id_destino, nombre) VALUES ('86', '19', 'Degustar comida típica.');
INSERT INTO actividades (id_actividad, id_destino, nombre) VALUES ('87', '20', 'Senderismo.');
INSERT INTO actividades (id_actividad, id_destino, nombre) VALUES ('88', '20', 'Observar la naturaleza.');
INSERT INTO actividades (id_actividad, id_destino, nombre) VALUES ('89', '20', 'Tomar fotografías.');
INSERT INTO actividades (id_actividad, id_destino, nombre) VALUES ('90', '20', 'Disfrutar del clima fresco.');
INSERT INTO actividades (id_actividad, id_destino, nombre) VALUES ('95', '22', 'Nadar en zonas seguras.');
INSERT INTO actividades (id_actividad, id_destino, nombre) VALUES ('96', '22', 'Disfrutar del atardecer.');
INSERT INTO actividades (id_actividad, id_destino, nombre) VALUES ('97', '22', 'Degustar mariscos.');
INSERT INTO actividades (id_actividad, id_destino, nombre) VALUES ('98', '22', 'Caminar por la playa.');
INSERT INTO actividades (id_actividad, id_destino, nombre) VALUES ('99', '23', 'Paseos en lancha.');
INSERT INTO actividades (id_actividad, id_destino, nombre) VALUES ('100', '23', 'Observar aves.');
INSERT INTO actividades (id_actividad, id_destino, nombre) VALUES ('101', '23', 'Conocer la naturaleza.');
INSERT INTO actividades (id_actividad, id_destino, nombre) VALUES ('102', '23', 'Tomar fotografías.');
INSERT INTO actividades (id_actividad, id_destino, nombre) VALUES ('103', '24', 'Senderismo con guía.');
INSERT INTO actividades (id_actividad, id_destino, nombre) VALUES ('104', '24', 'Observar paisajes.');
INSERT INTO actividades (id_actividad, id_destino, nombre) VALUES ('105', '24', 'Tomar fotografías.');
INSERT INTO actividades (id_actividad, id_destino, nombre) VALUES ('106', '24', 'Disfrutar de la naturaleza.');
INSERT INTO actividades (id_actividad, id_destino, nombre) VALUES ('107', '25', 'Nadar.');
INSERT INTO actividades (id_actividad, id_destino, nombre) VALUES ('108', '25', 'Disfrutar de áreas verdes.');
INSERT INTO actividades (id_actividad, id_destino, nombre) VALUES ('109', '25', 'Compartir en familia.');
INSERT INTO actividades (id_actividad, id_destino, nombre) VALUES ('110', '25', 'Tomar fotografías.');
INSERT INTO actividades (id_actividad, id_destino, nombre) VALUES ('111', '26', 'Conocer su arquitectura.');
INSERT INTO actividades (id_actividad, id_destino, nombre) VALUES ('112', '26', 'Recorrer el centro histórico.');
INSERT INTO actividades (id_actividad, id_destino, nombre) VALUES ('113', '26', 'Tomar fotografías.');
INSERT INTO actividades (id_actividad, id_destino, nombre) VALUES ('114', '26', 'Visitar lugares cercanos.');
INSERT INTO actividades (id_actividad, id_destino, nombre) VALUES ('115', '27', 'Recorrer el centro histórico y la iglesia.');
INSERT INTO actividades (id_actividad, id_destino, nombre) VALUES ('116', '27', 'Comprar artesanías.');
INSERT INTO actividades (id_actividad, id_destino, nombre) VALUES ('117', '27', 'Visitar galerías de arte y talleres.');
INSERT INTO actividades (id_actividad, id_destino, nombre) VALUES ('118', '27', 'Degustar comida típica y café.');
INSERT INTO actividades (id_actividad, id_destino, nombre) VALUES ('119', '28', 'Dar paseos en lancha hacia las islas.');
INSERT INTO actividades (id_actividad, id_destino, nombre) VALUES ('120', '28', 'Observar aves y paisajes.');
INSERT INTO actividades (id_actividad, id_destino, nombre) VALUES ('121', '28', 'Disfrutar de la gastronomía en el puerto.');
INSERT INTO actividades (id_actividad, id_destino, nombre) VALUES ('122', '28', 'Tomar fotografías.');
INSERT INTO actividades (id_actividad, id_destino, nombre) VALUES ('123', '29', 'Caminata y senderismo.');
INSERT INTO actividades (id_actividad, id_destino, nombre) VALUES ('124', '29', 'Observar la formación rocosa única.');
INSERT INTO actividades (id_actividad, id_destino, nombre) VALUES ('125', '29', 'Tomar fotografías.');
INSERT INTO actividades (id_actividad, id_destino, nombre) VALUES ('126', '29', 'Disfrutar de la naturaleza.');
INSERT INTO actividades (id_actividad, id_destino, nombre) VALUES ('127', '30', 'Nadar en el océano o disfrutar de las piscinas.');
INSERT INTO actividades (id_actividad, id_destino, nombre) VALUES ('128', '30', 'Practicar deportes de playa (voleibol, fútbol).');
INSERT INTO actividades (id_actividad, id_destino, nombre) VALUES ('129', '30', 'Degustar mariscos frescos.');
INSERT INTO actividades (id_actividad, id_destino, nombre) VALUES ('130', '30', 'Ver atardeceres y descansar.');
INSERT INTO actividades (id_actividad, id_destino, nombre) VALUES ('131', '31', 'Recorridos en lancha por los canales.');
INSERT INTO actividades (id_actividad, id_destino, nombre) VALUES ('132', '31', 'Avistamiento de aves y naturaleza.');
INSERT INTO actividades (id_actividad, id_destino, nombre) VALUES ('133', '31', 'Visitar la desemboque a la playa La Puntilla.');
INSERT INTO actividades (id_actividad, id_destino, nombre) VALUES ('134', '31', 'Tomar fotografías del paisaje.');
INSERT INTO actividades (id_actividad, id_destino, nombre) VALUES ('135', '32', 'Disfrutar de las vistas al Lago de Ilopango.');
INSERT INTO actividades (id_actividad, id_destino, nombre) VALUES ('136', '32', 'Visitar cafés y restaurantes de montaña.');
INSERT INTO actividades (id_actividad, id_destino, nombre) VALUES ('137', '32', 'Recorrer el pueblo y sus iglesias históricas.');
INSERT INTO actividades (id_actividad, id_destino, nombre) VALUES ('138', '32', 'Tomar fotografías del paisaje.');
INSERT INTO actividades (id_actividad, id_destino, nombre) VALUES ('139', '33', 'Visitar los talleres y tiendas artesanales.');
INSERT INTO actividades (id_actividad, id_destino, nombre) VALUES ('140', '33', 'Modelar piezas de barro en talleres locales.');
INSERT INTO actividades (id_actividad, id_destino, nombre) VALUES ('141', '33', 'Recorrer el centro histórico.');
INSERT INTO actividades (id_actividad, id_destino, nombre) VALUES ('142', '33', 'Degustar gastronomía típica');
INSERT INTO actividades (id_actividad, id_destino, nombre) VALUES ('143', '34', 'Conocer la Iglesia Parroquial y el parque central.');
INSERT INTO actividades (id_actividad, id_destino, nombre) VALUES ('144', '34', 'Probar los famosos dulces de Sensuntepeque.');
INSERT INTO actividades (id_actividad, id_destino, nombre) VALUES ('145', '34', 'Disfrutar del ambiente tranquilo.');
INSERT INTO actividades (id_actividad, id_destino, nombre) VALUES ('146', '34', 'Tomar fotografías del pueblo');
INSERT INTO actividades (id_actividad, id_destino, nombre) VALUES ('147', '35', 'Caminatas y senderismo guiado.');
INSERT INTO actividades (id_actividad, id_destino, nombre) VALUES ('148', '35', 'Disfrutar del clima fresco y la vegetación.');
INSERT INTO actividades (id_actividad, id_destino, nombre) VALUES ('149', '35', 'Avistamiento de flora y fauna.');
INSERT INTO actividades (id_actividad, id_destino, nombre) VALUES ('150', '35', 'Tomar fotografías.');
INSERT INTO actividades (id_actividad, id_destino, nombre) VALUES ('151', '36', 'Senderismo con guía.');
INSERT INTO actividades (id_actividad, id_destino, nombre) VALUES ('152', '36', 'Observar el paisaje.');
INSERT INTO actividades (id_actividad, id_destino, nombre) VALUES ('153', '36', 'Tomar fotografías.');
INSERT INTO actividades (id_actividad, id_destino, nombre) VALUES ('154', '36', 'Conocer sus alrededores.');
INSERT INTO actividades (id_actividad, id_destino, nombre) VALUES ('155', '37', 'Caminar.');
INSERT INTO actividades (id_actividad, id_destino, nombre) VALUES ('156', '37', 'Compartir en familia.');
INSERT INTO actividades (id_actividad, id_destino, nombre) VALUES ('157', '37', 'Disfrutar de la naturaleza.');
INSERT INTO actividades (id_actividad, id_destino, nombre) VALUES ('158', '37', 'Tomar fotografías.');
INSERT INTO actividades (id_actividad, id_destino, nombre) VALUES ('159', '38', 'Conocer su arquitectura.');
INSERT INTO actividades (id_actividad, id_destino, nombre) VALUES ('160', '38', 'Recorrer el centro histórico.');
INSERT INTO actividades (id_actividad, id_destino, nombre) VALUES ('161', '38', 'Visitar el parque central.');
INSERT INTO actividades (id_actividad, id_destino, nombre) VALUES ('162', '38', 'Tomar fotografías.');
INSERT INTO actividades (id_actividad, id_destino, nombre) VALUES ('163', '39', 'Conocer la historia local.');
INSERT INTO actividades (id_actividad, id_destino, nombre) VALUES ('164', '39', 'Observar fotografías y objetos.');
INSERT INTO actividades (id_actividad, id_destino, nombre) VALUES ('165', '39', 'Recorrer el museo.');
INSERT INTO actividades (id_actividad, id_destino, nombre) VALUES ('166', '39', 'Aprender sobre Morazán.');
INSERT INTO actividades (id_actividad, id_destino, nombre) VALUES ('167', '40', 'Realizar caminatas.');
INSERT INTO actividades (id_actividad, id_destino, nombre) VALUES ('168', '40', 'Observar paisajes.');
INSERT INTO actividades (id_actividad, id_destino, nombre) VALUES ('169', '40', 'Observar aves.');
INSERT INTO actividades (id_actividad, id_destino, nombre) VALUES ('170', '40', 'Tomar fotografías.');
INSERT INTO actividades (id_actividad, id_destino, nombre) VALUES ('171', '41', 'Caminar por senderos.');
INSERT INTO actividades (id_actividad, id_destino, nombre) VALUES ('172', '41', 'Observar la cascada.');
INSERT INTO actividades (id_actividad, id_destino, nombre) VALUES ('173', '41', 'Fotografiar el paisaje.');
INSERT INTO actividades (id_actividad, id_destino, nombre) VALUES ('174', '41', 'Disfrutar de la naturaleza.');
INSERT INTO actividades (id_actividad, id_destino, nombre) VALUES ('175', '42', 'Paseos en lancha.');
INSERT INTO actividades (id_actividad, id_destino, nombre) VALUES ('176', '42', 'Observar aves y fauna marina.');
INSERT INTO actividades (id_actividad, id_destino, nombre) VALUES ('177', '42', 'Conocer las islas.');
INSERT INTO actividades (id_actividad, id_destino, nombre) VALUES ('178', '42', 'Tomar fotografías.');
INSERT INTO actividades (id_actividad, id_destino, nombre) VALUES ('179', '43', 'Recorrer la isla con guía.');
INSERT INTO actividades (id_actividad, id_destino, nombre) VALUES ('180', '43', 'Observar paisajes.');
INSERT INTO actividades (id_actividad, id_destino, nombre) VALUES ('181', '43', 'Disfrutar de la naturaleza.');
INSERT INTO actividades (id_actividad, id_destino, nombre) VALUES ('182', '43', 'Tomar fotografías.');
INSERT INTO actividades (id_actividad, id_destino, nombre) VALUES ('183', '44', 'Visitar la iglesia.');
INSERT INTO actividades (id_actividad, id_destino, nombre) VALUES ('184', '44', 'Disfrutar de miradores.');
INSERT INTO actividades (id_actividad, id_destino, nombre) VALUES ('185', '44', 'Recorrer el municipio.');
INSERT INTO actividades (id_actividad, id_destino, nombre) VALUES ('186', '44', 'Fotografiar el Golfo de Fonseca.');
INSERT INTO actividades (id_actividad, id_destino, nombre) VALUES ('187', '45', 'Probar las mejores pupusas');
INSERT INTO actividades (id_actividad, id_destino, nombre) VALUES ('188', '45', 'Visitar el mercado local');
INSERT INTO actividades (id_actividad, id_destino, nombre) VALUES ('189', '45', 'Caminar por el centro del pueblo');
INSERT INTO actividades (id_actividad, id_destino, nombre) VALUES ('190', '46', 'Ascenso al cráter');
INSERT INTO actividades (id_actividad, id_destino, nombre) VALUES ('191', '46', 'Fotografía de paisaje');
INSERT INTO actividades (id_actividad, id_destino, nombre) VALUES ('192', '46', 'Senderismo');
INSERT INTO actividades (id_actividad, id_destino, nombre) VALUES ('193', '47', 'Observación de aves');
INSERT INTO actividades (id_actividad, id_destino, nombre) VALUES ('194', '47', 'Senderismo en bosque nuboso');
INSERT INTO actividades (id_actividad, id_destino, nombre) VALUES ('195', '47', 'Fotografía de naturaleza');
INSERT INTO actividades (id_actividad, id_destino, nombre) VALUES ('196', '48', 'Degustar comida típica');
INSERT INTO actividades (id_actividad, id_destino, nombre) VALUES ('197', '48', 'Compras de artesanías');
INSERT INTO actividades (id_actividad, id_destino, nombre) VALUES ('198', '48', 'Vivir la cultura urbana');
INSERT INTO actividades (id_actividad, id_destino, nombre) VALUES ('199', '49', 'Visitar la Catedral Metropolitana');
INSERT INTO actividades (id_actividad, id_destino, nombre) VALUES ('200', '49', 'Comer en plazas modernas');
INSERT INTO actividades (id_actividad, id_destino, nombre) VALUES ('201', '49', 'Recorrer el Palacio Nacional');
INSERT INTO actividades (id_actividad, id_destino, nombre) VALUES ('202', '50', 'Degustar pupusas');
INSERT INTO actividades (id_actividad, id_destino, nombre) VALUES ('203', '50', 'Conocer la cultura local');
INSERT INTO actividades (id_actividad, id_destino, nombre) VALUES ('204', '51', 'Cena romántica');
INSERT INTO actividades (id_actividad, id_destino, nombre) VALUES ('205', '51', 'Probar platos típicos');
INSERT INTO actividades (id_actividad, id_destino, nombre) VALUES ('206', '52', 'Degustación de café');
INSERT INTO actividades (id_actividad, id_destino, nombre) VALUES ('207', '52', 'Disfrutar la vista');
INSERT INTO actividades (id_actividad, id_destino, nombre) VALUES ('208', '53', 'Tour gastronómico');
INSERT INTO actividades (id_actividad, id_destino, nombre) VALUES ('209', '53', 'Compras rápidas');
INSERT INTO actividades (id_actividad, id_destino, nombre) VALUES ('210', '54', 'Senderismo');
INSERT INTO actividades (id_actividad, id_destino, nombre) VALUES ('211', '54', 'Observación de volcanes');
INSERT INTO actividades (id_actividad, id_destino, nombre) VALUES ('214', '56', 'Trekking');
INSERT INTO actividades (id_actividad, id_destino, nombre) VALUES ('215', '56', 'Avistamiento de la ciudad');
INSERT INTO actividades (id_actividad, id_destino, nombre) VALUES ('222', '1', 'Senderismo extremo');
INSERT INTO actividades (id_actividad, id_destino, nombre) VALUES ('223', '1', 'Observación de aves');
INSERT INTO actividades (id_actividad, id_destino, nombre) VALUES ('224', '1', 'Fotografía de naturaleza');
INSERT INTO actividades (id_actividad, id_destino, nombre) VALUES ('225', '2', 'Tour de murales');
INSERT INTO actividades (id_actividad, id_destino, nombre) VALUES ('226', '2', 'Degustación de café');
INSERT INTO actividades (id_actividad, id_destino, nombre) VALUES ('227', '2', 'Caminatas por el pueblo');
INSERT INTO actividades (id_actividad, id_destino, nombre) VALUES ('228', '3', 'Canopy');
INSERT INTO actividades (id_actividad, id_destino, nombre) VALUES ('229', '3', 'Ruta de los cafetales');
INSERT INTO actividades (id_actividad, id_destino, nombre) VALUES ('230', '3', 'Visita al mirador');
INSERT INTO actividades (id_actividad, id_destino, nombre) VALUES ('231', '4', 'Caminatas ligeras');
INSERT INTO actividades (id_actividad, id_destino, nombre) VALUES ('232', '4', 'Meditación');
INSERT INTO actividades (id_actividad, id_destino, nombre) VALUES ('233', '4', 'Picnic');
INSERT INTO actividades (id_actividad, id_destino, nombre) VALUES ('234', '5', 'Paseos en lancha');
INSERT INTO actividades (id_actividad, id_destino, nombre) VALUES ('235', '5', 'Kayak');
INSERT INTO actividades (id_actividad, id_destino, nombre) VALUES ('236', '5', 'Almuerzos frente al lago');
INSERT INTO actividades (id_actividad, id_destino, nombre) VALUES ('237', '6', 'Ascenso al cráter');
INSERT INTO actividades (id_actividad, id_destino, nombre) VALUES ('238', '6', 'Senderismo');
INSERT INTO actividades (id_actividad, id_destino, nombre) VALUES ('239', '6', 'Fotografía de paisaje');
INSERT INTO actividades (id_actividad, id_destino, nombre) VALUES ('240', '7', 'Observación de volcanes');
INSERT INTO actividades (id_actividad, id_destino, nombre) VALUES ('241', '7', 'Senderismo guiado');
INSERT INTO actividades (id_actividad, id_destino, nombre) VALUES ('242', '7', 'Picnic en el mirador');
INSERT INTO actividades (id_actividad, id_destino, nombre) VALUES ('243', '8', 'Festival Gastronómico');
INSERT INTO actividades (id_actividad, id_destino, nombre) VALUES ('244', '8', 'Visita a cascadas');
INSERT INTO actividades (id_actividad, id_destino, nombre) VALUES ('245', '8', 'Compras de artesanías');
INSERT INTO actividades (id_actividad, id_destino, nombre) VALUES ('246', '9', 'Compras de artesanías');
INSERT INTO actividades (id_actividad, id_destino, nombre) VALUES ('247', '9', 'Recorrido histórico');
INSERT INTO actividades (id_actividad, id_destino, nombre) VALUES ('248', '9', 'Degustación de dulces típicos');
INSERT INTO actividades (id_actividad, id_destino, nombre) VALUES ('249', '10', 'Snorkeling');
INSERT INTO actividades (id_actividad, id_destino, nombre) VALUES ('250', '10', 'Relajación en la playa');
INSERT INTO actividades (id_actividad, id_destino, nombre) VALUES ('251', '10', 'Caminatas costeras');
INSERT INTO actividades (id_actividad, id_destino, nombre) VALUES ('252', '11', 'Visita al volcán');
INSERT INTO actividades (id_actividad, id_destino, nombre) VALUES ('253', '11', 'Tour agrícola');
INSERT INTO actividades (id_actividad, id_destino, nombre) VALUES ('254', '11', 'Senderismo');
INSERT INTO actividades (id_actividad, id_destino, nombre) VALUES ('255', '12', 'Clases de surf');
INSERT INTO actividades (id_actividad, id_destino, nombre) VALUES ('256', '12', 'Fiestas nocturnas');
INSERT INTO actividades (id_actividad, id_destino, nombre) VALUES ('257', '12', 'Observación de atardeceres');
INSERT INTO actividades (id_actividad, id_destino, nombre) VALUES ('258', '13', 'Mercado del pescado');
INSERT INTO actividades (id_actividad, id_destino, nombre) VALUES ('259', '13', 'Paseos en lancha');
INSERT INTO actividades (id_actividad, id_destino, nombre) VALUES ('260', '13', 'Comida marina');
INSERT INTO actividades (id_actividad, id_destino, nombre) VALUES ('261', '14', 'Avistamiento de aves');
INSERT INTO actividades (id_actividad, id_destino, nombre) VALUES ('262', '14', 'Senderismo');
INSERT INTO actividades (id_actividad, id_destino, nombre) VALUES ('263', '14', 'Estudio de flora');
INSERT INTO actividades (id_actividad, id_destino, nombre) VALUES ('264', '15', 'Senderismo');
INSERT INTO actividades (id_actividad, id_destino, nombre) VALUES ('265', '15', 'Fotografía');
INSERT INTO actividades (id_actividad, id_destino, nombre) VALUES ('266', '15', 'Picnic');
INSERT INTO actividades (id_actividad, id_destino, nombre) VALUES ('267', '16', 'Tour por pueblos');
INSERT INTO actividades (id_actividad, id_destino, nombre) VALUES ('268', '16', 'Visita a cafetales');
INSERT INTO actividades (id_actividad, id_destino, nombre) VALUES ('269', '16', 'Gastronomía local');
INSERT INTO actividades (id_actividad, id_destino, nombre) VALUES ('270', '17', 'Paseos en lancha');
INSERT INTO actividades (id_actividad, id_destino, nombre) VALUES ('271', '17', 'Observación de manglares');
INSERT INTO actividades (id_actividad, id_destino, nombre) VALUES ('272', '17', 'Pesca deportiva');
INSERT INTO actividades (id_actividad, id_destino, nombre) VALUES ('273', '18', 'Camping');
INSERT INTO actividades (id_actividad, id_destino, nombre) VALUES ('274', '18', 'Senderismo');
INSERT INTO actividades (id_actividad, id_destino, nombre) VALUES ('275', '18', 'Observación de estrellas');
INSERT INTO actividades (id_actividad, id_destino, nombre) VALUES ('276', '19', 'Tour de arte');
INSERT INTO actividades (id_actividad, id_destino, nombre) VALUES ('277', '19', 'Caminatas naturales');
INSERT INTO actividades (id_actividad, id_destino, nombre) VALUES ('278', '19', 'Visita a talleres');
INSERT INTO actividades (id_actividad, id_destino, nombre) VALUES ('279', '20', 'Observación de paisajes');
INSERT INTO actividades (id_actividad, id_destino, nombre) VALUES ('280', '20', 'Fotografía');
INSERT INTO actividades (id_actividad, id_destino, nombre) VALUES ('281', '20', 'Descanso');
INSERT INTO actividades (id_actividad, id_destino, nombre) VALUES ('282', '22', 'Surf');
INSERT INTO actividades (id_actividad, id_destino, nombre) VALUES ('283', '22', 'Camping');
INSERT INTO actividades (id_actividad, id_destino, nombre) VALUES ('284', '22', 'Relajación');
INSERT INTO actividades (id_actividad, id_destino, nombre) VALUES ('285', '23', 'Picnic');
INSERT INTO actividades (id_actividad, id_destino, nombre) VALUES ('286', '23', 'Caminatas');
INSERT INTO actividades (id_actividad, id_destino, nombre) VALUES ('287', '23', 'Fotografía');
INSERT INTO actividades (id_actividad, id_destino, nombre) VALUES ('288', '24', 'Senderismo');
INSERT INTO actividades (id_actividad, id_destino, nombre) VALUES ('289', '24', 'Ascenso');
INSERT INTO actividades (id_actividad, id_destino, nombre) VALUES ('290', '24', 'Fotografía');
INSERT INTO actividades (id_actividad, id_destino, nombre) VALUES ('291', '25', 'Natación');
INSERT INTO actividades (id_actividad, id_destino, nombre) VALUES ('292', '25', 'Picnic');
INSERT INTO actividades (id_actividad, id_destino, nombre) VALUES ('293', '25', 'Reuniones familiares');
INSERT INTO actividades (id_actividad, id_destino, nombre) VALUES ('294', '26', 'Visita religiosa');
INSERT INTO actividades (id_actividad, id_destino, nombre) VALUES ('295', '26', 'Fotografía');
INSERT INTO actividades (id_actividad, id_destino, nombre) VALUES ('296', '26', 'Historia');
INSERT INTO actividades (id_actividad, id_destino, nombre) VALUES ('297', '27', 'Paseo en lancha');
INSERT INTO actividades (id_actividad, id_destino, nombre) VALUES ('298', '27', 'Tour colonial');
INSERT INTO actividades (id_actividad, id_destino, nombre) VALUES ('299', '27', 'Artesanías');
INSERT INTO actividades (id_actividad, id_destino, nombre) VALUES ('300', '28', 'Avistamiento de aves');
INSERT INTO actividades (id_actividad, id_destino, nombre) VALUES ('301', '28', 'Pesca');
INSERT INTO actividades (id_actividad, id_destino, nombre) VALUES ('302', '28', 'Paseos en lancha');
INSERT INTO actividades (id_actividad, id_destino, nombre) VALUES ('303', '29', 'Fotografía');
INSERT INTO actividades (id_actividad, id_destino, nombre) VALUES ('304', '29', 'Caminatas');
INSERT INTO actividades (id_actividad, id_destino, nombre) VALUES ('305', '29', 'Baños naturales');
INSERT INTO actividades (id_actividad, id_destino, nombre) VALUES ('306', '30', 'Resorts');
INSERT INTO actividades (id_actividad, id_destino, nombre) VALUES ('307', '30', 'Jet Ski');
INSERT INTO actividades (id_actividad, id_destino, nombre) VALUES ('308', '30', 'Relajación');
INSERT INTO actividades (id_actividad, id_destino, nombre) VALUES ('309', '31', 'Paseos en lancha');
INSERT INTO actividades (id_actividad, id_destino, nombre) VALUES ('310', '31', 'Pesca');
INSERT INTO actividades (id_actividad, id_destino, nombre) VALUES ('311', '31', 'Observación de aves');
INSERT INTO actividades (id_actividad, id_destino, nombre) VALUES ('312', '32', 'Observación de vistas');
INSERT INTO actividades (id_actividad, id_destino, nombre) VALUES ('313', '32', 'Fotografía');
INSERT INTO actividades (id_actividad, id_destino, nombre) VALUES ('314', '32', 'Descanso');
INSERT INTO actividades (id_actividad, id_destino, nombre) VALUES ('315', '33', 'Taller de barro');
INSERT INTO actividades (id_actividad, id_destino, nombre) VALUES ('316', '33', 'Compras');
INSERT INTO actividades (id_actividad, id_destino, nombre) VALUES ('317', '33', 'Tour cultural');
INSERT INTO actividades (id_actividad, id_destino, nombre) VALUES ('318', '34', 'Tour histórico');
INSERT INTO actividades (id_actividad, id_destino, nombre) VALUES ('319', '34', 'Compras');
INSERT INTO actividades (id_actividad, id_destino, nombre) VALUES ('320', '34', 'Visita a iglesias');
INSERT INTO actividades (id_actividad, id_destino, nombre) VALUES ('321', '35', 'Educación ambiental');
INSERT INTO actividades (id_actividad, id_destino, nombre) VALUES ('322', '35', 'Senderismo');
INSERT INTO actividades (id_actividad, id_destino, nombre) VALUES ('323', '35', ' Picnic');
INSERT INTO actividades (id_actividad, id_destino, nombre) VALUES ('324', '36', 'Ascenso');
INSERT INTO actividades (id_actividad, id_destino, nombre) VALUES ('325', '36', 'Observación volcánica');
INSERT INTO actividades (id_actividad, id_destino, nombre) VALUES ('326', '36', 'Fotografía');
INSERT INTO actividades (id_actividad, id_destino, nombre) VALUES ('327', '37', 'Juegos');
INSERT INTO actividades (id_actividad, id_destino, nombre) VALUES ('328', '37', 'Picnic');
INSERT INTO actividades (id_actividad, id_destino, nombre) VALUES ('329', '37', 'Caminatas');
INSERT INTO actividades (id_actividad, id_destino, nombre) VALUES ('330', '38', 'Visita religiosa');
INSERT INTO actividades (id_actividad, id_destino, nombre) VALUES ('331', '38', 'Arquitectura');
INSERT INTO actividades (id_actividad, id_destino, nombre) VALUES ('332', '38', 'Fotografía');
INSERT INTO actividades (id_actividad, id_destino, nombre) VALUES ('333', '39', 'Tour histórico');
INSERT INTO actividades (id_actividad, id_destino, nombre) VALUES ('334', '39', 'Exposiciones');
INSERT INTO actividades (id_actividad, id_destino, nombre) VALUES ('335', '39', 'Aprendizaje');
INSERT INTO actividades (id_actividad, id_destino, nombre) VALUES ('336', '40', 'Senderismo');
INSERT INTO actividades (id_actividad, id_destino, nombre) VALUES ('337', '40', 'Exploración');
INSERT INTO actividades (id_actividad, id_destino, nombre) VALUES ('338', '40', 'Fotografía');
INSERT INTO actividades (id_actividad, id_destino, nombre) VALUES ('339', '41', 'Baños naturales');
INSERT INTO actividades (id_actividad, id_destino, nombre) VALUES ('340', '41', 'Fotografía');
INSERT INTO actividades (id_actividad, id_destino, nombre) VALUES ('341', '41', 'Senderismo');
INSERT INTO actividades (id_actividad, id_destino, nombre) VALUES ('342', '42', 'Navegación');
INSERT INTO actividades (id_actividad, id_destino, nombre) VALUES ('343', '42', 'Pesca');
INSERT INTO actividades (id_actividad, id_destino, nombre) VALUES ('344', '42', 'Visita a islas');
INSERT INTO actividades (id_actividad, id_destino, nombre) VALUES ('345', '43', 'Playa');
INSERT INTO actividades (id_actividad, id_destino, nombre) VALUES ('346', '43', 'Snorkeling');
INSERT INTO actividades (id_actividad, id_destino, nombre) VALUES ('347', '43', 'Descanso');
INSERT INTO actividades (id_actividad, id_destino, nombre) VALUES ('348', '44', 'Observación de vistas');
INSERT INTO actividades (id_actividad, id_destino, nombre) VALUES ('349', '44', 'Trekking');
INSERT INTO actividades (id_actividad, id_destino, nombre) VALUES ('350', '44', 'Cultura local');
INSERT INTO actividades (id_actividad, id_destino, nombre) VALUES ('351', '45', 'Gastronomía');
INSERT INTO actividades (id_actividad, id_destino, nombre) VALUES ('352', '45', 'Artesanías');
INSERT INTO actividades (id_actividad, id_destino, nombre) VALUES ('353', '45', 'Paseos');
INSERT INTO actividades (id_actividad, id_destino, nombre) VALUES ('354', '46', 'Ascenso');
INSERT INTO actividades (id_actividad, id_destino, nombre) VALUES ('355', '46', 'Fotografía');
INSERT INTO actividades (id_actividad, id_destino, nombre) VALUES ('356', '46', 'Senderismo');
INSERT INTO actividades (id_actividad, id_destino, nombre) VALUES ('357', '47', 'Observación de orquídeas');
INSERT INTO actividades (id_actividad, id_destino, nombre) VALUES ('358', '47', 'Senderismo');
INSERT INTO actividades (id_actividad, id_destino, nombre) VALUES ('359', '47', 'Fotografía');
INSERT INTO actividades (id_actividad, id_destino, nombre) VALUES ('360', '48', 'Compras');
INSERT INTO actividades (id_actividad, id_destino, nombre) VALUES ('361', '48', 'Gastronomía');
INSERT INTO actividades (id_actividad, id_destino, nombre) VALUES ('362', '48', 'Cultura urbana');
INSERT INTO actividades (id_actividad, id_destino, nombre) VALUES ('363', '49', 'Tour arquitectónico');
INSERT INTO actividades (id_actividad, id_destino, nombre) VALUES ('364', '49', 'Visita a museos');
INSERT INTO actividades (id_actividad, id_destino, nombre) VALUES ('365', '49', 'Paseos');
INSERT INTO actividades (id_actividad, id_destino, nombre) VALUES ('366', '50', 'Degustación');
INSERT INTO actividades (id_actividad, id_destino, nombre) VALUES ('367', '50', 'Cena');
INSERT INTO actividades (id_actividad, id_destino, nombre) VALUES ('368', '50', 'Cultura culinaria');
INSERT INTO actividades (id_actividad, id_destino, nombre) VALUES ('369', '51', 'Cena romántica');
INSERT INTO actividades (id_actividad, id_destino, nombre) VALUES ('370', '51', 'Gastronomía');
INSERT INTO actividades (id_actividad, id_destino, nombre) VALUES ('371', '51', 'Descanso');
INSERT INTO actividades (id_actividad, id_destino, nombre) VALUES ('372', '52', 'Café especial');
INSERT INTO actividades (id_actividad, id_destino, nombre) VALUES ('373', '52', 'Lectura');
INSERT INTO actividades (id_actividad, id_destino, nombre) VALUES ('374', '52', 'Vistas');
INSERT INTO actividades (id_actividad, id_destino, nombre) VALUES ('375', '53', 'Degustación');
INSERT INTO actividades (id_actividad, id_destino, nombre) VALUES ('376', '53', 'Compras');
INSERT INTO actividades (id_actividad, id_destino, nombre) VALUES ('377', '53', 'Cultura');
INSERT INTO actividades (id_actividad, id_destino, nombre) VALUES ('378', '54', 'Observación volcánica');
INSERT INTO actividades (id_actividad, id_destino, nombre) VALUES ('379', '54', 'Senderismo');
INSERT INTO actividades (id_actividad, id_destino, nombre) VALUES ('380', '54', 'Fotografía');
INSERT INTO actividades (id_actividad, id_destino, nombre) VALUES ('381', '56', 'Ascenso');
INSERT INTO actividades (id_actividad, id_destino, nombre) VALUES ('382', '56', 'Senderismo');
INSERT INTO actividades (id_actividad, id_destino, nombre) VALUES ('383', '56', 'Fotografía');
INSERT INTO actividades (id_actividad, id_destino, nombre) VALUES ('384', '60', 'Baños naturales');
INSERT INTO actividades (id_actividad, id_destino, nombre) VALUES ('385', '60', 'Senderismo');
INSERT INTO actividades (id_actividad, id_destino, nombre) VALUES ('386', '60', 'Fotografía');
INSERT INTO actividades (id_actividad, id_destino, nombre) VALUES ('387', '61', 'Meditación');
INSERT INTO actividades (id_actividad, id_destino, nombre) VALUES ('388', '61', 'Senderismo');
INSERT INTO actividades (id_actividad, id_destino, nombre) VALUES ('389', '61', 'Oración');
INSERT INTO actividades (id_actividad, id_destino, nombre) VALUES ('390', '62', 'Tour arqueológico');
INSERT INTO actividades (id_actividad, id_destino, nombre) VALUES ('391', '62', 'Historia');
INSERT INTO actividades (id_actividad, id_destino, nombre) VALUES ('392', '62', 'Fotografía');
INSERT INTO actividades (id_actividad, id_destino, nombre) VALUES ('393', '63', 'Asistencia a obras');
INSERT INTO actividades (id_actividad, id_destino, nombre) VALUES ('394', '63', 'Arquitectura');
INSERT INTO actividades (id_actividad, id_destino, nombre) VALUES ('395', '63', 'Cultura');
INSERT INTO actividades (id_actividad, id_destino, nombre) VALUES ('396', '64', 'Visita arquitectónica');
INSERT INTO actividades (id_actividad, id_destino, nombre) VALUES ('397', '64', 'Fotografía');
INSERT INTO actividades (id_actividad, id_destino, nombre) VALUES ('398', '64', 'Espiritualidad');
INSERT INTO actividades (id_actividad, id_destino, nombre) VALUES ('399', '65', 'Tour gastronómico');
INSERT INTO actividades (id_actividad, id_destino, nombre) VALUES ('400', '65', 'Cata de pupusas');
INSERT INTO actividades (id_actividad, id_destino, nombre) VALUES ('401', '65', 'Cultura');
INSERT INTO actividades (id_actividad, id_destino, nombre) VALUES ('402', '66', 'Degustación');
INSERT INTO actividades (id_actividad, id_destino, nombre) VALUES ('403', '66', 'Compras típicas');
INSERT INTO actividades (id_actividad, id_destino, nombre) VALUES ('404', '66', 'Cultura');
INSERT INTO actividades (id_actividad, id_destino, nombre) VALUES ('405', '67', 'Caminatas');
INSERT INTO actividades (id_actividad, id_destino, nombre) VALUES ('406', '67', 'Artesanías');
INSERT INTO actividades (id_actividad, id_destino, nombre) VALUES ('407', '67', 'Descanso');


-- Table: resenas
CREATE TABLE `resenas` (
  `id_resena` int NOT NULL AUTO_INCREMENT,
  `id_destino` int NOT NULL,
  `id_usuario` int NOT NULL,
  `puntuacion` int NOT NULL,
  `comentario` text NOT NULL,
  `fecha` datetime DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id_resena`),
  KEY `id_destino` (`id_destino`),
  KEY `id_usuario` (`id_usuario`),
  CONSTRAINT `resenas_ibfk_1` FOREIGN KEY (`id_destino`) REFERENCES `destinos` (`id_destino`) ON DELETE CASCADE,
  CONSTRAINT `resenas_ibfk_2` FOREIGN KEY (`id_usuario`) REFERENCES `usuarios` (`id_usuario`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=125 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

INSERT INTO resenas (id_resena, id_destino, id_usuario, puntuacion, comentario, fecha) VALUES ('1', '1', '5', '5', 'Increíble experiencia, la naturaleza es imponente.', '2026-09-18 15:41:17');
INSERT INTO resenas (id_resena, id_destino, id_usuario, puntuacion, comentario, fecha) VALUES ('2', '1', '4', '4', 'Cansado pero valió la pena.', '2026-09-18 15:41:17');
INSERT INTO resenas (id_resena, id_destino, id_usuario, puntuacion, comentario, fecha) VALUES ('3', '2', '1', '5', 'El pueblo más bonito de la ruta.', '2026-09-18 15:41:17');
INSERT INTO resenas (id_resena, id_destino, id_usuario, puntuacion, comentario, fecha) VALUES ('4', '2', '3', '5', 'Arte en cada esquina.', '2026-09-18 15:41:17');
INSERT INTO resenas (id_resena, id_destino, id_usuario, puntuacion, comentario, fecha) VALUES ('5', '3', '3', '4', 'El clima es perfecto.', '2026-09-18 15:41:17');
INSERT INTO resenas (id_resena, id_destino, id_usuario, puntuacion, comentario, fecha) VALUES ('6', '3', '1', '5', 'Aventuras increíbles.', '2026-09-18 15:41:17');
INSERT INTO resenas (id_resena, id_destino, id_usuario, puntuacion, comentario, fecha) VALUES ('7', '4', '2', '5', 'Un oasis de tranquilidad.', '2026-09-18 15:41:17');
INSERT INTO resenas (id_resena, id_destino, id_usuario, puntuacion, comentario, fecha) VALUES ('8', '4', '3', '4', 'Muy relajante.', '2026-09-18 15:41:17');
INSERT INTO resenas (id_resena, id_destino, id_usuario, puntuacion, comentario, fecha) VALUES ('9', '5', '2', '5', 'Vista impresionante.', '2026-09-18 15:41:17');
INSERT INTO resenas (id_resena, id_destino, id_usuario, puntuacion, comentario, fecha) VALUES ('10', '5', '1', '5', 'El agua es increíble.', '2026-09-18 15:41:17');
INSERT INTO resenas (id_resena, id_destino, id_usuario, puntuacion, comentario, fecha) VALUES ('11', '6', '4', '5', 'Esfuerzo que vale la pena.', '2026-09-18 15:41:17');
INSERT INTO resenas (id_resena, id_destino, id_usuario, puntuacion, comentario, fecha) VALUES ('12', '6', '4', '4', 'Vistas inigualables.', '2026-09-18 15:41:17');
INSERT INTO resenas (id_resena, id_destino, id_usuario, puntuacion, comentario, fecha) VALUES ('13', '7', '2', '4', 'Muy bien conservado.', '2026-09-18 15:41:17');
INSERT INTO resenas (id_resena, id_destino, id_usuario, puntuacion, comentario, fecha) VALUES ('14', '7', '2', '5', 'Paz total.', '2026-09-18 15:41:17');
INSERT INTO resenas (id_resena, id_destino, id_usuario, puntuacion, comentario, fecha) VALUES ('15', '8', '1', '5', 'La comida es deliciosa.', '2026-09-18 15:41:17');
INSERT INTO resenas (id_resena, id_destino, id_usuario, puntuacion, comentario, fecha) VALUES ('16', '8', '3', '4', 'Ambiente muy acogedor.', '2026-09-18 15:41:17');
INSERT INTO resenas (id_resena, id_destino, id_usuario, puntuacion, comentario, fecha) VALUES ('17', '9', '1', '4', 'Artesanías preciosas.', '2026-09-18 15:41:17');
INSERT INTO resenas (id_resena, id_destino, id_usuario, puntuacion, comentario, fecha) VALUES ('18', '9', '2', '5', 'Gente muy amable.', '2026-09-18 15:41:17');
INSERT INTO resenas (id_resena, id_destino, id_usuario, puntuacion, comentario, fecha) VALUES ('19', '10', '2', '5', 'Agua cristalina.', '2026-09-18 15:41:17');
INSERT INTO resenas (id_resena, id_destino, id_usuario, puntuacion, comentario, fecha) VALUES ('20', '10', '3', '4', 'Lugar muy tranquilo.', '2026-09-18 15:41:17');
INSERT INTO resenas (id_resena, id_destino, id_usuario, puntuacion, comentario, fecha) VALUES ('21', '11', '2', '4', 'Historia fascinante.', '2026-09-18 15:41:17');
INSERT INTO resenas (id_resena, id_destino, id_usuario, puntuacion, comentario, fecha) VALUES ('22', '11', '2', '3', 'Un poco caluroso.', '2026-09-18 15:41:17');
INSERT INTO resenas (id_resena, id_destino, id_usuario, puntuacion, comentario, fecha) VALUES ('23', '12', '5', '5', 'El mejor lugar para surfear.', '2026-09-18 15:41:17');
INSERT INTO resenas (id_resena, id_destino, id_usuario, puntuacion, comentario, fecha) VALUES ('24', '12', '3', '5', 'Energía increíble.', '2026-09-18 15:41:17');
INSERT INTO resenas (id_resena, id_destino, id_usuario, puntuacion, comentario, fecha) VALUES ('25', '13', '4', '4', 'Mariscos frescos.', '2026-09-18 15:41:17');
INSERT INTO resenas (id_resena, id_destino, id_usuario, puntuacion, comentario, fecha) VALUES ('26', '13', '4', '4', 'Muy concurrido los domingos.', '2026-09-18 15:41:17');
INSERT INTO resenas (id_resena, id_destino, id_usuario, puntuacion, comentario, fecha) VALUES ('27', '14', '3', '5', 'Naturaleza pura.', '2026-09-18 15:41:17');
INSERT INTO resenas (id_resena, id_destino, id_usuario, puntuacion, comentario, fecha) VALUES ('28', '14', '5', '4', 'Lugar muy tranquilo.', '2026-09-18 15:41:17');
INSERT INTO resenas (id_resena, id_destino, id_usuario, puntuacion, comentario, fecha) VALUES ('29', '15', '3', '5', 'Vista increíble de la ciudad.', '2026-09-18 15:41:17');
INSERT INTO resenas (id_resena, id_destino, id_usuario, puntuacion, comentario, fecha) VALUES ('30', '15', '2', '4', 'Clima muy fresco.', '2026-09-18 15:41:17');
INSERT INTO resenas (id_resena, id_destino, id_usuario, puntuacion, comentario, fecha) VALUES ('31', '16', '2', '5', 'Un recorrido mágico.', '2026-09-18 15:41:17');
INSERT INTO resenas (id_resena, id_destino, id_usuario, puntuacion, comentario, fecha) VALUES ('32', '16', '1', '5', 'Imprescindible visitar.', '2026-09-18 15:41:17');
INSERT INTO resenas (id_resena, id_destino, id_usuario, puntuacion, comentario, fecha) VALUES ('33', '17', '5', '4', 'Ecosistema fascinante.', '2026-09-18 15:41:17');
INSERT INTO resenas (id_resena, id_destino, id_usuario, puntuacion, comentario, fecha) VALUES ('34', '17', '1', '4', 'Lugar muy natural.', '2026-09-18 15:41:17');
INSERT INTO resenas (id_resena, id_destino, id_usuario, puntuacion, comentario, fecha) VALUES ('35', '18', '3', '5', 'Siento que estoy en Suiza.', '2026-09-18 15:41:17');
INSERT INTO resenas (id_resena, id_destino, id_usuario, puntuacion, comentario, fecha) VALUES ('36', '18', '5', '5', 'Frío pero hermoso.', '2026-09-18 15:41:17');
INSERT INTO resenas (id_resena, id_destino, id_usuario, puntuacion, comentario, fecha) VALUES ('37', '19', '1', '4', 'Muy artístico.', '2026-09-18 15:41:17');
INSERT INTO resenas (id_resena, id_destino, id_usuario, puntuacion, comentario, fecha) VALUES ('38', '19', '2', '5', 'Paz absoluta.', '2026-09-18 15:41:17');
INSERT INTO resenas (id_resena, id_destino, id_usuario, puntuacion, comentario, fecha) VALUES ('39', '20', '1', '4', 'Vistas espectaculares.', '2026-09-18 15:41:17');
INSERT INTO resenas (id_resena, id_destino, id_usuario, puntuacion, comentario, fecha) VALUES ('40', '20', '5', '4', 'Lugar tranquilo.', '2026-09-18 15:41:17');
INSERT INTO resenas (id_resena, id_destino, id_usuario, puntuacion, comentario, fecha) VALUES ('41', '22', '1', '5', 'Playa increíble.', '2026-09-18 15:41:17');
INSERT INTO resenas (id_resena, id_destino, id_usuario, puntuacion, comentario, fecha) VALUES ('42', '22', '4', '4', 'Poca gente, mucha paz.', '2026-09-18 15:41:17');
INSERT INTO resenas (id_resena, id_destino, id_usuario, puntuacion, comentario, fecha) VALUES ('43', '23', '2', '4', 'Lugar muy bonito.', '2026-09-18 15:41:17');
INSERT INTO resenas (id_resena, id_destino, id_usuario, puntuacion, comentario, fecha) VALUES ('44', '23', '5', '3', 'Sencillo pero agradable.', '2026-09-18 15:41:17');
INSERT INTO resenas (id_resena, id_destino, id_usuario, puntuacion, comentario, fecha) VALUES ('45', '24', '4', '5', 'Desafío total.', '2026-09-18 15:41:17');
INSERT INTO resenas (id_resena, id_destino, id_usuario, puntuacion, comentario, fecha) VALUES ('46', '24', '3', '4', 'Vistas increíbles.', '2026-09-18 15:41:17');
INSERT INTO resenas (id_resena, id_destino, id_usuario, puntuacion, comentario, fecha) VALUES ('47', '25', '3', '3', 'Bien para ir con niños.', '2026-09-18 15:41:17');
INSERT INTO resenas (id_resena, id_destino, id_usuario, puntuacion, comentario, fecha) VALUES ('48', '25', '5', '4', 'Lugar agradable.', '2026-09-18 15:41:18');
INSERT INTO resenas (id_resena, id_destino, id_usuario, puntuacion, comentario, fecha) VALUES ('49', '26', '5', '5', 'Arquitectura magnífica.', '2026-09-18 15:41:18');
INSERT INTO resenas (id_resena, id_destino, id_usuario, puntuacion, comentario, fecha) VALUES ('50', '26', '2', '4', 'Lugar sagrado.', '2026-09-18 15:41:18');
INSERT INTO resenas (id_resena, id_destino, id_usuario, puntuacion, comentario, fecha) VALUES ('51', '27', '3', '5', 'Me encanta caminar por sus calles.', '2026-09-18 15:41:18');
INSERT INTO resenas (id_resena, id_destino, id_usuario, puntuacion, comentario, fecha) VALUES ('52', '27', '5', '5', 'Pueblo mágico.', '2026-09-18 15:41:18');
INSERT INTO resenas (id_resena, id_destino, id_usuario, puntuacion, comentario, fecha) VALUES ('53', '28', '5', '4', 'Mucha calma.', '2026-09-18 15:41:18');
INSERT INTO resenas (id_resena, id_destino, id_usuario, puntuacion, comentario, fecha) VALUES ('54', '28', '1', '4', 'Paisajes hermosos.', '2026-09-18 15:41:18');
INSERT INTO resenas (id_resena, id_destino, id_usuario, puntuacion, comentario, fecha) VALUES ('55', '29', '5', '5', 'Impresionante la forma de la roca.', '2026-09-18 15:41:18');
INSERT INTO resenas (id_resena, id_destino, id_usuario, puntuacion, comentario, fecha) VALUES ('56', '29', '1', '5', 'Lugar mágico.', '2026-09-18 15:41:18');
INSERT INTO resenas (id_resena, id_destino, id_usuario, puntuacion, comentario, fecha) VALUES ('57', '30', '1', '4', 'Muy cómodo.', '2026-09-18 15:41:18');
INSERT INTO resenas (id_resena, id_destino, id_usuario, puntuacion, comentario, fecha) VALUES ('58', '30', '2', '3', 'Un poco caro.', '2026-09-18 15:41:18');
INSERT INTO resenas (id_resena, id_destino, id_usuario, puntuacion, comentario, fecha) VALUES ('59', '31', '3', '4', 'Experiencia auténtica.', '2026-09-18 15:41:18');
INSERT INTO resenas (id_resena, id_destino, id_usuario, puntuacion, comentario, fecha) VALUES ('60', '31', '4', '4', 'Muy natural.', '2026-09-18 15:41:18');
INSERT INTO resenas (id_resena, id_destino, id_usuario, puntuacion, comentario, fecha) VALUES ('61', '32', '4', '5', 'La mejor vista de la zona.', '2026-09-18 15:41:18');
INSERT INTO resenas (id_resena, id_destino, id_usuario, puntuacion, comentario, fecha) VALUES ('62', '32', '5', '4', 'Paz absoluta.', '2026-09-18 15:41:18');
INSERT INTO resenas (id_resena, id_destino, id_usuario, puntuacion, comentario, fecha) VALUES ('63', '33', '5', '5', 'Arte increíble.', '2026-09-18 15:41:18');
INSERT INTO resenas (id_resena, id_destino, id_usuario, puntuacion, comentario, fecha) VALUES ('64', '33', '5', '4', 'Lugar muy tradicional.', '2026-09-18 15:41:18');
INSERT INTO resenas (id_resena, id_destino, id_usuario, puntuacion, comentario, fecha) VALUES ('65', '34', '3', '4', 'Ciudad muy bonita.', '2026-09-18 15:41:18');
INSERT INTO resenas (id_resena, id_destino, id_usuario, puntuacion, comentario, fecha) VALUES ('66', '34', '5', '3', 'Tranquila.', '2026-09-18 15:41:18');
INSERT INTO resenas (id_resena, id_destino, id_usuario, puntuacion, comentario, fecha) VALUES ('67', '35', '5', '4', 'Ideal para aprender.', '2026-09-18 15:41:18');
INSERT INTO resenas (id_resena, id_destino, id_usuario, puntuacion, comentario, fecha) VALUES ('68', '35', '3', '4', 'Muy limpio.', '2026-09-18 15:41:18');
INSERT INTO resenas (id_resena, id_destino, id_usuario, puntuacion, comentario, fecha) VALUES ('69', '36', '2', '5', 'Una aventura real.', '2026-09-18 15:41:18');
INSERT INTO resenas (id_resena, id_destino, id_usuario, puntuacion, comentario, fecha) VALUES ('70', '36', '3', '4', 'Vistas increíbles.', '2026-09-18 15:41:18');
INSERT INTO resenas (id_resena, id_destino, id_usuario, puntuacion, comentario, fecha) VALUES ('71', '37', '5', '4', 'Divertido para niños.', '2026-09-18 15:41:18');
INSERT INTO resenas (id_resena, id_destino, id_usuario, puntuacion, comentario, fecha) VALUES ('72', '37', '2', '3', 'Básico pero cumple.', '2026-09-18 15:41:18');
INSERT INTO resenas (id_resena, id_destino, id_usuario, puntuacion, comentario, fecha) VALUES ('73', '38', '2', '5', 'Impresionante.', '2026-09-18 15:41:18');
INSERT INTO resenas (id_resena, id_destino, id_usuario, puntuacion, comentario, fecha) VALUES ('74', '38', '2', '5', 'Símbolo de la ciudad.', '2026-09-18 15:41:18');
INSERT INTO resenas (id_resena, id_destino, id_usuario, puntuacion, comentario, fecha) VALUES ('75', '39', '1', '4', 'Muy informativo.', '2026-09-18 15:41:18');
INSERT INTO resenas (id_resena, id_destino, id_usuario, puntuacion, comentario, fecha) VALUES ('76', '39', '5', '4', 'Importante conocer.', '2026-09-18 15:41:18');
INSERT INTO resenas (id_resena, id_destino, id_usuario, puntuacion, comentario, fecha) VALUES ('77', '40', '2', '4', 'Paz absoluta.', '2026-09-18 15:41:18');
INSERT INTO resenas (id_resena, id_destino, id_usuario, puntuacion, comentario, fecha) VALUES ('78', '40', '1', '3', 'Difícil acceso.', '2026-09-18 15:41:18');
INSERT INTO resenas (id_resena, id_destino, id_usuario, puntuacion, comentario, fecha) VALUES ('79', '41', '5', '5', 'Agua cristalina.', '2026-09-18 15:41:18');
INSERT INTO resenas (id_resena, id_destino, id_usuario, puntuacion, comentario, fecha) VALUES ('80', '41', '3', '4', 'Lugar hermoso.', '2026-09-18 15:41:18');
INSERT INTO resenas (id_resena, id_destino, id_usuario, puntuacion, comentario, fecha) VALUES ('81', '42', '1', '4', 'Experiencia única.', '2026-09-18 15:41:18');
INSERT INTO resenas (id_resena, id_destino, id_usuario, puntuacion, comentario, fecha) VALUES ('82', '42', '5', '4', 'Paisajes marinos.', '2026-09-18 15:41:18');
INSERT INTO resenas (id_resena, id_destino, id_usuario, puntuacion, comentario, fecha) VALUES ('83', '43', '4', '5', 'Paraíso terrenal.', '2026-09-18 15:41:18');
INSERT INTO resenas (id_resena, id_destino, id_usuario, puntuacion, comentario, fecha) VALUES ('84', '43', '1', '4', 'Muy relajante.', '2026-09-18 15:41:18');
INSERT INTO resenas (id_resena, id_destino, id_usuario, puntuacion, comentario, fecha) VALUES ('85', '44', '2', '5', 'La mejor vista del oriente.', '2026-09-18 15:41:18');
INSERT INTO resenas (id_resena, id_destino, id_usuario, puntuacion, comentario, fecha) VALUES ('86', '44', '1', '4', 'Lugar mágico.', '2026-09-18 15:41:18');
INSERT INTO resenas (id_resena, id_destino, id_usuario, puntuacion, comentario, fecha) VALUES ('87', '45', '2', '5', 'Las mejores pupusas.', '2026-09-18 15:41:18');
INSERT INTO resenas (id_resena, id_destino, id_usuario, puntuacion, comentario, fecha) VALUES ('88', '45', '3', '5', 'Pueblo encantador.', '2026-09-18 15:41:18');
INSERT INTO resenas (id_resena, id_destino, id_usuario, puntuacion, comentario, fecha) VALUES ('89', '46', '5', '4', 'Un clásico.', '2026-09-18 15:41:18');
INSERT INTO resenas (id_resena, id_destino, id_usuario, puntuacion, comentario, fecha) VALUES ('90', '46', '1', '4', 'Vistas increíbles.', '2026-09-18 15:41:18');
INSERT INTO resenas (id_resena, id_destino, id_usuario, puntuacion, comentario, fecha) VALUES ('91', '47', '2', '5', 'Místico y hermoso.', '2026-09-18 15:41:18');
INSERT INTO resenas (id_resena, id_destino, id_usuario, puntuacion, comentario, fecha) VALUES ('92', '47', '5', '5', 'Aire puro.', '2026-09-18 15:41:18');
INSERT INTO resenas (id_resena, id_destino, id_usuario, puntuacion, comentario, fecha) VALUES ('93', '48', '4', '4', 'Típico y real.', '2026-09-18 15:41:18');
INSERT INTO resenas (id_resena, id_destino, id_usuario, puntuacion, comentario, fecha) VALUES ('94', '48', '1', '3', 'Muy concurrido.', '2026-09-18 15:41:18');
INSERT INTO resenas (id_resena, id_destino, id_usuario, puntuacion, comentario, fecha) VALUES ('95', '49', '2', '5', 'Renovado y hermoso.', '2026-09-18 15:41:18');
INSERT INTO resenas (id_resena, id_destino, id_usuario, puntuacion, comentario, fecha) VALUES ('96', '49', '4', '4', 'Mucha historia.', '2026-09-18 15:41:18');
INSERT INTO resenas (id_resena, id_destino, id_usuario, puntuacion, comentario, fecha) VALUES ('97', '50', '5', '5', 'Sabor inigualable.', '2026-09-18 15:41:18');
INSERT INTO resenas (id_resena, id_destino, id_usuario, puntuacion, comentario, fecha) VALUES ('98', '50', '4', '5', 'Súper recomendado.', '2026-09-18 15:41:18');
INSERT INTO resenas (id_resena, id_destino, id_usuario, puntuacion, comentario, fecha) VALUES ('99', '51', '4', '4', 'Comida excelente.', '2026-09-18 15:41:18');
INSERT INTO resenas (id_resena, id_destino, id_usuario, puntuacion, comentario, fecha) VALUES ('100', '51', '3', '4', 'Ambiente lindo.', '2026-09-18 15:41:18');
INSERT INTO resenas (id_resena, id_destino, id_usuario, puntuacion, comentario, fecha) VALUES ('101', '52', '3', '5', 'El mejor café.', '2026-09-18 15:41:18');
INSERT INTO resenas (id_resena, id_destino, id_usuario, puntuacion, comentario, fecha) VALUES ('102', '52', '2', '4', 'Lugar acogedor.', '2026-09-18 15:41:18');
INSERT INTO resenas (id_resena, id_destino, id_usuario, puntuacion, comentario, fecha) VALUES ('103', '53', '1', '5', 'Típico y rico.', '2026-09-18 15:41:18');
INSERT INTO resenas (id_resena, id_destino, id_usuario, puntuacion, comentario, fecha) VALUES ('104', '53', '5', '4', 'Mucha variedad.', '2026-09-18 15:41:18');
INSERT INTO resenas (id_resena, id_destino, id_usuario, puntuacion, comentario, fecha) VALUES ('105', '54', '4', '5', 'Lugar místico.', '2026-09-18 15:41:18');
INSERT INTO resenas (id_resena, id_destino, id_usuario, puntuacion, comentario, fecha) VALUES ('106', '54', '4', '4', 'Impresionante.', '2026-09-18 15:41:18');
INSERT INTO resenas (id_resena, id_destino, id_usuario, puntuacion, comentario, fecha) VALUES ('107', '56', '2', '4', 'Divertido y retador.', '2026-09-18 15:41:18');
INSERT INTO resenas (id_resena, id_destino, id_usuario, puntuacion, comentario, fecha) VALUES ('108', '56', '4', '4', 'Vistas geniales.', '2026-09-18 15:41:19');
INSERT INTO resenas (id_resena, id_destino, id_usuario, puntuacion, comentario, fecha) VALUES ('109', '60', '3', '5', 'Paraíso oculto.', '2026-09-18 15:41:19');
INSERT INTO resenas (id_resena, id_destino, id_usuario, puntuacion, comentario, fecha) VALUES ('110', '60', '4', '5', 'Increíble.', '2026-09-18 15:41:19');
INSERT INTO resenas (id_resena, id_destino, id_usuario, puntuacion, comentario, fecha) VALUES ('111', '61', '1', '5', 'Paz total.', '2026-09-18 15:41:19');
INSERT INTO resenas (id_resena, id_destino, id_usuario, puntuacion, comentario, fecha) VALUES ('112', '61', '3', '4', 'Muy tranquilo.', '2026-09-18 15:41:19');
INSERT INTO resenas (id_resena, id_destino, id_usuario, puntuacion, comentario, fecha) VALUES ('113', '62', '4', '5', 'Fascinante historia.', '2026-09-18 15:41:19');
INSERT INTO resenas (id_resena, id_destino, id_usuario, puntuacion, comentario, fecha) VALUES ('114', '62', '4', '5', 'Patrimonio único.', '2026-09-18 15:41:19');
INSERT INTO resenas (id_resena, id_destino, id_usuario, puntuacion, comentario, fecha) VALUES ('115', '63', '5', '5', 'Elegante y majestuoso.', '2026-09-18 15:41:19');
INSERT INTO resenas (id_resena, id_destino, id_usuario, puntuacion, comentario, fecha) VALUES ('116', '63', '2', '4', 'Un icono.', '2026-09-18 15:41:19');
INSERT INTO resenas (id_resena, id_destino, id_usuario, puntuacion, comentario, fecha) VALUES ('117', '64', '2', '5', 'Luz y color increíbles.', '2026-09-18 15:41:19');
INSERT INTO resenas (id_resena, id_destino, id_usuario, puntuacion, comentario, fecha) VALUES ('118', '64', '4', '5', 'Única en el mundo.', '2026-09-18 15:41:19');
INSERT INTO resenas (id_resena, id_destino, id_usuario, puntuacion, comentario, fecha) VALUES ('119', '65', '4', '5', 'Sabor auténtico.', '2026-09-18 15:41:19');
INSERT INTO resenas (id_resena, id_destino, id_usuario, puntuacion, comentario, fecha) VALUES ('120', '65', '4', '5', 'Delicioso.', '2026-09-18 15:41:19');
INSERT INTO resenas (id_resena, id_destino, id_usuario, puntuacion, comentario, fecha) VALUES ('121', '66', '2', '4', 'Sabores intensos.', '2026-09-18 15:41:19');
INSERT INTO resenas (id_resena, id_destino, id_usuario, puntuacion, comentario, fecha) VALUES ('122', '66', '3', '4', 'Gente amable.', '2026-09-18 15:41:19');
INSERT INTO resenas (id_resena, id_destino, id_usuario, puntuacion, comentario, fecha) VALUES ('123', '67', '1', '5', 'Pueblo muy lindo.', '2026-09-18 15:41:19');
INSERT INTO resenas (id_resena, id_destino, id_usuario, puntuacion, comentario, fecha) VALUES ('124', '67', '4', '4', 'Súper tranquilo.', '2026-09-18 15:41:19');


SET FOREIGN_KEY_CHECKS = 1;