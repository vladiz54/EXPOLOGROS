<?php
header("Content-Type: application/json; charset=UTF-8");
session_start();

require_once("../config/conexion.php");

if (!isset($_SESSION['id_usuario'])) {
    http_response_code(401);
    echo json_encode(["success" => false, "message" => "User not authenticated"]);
    exit();
}

$id_usuario = $_SESSION['id_usuario'];
$nombre = isset($_POST['nombre']) ? trim($_POST['nombre']) : '';
$correo = isset($_POST['correo']) ? trim($_POST['correo']) : '';

if (empty($nombre) || empty($correo)) {
    echo json_encode(["success" => false, "message" => "Name and email are required"]);
    exit();
}

try {
    $database = new Database();
    $db = $database->getConnection();

    // Handle image upload
    $foto_url = null;
    if (isset($_FILES['foto']) && $_FILES['foto']['error'] === UPLOAD_ERR_OK) {
        $fileTmpPath = $_FILES['foto']['tmp_name'];
        $fileName = $_FILES['foto']['name'];
        $fileExtension = strtolower(pathinfo($fileName, PATHINFO_EXTENSION));

        $allowedExtensions = ['jpg', 'jpeg', 'png', 'webp'];
        if (!in_array($fileExtension, $allowedExtensions)) {
            echo json_encode(["success" => false, "message" => "Invalid file format. Only JPG, PNG, and WEBP are allowed."]);
            exit();
        }

        // Unique name for the profile picture: user_id_timestamp.ext
        $newFileName = "profile_" . $id_usuario . "_" . time() . "." . $fileExtension;
        $destPath = "../public/assets_img/profiles/" . $newFileName;

        if (move_uploaded_file($fileTmpPath, $destPath)) {
            $foto_url = "assets_img/profiles/" . $newFileName;
        } else {
            echo json_encode(["success" => false, "message" => "Failed to upload image"]);
            exit();
        }
    }

    // Update user in database
    if ($foto_url) {
        $query = "UPDATE usuarios SET nombre = :nombre, correo = :correo, foto_perfil = :foto WHERE id_usuario = :id";
        $stmt = $db->prepare($query);
        $stmt->execute([
            ":nombre" => $nombre,
            ":correo" => $correo,
            ":foto" => $foto_url,
            ":id" => $id_usuario
        ]);
    } else {
        $query = "UPDATE usuarios SET nombre = :nombre, correo = :correo WHERE id_usuario = :id";
        $stmt = $db->prepare($query);
        $stmt->execute([
            ":nombre" => $nombre,
            ":correo" => $correo,
            ":id" => $id_usuario
        ]);
    }

    echo json_encode(["success" => true, "message" => "Profile updated successfully"]);

} catch (Exception $e) {
    http_response_code(500);
    echo json_encode(["success" => false, "message" => "Server error: " . $e->getMessage()]);
}
?>
