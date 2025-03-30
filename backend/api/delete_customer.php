<?php
header('Content-Type: application/json');
header("Access-Control-Allow-Origin: *");

include 'db.php';

$customerId = $_POST['CustomerID'] ?? null;

if (!$customerId) {
    http_response_code(400);
    echo json_encode(['error' => 'Customer ID is required.']);
    exit;
}

try {
    $stmt = $pdo->prepare("DELETE FROM Customer WHERE CustomerID = :id");
    $stmt->execute(['id' => $customerId]);

    echo json_encode(['success' => true]);
} catch (PDOException $e) {
    http_response_code(500);
    echo json_encode(['error' => $e->getMessage()]);
}