<?php
header('Content-Type: application/json');
header("Access-Control-Allow-Origin: *");
header("Access-Control-Allow-Methods: POST, OPTIONS");
header("Access-Control-Allow-Headers: Content-Type");

// Handle preflight OPTIONS request
if ($_SERVER['REQUEST_METHOD'] === 'OPTIONS') {
    http_response_code(200);
    exit();
}
include 'db.php';

$data = json_decode(file_get_contents("php://input"), true);

if (!$data || !isset($data['HotelID'], $data['FullName'], $data['Address'], $data['SSN_SIN'], $data['Role'])) {
    http_response_code(400);
    echo json_encode(['error' => 'Invalid input.']);
    exit;
}

try {
    $stmt = $pdo->prepare("INSERT INTO Employee (HotelID, FullName, Address, SSN_SIN, Role)
                           VALUES (:hotelID, :fullName, :address, :ssn, :role)");
    $stmt->execute([
        'hotelID' => $data['HotelID'],
        'fullName' => $data['FullName'],
        'address' => $data['Address'],
        'ssn' => $data['SSN_SIN'],
        'role' => $data['Role']
    ]);
    echo json_encode(['success' => true]);
} catch (PDOException $e) {
    http_response_code(500);
    echo json_encode(['error' => $e->getMessage()]);
}