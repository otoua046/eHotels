<?php
header('Content-Type: application/json');
header("Access-Control-Allow-Origin: *");

include 'db.php';

try {
    $stmt = $pdo->query("
        SELECT 
            r.RentingID,
            r.RoomID,
            r.BookingID,
            r.EmployeeID,
            r.CustomerID,
            c.FullName AS CustomerName,
            r.CheckInDate,
            r.CheckOutDate,
            r.PaymentStatus
        FROM Renting r
        JOIN Customer c ON r.CustomerID = c.CustomerID
    ");

    $rentings = $stmt->fetchAll();
    echo json_encode($rentings);
} catch (PDOException $e) {
    http_response_code(500);
    echo json_encode(['error' => $e->getMessage()]);
}