-- --------------------------------------------------------
-- Host:                         127.0.0.1
-- Server version:               8.0.30 - MySQL Community Server - GPL
-- Server OS:                    Win64
-- HeidiSQL Version:             12.1.0.6537
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;


-- Dumping database structure for amonos
CREATE DATABASE IF NOT EXISTS `amonos` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `amonos`;

-- Dumping structure for table amonos.actividades
CREATE TABLE IF NOT EXISTS `actividades` (
  `id_actividad` int NOT NULL AUTO_INCREMENT,
  `id_destino` int NOT NULL,
  `nombre` varchar(100) NOT NULL,
  PRIMARY KEY (`id_actividad`),
  KEY `id_destino` (`id_destino`),
  CONSTRAINT `actividades_ibfk_1` FOREIGN KEY (`id_destino`) REFERENCES `destinos` (`id_destino`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Dumping data for table amonos.actividades: ~0 rows (approximately)

-- Dumping structure for table amonos.categorias_destino
CREATE TABLE IF NOT EXISTS `categorias_destino` (
  `id_categoria` int NOT NULL AUTO_INCREMENT,
  `nombre_categoria` varchar(100) NOT NULL,
  `icono` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`id_categoria`),
  UNIQUE KEY `nombre_categoria` (`nombre_categoria`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Dumping data for table amonos.categorias_destino: ~3 rows (approximately)
INSERT INTO `categorias_destino` (`id_categoria`, `nombre_categoria`, `icono`) VALUES
	(1, 'Playa', '🏖️'),
	(2, 'Aventura', '🌿'),
	(3, 'Cultura', '🏛️');

-- Dumping structure for table amonos.destinos
CREATE TABLE IF NOT EXISTS `destinos` (
  `id_destino` int NOT NULL AUTO_INCREMENT,
  `id_categoria` int NOT NULL,
  `nombre` varchar(150) NOT NULL,
  `descripcion` text,
  `departamento` varchar(100) DEFAULT NULL,
  `direccion` varchar(255) DEFAULT NULL,
  `latitud` decimal(10,8) DEFAULT NULL,
  `longitud` decimal(11,8) DEFAULT NULL,
  `precio_entrada` decimal(10,2) DEFAULT NULL,
  `precio_comida` decimal(10,2) DEFAULT NULL,
  `precio_parqueo` decimal(10,2) DEFAULT NULL,
  `precio_hospedaje` decimal(10,2) DEFAULT NULL,
  `puntaje` decimal(10,1) DEFAULT NULL,
  `tipo_visitante` enum('familia','jovenes','pareja','todos') DEFAULT 'todos',
  PRIMARY KEY (`id_destino`)
) ENGINE=InnoDB AUTO_INCREMENT=22 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Dumping data for table amonos.destinos: ~2 rows (approximately)
INSERT INTO `destinos` (`id_destino`, `id_categoria`, `nombre`, `descripcion`, `departamento`, `direccion`, `latitud`, `longitud`, `precio_entrada`, `precio_comida`, `precio_parqueo`, `precio_hospedaje`, `puntaje`, `tipo_visitante`) VALUES
	(7, 2, 'Lago de Coatepeque', NULL, 'Santa Ana', NULL, NULL, NULL, 15.00, NULL, NULL, NULL, 4.8, 'todos'),
	(8, 1, 'Playa El Tunco', NULL, 'La Libertad', NULL, NULL, NULL, 0.00, NULL, NULL, NULL, 4.6, 'todos');

-- Dumping structure for table amonos.favoritos
CREATE TABLE IF NOT EXISTS `favoritos` (
  `id_favorito` int NOT NULL AUTO_INCREMENT,
  `id_usuario` int NOT NULL,
  `id_destino` int NOT NULL,
  `fecha_agregado` datetime DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id_favorito`),
  KEY `id_usuario` (`id_usuario`),
  KEY `id_destino` (`id_destino`),
  CONSTRAINT `favoritos_ibfk_1` FOREIGN KEY (`id_usuario`) REFERENCES `usuarios` (`id_usuario`),
  CONSTRAINT `favoritos_ibfk_2` FOREIGN KEY (`id_destino`) REFERENCES `destinos` (`id_destino`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Dumping data for table amonos.favoritos: ~0 rows (approximately)

-- Dumping structure for table amonos.historial_visitas
CREATE TABLE IF NOT EXISTS `historial_visitas` (
  `id_visita` int NOT NULL AUTO_INCREMENT,
  `id_usuario` int NOT NULL,
  `id_destino` int NOT NULL,
  `fecha_visita` date NOT NULL,
  `calificacion` tinyint DEFAULT NULL,
  `gasto_total` decimal(10,2) DEFAULT NULL,
  PRIMARY KEY (`id_visita`),
  KEY `id_usuario` (`id_usuario`),
  KEY `id_destino` (`id_destino`),
  CONSTRAINT `historial_visitas_ibfk_1` FOREIGN KEY (`id_usuario`) REFERENCES `usuarios` (`id_usuario`),
  CONSTRAINT `historial_visitas_ibfk_2` FOREIGN KEY (`id_destino`) REFERENCES `destinos` (`id_destino`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Dumping data for table amonos.historial_visitas: ~0 rows (approximately)

-- Dumping structure for table amonos.imagenes_destino
CREATE TABLE IF NOT EXISTS `imagenes_destino` (
  `id_imagen` int NOT NULL AUTO_INCREMENT,
  `id_destino` int NOT NULL,
  `imagen_url` varchar(255) NOT NULL,
  PRIMARY KEY (`id_imagen`),
  KEY `id_destino` (`id_destino`),
  CONSTRAINT `imagenes_destino_ibfk_1` FOREIGN KEY (`id_destino`) REFERENCES `destinos` (`id_destino`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Dumping data for table amonos.imagenes_destino: ~2 rows (approximately)
INSERT INTO `imagenes_destino` (`id_imagen`, `id_destino`, `imagen_url`) VALUES
	(7, 7, 'https://i.pinimg.com/736x/e4/2f/02/e42f029c72f9092539f18fa5720af0c9.jpg'),
	(8, 8, 'https://th.bing.com/th/id/R.b247efb4b22d8b17052467b266b71ac4?rik=xFaxWkCaoOBP%2fQ&pid=ImgRaw&r=0');

-- Dumping structure for table amonos.preferencias
CREATE TABLE IF NOT EXISTS `preferencias` (
  `id_preferencias` int NOT NULL,
  `id_categoria` int NOT NULL,
  `id_usuario` int NOT NULL,
  PRIMARY KEY (`id_preferencias`),
  KEY `id_usuario` (`id_usuario`),
  KEY `id_categoria` (`id_categoria`),
  CONSTRAINT `preferencias_ibfk_1` FOREIGN KEY (`id_usuario`) REFERENCES `usuarios` (`id_usuario`),
  CONSTRAINT `preferencias_ibfk_2` FOREIGN KEY (`id_categoria`) REFERENCES `categorias_destino` (`id_categoria`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Dumping data for table amonos.preferencias: ~0 rows (approximately)

-- Dumping structure for table amonos.presupuestos_viaje
CREATE TABLE IF NOT EXISTS `presupuestos_viaje` (
  `id_presupuesto` int NOT NULL AUTO_INCREMENT,
  `id_usuario` int NOT NULL,
  `id_destino` int NOT NULL,
  `nombre_presupuesto` varchar(100) DEFAULT NULL,
  `cantidad_personas` int NOT NULL DEFAULT '1',
  `incluir_entrada` tinyint(1) DEFAULT '1',
  `incluir_comida` tinyint(1) DEFAULT '1',
  `incluir_parqueo` tinyint(1) DEFAULT '0',
  `incluir_hospedaje` tinyint(1) DEFAULT '0',
  `costo_entrada` decimal(10,2) DEFAULT '0.00',
  `costo_comida` decimal(10,2) DEFAULT '0.00',
  `costo_parqueo` decimal(10,2) DEFAULT '0.00',
  `costo_hospedaje` decimal(10,2) DEFAULT '0.00',
  `presupuesto_usuario` decimal(10,2) NOT NULL,
  `costo_estimado` decimal(10,2) NOT NULL,
  `dinero_restante` decimal(10,2) NOT NULL,
  `fecha_calculo` datetime DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id_presupuesto`),
  KEY `id_usuario` (`id_usuario`),
  KEY `id_destino` (`id_destino`),
  CONSTRAINT `presupuestos_viaje_ibfk_1` FOREIGN KEY (`id_usuario`) REFERENCES `usuarios` (`id_usuario`),
  CONSTRAINT `presupuestos_viaje_ibfk_2` FOREIGN KEY (`id_destino`) REFERENCES `destinos` (`id_destino`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Dumping data for table amonos.presupuestos_viaje: ~0 rows (approximately)

-- Dumping structure for table amonos.resenas
CREATE TABLE IF NOT EXISTS `resenas` (
  `id_resena` int NOT NULL AUTO_INCREMENT,
  `id_usuario` int NOT NULL,
  `puntuacion` int DEFAULT NULL,
  `comentario` text,
  `fecha` datetime DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id_resena`),
  KEY `id_usuario` (`id_usuario`),
  CONSTRAINT `resenas_ibfk_1` FOREIGN KEY (`id_usuario`) REFERENCES `usuarios` (`id_usuario`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Dumping data for table amonos.resenas: ~0 rows (approximately)

-- Dumping structure for table amonos.usuarios
CREATE TABLE IF NOT EXISTS `usuarios` (
  `id_usuario` int NOT NULL AUTO_INCREMENT,
  `nombre` varchar(100) NOT NULL,
  `correo` varchar(200) DEFAULT NULL,
  `password_hash` varchar(255) DEFAULT NULL,
  `estado` enum('activo','suspendido') DEFAULT 'activo',
  PRIMARY KEY (`id_usuario`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Dumping data for table amonos.usuarios: ~2 rows (approximately)
INSERT INTO `usuarios` (`id_usuario`, `nombre`, `correo`, `password_hash`, `estado`) VALUES
	(2, 'Diego Ayala', 'test@correo.com', '$2y$10$e8T34vG9u8LgE3h1K.mDpewLg5R8v.2u5o8qZ/xK8Z3F9l/4D8jG6', 'activo'),
	(3, 'christopher', 'chris@gmail.com', '$2y$10$kxhSTUDGESGouw8IIRqT7ObubsE3XvfhHHuaiNvD/K6nLJMMFcGce', 'activo'),
	(4, 'edwin', 'edwin@gmail.com', '$2y$10$TLG2cKR/J3BZd4ShL8v7gOQtE/udsppGZzNHahtwwmTFU5wAzNvV2', 'activo');

/*!40103 SET TIME_ZONE=IFNULL(@OLD_TIME_ZONE, 'system') */;
/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;
