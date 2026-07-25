<?php
// api/obtener_posts.php

// Configuración de cabeceras para JSON y CORS
header('Content-Type: application/json; charset=utf-8');
header('Access-Control-Allow-Origin: *');
require_once '../config/conexion.php';

// Parámetros opcionales para filtrado directo desde PHP
$categoria = isset($_GET['categoria']) ? trim($_GET['categoria']) : 'todos';
$busqueda  = isset($_GET['buscar']) ? trim($_GET['buscar']) : '';

// Consulta base con JOIN a categorías e imágenes
$sql = "
    SELECT 
        d.id_destino AS id,
        d.nombre,
        d.descripcion,
        d.departamento,
        d.direccion,
        d.precio_entrada,
        d.precio_comida,
        d.puntaje,
        d.tipo_visitante,
        c.nombre_categoria AS categoria,
        (
            SELECT imagen_url 
            FROM imagenes_destino img 
            WHERE img.id_destino = d.id_destino 
            LIMIT 1
        ) AS imagen
    FROM destinos d
    INNER JOIN categorias_destino c ON d.id_categoria = c.id_categoria
    WHERE 1=1
";

$params = [];

if ($categoria !== 'todos' && !empty($categoria)) {
    $sql .= " AND LOWER(c.nombre_categoria) = :categoria";
    $params[':categoria'] = strtolower($categoria);
}

if (!empty($busqueda)) {
    $sql .= " AND (LOWER(d.nombre) LIKE :busqueda OR LOWER(d.departamento) LIKE :busqueda)";
    $params[':busqueda'] = '%' . strtolower($busqueda) . '%';
}

$sql .= " ORDER BY d.id_destino DESC";

try {
    $stmt = $pdo->prepare($sql);
    $stmt->execute($params);
    $destinos = $stmt->fetchAll();

    // Formatear los datos para adaptarlos exactamente a lo que espera la vista
    $destinosFormateados = array_map(function($d) {
        // Formato para la ubicación
        $ubicacion = $d['departamento'];
        if (!empty($d['direccion'])) {
            $ubicacion .= ' — ' . $d['direccion'];
        }

        // Formato para el precio estimado
        $precioMin = (float) $d['precio_entrada'];
        $precioMax = $precioMin + (float) $d['precio_comida'];
        $precioTexto = ($precioMax > 0) ? "\$" . number_format($precioMin, 2) . " - \$" . number_format($precioMax, 2) : "Gratis";

        // Mapear el rango de presupuesto
        $presupuesto = 'economico';
        if ($precioMax > 50) {
            $presupuesto = 'premium';
        } elseif ($precioMax >= 20) {
            $presupuesto = 'conforme';
        }

        return [
            'id'           => $d['id'],
            'nombre'       => $d['nombre'],
            'ubicacion'    => $ubicacion,
            'tags'         => ucfirst($d['tipo_visitante']),
            'descripcion'  => $d['descripcion'] ?? 'Sin descripción disponible.',
            'precioTexto'  => $precioTexto,
            'rating'       => '⭐ ' . number_format((float)($d['puntaje'] ?? 4.5), 1),
            'imagen'       => $d['imagen'] ?? 'https://via.placeholder.com/600x400?text=Sin+Imagen',
            'categoria'    => strtolower($d['categoria']),
            'presupuesto'  => $presupuesto
        ];
    }, $destinos);

    echo json_encode([
        'status' => 'success',
        'data'   => $destinosFormateados
    ]);

} catch (PDOException $e) {
    echo json_encode([
        'status'  => 'error',
        'message' => 'Error al consultar destinos: ' . $e->getMessage()
    ]);
}
?>

