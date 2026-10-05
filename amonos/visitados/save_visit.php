<?php
header("Access-Control-Allow-Origin: *");
header("Content-Type: application/json; charset=UTF-8");
header("Access-Control-Allow-Methods: POST");
header("Access-Control-Allow-Headers: Content-Type");

require_once "../config/conexion.php";

$data = json_decode(file_get_contents("php://input"));

if (!$data || !isset($data->id_destino) || !isset($data->id_usuario)) {
    http_response_code(400);
    echo json_encode(["success" => false, "message" => "Datos incompletos. Se requiere id_destino e id_usuario."]);
    exit();
}

try {
    $database = new Database();
    $db = $database->getConnection();

    // Usamos INSERT IGNORE o ON DUPLICATE KEY UPDATE para evitar errores si ya está visitado
    $query = "INSERT INTO visitados (id_usuario, id_destino) VALUES (:user, :dest)
              ON DUPLICATE KEY UPDATE fecha_visita = CURRENT_TIMESTAMP";

    $stmt = $db->prepare($query);
    $stmt->execute([
        ':user' => $data->id_usuario,
        ':dest' => $data->id_destino
    ]);

    echo json_encode(["success" => true, "message" => "Destino guardado en tu historial de visitas."]);

} catch (PDOException $e) {
    http_response_code(500);
    echo json_encode(["success" => false, "message" => "Error de base de datos: " . $e->getMessage()]);
}
?>
