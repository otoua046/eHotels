<?php
header('Content-Type: application/json');
header("Access-Control-Allow-Origin: *");
header("Access-Control-Allow-Methods: POST");
header("Access-Control-Allow-Headers: Content-Type");

include 'db.php';

$data = json_decode(file_get_contents('php://input'), true);

if (!$data) {
    echo json_encode(["error" => "Empty or invalid JSON", "raw" => file_get_contents('php://input')]);
    exit;
}

$rentingId = $data['rentingId'] ?? null;

if (!$rentingId) {
    http_response_code(400);
    echo json_encode(["error" => "Missing rentingId."]);
    exit;
}

try {
    $stmt = $pdo->prepare("
        UPDATE Renting 
        SET CheckOutDate = CURDATE() 
        WHERE RentingID = :rentingId
    ");
    $stmt->execute([':rentingId' => $rentingId]);

    echo json_encode(["success" => true]);
} catch (PDOException $e) {
    http_response_code(500);
    echo json_encode(["error" => $e->getMessage()]);
}