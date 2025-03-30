<?php
header('Content-Type: application/json');
header("Access-Control-Allow-Origin: *");
header("Access-Control-Allow-Methods: POST");
header("Access-Control-Allow-Headers: Content-Type");

// Handle preflight OPTIONS request
if ($_SERVER['REQUEST_METHOD'] === 'OPTIONS') {
    http_response_code(200);
    exit();
}

include 'db.php';

$data = json_decode(file_get_contents('php://input'), true);

$name = $data['FullName'] ?? null;
$address = $data['Address'] ?? null;
$idType = $data['IDType'] ?? null;

if (!$name || !$address || !$idType) {
    http_response_code(400);
    echo json_encode(['error' => 'Missing required fields.']);
    exit;
}

try {
    $stmt = $pdo->prepare("INSERT INTO Customer (FullName, Address, IDType, RegistrationDate) VALUES (:name, :address, :idType, CURDATE())");
    $stmt->execute([
        ':name' => $name,
        ':address' => $address,
        ':idType' => $idType
    ]);

    $customerID = $pdo->lastInsertId(); 

    echo json_encode([
        'success' => true,
        'customerID' => $customerID
    ]);
} catch (PDOException $e) {
    http_response_code(500);
    echo json_encode(['error' => $e->getMessage()]);
}