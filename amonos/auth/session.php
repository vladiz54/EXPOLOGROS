<?php
header("Content-Type: application/json; charset=UTF-8");

session_start();

if (isset($_SESSION['id_usuario'])) {
    echo json_encode([
        "logged_in" => true,
        "usuario" => [
            "id_usuario" => $_SESSION['id_usuario'],
            "nombre" => $_SESSION['nombre'],
            "correo" => $_SESSION['correo']
        ]
    ]);
} else {
    echo json_encode([
        "logged_in" => false
    ]);
}