<?php
header('Content-Type: application/json');
header("Access-Control-Allow-Origin: *");
header("Access-Control-Allow-Methods: POST");
header("Access-Control-Allow-Headers: Content-Type");

include 'db.php';

$data = json_decode(file_get_contents('php://input'), true);

// Handle preflight OPTIONS request
if ($_SERVER['REQUEST_METHOD'] === 'OPTIONS') {
    http_response_code(200);
    exit();
}

$roomId = $data['roomId'] ?? null;
$employeeId = $data['employeeId'] ?? null;
$customerId = $data['customerId'] ?? null;
$checkIn = $data['checkInDate'] ?? null;
$checkOut = $data['checkOutDate'] ?? null;
$creditCard = $data['creditCard'] ?? null;

if (!$roomId || !$employeeId || !$customerId || !$checkIn || !$checkOut) {
    http_response_code(400);
    echo json_encode(['error' => 'Missing required fields']);
    exit;
}

try {
    // Step 1: Create a new booking for this renting
    $bookingStmt = $pdo->prepare("
        INSERT INTO Booking (RoomID, CustomerID, StartDate, EndDate)
        VALUES (:roomId, :customerId, :startDate, :endDate)
    ");
    $bookingStmt->execute([
        ':roomId' => $roomId,
        ':customerId' => $customerId,
        ':startDate' => $checkIn,
        ':endDate' => $checkOut
    ]);

    $newBookingId = $pdo->lastInsertId();

    // Step 2: Insert into Renting using that booking
    $rentingStmt = $pdo->prepare("
        INSERT INTO Renting (RoomID, BookingID, EmployeeID, CustomerID, CheckInDate, CheckOutDate, PaymentStatus)
        VALUES (:roomId, :bookingId, :employeeId, :customerId, :checkIn, :checkOut, :paymentStatus)
    ");
    $rentingStmt->execute([
        ':roomId' => $roomId,
        ':bookingId' => $newBookingId,
        ':employeeId' => $employeeId,
        ':customerId' => $customerId,
        ':checkIn' => $checkIn,
        ':checkOut' => $checkOut,
        ':paymentStatus' => $creditCard ? 'Paid' : 'Unpaid'
    ]);

    echo json_encode(['success' => true]);

} catch (PDOException $e) {
    http_response_code(500);
    echo json_encode(['error' => $e->getMessage()]);
}