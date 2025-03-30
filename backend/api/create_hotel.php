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

if (!$data || !isset($data['ChainID'], $data['HotelName'], $data['Address'], $data['Email'], $data['PhoneNumber'], $data['Category'])) {
    http_response_code(400);
    echo json_encode(['error' => 'Invalid input.']);
    exit;
}

try {
    $stmt = $pdo->prepare("INSERT INTO Hotel (ChainID, HotelName, Address, Email, PhoneNumber, Category)
                           VALUES (:chainID, :hotelName, :address, :email, :phoneNumber, :category)");
    $stmt->execute([
        'chainID' => $data['ChainID'],
        'hotelName' => $data['HotelName'],
        'address' => $data['Address'],
        'email' => $data['Email'],
        'phoneNumber' => $data['PhoneNumber'],
        'category' => $data['Category']
    ]);
    echo json_encode(['success' => true]);
} catch (PDOException $e) {
    http_response_code(500);
    echo json_encode(['error' => $e->getMessage()]);
}