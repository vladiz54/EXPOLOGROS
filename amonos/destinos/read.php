<?php
header("Content-Type: application/json; charset=UTF-8");

require_once("../config/conexion.php");

try {
    $database = new Database();
    $db = $database->getConnection();

    // Obtener los filtros desde la URL (o asignar valores por defecto)
    $categoria = isset($_GET['categoria']) ? trim($_GET['categoria']) : 'Todos';
    $departamento = isset($_GET['departamento']) ? trim($_GET['departamento']) : 'Todos';

    // Consulta base con JOIN a la tabla de categorías
    $query = "SELECT d.id_destino, d.nombre, d.departamento, d.precio_entrada, d.puntaje, c.nombre_categoria,
                     (SELECT imagen_url FROM imagenes_destino img WHERE img.id_destino = d.id_destino LIMIT 1) AS imagen_url
              FROM destinos d
              INNER JOIN categorias_destino c ON d.id_categoria = c.id_categoria
              WHERE 1=1";

    $params = [];

    // Agregar condición si se selecciona una categoría específica
    if ($categoria !== 'Todos' && !empty($categoria)) {
        $query .= " AND c.nombre_categoria = :categoria";
        $params[':categoria'] = $categoria;
    }

    // Agregar condición si se selecciona un departamento específico
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
    echo json_encode([
        "success" => false,
        "message" => "Error de base de datos: " . $e->getMessage()
    ]);
}