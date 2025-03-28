<?php
header('Content-Type: application/json');
header("Access-Control-Allow-Origin: *");
header("Access-Control-Allow-Methods: POST, OPTIONS");
header("Access-Control-Allow-Headers: Content-Type");

// Handle preflight request
if ($_SERVER['REQUEST_METHOD'] === 'OPTIONS') {
    http_response_code(200);
    exit();
}

include 'db.php';

$data = json_decode(file_get_contents("php://input"), true);

$roomId = $data['roomId'] ?? null;
$startDate = $data['startDate'] ?? null;
$endDate = $data['endDate'] ?? null;
$customerId = $data['customerId'] ?? null;

if (!$roomId || !$startDate || !$endDate || !$customerId) {
    echo json_encode(["error" => "Missing required fields"]);
    exit;
}

try {
    $stmt = $pdo->prepare("
        INSERT INTO Booking (CustomerID, RoomID, StartDate, EndDate, Status)
        VALUES (:customerId, :roomId, :startDate, :endDate, 'Booked')
    ");
    $stmt->execute([
        'customerId' => $customerId,
        'roomId' => $roomId,
        'startDate' => $startDate,
        'endDate' => $endDate
    ]);

    echo json_encode([
        "success" => true,
        "bookingId" => $pdo->lastInsertId()
    ]);
} catch (PDOException $e) {
    http_response_code(500);
    echo json_encode(["error" => $e->getMessage()]);
}