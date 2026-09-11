<?php
header("Content-Type: application/json; charset=UTF-8");
header("Access-Control-Allow-Origin: *");

require_once("../config/conexion.php");
session_start();

if (!isset($_SESSION['id_usuario'])) {
    http_response_code(401);
    echo json_encode(["success" => false, "message" => "Debes iniciar sesión para guardar favoritos."]);
    exit();
}

$data = json_decode(file_get_contents("php://input"), true);
$id_destino = isset($data['id_destino']) ? intval($data['id_destino']) : 0;
$id_usuario = $_SESSION['id_usuario'];

if ($id_destino <= 0) {
    http_response_code(400);
    echo json_encode(["success" => false, "message" => "ID de destino inválido."]);
    exit();
}

try {
    $database = new Database();
    $db = $database->getConnection();

    $queryCheck = "SELECT id_favorito FROM favoritos WHERE id_usuario = :user AND id_destino = :dest";
    $stmtCheck = $db->prepare($queryCheck);
    $stmtCheck->execute([':user' => $id_usuario, ':dest' => $id_destino]);

    if ($stmtCheck->rowCount() > 0) {
        $queryDel = "DELETE FROM favoritos WHERE id_usuario = :user AND id_destino = :dest";
        $stmtDel = $db->prepare($queryDel);
        $stmtDel->execute([':user' => $id_usuario, ':dest' => $id_destino]);

        echo json_encode(["success" => true, "action" => "removed", "message" => "Eliminado de favoritos."]);
    } else {
        $queryIns = "INSERT INTO favoritos (id_usuario, id_destino) VALUES (:user, :dest)";
        $stmtIns = $db->prepare($queryIns);
        $stmtIns->execute([':user' => $id_usuario, ':dest' => $id_destino]);

        echo json_encode(["success" => true, "action" => "added", "message" => "Agregado a favoritos."]);
    }

} catch (PDOException $e) {
    http_response_code(500);
    echo json_encode(["success" => false, "message" => "Error en el servidor: " . $e->getMessage()]);
}
?>
