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

if (!$data || !isset($data['EmployeeID'])) {
    http_response_code(400);
    echo json_encode(['error' => 'Employee ID is required.']);
    exit;
}

try {
    $stmt = $pdo->prepare("UPDATE Employee
                           SET HotelID = :hotelID, FullName = :fullName, Address = :address,
                               SSN_SIN = :ssn, Role = :role
                           WHERE EmployeeID = :employeeID");
    $stmt->execute([
        'employeeID' => $data['EmployeeID'],
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