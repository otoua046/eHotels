<?php
header("Access-Control-Allow-Origin: *");
header("Access-Control-Allow-Headers: *");
header("Access-Control-Allow-Methods: GET, POST, OPTIONS");
header("Content-Type: application/json");

if ($_SERVER['REQUEST_METHOD'] === 'OPTIONS') {
    http_response_code(200);
    exit();
}

include 'db.php';

$name = $_GET['name'] ?? '';

if (!$name) {
    echo json_encode(["exists" => false]);
    exit;
}

try {
    $stmt = $pdo->prepare("SELECT CustomerID FROM Customer WHERE FullName = :name");
    $stmt->execute(['name' => $name]);
    $customer = $stmt->fetch();

    if ($customer) {
        echo json_encode(["exists" => true, "customerID" => $customer['CustomerID']]);
    } else {
        echo json_encode(["exists" => false]);
    }

} catch (PDOException $e) {
    http_response_code(500);
    echo json_encode(["error" => $e->getMessage()]);
}

file_put_contents('php://stderr', print_r($_POST, true));