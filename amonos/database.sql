CREATE DATABASE IF NOT EXISTS amonos;
USE amonos;

CREATE TABLE IF NOT EXISTS categorias_destino (
    id_categoria INT AUTO_INCREMENT PRIMARY KEY,
    nombre_categoria VARCHAR(100) NOT NULL
);

CREATE TABLE IF NOT EXISTS usuarios (
    id_usuario INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    correo VARCHAR(150) NOT NULL UNIQUE,
    password_hash VARCHAR(255) NOT NULL,
    estado VARCHAR(20) DEFAULT 'activo'
);

CREATE TABLE IF NOT EXISTS destinos (
    id_destino INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(150) NOT NULL,
    departamento VARCHAR(100) NOT NULL,
    descripcion TEXT,
    precio_entrada DECIMAL(10,2) DEFAULT 0.00,
    precio_comida DECIMAL(10,2) DEFAULT 0.00,
    precio_parqueo DECIMAL(10,2) DEFAULT 0.00,
    precio_hospedaje DECIMAL(10,2) DEFAULT 0.00,
    id_categoria INT,
    puntaje DECIMAL(3,1) DEFAULT 0.0,
    FOREIGN KEY (id_categoria) REFERENCES categorias_destino(id_categoria) ON DELETE SET NULL
);

CREATE TABLE IF NOT EXISTS imagenes_destino (
    id_imagen INT AUTO_INCREMENT PRIMARY KEY,
    id_destino INT NOT NULL,
    imagen_url VARCHAR(255) NOT NULL,
    FOREIGN KEY (id_destino) REFERENCES destinos(id_destino) ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS actividades (
    id_actividad INT AUTO_INCREMENT PRIMARY KEY,
    id_destino INT NOT NULL,
    nombre VARCHAR(150) NOT NULL,
    FOREIGN KEY (id_destino) REFERENCES destinos(id_destino) ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS resenas (
    id_resena INT AUTO_INCREMENT PRIMARY KEY,
    id_destino INT NOT NULL,
    id_usuario INT NOT NULL,
    puntuacion INT NOT NULL,
    comentario TEXT NOT NULL,
    fecha DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (id_destino) REFERENCES destinos(id_destino) ON DELETE CASCADE,
    FOREIGN KEY (id_usuario) REFERENCES usuarios(id_usuario) ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS favoritos (
    id_favorito INT AUTO_INCREMENT PRIMARY KEY,
    id_usuario INT NOT NULL,
    id_destino INT NOT NULL,
    fecha_guardado DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (id_usuario) REFERENCES usuarios(id_usuario) ON DELETE CASCADE,
    FOREIGN KEY (id_destino) REFERENCES destinos(id_destino) ON DELETE CASCADE,
    UNIQUE (id_usuario, id_destino)
);

INSERT INTO categorias_destino (nombre_categoria) VALUES ('Aventura'), ('Cultural'), ('Playa'), ('Gastronómico'), ('Naturaleza');
