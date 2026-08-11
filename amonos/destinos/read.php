<?php
header("Content-Type: application/json; charset=UTF-8");
header("Access-Control-Allow-Methods: GET");

require_once("../config/conexion.php");

session_start();
$id_usuario = isset($_SESSION['id_usuario']) ? (int)$_SESSION['id_usuario'] : 0;

$response = [
    "success" => false,
    "data" => []
];

// Obtener parámetros de búsqueda y filtro
$q = isset($_GET['q']) ? trim($_GET['q']) : '';
$departamento = isset($_GET['departamento']) ? trim($_GET['departamento']) : '';
$id_categoria = isset($_GET['id_categoria']) ? (int)$_GET['id_categoria'] : 0;
$id_destino = isset($_GET['id_destino']) ? (int)$_GET['id_destino'] : 0;

try {
    $database = new Database();
    $db = $database->getConnection();

    $query = "SELECT d.id_destino, d.id_categoria, d.nombre, d.descripcion, d.departamento, 
                     d.direccion, d.precio_entrada, d.puntaje,
                     (SELECT imagen_url FROM imagenes_destino img WHERE img.id_destino = d.id_destino LIMIT 1) AS imagen_url,
                     (SELECT COUNT(*) FROM resenas r WHERE r.id_destino = d.id_destino) AS total_resenas,
                     EXISTS(SELECT 1 FROM favoritos f WHERE f.id_destino = d.id_destino AND f.id_usuario = :id_usuario_fav) AS es_favorito
              FROM destinos d
              WHERE 1=1";

    $params = [
        ":id_usuario_fav" => $id_usuario
    ];

    if ($id_destino > 0) {
        $query .= " AND d.id_destino = :id_destino";
        $params[":id_destino"] = $id_destino;
    }

    if (!empty($q)) {
        $query .= " AND (d.nombre LIKE :q OR d.descripcion LIKE :q OR d.departamento LIKE :q)";
        $params[":q"] = "%" . $q . "%";
    }

    if (!empty($departamento) && $departamento !== "Todos") {
        $query .= " AND d.departamento = :departamento";
        $params[":departamento"] = $departamento;
    }

    if ($id_categoria > 0) {
        $query .= " AND d.id_categoria = :id_categoria";
        $params[":id_categoria"] = $id_categoria;
    }

    $query .= " ORDER BY d.puntaje DESC, d.id_destino DESC";

    $stmt = $db->prepare($query);

    foreach ($params as $key => $val) {
        if (is_int($val)) {
            $stmt->bindValue($key, $val, PDO::PARAM_INT);
        } else {
            $stmt->bindValue($key, $val, PDO::PARAM_STR);
        }
    }

    $stmt->execute();
    $destinos = $stmt->fetchAll(PDO::FETCH_ASSOC);

    $response["success"] = true;
    $response["data"] = $destinos;

} catch (PDOException $e) {
    $response["message"] = "Error al consultar destinos: " . $e->getMessage();
}

echo json_encode($response);

