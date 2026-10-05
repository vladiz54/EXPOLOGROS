<?php
header("Access-Control-Allow-Origin: *");
header("Content-Type: application/json; charset=UTF-8");

require_once "../config/conexion.php";

$id_usuario = isset($_GET['id_usuario']) ? intval($_GET['id_usuario']) : 1; // Default user 1 for testing

try {
    $database = new Database();
    $db = $database->getConnection();

    $query = "SELECT d.nombre, d.departamento, (d.precio_entrada + d.precio_comida + d.precio_parqueo) as total
              FROM visitados v
              JOIN destinos d ON v.id_destino = d.id_destino
              WHERE v.id_usuario = :user
              ORDER BY v.fecha_visita DESC";

    $stmt = $db->prepare($query);
    $stmt->execute([':user' => $id_usuario]);
    $visitados = $stmt->fetchAll(PDO::FETCH_ASSOC);

    echo json_encode([
        "success" => true,
        "data" => $visitados
    ]);

} catch (PDOException $e) {
    http_response_code(500);
    echo json_encode(["success" => false, "message" => "Error: " . $e->getMessage()]);
}
?>
