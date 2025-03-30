<?php
header('Content-Type: application/json');
header("Access-Control-Allow-Origin: *");

include 'db.php';

$employeeId = $_POST['EmployeeID'] ?? null;

if (!$employeeId) {
    http_response_code(400);
    echo json_encode(['error' => 'Employee ID is required.']);
    exit;
}

try {
    $stmt = $pdo->prepare("DELETE FROM Employee WHERE EmployeeID = :id");
    $stmt->execute(['id' => $employeeId]);

    echo json_encode(['success' => true]);
} catch (PDOException $e) {
    http_response_code(500);
    echo json_encode(['error' => $e->getMessage()]);
}