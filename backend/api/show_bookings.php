<?php
header('Content-Type: application/json');
header("Access-Control-Allow-Origin: *");

include 'db.php';

try {
    $stmt = $pdo->query("
        SELECT 
            b.BookingID,
            b.CustomerID,
            b.RoomID,
            b.StartDate,
            b.EndDate,
            b.Status,
            c.FullName AS CustomerName,
            r.Price AS RoomPrice,
            r.Capacity,
            r.ViewType
        FROM Booking b
        JOIN Customer c ON b.CustomerID = c.CustomerID
        JOIN Room r ON b.RoomID = r.RoomID
        WHERE b.Status = 'Booked'
    ");
    
    $bookings = $stmt->fetchAll();
    echo json_encode($bookings);

} catch (PDOException $e) {
    http_response_code(500);
    echo json_encode(['error' => $e->getMessage()]);
}