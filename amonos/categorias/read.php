<?php
header("Content-Type: application/json; charset=UTF-8");
header("Access-Control-Allow-Methods: GET");

require_once("../config/conexion.php");

$response = [
    "success" => false,
    "data" => []
];

try {
    $database = new Database();
    $db = $database->getConnection();

    $query = "SELECT id_categoria, nombre_categoria, icono FROM categorias_destino ORDER BY nombre_categoria ASC";
    $stmt = $db->prepare($query);
    $stmt->execute();

    $categorias = $stmt->fetchAll(PDO::FETCH_ASSOC);

    $response["success"] = true;
    $response["data"] = $categorias;

} catch (PDOException $e) {
    $response["message"] = "Error al consultar categorías: " . $e->getMessage();
}

echo json_encode($response);