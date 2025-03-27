<?php
header('Content-Type: application/json');
include 'db.php'

// sample query - will customize later
$stmt = $pdo->query("SELECT * FROM Room LIMIT 10");
$rooms = $stmt->fetchAll();
echo json_encode($rooms);
?>
