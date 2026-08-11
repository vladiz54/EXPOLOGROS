<?php
// 1. Incluir el archivo de conexión (subimos un nivel con ../ para buscar la carpeta config)
require_once '../config/conexion.php';

// 2. Definir la consulta SQL para obtener los destinos
$sql = "SELECT * FROM destinos";
$resultado = $conexion->query($sql);

// 3. Crear un arreglo para guardar los datos
$destinos = array();

if ($resultado && $resultado->num_rows > 0) {
    while ($fila = $resultado->fetch_assoc()) {
        $destinos[] = $fila;
    }
}

// 4. Devolver la respuesta en formato JSON (para que JS lo lea fácilmente)
header('Content-Type: application/json');
echo json_encode($destinos, JSON_UNESCAPED_UNICODE);

// 5. Cerrar la conexión
$conexion->close();
?>


