<?php
header("Content-Type: application/json");
require_once("conexion.php");
try {
$database = new Database();
$db = $database->getConnection();
if ($db) {
http_response_code(200);
echo json_encode([
"success" => true,
"message" => "¡Conexión exitosa a la base de datos '{$database->getDbName()}'!"
]);
}

} catch (PDOException $exception) {
http_response_code(500);
echo json_encode([
"success" => false,
"message" => "Error de conexión a la base de datos.",
"error_details" => $exception->getMessage()
]);
}
?>
