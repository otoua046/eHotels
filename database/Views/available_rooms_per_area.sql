CREATE VIEW available_rooms_per_area AS
SELECT 
    hotel.region,
    (hotel.ttl - booked_rooms.ct) AS 'available rooms'
FROM
-- joins together two different aggregations, 1 being the total number of rooms in a region and the other being the number of booked rooms in a region -- 
    (SELECT 
        SUM(numberofrooms) AS ttl,
            SUBSTRING(hotel.Address, LOCATE(',', hotel.Address) + 2) AS region
    FROM
        hotel
    GROUP BY region) AS hotel,
    (SELECT 
        COUNT(hotel.hotelID) AS ct,
            SUBSTRING(hotel.Address, LOCATE(',', hotel.Address, 1) + 2) AS region
    FROM
        hotel
        -- join on booked rooms creates a table with n entries where n is the number of booked rooms
    INNER JOIN (SELECT 
		room.hotelid
    FROM
        room
        -- join limits the rooms returned to booked rooms -- 
    INNER JOIN (SELECT 
        roomid
    FROM
        booking
    WHERE
-- REPLACE DATES SEARCHED HERE --
        StartDate >= DATE('2023-1-10')
            AND DATE('2024-7-11') >= EndDate) AS book1 ON room.roomid = book1.roomid) AS room1 ON room1.hotelid = hotel.hotelid
    GROUP BY region) AS booked_rooms
WHERE
    booked_rooms.region = hotel.region;