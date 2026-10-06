<?php
require_once 'config/conexion.php';

try {
    $database = new Database();
    $db = $database->getConnection();

    // 1. Buscar el ID de la categoría 'Cultura'
    $stmtCat = $db->prepare("SELECT id_categoria FROM categorias_destino WHERE nombre_categoria = 'Cultura' LIMIT 1");
    $stmtCat->execute();
    $catId = $stmtCat->fetchColumn();

    if (!$catId) {
        die("Error: Categoría 'Cultura' no encontrada.\n");
    }

    // 2. Insertar el destino
    $nombre = 'Catedral Basílica Nuestra Señora de la Paz';
    $departamento = 'San Miguel, El Salvador';
    $descripcion = 'Una de las catedrales más impresionantes de la región, símbolo de la fe y la arquitectura religiosa en San Miguel.';
    $precio_entrada = 0.00;
    $precio_comida = 5.00;
    $precio_parqueo = 2.00;
    $precio_hospedaje = 0.00;
    $puntaje = 4.8;

    $sql = "INSERT INTO destinos (nombre, departamento, descripcion, id_categoria, precio_entrada, precio_comida, precio_parqueo, precio_hospedaje, puntaje)
            VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)";

    $stmt = $db->prepare($sql);
    $stmt->execute([$nombre, $departamento, $descripcion, $catId, $precio_entrada, $precio_comida, $precio_parqueo, $precio_hospedaje, $puntaje]);

    echo "Destination 'Catedral Basílica Nuestra Señora de la Paz' added successfully!\n";

} catch (Exception $e) {
    echo "Error: " . $e->getMessage() . "\n";
}
?>
