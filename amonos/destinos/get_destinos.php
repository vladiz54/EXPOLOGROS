<?php
header("Access-Control-Allow-Origin: *");
header("Content-Type: application/json; charset=UTF-8");

// Incluimos tu configuración de conexión
require_once "../config/conexion.php";

$id_destino = isset($_GET['id']) ? intval($_GET['id']) : 0;

if ($id_destino <= 0) {
    http_response_code(400);
    echo json_encode(["error" => "ID de destino inválido"]);
    exit();
}

try {
    // Instanciar base de datos y obtener conexión PDO
    $database = new Database();
    $db = $database->getConnection();

    // 1. Obtener datos principales del destino
    $queryDestino = "SELECT * FROM destinos WHERE id_destino = :id_destino";
    $stmt = $db->prepare($queryDestino);
    $stmt->bindParam(":id_destino", $id_destino, PDO::PARAM_INT);
    $stmt->execute();

    if ($stmt->rowCount() === 0) {
        http_response_code(404);
        echo json_encode(["error" => "Destino no encontrado"]);
        exit();
    }

    $destino = $stmt->fetch(PDO::FETCH_ASSOC);

    // 2. Obtener imágenes
    $queryImg = "SELECT imagen_url FROM imagenes_destino WHERE id_destino = :id_destino";
    $stmtImg = $db->prepare($queryImg);
    $stmtImg->bindParam(":id_destino", $id_destino, PDO::PARAM_INT);
    $stmtImg->execute();
    $imagenes = $stmtImg->fetchAll(PDO::FETCH_COLUMN);

    // 3. Obtener actividades
    $queryAct = "SELECT nombre FROM actividades WHERE id_destino = :id_destino";
    $stmtAct = $db->prepare($queryAct);
    $stmtAct->bindParam(":id_destino", $id_destino, PDO::PARAM_INT);
    $stmtAct->execute();
    $actividades = $stmtAct->fetchAll(PDO::FETCH_COLUMN);

    // 4. Obtener reseñas con nombre de usuario
    $queryResenas = "SELECT r.puntuacion, r.comentario, u.nombre AS usuario 
                     FROM resenas r 
                     JOIN usuarios u ON r.id_usuario = u.id_usuario 
                     WHERE r.id_destino = :id_destino
                     ORDER BY r.fecha DESC";
    $stmtResenas = $db->prepare($queryResenas);
    $stmtResenas->bindParam(":id_destino", $id_destino, PDO::PARAM_INT);
    $stmtResenas->execute();
    $resenas = $stmtResenas->fetchAll(PDO::FETCH_ASSOC);

    // Respuesta estructurada JSON
    echo json_encode([
        "id" => (int)$destino['id_destino'],
        "nombre" => $destino['nombre'],
        "departamento" => $destino['departamento'],
        "descripcion" => $destino['descripcion'],
        "costos" => [
            "transporte" => 5.00, // Valor base estimado de transporte
            "comida" => (float)($destino['precio_comida'] ?? 0),
            "entradas" => (float)($destino['precio_entrada'] ?? 0),
            "parqueo" => (float)($destino['precio_parqueo'] ?? 0),
            "hospedaje" => (float)($destino['precio_hospedaje'] ?? 0)
        ],
        "imagenes" => $imagenes,
        "actividades" => $actividades,
        "resenas" => $resenas
    ]);

} catch (PDOException $e) {
    http_response_code(500);
    echo json_encode(["error" => "Error en el servidor: " . $e->getMessage()]);
}
?>