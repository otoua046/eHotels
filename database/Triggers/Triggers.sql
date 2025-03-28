-- Trigger to ensure valid booking dates
DELIMITER //
CREATE TRIGGER trg_check_booking_dates
BEFORE INSERT ON Booking
FOR EACH ROW
BEGIN
    IF NEW.StartDate >= NEW.EndDate THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'StartDate must be before EndDate';
    END IF;
END; //
DELIMITER ;

-- Prevent adding employees if no manager exists
DELIMITER //
CREATE TRIGGER trg_prevent_insert_without_manager
BEFORE INSERT ON Employee
FOR EACH ROW
BEGIN
    DECLARE manager_count INT;
    
    -- Only check if inserting non-manager
    IF NEW.Role != 'Manager' THEN
        SELECT COUNT(*) INTO manager_count
        FROM Employee
        WHERE HotelID = NEW.HotelID AND Role = 'Manager';
        
        IF manager_count = 0 THEN
            SIGNAL SQLSTATE '45000' 
            SET MESSAGE_TEXT = 'Cannot add employee - hotel must have at least one manager';
        END IF;
    END IF;
END//
DELIMITER ;

-- Prevent changing last manager's role
DELIMITER //
CREATE TRIGGER trg_prevent_manager_role_change
BEFORE UPDATE ON Employee
FOR EACH ROW
BEGIN
    DECLARE manager_count INT;
    
    -- Only check when changing manager to non-manager
    IF OLD.Role = 'Manager' AND NEW.Role != 'Manager' THEN
        SELECT COUNT(*) INTO manager_count
        FROM Employee
        WHERE HotelID = NEW.HotelID 
          AND Role = 'Manager'
          AND EmployeeID != OLD.EmployeeID;  -- Exclude current employee
        
        IF manager_count = 0 THEN
            SIGNAL SQLSTATE '45000' 
            SET MESSAGE_TEXT = 'Cannot change role - hotel must have at least one manager';
        END IF;
    END IF;
END//
DELIMITER ;

-- Prevent deleting last manager
DELIMITER //
CREATE TRIGGER trg_prevent_last_manager_deletion
BEFORE DELETE ON Employee
FOR EACH ROW
BEGIN
    DECLARE manager_count INT;
    
    -- Only check when deleting managers
    IF OLD.Role = 'Manager' THEN
        SELECT COUNT(*) INTO manager_count
        FROM Employee
        WHERE HotelID = OLD.HotelID 
          AND Role = 'Manager'
          AND EmployeeID != OLD.EmployeeID;  -- Exclude current employee
        
        IF manager_count = 0 THEN
            SIGNAL SQLSTATE '45000' 
            SET MESSAGE_TEXT = 'Cannot delete last manager of a hotel';
        END IF;
    END IF;
END//
DELIMITER ;

-- Allows updates to hotel rooms
DELIMITER //
CREATE TRIGGER trg_update_hotel_rooms
AFTER INSERT ON Room
FOR EACH ROW
BEGIN
    UPDATE Hotel
    SET NumberOfRooms = NumberOfRooms + 1
    WHERE HotelID = NEW.HotelID;
END; //

DELIMITER ;

-- Allows deletes to hotel rooms
DELIMITER //
CREATE TRIGGER trg_update_hotel_rooms_delete
AFTER DELETE ON Room
FOR EACH ROW
BEGIN
    UPDATE Hotel
    SET NumberOfRooms = NumberOfRooms - 1
    WHERE HotelID = OLD.HotelID;
END; //

DELIMITER ;
