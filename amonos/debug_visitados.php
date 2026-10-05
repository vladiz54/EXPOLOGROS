<?php
require_once 'config/conexion.php';

$database = new Database();
$db = $database->getConnection();

try {
    $stmt = $db->query("SELECT * FROM visitados");
    $results = $stmt->fetchAll(PDO::FETCH_ASSOC);
    print_r($results);
} catch (Exception $e) {
    echo "Error: " . $e->getMessage();
}
?>
