<?php
header("Content-Type: application/json; charset=UTF-8");
header("Access-Control-Allow-Methods: POST");

require_once("../config/conexion.php");

session_start();

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

$correo = isset($data['correo']) ? trim($data['correo']) : '';
$password = isset($data['password']) ? trim($data['password']) : '';

if (empty($correo) || empty($password)) {
    $response["message"] = "Por favor, complete todos los campos obligatorios.";
    echo json_encode($response);
    exit;
}

if (!filter_var($correo, FILTER_VALIDATE_EMAIL)) {
    $response["message"] = "El formato del correo electrónico no es válido.";
    echo json_encode($response);
    exit;
}

try {
    $database = new Database();
    $db = $database->getConnection();

    $query = "SELECT id_usuario, nombre, correo, password_hash, estado 
              FROM usuarios 
              WHERE correo = :correo 
              LIMIT 1";

    $stmt = $db->prepare($query);
    $stmt->bindParam(":correo", $correo, PDO::PARAM_STR);
    $stmt->execute();

    if ($stmt->rowCount() > 0) {
        $row = $stmt->fetch(PDO::FETCH_ASSOC);

        if ($row['estado'] !== 'activo') {
            $response["message"] = "Tu cuenta se encuentra suspendida. Contacta al soporte.";
            echo json_encode($response);
            exit;
        }

        if (password_verify($password, $row['password_hash'])) {
            $_SESSION['id_usuario'] = $row['id_usuario'];
            $_SESSION['nombre'] = $row['nombre'];
            $_SESSION['correo'] = $row['correo'];

            $response["success"] = true;
            $response["message"] = "¡Inicio de sesión exitoso!";
        } else {
            $response["message"] = "Credenciales incorrectas.";
        }
    } else {
        $response["message"] = "Credenciales incorrectas.";
    }

} catch (PDOException $e) {
    $response["message"] = "Error en el servidor: " . $e->getMessage();
}

echo json_encode($response);