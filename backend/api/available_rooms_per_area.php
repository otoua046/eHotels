<?php
header('Content-Type: application/json');
header("Access-Control-Allow-Origin: *");

include 'db.php';

try {
    $stmt = $pdo->query("SELECT * FROM available_rooms_per_area");
    $data = $stmt->fetchAll(PDO::FETCH_ASSOC);
    echo json_encode($data);
} catch (PDOException $e) {
    http_response_code(500);
    echo json_encode(['error' => $e->getMessage()]);
}