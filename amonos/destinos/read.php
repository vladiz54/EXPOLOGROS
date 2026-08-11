<?php
header("Content-Type: application/json; charset=UTF-8");

// Incluye tu archivo de conexión
require_once("../config/conexion.php");

try {
    $database = new Database();
    $db = $database->getConnection();

    // Consulta directa para traer todos los destinos con su primera imagen
    $query = "SELECT d.id_destino, d.nombre, d.departamento, d.precio_entrada, d.puntaje,
                     (SELECT imagen_url FROM imagenes_destino img WHERE img.id_destino = d.id_destino LIMIT 1) AS imagen_url
              FROM destinos d
              ORDER BY d.id_destino DESC";

    $stmt = $db->prepare($query);
    $stmt->execute();
    
    $destinos = $stmt->fetchAll(PDO::FETCH_ASSOC);

    echo json_encode([
        "success" => true,
        "data" => $destinos
    ]);

} catch (PDOException $e) {
    echo json_encode([
        "success" => false,
        "message" => "Error de base de datos: " . $e->getMessage()
    ]);
}