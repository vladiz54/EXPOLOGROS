<?php
header("Content-Type: application/json; charset=UTF-8");
header("Access-Control-Allow-Methods: POST");

require_once("../config/conexion.php");

$response = [
    "success" => false,
    "message" => ""
];

if ($_SERVER['REQUEST_METHOD'] !== 'POST') {
    $response["message"] = "Método no permitido.";
    echo json_encode($response);
    exit;
}

$data = json_decode(file_get_contents("php://input"), true);

$nombre   = isset($data['nombre']) ? trim($data['nombre']) : '';
$correo   = isset($data['correo']) ? trim($data['correo']) : '';
$password = isset($data['password']) ? trim($data['password']) : '';

if (empty($nombre) || empty($correo) || empty($password)) {
    $response["message"] = "Por favor, complete todos los campos obligatorios.";
    echo json_encode($response);
    exit;
}

if (!filter_var($correo, FILTER_VALIDATE_EMAIL)) {
    $response["message"] = "El formato del correo electrónico no es válido.";
    echo json_encode($response);
    exit;
}

if (strlen($password) < 8) {
    $response["message"] = "La contraseña debe tener al menos 8 caracteres.";
    echo json_encode($response);
    exit;
}

try {
    $database = new Database();
    $db = $database->getConnection();

    // Validar si el correo ya existe
    $checkQuery = "SELECT id_usuario FROM usuarios WHERE correo = :correo LIMIT 1";
    $checkStmt = $db->prepare($checkQuery);
    $checkStmt->bindParam(":correo", $correo, PDO::PARAM_STR);
    $checkStmt->execute();

    if ($checkStmt->rowCount() > 0) {
        $response["message"] = "El correo electrónico ya se encuentra registrado.";
        echo json_encode($response);
        exit;
    }

    // Hashear la contraseña de forma segura
    $password_hash = password_hash($password, PASSWORD_BCRYPT);

    // Insertar nuevo usuario
    $insertQuery = "INSERT INTO usuarios (nombre, correo, password_hash, estado) 
                    VALUES (:nombre, :correo, :password_hash, 'activo')";

    $stmt = $db->prepare($insertQuery);
    $stmt->bindParam(":nombre", $nombre, PDO::PARAM_STR);
    $stmt->bindParam(":correo", $correo, PDO::PARAM_STR);
    $stmt->bindParam(":password_hash", $password_hash, PDO::PARAM_STR);

    if ($stmt->execute()) {
        $response["success"] = true;
        $response["message"] = "¡Registro exitoso! Ya puedes iniciar sesión.";
    } else {
        $response["message"] = "No se pudo registrar el usuario. Inténtalo de nuevo.";
    }

} catch (PDOException $e) {
    $response["message"] = "Error en el servidor: " . $e->getMessage();
}

echo json_encode($response);