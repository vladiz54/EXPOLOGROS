<?php
require_once 'config/conexion.php';

$destino_nombre = "Mercados Gastronómicos de San Miguel";
$imagenes = [
    'assets_img/destinos/mercado-san-1.webp',
    'assets_img/destinos/mercado-san-2.webp',
    'assets_img/destinos/mercado-san-3.webp',
    'assets_img/destinos/mercado-san-4.webp',
    'assets_img/destinos/mercado-san-5.webp'
];

try {
    $database = new Database();
    $db = $database->getConnection();

    // 1. Buscar el ID del destino
    $stmt = $db->prepare("SELECT id_destino FROM destinos WHERE nombre = :nombre");
    $stmt->bindParam(":nombre", $destino_nombre);
    $stmt->execute();
    $res = $stmt->fetch(PDO::FETCH_ASSOC);

    if (!$res) {
        die("Error: No se encontró el destino '$destino_nombre'\n");
    }

    $id_destino = $res['id_destino'];
    echo "Destino encontrado: $destino_nombre (ID: $id_destino)\n";

    // 2. Limpiar imágenes anteriores para evitar duplicados y asegurar el orden
    $stmtDel = $db->prepare("DELETE FROM imagenes_destino WHERE id_destino = :id");
    $stmtDel->bindParam(":id", $id_destino);
    $stmtDel->execute();

    // 3. Insertar las imágenes en el orden correcto
    $stmtIns = $db->prepare("INSERT INTO imagenes_destino (id_destino, imagen_url) VALUES (:id, :url)");

    foreach ($imagenes as $url) {
        $stmtIns->bindParam(":id", $id_destino);
        $stmtIns->bindParam(":url", $url);
        $stmtIns->execute();
        echo "Imagen agregada: $url\n";
    }

    echo "Proceso completado con éxito. La imagen 1 es la portada.\n";

} catch (PDOException $e) {
    echo "Error de base de datos: " . $e->getMessage() . "\n";
}
?>
