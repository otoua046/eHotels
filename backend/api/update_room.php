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

if (!$data || !isset($data['RoomID'])) {
    http_response_code(400);
    echo json_encode(['error' => 'Room ID is required.']);
    exit;
}

try {
    $stmt = $pdo->prepare("UPDATE Room
    SET HotelID = :hotelID, 
        RoomNumber = :roomNumber, 
        Price = :price,
        Amenities = :amenities, 
        Capacity = :capacity, 
        ViewType = :viewType,
        CanBeExtended = :canBeExtended, 
        HasDamage = :hasDamage,
        ProblemDescription = :problemDescription
    WHERE RoomID = :roomID");
    
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
        'roomID' => $data['RoomID']
    ]);
    echo json_encode(['success' => true]);
} catch (PDOException $e) {
    http_response_code(500);
    echo json_encode(['error' => $e->getMessage()]);
}