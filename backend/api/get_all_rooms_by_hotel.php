<?php
header('Content-Type: application/json');
header("Access-Control-Allow-Origin: *");


include 'db.php';

$hotelName = $_GET['hotel_name'] ?? null;

$query = "
    SELECT * FROM Room r
    JOIN Hotel h ON r.HotelId = h.HotelId
    WHERE 1 = 1

";

$params = [];

if ($hotelName) {
    $query .= " AND h.Hotelname = :hotel_name";
    $params['hotel_name'] = $hotelName;
}

try {
    $stmt = $pdo->prepare($query);
    $stmt->execute($params);
    $rooms = $stmt->fetchAll();
    echo json_encode($rooms);
} catch (PDOException $e) {
    http_response_code(500);
    echo json_encode(["error" => $e->getMessage()]);
}

