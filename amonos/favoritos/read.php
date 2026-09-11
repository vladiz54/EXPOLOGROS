<?php
header("Content-Type: application/json; charset=UTF-8");
header("Access-Control-Allow-Origin: *");

require_once("../config/conexion.php");
session_start();

if (!isset($_SESSION['id_usuario'])) {
    http_response_code(401);
    echo json_encode(["success" => false, "message" => "Sesión no iniciada."]);
    exit();
}

try {
    $database = new Database();
    $db = $database->getConnection();
    $id_usuario = $_SESSION['id_usuario'];

    $query = "SELECT d.id_destino AS id, d.nombre, d.departamento,
                     (SELECT imagen_url FROM imagenes_destino img WHERE img.id_destino = d.id_destino LIMIT 1) AS imagen
              FROM favoritos f
              JOIN destinos d ON f.id_destino = d.id_destino
              WHERE f.id_usuario = :user";

    $stmt = $db->prepare($query);
    $stmt->bindParam(":user", $id_usuario, PDO::PARAM_INT);
    $stmt->execute();
    $favoritos = $stmt->fetchAll(PDO::FETCH_ASSOC);

    echo json_encode([
        "success" => true,
        "data" => $favoritos
    ]);

} catch (PDOException $e) {
    http_response_code(500);
    echo json_encode(["success" => false, "message" => "Error: " . $e->getMessage()]);
}
?>
