<?php
header('Content-Type: application/json');
header("Access-Control-Allow-Origin: *");

include 'db.php';

try {
    $stmt = $pdo->query("SELECT DISTINCT ChainName, ChainID FROM HotelChain ORDER BY ChainID");
    $chains = $stmt->fetchAll();
    echo json_encode($chains);
} catch (PDOException $e) {
    http_response_code(500);
    echo json_encode(["error" => $e->getMessage()]);
}