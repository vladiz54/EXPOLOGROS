<?php
// Credenciales de conexión en Laragon
$host     = "localhost";
$usuario  = "root";
$password = ""; // En Laragon por defecto va vacío
$database = "amonos";

// Crear conexión
$conexion = new mysqli($host, $usuario, $password, $database);

// Verificar si hubo error
if ($conexion->connect_error) {
    die("Error de conexión a la base de datos: " . $conexion->connect_error);
}

// Asegurar caracteres especiales (ñ, tildes)
$conexion->set_charset("utf8mb4");
?>