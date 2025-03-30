<?php
header('Content-Type: application/json');
header("Access-Control-Allow-Origin: *");

include 'db.php';

$hotelId = $_POST['HotelID'] ?? null;

if (!$hotelId) {
    http_response_code(400);
    echo json_encode(['error' => 'HotelID is required.']);
    exit;
}

try {
    $stmt = $pdo->prepare("DELETE FROM Hotel WHERE HotelID = :id");
    $stmt->execute(['id' => $hotelId]);

    echo json_encode(['success' => true]);
} catch (PDOException $e) {
    http_response_code(500);
    echo json_encode(['error' => $e->getMessage()]);
}