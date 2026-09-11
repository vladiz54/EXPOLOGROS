<?php
header("Content-Type: application/json; charset=UTF-8");
header("Access-Control-Allow-Origin: *");

require_once("../config/conexion.php");

try {
    $database = new Database();
    $db = $database->getConnection();

    $categoria = isset($_GET['categoria']) ? trim($_GET['categoria']) : 'Todos';
    $departamento = isset($_GET['departamento']) ? trim($_GET['departamento']) : 'Todos';

    $query = "SELECT d.id_destino AS id,
                     d.nombre,
                     d.departamento AS ubicacion,
                     d.precio_entrada AS precio,
                     d.puntaje AS rating,
                     c.nombre_categoria AS categoria,
                     (SELECT imagen_url FROM imagenes_destino img WHERE img.id_destino = d.id_destino LIMIT 1) AS imagen,
                     d.descripcion
              FROM destinos d
              INNER JOIN categorias_destino c ON d.id_categoria = c.id_categoria
              WHERE 1=1";

    $params = [];

    if ($categoria !== 'Todos' && !empty($categoria)) {
        $query .= " AND c.nombre_categoria = :categoria";
        $params[':categoria'] = $categoria;
    }

    if ($departamento !== 'Todos' && !empty($departamento)) {
        $query .= " AND d.departamento = :departamento";
        $params[':departamento'] = $departamento;
    }

    $query .= " ORDER BY d.id_destino DESC";

    $stmt = $db->prepare($query);
    $stmt->execute($params);
    $destinos = $stmt->fetchAll(PDO::FETCH_ASSOC);

    echo json_encode([
        "success" => true,
        "data" => $destinos
    ]);

} catch (PDOException $e) {
    http_response_code(500);
    echo json_encode([
        "success" => false,
        "message" => "Error de base de datos: " . $e->getMessage()
    ]);
}
?>
