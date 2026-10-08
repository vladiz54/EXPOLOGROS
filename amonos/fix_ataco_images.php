<?php
require_once "config/conexion.php";
try {
    $database = new Database();
    $db = $database->getConnection();

    // 1. Find destination ID using a LIKE query just in case there are trailing spaces
    $queryId = "SELECT id_destino FROM destinos WHERE nombre LIKE :nombre";
    $stmtId = $db->prepare($queryId);
    $stmtId->bindParam(":nombre", "%Concepción de Ataco%");
    $stmtId->execute();
    $idDestino = $stmtId->fetchColumn();

    if (!$idDestino) {
        echo "ERROR: Destination not found.\n";
        exit();
    }

    // 2. Image list
    $images = [
        "assets_img/destinos/ataco1.webp",
        "assets_img/destinos/ataco2.webp",
        "assets_img/destinos/ataco3.webp",
        "assets_img/destinos/ataco4.webp",
        "assets_img/destinos/ataco5.webp"
    ];

    // 3. Clear old images
    $del = $db->prepare("DELETE FROM imagenes_destino WHERE id_destino = ?");
    $del->execute([$idDestino]);

    // 4. Insert images
    $ins = $db->prepare("INSERT INTO imagenes_destino (id_destino, imagen_url, orden) VALUES (?, ?, ?)");
    foreach ($images as $index => $url) {
        $ins->execute([$idDestino, $url, $index + 1]);
    }

    echo "SUCCESS: Images added to ID " . $idDestino;
} catch (Exception $e) {
    echo "ERROR: " . $e->getMessage();
}
?>
