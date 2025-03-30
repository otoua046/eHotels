<?php
header('Content-Type: application/json');
header("Access-Control-Allow-Origin: *");

include 'db.php';



try {
    $stmt = $pdo->query("
        SELECT h.*, c.ChainName
        FROM Hotel h
        JOIN HotelChain c ON h.ChainID = c.ChainID
        ORDER BY HotelID
    ");
    $hotels = $stmt->fetchAll();
    echo json_encode($hotels);
} catch (PDOException $e) {
    http_response_code(500);
    echo json_encode(['error' => $e->getMessage()]);
}