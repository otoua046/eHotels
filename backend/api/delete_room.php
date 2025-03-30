<?php
header('Content-Type: application/json');
header("Access-Control-Allow-Origin: *");

include 'db.php';

$roomId = $_POST['RoomID'] ?? null;

if (!$roomId) {
    http_response_code(400);
    echo json_encode(['error' => 'Room ID is required.']);
    exit;
}

try {
    $stmt = $pdo->prepare("DELETE FROM Room WHERE RoomID = :id");
    $stmt->execute(['id' => $roomId]);

    echo json_encode(['success' => true]);
} catch (PDOException $e) {
    http_response_code(500);
    echo json_encode(['error' => $e->getMessage()]);
}