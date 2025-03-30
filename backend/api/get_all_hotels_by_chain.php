<?php
header('Content-Type: application/json');
header("Access-Control-Allow-Origin: *");


include 'db.php';

$hotelChain = $_GET['hotel_chain'] ?? null;

$query = "
    SELECT h.HotelName FROM Hotel h
    JOIN HotelChain c ON h.ChainID = c.ChainID
    WHERE 1 = 1



";

$params = [];

if ($hotelChain) {
    $query .= " AND c.ChainName = :hotel_chain";
    $params['hotel_chain'] = $hotelChain;
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

