<?php
require_once 'config/conexion.php';

$destino_nombre = "Catedral Basílica Nuestra Señora de la Paz";
$imagenes = [
    'assets_img/destinos/catedral-basilica-1.webp',
    'assets_img/destinos/catedral-basilica-2.webp',
    'assets_img/destinos/catedral-basilica-3.webp',
    'assets_img/destinos/catedral-basilica-4.webp',
    'assets_img/destinos/catedral-basilica-5.webp'
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

    // 2. Insertar las imágenes
    $stmtIns = $db->prepare("INSERT INTO imagenes_destino (id_destino, imagen_url) VALUES (:id, :url)");

    foreach ($imagenes as $url) {
        $stmtIns->bindParam(":id", $id_destino);
        $stmtIns->bindParam(":url", $url);
        $stmtIns->execute();
        echo "Imagen agregada: $url\n";
    }

    echo "Proceso completado con éxito.\n";

} catch (PDOException $e) {
    echo "Error de base de datos: " . $e->getMessage() . "\n";
}
?>
