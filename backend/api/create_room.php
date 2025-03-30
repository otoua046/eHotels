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

if (!$data || !isset($data['HotelID'], $data['RoomNumber'], $data['Price'], $data['Amenities'], $data['Capacity'], $data['ViewType'], $data['CanBeExtended'], $data['HasDamage'], $data['ProblemDescription'])) {
    http_response_code(400);
    echo json_encode(['error' => 'Invalid input.']);
    exit;
}

try {
    $stmt = $pdo->prepare("INSERT INTO Room (HotelID, RoomNumber, Price, Amenities, Capacity, ViewType, CanBeExtended, HasDamage, ProblemDescription)
                           VALUES (:hotelID, :roomNumber, :price, :amenities, :capacity, :viewType, :canBeExtended, :hasDamage, :problemDescription)");
    $stmt->execute([
        'hotelID' => $data['HotelID'],
        'roomNumber' => $data['RoomNumber'],
        'price' => $data['Price'],
        'amenities' => $data['Amenities'],
        'capacity' => $data['Capacity'],
        'viewType' => $data['ViewType'],
        'canBeExtended' => $data['CanBeExtended'],
        'hasDamage' => $data['HasDamage'],
        'problemDescription' => $data['ProblemDescription'],
        
    ]);
    echo json_encode(['success' => true]);
} catch (PDOException $e) {
    http_response_code(500);
    echo json_encode(['error' => $e->getMessage()]);
}