CREATE OR REPLACE VIEW available_capacity_per_hotel AS
SELECT 
    h.HotelName,
    COALESCE(total.CapacityInt - booked.BookedCapacity, total.CapacityInt) AS AvailableCapacity
FROM
    -- Total capacity per hotel
    (
        SELECT 
            hotelid,
            SUM(FIELD(Capacity, 'single', 'double', 'triple', 'quad')) AS CapacityInt
        FROM room
        GROUP BY hotelid
    ) AS total
JOIN hotel h ON h.HotelID = total.hotelid

LEFT JOIN 
    -- Booked capacity per hotel
    (
        SELECT 
            r.hotelid,
            SUM(FIELD(r.Capacity, 'single', 'double', 'triple', 'quad')) AS BookedCapacity
        FROM room r
        INNER JOIN booking b ON b.RoomID = r.RoomID
        WHERE 
            b.StartDate >= DATE('2023-01-10') AND DATE('2024-07-11') >= b.EndDate
        GROUP BY r.hotelid
    ) AS booked ON booked.hotelid = total.hotelid;