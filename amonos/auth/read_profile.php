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

    $query = "SELECT nombre, correo FROM usuarios WHERE id_usuario = :id";
    $stmt = $db->prepare($query);
    $stmt->bindParam(":id", $id_usuario, PDO::PARAM_INT);
    $stmt->execute();
    $user = $stmt->fetch(PDO::FETCH_ASSOC);

    echo json_encode([
        "success" => true,
        "data" => $user
    ]);

} catch (PDOException $e) {
    http_response_code(500);
    echo json_encode(["success" => false, "message" => "Error: " . $e->getMessage()]);
}
?>
