-- 1st Query - Retrieve all hotels in Ottawa
SELECT * FROM Hotel WHERE Address LIKE '%Ottawa%';

-- 2nd Query - Retrieve all bookings with customer and room details
SELECT b.BookingID, c.FullName AS CustomerName, r.RoomID, r.Capacity, r.ViewType, b.StartDate, b.EndDate
FROM Booking b
JOIN Customer c ON b.CustomerID = c.CustomerID
JOIN Room r ON b.RoomID = r.RoomID;

-- 3rd Query (with aggregation) - Total # of rooms in each hotel chain
SELECT hc.ChainID, hc.CentralOfficeAddress, SUM(h.NumberOfRooms) AS TotalRooms
FROM HotelChain hc
JOIN Hotel h ON hc.ChainID = h.ChainID
GROUP BY hc.ChainID, hc.CentralOfficeAddress;

-- 4th Query (with nested query) - All customers who booked a sea view room
SELECT c.CustomerID, c.FullName, c.Address
FROM Customer c
WHERE c.CustomerID IN (
    SELECT b.CustomerID
    FROM Booking b
    JOIN Room r ON b.RoomID = r.RoomID
    WHERE r.ViewType = 'Sea'
);
