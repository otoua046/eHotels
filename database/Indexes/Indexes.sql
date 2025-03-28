-- Room Search Index
CREATE INDEX idx_room_search ON Room(HotelID, Capacity, Price);
-- Used to speed up queries such as:
SELECT * FROM Room 
WHERE HotelID = 1 
  AND Capacity = 'Double'
  AND Price < 300;
  
  -- Booking Conflict Check Index
  CREATE INDEX idx_booking_dates ON Booking(RoomID, StartDate, EndDate);
  -- Used to prevent double-bookings and optimizes:
  SELECT * FROM Booking 
WHERE RoomID = 1 
  AND StartDate <= '2023-11-01' 
  AND EndDate >= '2023-11-05';
  
  -- Customer Lookup Index
  CREATE INDEX idx_customer_name ON Customer(FullName);
  -- Used to make guest searches instant:
  SELECT * FROM Customer WHERE FullName LIKE 'John%';