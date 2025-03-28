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

$bookingId = $data['bookingId'] ?? null;
$creditCard = $data['creditCard'] ?? null;
$employeeId = $data['employeeId'] ?? null;
$roomId = $data['roomId'] ?? null;
$customerId = $data['customerId'] ?? null;

if (!$bookingId) {
    http_response_code(400);
    echo json_encode(["error" => "Missing bookingId."]);
    exit;
}

try {
    // Step 1: Update Booking status
    $updateStmt = $pdo->prepare("UPDATE Booking SET Status = 'Rented' WHERE BookingID = :bookingId");
    $updateStmt->execute([':bookingId' => $bookingId]);

    // Step 2: Fetch Booking info (StartDate, EndDate, RoomID, CustomerID)
    $infoStmt = $pdo->prepare("SELECT * FROM Booking WHERE BookingID = :bookingId");
    $infoStmt->execute([':bookingId' => $bookingId]);
    $booking = $infoStmt->fetch();

    if (!$booking) {
        http_response_code(404);
        echo json_encode(["error" => "Booking not found."]);
        exit;
    }

    // Step 3: Insert into Renting
    $insertStmt = $pdo->prepare("
    INSERT INTO Renting (RoomID, BookingID, EmployeeID, CustomerID, CheckInDate, CheckOutDate, PaymentStatus)
    VALUES (:roomId, :bookingId, :employeeId, :customerId, :checkIn, :checkOut, :paymentStatus)
    ");
    $insertStmt->execute([
        ':roomId' => $roomId,
        ':bookingId' => $bookingId,
        ':employeeId' => $employeeId,
        ':customerId' => $customerId,
        ':checkIn' => $booking['StartDate'],
        ':checkOut' => $booking['EndDate'],
        ':paymentStatus' => $creditCard ? 'Paid' : 'Unpaid'
    ]);

    echo json_encode(["success" => true]);

} catch (PDOException $e) {
    http_response_code(500);
    echo json_encode(["error" => $e->getMessage()]);
}