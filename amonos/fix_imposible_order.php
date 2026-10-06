<?php
require_once 'config/conexion.php';

try {
    $database = new Database();
    $db = $database->getConnection();

    // 1. Verificar si el-imposible-1 ya existe para evitar duplicados
    $stmtCheck = $db->prepare("SELECT id_imagen FROM imagenes_destino WHERE id_destino = 1 AND imagen_url = 'assets_img/destinos/el-imposible-1.webp'");
    $stmtCheck->execute();

    if ($stmtCheck->fetch()) {
        echo "La imagen el-imposible-1 ya existe en la base de datos.\n";
    } else {
        // 2. Agregar la imagen faltante
        $stmtIns = $db->prepare("INSERT INTO imagenes_destino (id_destino, imagen_url) VALUES (1, 'assets_img/destinos/el-imposible-1.webp')");
        $stmtIns->execute();
        echo "Imagen el-imposible-1 agregada con éxito.\n";
    }

    // 3. Re-ordenar: Para que el-imposible-1 sea la primera (portada),
    // la forma más sencilla en esta estructura es asegurar que sea la primera cargada o
    // si la tabla tiene un campo de orden. Como no lo tiene, el sistema toma el primer resultado.
    // Vamos a borrar las imágenes de El Imposible y agregarlas en el orden exacto.

    $db->prepare("DELETE FROM imagenes_destino WHERE id_destino = 1")->execute();

    $orden = [
        'assets_img/destinos/el-imposible-1.webp',
        'assets_img/destinos/el-imposible-2.webp',
        'assets_img/destinos/el-imposible-3.webp',
        'assets_img/destinos/el-imposible-4.webp',
        'assets_img/destinos/el-imposible-5.webp'
    ];

    $stmtIns = $db->prepare("INSERT INTO imagenes_destino (id_destino, imagen_url) VALUES (1, :url)");
    foreach ($orden as $url) {
        $stmtIns->execute([':url' => $url]);
    }

    echo "Imágenes de El Imposible re-ordenadas. La imagen 1 ahora es la portada.\n";

} catch (PDOException $e) {
    echo "Error: " . $e->getMessage() . "\n";
}
?>
