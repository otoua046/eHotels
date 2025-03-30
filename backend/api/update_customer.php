<?php
header('Content-Type: application/json');
header("Access-Control-Allow-Origin: *");
header("Access-Control-Allow-Methods: POST, OPTIONS");
header("Access-Control-Allow-Headers: Content-Type");

if ($_SERVER['REQUEST_METHOD'] === 'OPTIONS') {
    http_response_code(200);
    exit;
}

include 'db.php';

// Get the raw POST data and decode it
$data = json_decode(file_get_contents('php://input'), true);


if (!isset($data['CustomerID'], $data['FullName'], $data['Address'], $data['IDType'])) {
    http_response_code(400);
    echo json_encode(['error' => 'Missing required customer fields.']);
    exit;
}

try {
    $stmt = $pdo->prepare("
        UPDATE Customer 
        SET FullName = :fullName, Address = :address, IDType = :idType
        WHERE CustomerID = :customerID
    ");
    $stmt->execute([
        'fullName' => $data['FullName'],
        'address' => $data['Address'],
        'idType' => $data['IDType'],
        'customerID' => $data['CustomerID']
    ]);

    echo json_encode(['success' => true]);
} catch (PDOException $e) {
    http_response_code(500);
    echo json_encode(['error' => $e->getMessage()]);
}