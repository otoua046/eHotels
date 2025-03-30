<?php
header('Content-Type: application/json');
header("Access-Control-Allow-Origin: *");

include 'db.php';

try {
    $stmt = $pdo->query("
        SELECT e.*, h.HotelName
        FROM Employee e
        JOIN Hotel h ON e.HotelID = h.HotelID
        ORDER BY EmployeeID
    ");
    $employees = $stmt->fetchAll();
    echo json_encode($employees);
} catch (PDOException $e) {
    http_response_code(500);
    echo json_encode(['error' => $e->getMessage()]);
}