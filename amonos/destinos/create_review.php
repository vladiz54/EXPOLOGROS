<?php
header("Content-Type: application/json; charset=UTF-8");
header("Access-Control-Allow-Origin: *");
header("Access-Control-Allow-Methods: POST");
header("Access-Control-Allow-Headers: Content-Type");

// Start session to access user data
session_start();
require_once("../config/conexion.php");

// Check if user is logged in - matching the session key 'id_usuario' found in session.php
if (!isset($_SESSION['id_usuario'])) {
    http_response_code(401);
    echo json_encode(["success" => false, "message" => "You must be logged in to post a review."]);
    exit();
}

$data = json_decode(file_get_contents("php://input"), true);

$id_destino = isset($data['id_destino']) ? intval($data['id_destino']) : 0;
$puntuacion = isset($data['puntuacion']) ? intval($data['puntuacion']) : 0;
$comentario = isset($data['comentario']) ? trim($data['comentario']) : "";
$id_usuario = $_SESSION['id_usuario'];

if ($id_destino <= 0 || $puntuacion < 1 || $puntuacion > 5 || empty($comentario)) {
    http_response_code(400);
    echo json_encode(["success" => false, "message" => "Please provide a valid rating and comment."]);
    exit();
}

try {
    $database = new Database();
    $db = $database->getConnection();

    // Check if user already reviewed this destination (Optional: prevent multiple reviews)
    $checkQuery = "SELECT id_resena FROM resenas WHERE id_destino = :id_dest AND id_usuario = :id_user";
    $checkStmt = $db->prepare($checkQuery);
    $checkStmt->bindParam(":id_dest", $id_destino, PDO::PARAM_INT);
    $checkStmt->bindParam(":id_user", $id_usuario, PDO::PARAM_INT);
    $checkStmt->execute();

    if ($checkStmt->fetch()) {
        http_response_code(400);
        echo json_encode(["success" => false, "message" => "You have already reviewed this destination."]);
        exit();
    }

    $query = "INSERT INTO resenas (id_destino, id_usuario, puntuacion, comentario, fecha)
              VALUES (:id_dest, :id_user, :puntuacion, :comentario, NOW())";

    $stmt = $db->prepare($query);
    $stmt->bindParam(":id_dest", $id_destino, PDO::PARAM_INT);
    $stmt->bindParam(":id_user", $id_usuario, PDO::PARAM_INT);
    $stmt->bindParam(":puntuacion", $puntuacion, PDO::PARAM_INT);
    $stmt->bindParam(":comentario", $comentario, PDO::PARAM_STR);

    if ($stmt->execute()) {
        echo json_encode(["success" => true, "message" => "Review posted successfully!"]);
    } else {
        throw new Exception("Failed to insert review.");
    }

} catch (Exception $e) {
    http_response_code(500);
    echo json_encode(["success" => false, "message" => "Server error: " . $e->getMessage()]);
}
?>
