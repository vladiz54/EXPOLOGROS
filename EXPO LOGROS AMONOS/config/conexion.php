<?php
// config/conexion.php

$host = 'localhost';
$db   = 'amonos'; // Reemplaza por el nombre exacto de tu Base de Datos en phpMyAdmin
$user = 'root';        // Usuario por defecto en LARAGON
$pass = '';            // Contraseña por defecto en LARAGON

try {
    $pdo = new PDO("mysql:host=$host;dbname=$db;charset=utf8mb4", $user, $pass, [
        PDO::ATTR_ERRMODE => PDO::ERRMODE_EXCEPTION,
        PDO::ATTR_DEFAULT_FETCH_MODE => PDO::FETCH_ASSOC
    ]);
} catch (PDOException $e) {
    // Si la conexión falla, devolvemos una respuesta en JSON y detenemos el script
    echo json_encode(["status" => "error", "mensaje" => "Error de conexión: " . $e->getMessage()]);
    exit;
}