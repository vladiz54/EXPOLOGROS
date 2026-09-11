<?php
header("Content-Type: application/json; charset=UTF-8");
header("Access-Control-Allow-Origin: *");

require_once("../config/conexion.php");

$id_destino = isset($_GET['id']) ? intval($_GET['id']) : 0;

if ($id_destino <= 0) {
    http_response_code(400);
    echo json_encode(["success" => false, "message" => "ID de destino inválido"]);
    exit();
}

try {
    $database = new Database();
    $db = $database->getConnection();

    $queryDestino = "SELECT d.id_destino, d.nombre, d.departamento, d.descripcion, d.precio_entrada, d.precio_comida, d.precio_parqueo, d.precio_hospedaje
                    FROM destinos d
                    WHERE d.id_destino = :id";
    $stmt = $db->prepare($queryDestino);
    $stmt->bindParam(":id", $id_destino, PDO::PARAM_INT);
    $stmt->execute();
    $destino = $stmt->fetch(PDO::FETCH_ASSOC);

    if (!$destino) {
        http_response_code(404);
        echo json_encode(["success" => false, "message" => "Destino no encontrado"]);
        exit();
    }

    $queryImg = "SELECT imagen_url FROM imagenes_destino WHERE id_destino = :id";
    $stmtImg = $db->prepare($queryImg);
    $stmtImg->bindParam(":id", $id_destino, PDO::PARAM_INT);
    $stmtImg->execute();
    $imagenes = $stmtImg->fetchAll(PDO::FETCH_COLUMN);

    $queryAct = "SELECT nombre FROM actividades WHERE id_destino = :id";
    $stmtAct = $db->prepare($queryAct);
    $stmtAct->bindParam(":id", $id_destino, PDO::PARAM_INT);
    $stmtAct->execute();
    $actividades = $stmtAct->fetchAll(PDO::FETCH_COLUMN);

    $queryResenas = "SELECT r.puntuacion, r.comentario, u.nombre AS usuario
                     FROM resenas r
                     JOIN usuarios u ON r.id_usuario = u.id_usuario
                     WHERE r.id_destino = :id
                     ORDER BY r.fecha DESC";
    $stmtResenas = $db->prepare($queryResenas);
    $stmtResenas->bindParam(":id", $id_destino, PDO::PARAM_INT);
    $stmtResenas->execute();
    $resenas = $stmtResenas->fetchAll(PDO::FETCH_ASSOC);

    echo json_encode([
        "success" => true,
        "data" => [
            "id" => (int)$destino['id_destino'],
            "nombre" => $destino['nombre'],
            "departamento" => $destino['departamento'],
            "descripcion" => $destino['descripcion'],
            "costos" => [
                "entrada" => (float)$destino['precio_entrada'],
                "comida" => (float)$destino['precio_comida'],
                "parqueo" => (float)$destino['precio_parqueo'],
                "hospedaje" => (float)$destino['precio_hospedaje']
            ],
            "imagenes" => $imagenes,
            "actividades" => $actividades,
            "resenas" => $resenas
        ]
    ]);

} catch (PDOException $e) {
    http_response_code(500);
    echo json_encode(["success" => false, "message" => "Error en el servidor: " . $e->getMessage()]);
}
?>
