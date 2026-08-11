<?php
header("Content-Type: application/json; charset=UTF-8");
header("Access-Control-Allow-Methods: POST");

require_once("../config/conexion.php");

session_start();

$response = [
    "success" => false,
    "message" => ""
];

if (!isset($_SESSION['id_usuario'])) {
    $response["message"] = "Debes iniciar sesión para guardar favoritos.";
    echo json_encode($response);
    exit;
}

$data = json_decode(file_get_contents("php://input"), true);
$id_destino = isset($data['id_destino']) ? (int)$data['id_destino'] : 0;
$id_usuario = (int)$_SESSION['id_usuario'];

if ($id_destino <= 0) {
    $response["message"] = "ID de destino no válido.";
    echo json_encode($response);
    exit;
}

try {
    $database = new Database();
    $db = $database->getConnection();

    // Comprobar si ya existe
    $checkQuery = "SELECT id_favorito FROM favoritos WHERE id_usuario = :id_usuario AND id_destino = :id_destino LIMIT 1";
    $checkStmt = $db->prepare($checkQuery);
    $checkStmt->bindParam(":id_usuario", $id_usuario, PDO::PARAM_INT);
    $checkStmt->bindParam(":id_destino", $id_destino, PDO::PARAM_INT);
    $checkStmt->execute();

    if ($checkStmt->rowCount() > 0) {
        // Eliminar
        $deleteQuery = "DELETE FROM favoritos WHERE id_usuario = :id_usuario AND id_destino = :id_destino";
        $deleteStmt = $db->prepare($deleteQuery);
        $deleteStmt->bindParam(":id_usuario", $id_usuario, PDO::PARAM_INT);
        $deleteStmt->bindParam(":id_destino", $id_destino, PDO::PARAM_INT);
        $deleteStmt->execute();

        $response["success"] = true;
        $response["action"] = "removed";
        $response["message"] = "Eliminado de favoritos.";
    } else {
        // Insertar
        $insertQuery = "INSERT INTO favoritos (id_usuario, id_destino) VALUES (:id_usuario, :id_destino)";
        $insertStmt = $db->prepare($insertQuery);
        $insertStmt->bindParam(":id_usuario", $id_usuario, PDO::PARAM_INT);
        $insertStmt->bindParam(":id_destino", $id_destino, PDO::PARAM_INT);
        $insertStmt->execute();

        $response["success"] = true;
        $response["action"] = "added";
        $response["message"] = "Guardado en favoritos.";
    }

} catch (PDOException $e) {
    $response["message"] = "Error en favoritos: " . $e->getMessage();
}

echo json_encode($response);