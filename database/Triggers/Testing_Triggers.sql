-- TESTING trg_check_booking_dates
-- Passes because dates are valid
INSERT INTO Booking (CustomerID, RoomID, StartDate, EndDate)
VALUES (1, 1, '2023-12-01', '2023-12-05');

-- Fails because start date is after end date
INSERT INTO Booking (CustomerID, RoomID, StartDate, EndDate)
VALUES (1, 1, '2023-12-10', '2023-12-05'); -- End before start


-- TESTING trg_prevent_insert_without_manager
-- Show current hotel managers
SELECT * FROM Employee 
WHERE HotelID = 1 AND Role = 'Manager';

-- Try adding non-manager to hotel with no managers - fails
INSERT INTO Employee (HotelID, FullName, Role)
VALUES (6, 'Test Employee', 'Receptionist');


-- TESTING trg_prevent_manager_role_change
-- Try changing last manager to receptionist - fails
UPDATE Employee SET Role = 'Receptionist' 
WHERE SSN_SIN = '123-45-6789';


-- TESTING trg_prevent_last_manager_deletion
-- Try deleting last manager - fails
DELETE FROM Employee 
WHERE SSN_SIN = '123-45-6789';


-- TESTING trg_update_hotel_rooms
-- Check current room count for Hotel 1
SELECT HotelID, NumberOfRooms FROM Hotel WHERE HotelID = 1;

-- Insert a new room
INSERT INTO Room (HotelID, RoomNumber, Price, Amenities, Capacity, ViewType, CanBeExtended, HasDamage, ProblemDescription)
VALUES (1, 9, 199.03, 'TV, Air Condition, Fridge', 'Triple', 'Mountain', FALSE, FALSE, NULL);

-- Count increased by 1
SELECT HotelID, NumberOfRooms FROM Hotel WHERE HotelID = 1;


-- TESTING trg_update_hotel_rooms_delete
-- Check current count
SELECT NumberOfRooms FROM Hotel WHERE HotelID = 1;

-- Delete the room we previously added
DELETE FROM Room WHERE RoomID = 401; 

-- Verify count decreased by 1
SELECT NumberOfRooms FROM Hotel WHERE HotelID = 1;