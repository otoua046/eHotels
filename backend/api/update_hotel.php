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

$data = json_decode(file_get_contents("php://input"), true);

if (!$data || !isset($data['HotelID'])) {
    http_response_code(400);
    echo json_encode(['error' => 'Hotel ID is required.']);
    exit;
}

try {
    $stmt = $pdo->prepare("UPDATE Hotel
                           SET ChainID = :chainID, HotelName = :hotelName, Address = :address,
                               Email = :email, PhoneNumber = :phoneNumber, Category =:category
                           WHERE HotelID = :hotelID");
    $stmt->execute([
        'hotelID' => $data['HotelID'],
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