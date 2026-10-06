<?php
require_once 'config/conexion.php';

try {
    $database = new Database();
    $db = $database->getConnection();

    // 1. Identificar las imágenes que queremos conservar (las de El Imposible)
    // Buscamos el ID de El Imposible primero
    $stmtDest = $db->prepare("SELECT id_destino FROM destinos WHERE nombre = 'Parque Nacional El Imposible'");
    $stmtDest->execute();
    $resDest = $stmtDest->fetch(PDO::FETCH_ASSOC);

    if (!$resDest) {
        die("Error: No se encontró el destino 'Parque Nacional El Imposible'\n");
    }
    $idImposible = $resDest['id_destino'];

    echo "Conservando imágenes para el ID: $idImposible (Parque Nacional El Imposible)\n";

    // 2. Eliminar todas las imágenes que NO pertenecen a El Imposible
    // O que tengan URLs externas (que no empiecen con 'assets_img/')
    $stmtDel = $db->prepare("DELETE FROM imagenes_destino WHERE id_destino != :id OR imagen_url NOT LIKE 'assets_img/%'");
    $stmtDel->bindParam(":id", $idImposible);
    $stmtDel->execute();

    echo "Se han eliminado las imágenes obsoletas y links externos.\n";
    echo "Solo se han mantenido las imágenes locales de El Imposible.\n";

} catch (PDOException $e) {
    echo "Error de base de datos: " . $e->getMessage() . "\n";
}
?>
