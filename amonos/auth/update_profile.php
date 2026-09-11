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

$data = json_decode(file_get_contents("php://input"), true);
$id_usuario = $_SESSION['id_usuario'];

$nombre = isset($data['nombre']) ? trim($data['nombre']) : '';
$correo = isset($data['correo']) ? trim($data['correo']) : '';

if (empty($nombre) || empty($correo)) {
    echo json_encode(["success" => false, "message" => "Nombre y correo son obligatorios."]);
    exit();
}

try {
    $database = new Database();
    $db = $database->getConnection();

    $query = "UPDATE usuarios SET nombre = :nombre, correo = :correo WHERE id_usuario = :id";
    $stmt = $db->prepare($query);
    $stmt->execute([
        ':nombre' => $nombre,
        ':correo' => $correo,
        ':id' => $id_usuario
    ]);

    $_SESSION['nombre'] = $nombre;
    $_SESSION['correo'] = $correo;

    echo json_encode(["success" => true, "message" => "Perfil actualizado correctamente."]);

} catch (PDOException $e) {
    http_response_code(500);
    echo json_encode(["success" => false, "message" => "Error: " . $e->getMessage()]);
}
?>
