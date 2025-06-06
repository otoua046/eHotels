<?php
header('Content-Type: application/json');
header("Access-Control-Allow-Origin: *");

include 'db.php';

$startDate = $_GET['start_date'] ?? null;
$endDate = $_GET['end_date'] ?? null;
$capacity = $_GET['capacity'] ?? null;
$area = $_GET['area'] ?? null;
$category = $_GET['category'] ?? null;
$minPrice = $_GET['min_price'] ?? null;
$maxPrice = $_GET['max_price'] ?? null;
$view = $_GET['view'] ?? null;
$extendable = $_GET['extendable'] ?? null;
$minAvailableCapacity = $_GET['min_available_capacity'] ?? null;
$hotelChain = $_GET['hotel_chain'] ?? null;

$query = "
    SELECT 
        r.RoomID,
        r.RoomNumber,
        r.Price,
        r.Capacity,
        r.ViewType,
        r.CanBeExtended,
        r.HasDamage,
        r.ProblemDescription,
        r.Amenities,
        h.HotelID,
        h.Address AS HotelAddress,
        h.Email AS HotelEmail,
        h.PhoneNumber AS HotelPhone,
        h.HotelName AS HotelName,
        h.Category,
        c.CentralOfficeAddress,
        ac.AvailableCapacity AS AvailableCapacity
    FROM Room r
    JOIN Hotel h ON r.HotelID = h.HotelID
    JOIN HotelChain c ON h.ChainID = c.ChainID
    JOIN available_capacity_per_hotel ac ON ac.HotelName = h.HotelName
    WHERE 1 = 1
";

$params = [];

if ($startDate && $endDate) {
    $query .= "
        AND r.RoomID NOT IN (
            SELECT b.RoomID FROM Booking b
            WHERE (b.StartDate <= :endDate AND b.EndDate >= :startDate)
            UNION
            SELECT r3.RoomID FROM Renting r3
            WHERE (r3.CheckInDate <= :endDate AND r3.CheckOutDate >= :startDate)
        )
    ";
    $params['startDate'] = $startDate;
    $params['endDate'] = $endDate;
}

if ($area) {
    $query .= " AND h.Address LIKE :area";
    $params['area'] = '%' . $area . '%';
}

if ($category) {
    $query .= " AND h.Category = :category";
    $params['category'] = $category;
}

if ($minPrice) {
    $query .= " AND r.Price >= :minPrice";
    $params['minPrice'] = $minPrice;
}

if ($maxPrice) {
    $query .= " AND r.Price <= :maxPrice";
    $params['maxPrice'] = $maxPrice;
}

if ($capacity) {
    $query .= " AND r.Capacity = :capacity";
    $params['capacity'] = $capacity;
}

if ($view) {
    $query .= " AND r.ViewType = :view";
    $params['view'] = $view;
}

if ($extendable !== null && $extendable !== '') {
    $query .= " AND r.CanBeExtended = :extendable";
    $params['extendable'] = $extendable;
}

if ($minAvailableCapacity !== null && $minAvailableCapacity !== '') {
    $query .= " AND ac.AvailableCapacity >= :minAvailableCapacity";
    $params['minAvailableCapacity'] = $minAvailableCapacity;
}

if ($hotelChain !== null && $hotelChain !== ''){
    $query .= " AND c.ChainName = :hotelChain";
    $params['hotelChain'] = $hotelChain;
}

try {
    $stmt = $pdo->prepare($query);
    $stmt->execute($params);
    $rooms = $stmt->fetchAll();
    echo json_encode($rooms);
} catch (PDOException $e) {
    http_response_code(500);
    echo json_encode(["error" => $e->getMessage()]);
}