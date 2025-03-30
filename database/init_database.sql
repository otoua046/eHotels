-- START OF: SQLProject/Creates/Create_Database.sql
CREATE DATABASE eHotels;
USE eHotels;

-- START OF: SQLProject/Creates/HotelChain.sql
CREATE TABLE HotelChain (
    ChainID INT PRIMARY KEY AUTO_INCREMENT,
    ChainName VARCHAR(100) NOT NULL UNIQUE, 
    CentralOfficeAddress VARCHAR(255) NOT NULL,
    NumberOfHotels INT DEFAULT 0,
    Email VARCHAR(100) UNIQUE NOT NULL,
    PhoneNumber VARCHAR(15) UNIQUE NOT NULL
);


-- START OF: SQLProject/Creates/Hotel.sql
CREATE TABLE Hotel (
    HotelID INT PRIMARY KEY AUTO_INCREMENT,
    ChainID INT NOT NULL,
    HotelName VARCHAR(100) NOT NULL UNIQUE,  -- 🆕 Added HotelName
    Address VARCHAR(255) NOT NULL,
    Email VARCHAR(100) UNIQUE NOT NULL,
    PhoneNumber VARCHAR(15) UNIQUE NOT NULL,
    Category ENUM('1-star', '2-star', '3-star', '4-star', '5-star') NOT NULL,
    NumberOfRooms INT DEFAULT 0,
    FOREIGN KEY (ChainID) REFERENCES HotelChain(ChainID) ON DELETE CASCADE
);

-- START OF: SQLProject/Creates/Room.sql
CREATE TABLE Room (
    RoomID INT PRIMARY KEY AUTO_INCREMENT,
    HotelID INT NOT NULL,
    RoomNumber INT NOT NULL,
    Price DECIMAL(10, 2) NOT NULL,
    Amenities TEXT,
    Capacity ENUM('Single', 'Double', 'Triple', 'Quad') NOT NULL,
    ViewType ENUM('Sea', 'Mountain', 'None') DEFAULT 'None',
    CanBeExtended BOOLEAN DEFAULT FALSE,
    HasDamage BOOLEAN DEFAULT FALSE,
    ProblemDescription TEXT,  
    FOREIGN KEY (HotelID) REFERENCES Hotel(HotelID) ON DELETE CASCADE
);


-- START OF: SQLProject/Creates/Employee.sql
CREATE TABLE Employee (
    EmployeeID INT PRIMARY KEY AUTO_INCREMENT,
    HotelID INT NOT NULL,
    FullName VARCHAR(100) NOT NULL,
    Address VARCHAR(255) NOT NULL,
    SSN_SIN VARCHAR(20) UNIQUE NOT NULL,
    Role ENUM('Manager', 'Receptionist', 'Housekeeping') NOT NULL,
    FOREIGN KEY (HotelID) REFERENCES Hotel(HotelID) ON DELETE CASCADE
);


-- START OF: SQLProject/Creates/Customer.sql
CREATE TABLE Customer (
    CustomerID INT PRIMARY KEY AUTO_INCREMENT,
    FullName VARCHAR(100) NOT NULL,
    Address VARCHAR(255) NOT NULL,
    IDType ENUM('SSN', 'SIN', 'Driving License') NOT NULL,
    RegistrationDate DATE NOT NULL
);
ALTER TABLE Customer
MODIFY COLUMN RegistrationDate DATE DEFAULT (CURRENT_DATE);


-- START OF: SQLProject/Creates/Booking.sql
CREATE TABLE Booking (
    BookingID INT PRIMARY KEY AUTO_INCREMENT,
    CustomerID INT NOT NULL,
    RoomID INT NOT NULL,
    StartDate DATE NOT NULL,
    EndDate DATE NOT NULL,
    Status ENUM('Booked', 'Cancelled', 'Rented') DEFAULT 'Booked',
    FOREIGN KEY (CustomerID) REFERENCES Customer(CustomerID) ON DELETE CASCADE,
    FOREIGN KEY (RoomID) REFERENCES Room(RoomID) ON DELETE CASCADE
);



-- START OF: SQLProject/Creates/Renting.sql
CREATE TABLE Renting (
    RentingID INT PRIMARY KEY AUTO_INCREMENT,
    RoomID INT NOT NULL,
    BookingID INT NOT NULL,
    EmployeeID INT NOT NULL,
    CustomerID INT NOT NULL,  
    CheckInDate DATE NOT NULL,
    CheckOutDate DATE,
    PaymentStatus ENUM('Paid', 'Unpaid') DEFAULT 'Unpaid',
    FOREIGN KEY (RoomID) REFERENCES Room(RoomID) ON DELETE CASCADE,
    FOREIGN KEY (BookingID) REFERENCES Booking(BookingID) ON DELETE CASCADE,
    FOREIGN KEY (EmployeeID) REFERENCES Employee(EmployeeID) ON DELETE CASCADE,
    FOREIGN KEY (CustomerID) REFERENCES Customer(CustomerID) ON DELETE CASCADE
);




-- START OF: SQLProject/Inserts/Insert_Customers.sql
INSERT INTO Customer (FullName, Address, IDType, RegistrationDate)
VALUES 
('John Doe', '123 Elm St, Ottawa, CA', 'SSN', '2023-10-01'),
('Jane Smith', '456 Oak St, Toronto, CA', 'Driving License', '2023-10-02'),
('Alice Johnson', '789 Pine St, Montreal, CA', 'SSN', '2023-10-03'),
('Bob Billy', '321 Maple St, Calgary, CA', 'Driving License', '2023-10-04'),
('Charlie Davidson', '456 Oak St, London, CA', 'SSN', '2023-10-05'),
('Ella Green', '101 Sunset Blvd, Ottawa, CA', 'Driving License', '2023-10-06'),
('Frank Ocean', '202 Park Ave, Toronto, CA', 'SSN', '2023-10-07'),
('Grace Lee', '303 5th Ave, Montreal, CA', 'Driving License', '2023-10-08'),
('Hannah Williams', '404 Lexington Ave, Calgary, CA', 'SSN', '2023-10-09'),
('Ivy Swift', '505 Madison Ave, London, CA', 'Driving License', '2023-10-10');


-- START OF: SQLProject/Inserts/Insert_Hotel_Chains.sql
INSERT INTO HotelChain (ChainName, CentralOfficeAddress, NumberOfHotels, Email, PhoneNumber)
VALUES 
-- Chain 1
('Maple Hospitality', '123 Somerset St, Ottawa, CA', 8, 'info@maplehospitality.com', '+1-613-555-0101'),

-- Chain 2
('Northern Stays', '456 Elgin St, Toronto, CA', 8, 'contact@northernstays.com', '+1-416-555-0502'),

-- Chain 3
('Laurier Luxe', '789 Laurier St, Montreal, CA', 8, 'support@laurierluxe.com', '+1-438-555-0403'),

-- Chain 4
('Prairie Suites', '321 Bank St, Calgary, CA', 8, 'hello@prairiesuites.com', '+1-519-555-0505'),

-- Chain 5
('London Comforts', '654 Kent St, London, CA', 8, 'reservations@londoncomforts.com', '+1-416-555-0507');

-- START OF: SQLProject/Inserts/Insert_Hotels.sql
INSERT INTO Hotel (ChainID, HotelName, Address, Email, PhoneNumber, Category, NumberOfRooms)
VALUES 
-- Chain 1 (Maple Hospitality)
(1, 'Maple Ottawa Central', '101 Lisgar St, Ottawa, CA', 'ottawa.central@maplehospitality.com', '+1-613-555-0101', '5-star', 5),
(1, 'Maple Toronto Heights', '202 Nepean St, Toronto, CA', 'toronto.heights@maplehospitality.com', '+1-416-555-0102', '4-star', 5),
(1, 'Maple Montreal Centre', '303 Gloucester St, Montreal, CA', 'montreal.centre@maplehospitality.com', '+1-438-555-0103', '3-star', 5),
(1, 'Maple Calgary West', '404 Slater St, Calgary, CA', 'calgary.west@maplehospitality.com', '+1-403-555-0104', '2-star', 5),
(1, 'Maple London East', '505 Queen St, London, CA', 'london.east@maplehospitality.com', '+1-519-555-0105', '1-star', 5),
(1, 'Maple Ottawa South', '606 Henderson Ave, Ottawa, CA', 'ottawa.south@maplehospitality.com', '+1-613-555-0106', '5-star', 5),
(1, 'Maple Toronto Uptown', '707 Sweetland Ave, Toronto, CA', 'toronto.uptown@maplehospitality.com', '+1-416-555-0107', '4-star', 5),
(1, 'Maple Montreal East', '808 Nelson St, Montreal, CA', 'montreal.east@maplehospitality.com', '+1-438-555-0108', '3-star', 5),

-- Chain 2 (Northern Stays)
(2, 'Northern Ottawa View', '101 Adelaide St, Ottawa, CA', 'ottawa.view@northernstays.com', '+1-613-555-0201', '5-star', 5),
(2, 'Northern Toronto Central', '202 Blue Jays Way, Toronto, CA', 'toronto.central@northernstays.com', '+1-416-555-0202', '4-star', 5),
(2, 'Northern Montreal Heights', '303 Spadina Ave, Montreal, CA', 'montreal.heights@northernstays.com', '+1-438-555-0203', '3-star', 5),
(2, 'Northern Calgary Garden', '404 Richmond St, Calgary, CA', 'calgary.garden@northernstays.com', '+1-403-555-0204', '2-star', 5),
(2, 'Northern London Ridge', '505 Front St, London, CA', 'london.ridge@northernstays.com', '+1-519-555-0205', '1-star', 5),
(2, 'Northern Ottawa Elite', '606 College St, Ottawa, CA', 'ottawa.elite@northernstays.com', '+1-613-555-0206', '5-star', 5),
(2, 'Northern Toronto Suites', '707 Harbord St, Toronto, CA', 'toronto.suites@northernstays.com', '+1-416-555-0207', '4-star', 5),
(2, 'Northern Montreal Lux', '808 Bloor St, Montreal, CA', 'montreal.lux@northernstays.com', '+1-438-555-0208', '3-star', 5),

-- Chain 3 (Laurier Luxe)
(3, 'Laurier Ottawa Square', '101 Boul Gouin St, Ottawa, CA', 'ottawa.square@laurierluxe.com', '+1-613-555-0301', '5-star', 5),
(3, 'Laurier Toronto Grand', '202 St Laurent Blvd, Toronto, CA', 'toronto.grand@laurierluxe.com', '+1-416-555-0302', '4-star', 5),
(3, 'Laurier Montreal Place', '303 Sauve St, Montreal, CA', 'montreal.place@laurierluxe.com', '+1-438-555-0303', '3-star', 5),
(3, 'Laurier Calgary East', '404 Fleury St, Calgary, CA', 'calgary.east@laurierluxe.com', '+1-403-555-0304', '2-star', 5),
(3, 'Laurier London Core', '505 St Hubert St, London, CA', 'london.core@laurierluxe.com', '+1-519-555-0305', '1-star', 5),
(3, 'Laurier Ottawa Hill', '606 Christophe Colomb Ave, Ottawa, CA', 'ottawa.hill@laurierluxe.com', '+1-613-555-0306', '5-star', 5),
(3, 'Laurier Toronto Tower', '707 Millen Ave, Toronto, CA', 'toronto.tower@laurierluxe.com', '+1-416-555-0307', '4-star', 5),
(3, 'Laurier Montreal Garden', '808 Foucher St, Montreal, CA', 'montreal.garden@laurierluxe.com', '+1-438-555-0308', '3-star', 5),

-- Chain 4 (Prairie Suites)
(4, 'Prairie Ottawa Prime', '101 Anderson Rd, Ottawa, CA', 'ottawa.prime@prairiesuites.com', '+1-613-555-0401', '5-star', 5),
(4, 'Prairie Toronto Centre', '202 Southland Dr, Toronto, CA', 'toronto.centre@prairiesuites.com', '+1-416-555-0402', '4-star', 5),
(4, 'Prairie Montreal Inn', '303 Elbow Dr, Montreal, CA', 'montreal.inn@prairiesuites.com', '+1-438-555-0403', '3-star', 5),
(4, 'Prairie Calgary Stay', '404 Braeside Dr, Calgary, CA', 'calgary.stay@prairiesuites.com', '+1-403-555-0404', '2-star', 5),
(4, 'Prairie London Inn', '505 Palliser Dr, London, CA', 'london.inn@prairiesuites.com', '+1-519-555-0405', '1-star', 5),
(4, 'Prairie Ottawa Horizon', '606 Oakfield Dr, Ottawa, CA', 'ottawa.horizon@prairiesuites.com', '+1-613-555-0406', '5-star', 5),
(4, 'Prairie Toronto Avenue', '707 Woodview Dr, Toronto, CA', 'toronto.avenue@prairiesuites.com', '+1-416-555-0407', '4-star', 5),
(4, 'Prairie Montreal Park', '808 Patton Ct, Montreal, CA', 'montreal.park@prairiesuites.com', '+1-438-555-0408', '3-star', 5),

-- Chain 5 (London Comforts)
(5, 'Comfort Ottawa Metro', '101 Talbot St, Ottawa, CA', 'ottawa.metro@londoncomforts.com', '+1-613-555-0501', '5-star', 5),
(5, 'Comfort Toronto Peak', '202 Carling St, Toronto, CA', 'toronto.peak@londoncomforts.com', '+1-416-555-0502', '4-star', 5),
(5, 'Comfort Montreal Palace', '303 Ridout St, Montreal, CA', 'montreal.palace@londoncomforts.com', '+1-438-555-0503', '3-star', 5),
(5, 'Comfort Calgary Royal', '404 Fullarton St, Calgary, CA', 'calgary.royal@londoncomforts.com', '+1-403-555-0504', '2-star', 5),
(5, 'Comfort London Core', '505 Dufferin Ave, London, CA', 'london.core@londoncomforts.com', '+1-519-555-0505', '1-star', 5),
(5, 'Comfort Ottawa Elite', '606 Albert St, Ottawa, CA', 'ottawa.elite@londoncomforts.com', '+1-613-555-0506', '5-star', 5),
(5, 'Comfort Toronto Park', '707 John St, Toronto, CA', 'toronto.park@londoncomforts.com', '+1-416-555-0507', '4-star', 5),
(5, 'Comfort Montreal East', '808 Mill St, Montreal, CA', 'montreal.east@londoncomforts.com', '+1-438-555-0508', '3-star', 5);

-- START OF: SQLProject/Inserts/Insert_Employees.sql
INSERT INTO Employee (HotelID, FullName, Address, SSN_SIN, Role)
VALUES 
-- Hotel 1 Employees
(1, 'Patrick Ally', '789 Pine St, Ottawa, CA', '123-45-6789', 'Manager'),
(1, 'Rubby Bob', '321 Maple St, Ottawa, CA', '987-65-4321', 'Receptionist'),

-- Hotel 2 Employees
(2, 'Michael Charlie', '456 Oak St, Toronto, CA', '555-55-5555', 'Manager'),
(2, 'Laurence Bloom', '101 Sunset Blvd, Toronto, CA', '666-66-6666', 'Housekeeping'),

-- Hotel 3 Employees
(3, 'Jill Frank', '202 Park Ave, Montreal, CA', '777-77-7777', 'Manager'),
(3, 'Mike Grace', '303 5th Ave, Montreal, CA', '888-88-8888', 'Receptionist'),

-- Hotel 4 Employees
(4, 'Samantha Hanner', '404 Lexington Ave, Calgary, CA', '999-99-9999', 'Manager'),
(4, 'Donald Ivy', '505 Madison Ave, Calgary, CA', '101-01-0101', 'Housekeeping'),

-- Hotel 5 Employees
(5, 'John Diaz', '606 Wall St, London, CA', '202-02-0202', 'Manager'),
(5, 'Larry Jane', '707 Times Square, London, CA', '303-03-0303', 'Receptionist'),

(6, 'Kevin Smith', '808 Elm St, Ottawa, CA', '404-04-0404', 'Manager'),
(6, 'Laura Davis', '909 Birch St, Ottawa, CA', '505-05-0505', 'Receptionist'),
(7, 'Steve Williams', '700 Street, City 7, CA', '606-60-0606', 'Manager'),
(7, 'Mike Johnson', '701 Blvd, City 7, CA', '606-60-0607', 'Housekeeping'),
(8, 'Xavier Williams', '800 Street, City 8, CA', '606-60-0608', 'Manager'),
(8, 'Oscar Wilson', '801 Ave, City 8, CA', '606-60-0609', 'Receptionist'),
(9, 'Quinn Williams', '900 Street, City 9, CA', '606-60-0610', 'Manager'),
(9, 'Kevin Davis', '901 Blvd, City 9, CA', '606-60-0611', 'Housekeeping'),
(10, 'Mike Brown', '1000 Street, City 10, CA', '606-60-0612', 'Manager'),
(10, 'Kevin Johnson', '1001 Ave, City 10, CA', '606-60-0613', 'Receptionist'),
(11, 'Uma Garcia', '1100 Street, City 11, CA', '606-60-0614', 'Manager'),
(11, 'Kevin Anderson', '1101 Blvd, City 11, CA', '606-60-0615', 'Housekeeping'),
(12, 'Nina Johnson', '1200 Street, City 12, CA', '606-60-0616', 'Manager'),
(12, 'Paula Jones', '1201 Ave, City 12, CA', '606-60-0617', 'Receptionist'),
(13, 'Nina Davis', '1300 Street, City 13, CA', '606-60-0618', 'Manager'),
(13, 'Quinn Johnson', '1301 Blvd, City 13, CA', '606-60-0619', 'Housekeeping'),
(14, 'Rachel Williams', '1400 Street, City 14, CA', '606-60-0620', 'Manager'),
(14, 'Zack Garcia', '1401 Ave, City 14, CA', '606-60-0621', 'Receptionist'),
(15, 'Kevin Wilson', '1500 Street, City 15, CA', '606-60-0622', 'Manager'),
(15, 'Laura Williams', '1501 Blvd, City 15, CA', '606-60-0623', 'Housekeeping'),
(16, 'Oscar Davis', '1600 Street, City 16, CA', '606-60-0624', 'Manager'),
(16, 'Uma Jones', '1601 Ave, City 16, CA', '606-60-0625', 'Receptionist'),
(17, 'Uma Brown', '1700 Street, City 17, CA', '606-60-0626', 'Manager'),
(17, 'Paula Davis', '1701 Blvd, City 17, CA', '606-60-0627', 'Housekeeping'),
(18, 'Uma Jones', '1800 Street, City 18, CA', '606-60-0628', 'Manager'),
(18, 'Quinn Anderson', '1801 Ave, City 18, CA', '606-60-0629', 'Receptionist'),
(19, 'Nina Jones', '1900 Street, City 19, CA', '606-60-0630', 'Manager'),
(19, 'Uma Brown', '1901 Blvd, City 19, CA', '606-60-0631', 'Housekeeping'),
(20, 'Victor Davis', '2000 Street, City 20, CA', '606-60-0632', 'Manager'),
(20, 'Uma Brown', '2001 Ave, City 20, CA', '606-60-0633', 'Receptionist'),
(21, 'Paula Miller', '2100 Street, City 21, CA', '606-60-0634', 'Manager'),
(21, 'Uma Anderson', '2101 Blvd, City 21, CA', '606-60-0635', 'Housekeeping'),
(22, 'Paula Brown', '2200 Street, City 22, CA', '606-60-0636', 'Manager'),
(22, 'Zack Jones', '2201 Ave, City 22, CA', '606-60-0637', 'Receptionist'),
(23, 'Quinn Smith', '2300 Street, City 23, CA', '606-60-0638', 'Manager'),
(23, 'Xavier Davis', '2301 Blvd, City 23, CA', '606-60-0639', 'Housekeeping'),
(24, 'Quinn Johnson', '2400 Street, City 24, CA', '606-60-0640', 'Manager'),
(24, 'Mike Davis', '2401 Ave, City 24, CA', '606-60-0641', 'Receptionist'),
(25, 'Xavier Wilson', '2500 Street, City 25, CA', '606-60-0642', 'Manager'),
(25, 'Zack Williams', '2501 Blvd, City 25, CA', '606-60-0643', 'Housekeeping'),
(26, 'Xavier Garcia', '2600 Street, City 26, CA', '606-60-0644', 'Manager'),
(26, 'Oscar Anderson', '2601 Ave, City 26, CA', '606-60-0645', 'Receptionist'),
(27, 'Rachel Williams', '2700 Street, City 27, CA', '606-60-0646', 'Manager'),
(27, 'Uma Miller', '2701 Blvd, City 27, CA', '606-60-0647', 'Housekeeping'),
(28, 'Uma Wilson', '2800 Street, City 28, CA', '606-60-0648', 'Manager'),
(28, 'Yara Johnson', '2801 Ave, City 28, CA', '606-60-0649', 'Receptionist'),
(29, 'Quinn Miller', '2900 Street, City 29, CA', '606-60-0650', 'Manager'),
(29, 'Rachel Jones', '2901 Blvd, City 29, CA', '606-60-0651', 'Housekeeping'),
(30, 'Laura Williams', '3000 Street, City 30, CA', '606-60-0652', 'Manager'),
(30, 'Laura Williams', '3001 Ave, City 30, CA', '606-60-0653', 'Receptionist'),
(31, 'Oscar Anderson', '3100 Street, City 31, CA', '606-60-0654', 'Manager'),
(31, 'Laura Garcia', '3101 Blvd, City 31, CA', '606-60-0655', 'Housekeeping'),
(32, 'Yara Brown', '3200 Street, City 32, CA', '606-60-0656', 'Manager'),
(32, 'Zack Smith', '3201 Ave, City 32, CA', '606-60-0657', 'Receptionist'),
(33, 'Victor Wilson', '3300 Street, City 33, CA', '606-60-0658', 'Manager'),
(33, 'Laura Williams', '3301 Blvd, City 33, CA', '606-60-0659', 'Housekeeping'),
(34, 'Uma Wilson', '3400 Street, City 34, CA', '606-60-0660', 'Manager'),
(34, 'Wendy Wilson', '3401 Ave, City 34, CA', '606-60-0661', 'Receptionist'),
(35, 'Steve Johnson', '3500 Street, City 35, CA', '606-60-0662', 'Manager'),
(35, 'Zack Brown', '3501 Blvd, City 35, CA', '606-60-0663', 'Housekeeping'),
(36, 'Steve Johnson', '3600 Street, City 36, CA', '606-60-0664', 'Manager'),
(36, 'Xavier Jones', '3601 Ave, City 36, CA', '606-60-0665', 'Receptionist'),
(37, 'Rachel Anderson', '3700 Street, City 37, CA', '606-60-0666', 'Manager'),
(37, 'Victor Anderson', '3701 Blvd, City 37, CA', '606-60-0667', 'Housekeeping'),
(38, 'Rachel Jones', '3800 Street, City 38, CA', '606-60-0668', 'Manager'),
(38, 'Laura Garcia', '3801 Ave, City 38, CA', '606-60-0669', 'Receptionist'),
(39, 'Nina Davis', '3900 Street, City 39, CA', '606-60-0670', 'Manager'),
(39, 'Yara Brown', '3901 Blvd, City 39, CA', '606-60-0671', 'Housekeeping'),
(40, 'Uma Miller', '4000 Street, City 40, CA', '606-60-0672', 'Manager'),
(40, 'Nina Garcia', '4001 Ave, City 40, CA', '606-60-0673', 'Receptionist');

-- START OF: SQLProject/Inserts/Insert_Rooms.sql
INSERT INTO Room (HotelID, RoomNumber, Price, Amenities, Capacity, ViewType, CanBeExtended, HasDamage, ProblemDescription)
VALUES
(1, 1, 162.5, 'TV, Air Condition, Fridge', 'Triple', 'None', TRUE, TRUE, 'Leaky faucet in bathroom'),
(1, 2, 194.4, 'TV, Air Condition, Fridge', 'Double', 'None', TRUE, FALSE, NULL),
(1, 3, 263.94, 'TV, Air Condition, Fridge', 'Triple', 'Sea', TRUE, FALSE, NULL),
(1, 4, 319.9, 'TV, Air Condition, Fridge', 'Quad', 'None', FALSE, FALSE, NULL),
(1, 5, 345.28, 'TV, Air Condition, Fridge', 'Quad', 'None', TRUE, FALSE, NULL),
(2, 1, 154.6, 'TV, Air Condition, Fridge', 'Single', 'None', FALSE, FALSE, NULL),
(2, 2, 213.61, 'TV, Air Condition, Fridge', 'Single', 'None', FALSE, FALSE, NULL),
(2, 3, 255.88, 'TV, Air Condition, Fridge', 'Triple', 'Mountain', FALSE, TRUE, 'TV screen cracked'),
(2, 4, 304.6, 'TV, Air Condition, Fridge', 'Quad', 'None', FALSE, FALSE, NULL),
(2, 5, 353.51, 'TV, Air Condition, Fridge', 'Quad', 'Mountain', FALSE, FALSE, NULL),
(3, 1, 166.29, 'TV, Air Condition, Fridge', 'Quad', 'Mountain', TRUE, FALSE, NULL),
(3, 2, 197.57, 'TV, Air Condition, Fridge', 'Single', 'Mountain', FALSE, FALSE, NULL),
(3, 3, 244.09, 'TV, Air Condition, Fridge', 'Double', 'None', FALSE, FALSE, NULL),
(3, 4, 306.32, 'TV, Air Condition, Fridge', 'Single', 'Sea', TRUE, FALSE, NULL),
(3, 5, 358.72, 'TV, Air Condition, Fridge', 'Double', 'Sea', TRUE, FALSE, NULL),
(4, 1, 160.98, 'TV, Air Condition, Fridge', 'Quad', 'Mountain', FALSE, FALSE, NULL),
(4, 2, 192.58, 'TV, Air Condition, Fridge', 'Quad', 'Mountain', TRUE, FALSE, NULL),
(4, 3, 253.29, 'TV, Air Condition, Fridge', 'Single', 'None', TRUE, FALSE, NULL),
(4, 4, 285.42, 'TV, Air Condition, Fridge', 'Double', 'Sea', FALSE, TRUE, 'TV screen cracked'),
(4, 5, 356.81, 'TV, Air Condition, Fridge', 'Quad', 'Mountain', FALSE, FALSE, NULL),
(5, 1, 155.67, 'TV, Air Condition, Fridge', 'Single', 'Sea', TRUE, TRUE, 'Desk drawer stuck'),
(5, 2, 205.35, 'TV, Air Condition, Fridge', 'Single', 'None', TRUE, FALSE, NULL),
(5, 3, 256.57, 'TV, Air Condition, Fridge', 'Double', 'Mountain', FALSE, FALSE, NULL),
(5, 4, 280.32, 'TV, Air Condition, Fridge', 'Single', 'None', TRUE, TRUE, 'Broken balcony door lock'),
(5, 5, 369.37, 'TV, Air Condition, Fridge', 'Single', 'Sea', FALSE, FALSE, NULL),
(6, 1, 139.02, 'TV, Air Condition, Fridge', 'Triple', 'None', TRUE, FALSE, NULL),
(6, 2, 199.4, 'TV, Air Condition, Fridge', 'Quad', 'Sea', FALSE, TRUE, 'Lighting issues in bathroom'),
(6, 3, 247.56, 'TV, Air Condition, Fridge', 'Double', 'Mountain', FALSE, TRUE, 'TV screen cracked'),
(6, 4, 288.95, 'TV, Air Condition, Fridge', 'Double', 'Sea', FALSE, TRUE, 'Lighting issues in bathroom'),
(6, 5, 341.8, 'TV, Air Condition, Fridge', 'Double', 'Mountain', FALSE, FALSE, NULL),
(7, 1, 154.51, 'TV, Air Condition, Fridge', 'Triple', 'Sea', TRUE, FALSE, NULL),
(7, 2, 196.36, 'TV, Air Condition, Fridge', 'Single', 'Sea', FALSE, FALSE, NULL),
(7, 3, 250.49, 'TV, Air Condition, Fridge', 'Quad', 'Sea', FALSE, FALSE, NULL),
(7, 4, 318.27, 'TV, Air Condition, Fridge', 'Triple', 'Mountain', FALSE, FALSE, NULL),
(7, 5, 353.18, 'TV, Air Condition, Fridge', 'Quad', 'None', TRUE, TRUE, 'Stained carpet near bed'),
(8, 1, 164.39, 'TV, Air Condition, Fridge', 'Double', 'Sea', TRUE, FALSE, NULL),
(8, 2, 182.65, 'TV, Air Condition, Fridge', 'Single', 'None', FALSE, FALSE, NULL),
(8, 3, 245.73, 'TV, Air Condition, Fridge', 'Quad', 'Mountain', FALSE, TRUE, 'Broken balcony door lock'),
(8, 4, 301.88, 'TV, Air Condition, Fridge', 'Quad', 'Mountain', TRUE, FALSE, NULL),
(8, 5, 362.85, 'TV, Air Condition, Fridge', 'Quad', 'Mountain', FALSE, TRUE, 'Lighting issues in bathroom'),
(9, 1, 131.93, 'TV, Air Condition, Fridge', 'Double', 'None', TRUE, FALSE, NULL),
(9, 2, 208.76, 'TV, Air Condition, Fridge', 'Single', 'Sea', TRUE, FALSE, NULL),
(9, 3, 252.58, 'TV, Air Condition, Fridge', 'Single', 'None', TRUE, FALSE, NULL),
(9, 4, 309.86, 'TV, Air Condition, Fridge', 'Double', 'Mountain', FALSE, FALSE, NULL),
(9, 5, 365.35, 'TV, Air Condition, Fridge', 'Single', 'Mountain', FALSE, FALSE, NULL),
(10, 1, 164.33, 'TV, Air Condition, Fridge', 'Quad', 'None', TRUE, FALSE, NULL),
(10, 2, 213.18, 'TV, Air Condition, Fridge', 'Triple', 'None', FALSE, TRUE, 'Stained carpet near bed'),
(10, 3, 261.65, 'TV, Air Condition, Fridge', 'Double', 'Sea', FALSE, FALSE, NULL),
(10, 4, 298.24, 'TV, Air Condition, Fridge', 'Triple', 'Sea', TRUE, FALSE, NULL),
(10, 5, 344.2, 'TV, Air Condition, Fridge', 'Single', 'Mountain', TRUE, FALSE, NULL),
(11, 1, 132.24, 'TV, Air Condition, Fridge', 'Triple', 'None', FALSE, TRUE, 'Lighting issues in bathroom'),
(11, 2, 182.88, 'TV, Air Condition, Fridge', 'Double', 'Sea', FALSE, TRUE, 'Broken balcony door lock'),
(11, 3, 246.24, 'TV, Air Condition, Fridge', 'Triple', 'Sea', TRUE, TRUE, 'Lighting issues in bathroom'),
(11, 4, 285.52, 'TV, Air Condition, Fridge', 'Double', 'Mountain', TRUE, FALSE, NULL),
(11, 5, 344.25, 'TV, Air Condition, Fridge', 'Quad', 'None', FALSE, TRUE, 'Fridge not cooling properly'),
(12, 1, 142.19, 'TV, Air Condition, Fridge', 'Triple', 'Mountain', FALSE, FALSE, NULL),
(12, 2, 206.13, 'TV, Air Condition, Fridge', 'Single', 'Mountain', FALSE, FALSE, NULL),
(12, 3, 242.33, 'TV, Air Condition, Fridge', 'Triple', 'Sea', TRUE, FALSE, NULL),
(12, 4, 311.02, 'TV, Air Condition, Fridge', 'Double', 'Sea', FALSE, TRUE, 'Leaky faucet in bathroom'),
(12, 5, 332.98, 'TV, Air Condition, Fridge', 'Quad', 'Mountain', TRUE, TRUE, 'AC not working'),
(13, 1, 141.25, 'TV, Air Condition, Fridge', 'Quad', 'Mountain', TRUE, TRUE, 'Window won''t open'),
(13, 2, 187.61, 'TV, Air Condition, Fridge', 'Double', 'None', TRUE, TRUE, 'Desk drawer stuck'),
(13, 3, 248.68, 'TV, Air Condition, Fridge', 'Triple', 'Sea', TRUE, FALSE, NULL),
(13, 4, 295.46, 'TV, Air Condition, Fridge', 'Quad', 'Mountain', TRUE, FALSE, NULL),
(13, 5, 345.57, 'TV, Air Condition, Fridge', 'Quad', 'Mountain', FALSE, FALSE, NULL),
(14, 1, 142.59, 'TV, Air Condition, Fridge', 'Single', 'Mountain', TRUE, FALSE, NULL),
(14, 2, 192.82, 'TV, Air Condition, Fridge', 'Triple', 'None', TRUE, FALSE, NULL),
(14, 3, 241.55, 'TV, Air Condition, Fridge', 'Double', 'Mountain', TRUE, FALSE, NULL),
(14, 4, 298.05, 'TV, Air Condition, Fridge', 'Quad', 'Sea', TRUE, FALSE, NULL),
(14, 5, 359.26, 'TV, Air Condition, Fridge', 'Quad', 'None', TRUE, TRUE, 'Fridge not cooling properly'),
(15, 1, 162.25, 'TV, Air Condition, Fridge', 'Double', 'Sea', TRUE, FALSE, NULL),
(15, 2, 192.83, 'TV, Air Condition, Fridge', 'Quad', 'Mountain', TRUE, FALSE, NULL),
(15, 3, 249.66, 'TV, Air Condition, Fridge', 'Single', 'None', TRUE, FALSE, NULL),
(15, 4, 298.42, 'TV, Air Condition, Fridge', 'Double', 'None', TRUE, FALSE, NULL),
(15, 5, 350.81, 'TV, Air Condition, Fridge', 'Triple', 'None', FALSE, FALSE, NULL),
(16, 1, 148.63, 'TV, Air Condition, Fridge', 'Single', 'Sea', FALSE, FALSE, NULL),
(16, 2, 216.65, 'TV, Air Condition, Fridge', 'Quad', 'None', FALSE, TRUE, 'AC not working'),
(16, 3, 266.08, 'TV, Air Condition, Fridge', 'Triple', 'Sea', TRUE, TRUE, 'Stained carpet near bed'),
(16, 4, 290.21, 'TV, Air Condition, Fridge', 'Single', 'None', TRUE, TRUE, 'AC not working'),
(16, 5, 345.36, 'TV, Air Condition, Fridge', 'Quad', 'Sea', TRUE, FALSE, NULL),
(17, 1, 145.49, 'TV, Air Condition, Fridge', 'Quad', 'None', TRUE, TRUE, 'Desk drawer stuck'),
(17, 2, 184.06, 'TV, Air Condition, Fridge', 'Quad', 'Mountain', TRUE, FALSE, NULL),
(17, 3, 266.16, 'TV, Air Condition, Fridge', 'Single', 'None', TRUE, TRUE, 'Desk drawer stuck'),
(17, 4, 295.3, 'TV, Air Condition, Fridge', 'Quad', 'Mountain', TRUE, FALSE, NULL),
(17, 5, 332.95, 'TV, Air Condition, Fridge', 'Single', 'Sea', TRUE, FALSE, NULL),
(18, 1, 168.81, 'TV, Air Condition, Fridge', 'Quad', 'Sea', FALSE, FALSE, NULL),
(18, 2, 198.31, 'TV, Air Condition, Fridge', 'Single', 'None', TRUE, FALSE, NULL),
(18, 3, 232.43, 'TV, Air Condition, Fridge', 'Quad', 'Mountain', TRUE, FALSE, NULL),
(18, 4, 280.94, 'TV, Air Condition, Fridge', 'Double', 'Sea', TRUE, FALSE, NULL),
(18, 5, 330.18, 'TV, Air Condition, Fridge', 'Quad', 'None', TRUE, FALSE, NULL),
(19, 1, 134.29, 'TV, Air Condition, Fridge', 'Single', 'Sea', TRUE, TRUE, 'Desk drawer stuck'),
(19, 2, 202.38, 'TV, Air Condition, Fridge', 'Double', 'Mountain', TRUE, TRUE, 'Window won''t open'),
(19, 3, 255.02, 'TV, Air Condition, Fridge', 'Quad', 'Mountain', TRUE, FALSE, NULL),
(19, 4, 300.35, 'TV, Air Condition, Fridge', 'Double', 'None', TRUE, FALSE, NULL),
(19, 5, 340.44, 'TV, Air Condition, Fridge', 'Single', 'Sea', TRUE, FALSE, NULL),
(20, 1, 133.73, 'TV, Air Condition, Fridge', 'Single', 'None', FALSE, FALSE, NULL),
(20, 2, 206.51, 'TV, Air Condition, Fridge', 'Double', 'None', FALSE, FALSE, NULL),
(20, 3, 269.68, 'TV, Air Condition, Fridge', 'Single', 'Mountain', FALSE, TRUE, 'Lighting issues in bathroom'),
(20, 4, 287.21, 'TV, Air Condition, Fridge', 'Double', 'None', FALSE, FALSE, NULL),
(20, 5, 366.56, 'TV, Air Condition, Fridge', 'Triple', 'Mountain', FALSE, FALSE, NULL),
(21, 1, 133.94, 'TV, Air Condition, Fridge', 'Quad', 'Mountain', FALSE, TRUE, 'Leaky faucet in bathroom'),
(21, 2, 180.88, 'TV, Air Condition, Fridge', 'Triple', 'Sea', TRUE, FALSE, NULL),
(21, 3, 243.35, 'TV, Air Condition, Fridge', 'Single', 'Mountain', TRUE, FALSE, NULL),
(21, 4, 285.45, 'TV, Air Condition, Fridge', 'Quad', 'None', FALSE, FALSE, NULL),
(21, 5, 350.68, 'TV, Air Condition, Fridge', 'Triple', 'Mountain', TRUE, TRUE, 'Desk drawer stuck'),
(22, 1, 143.14, 'TV, Air Condition, Fridge', 'Quad', 'None', FALSE, TRUE, 'Lighting issues in bathroom'),
(22, 2, 180.77, 'TV, Air Condition, Fridge', 'Triple', 'Sea', TRUE, TRUE, 'Desk drawer stuck'),
(22, 3, 248.75, 'TV, Air Condition, Fridge', 'Triple', 'Sea', FALSE, FALSE, NULL),
(22, 4, 284.09, 'TV, Air Condition, Fridge', 'Triple', 'Sea', TRUE, TRUE, 'Lighting issues in bathroom'),
(22, 5, 353.34, 'TV, Air Condition, Fridge', 'Triple', 'None', FALSE, TRUE, 'Lighting issues in bathroom'),
(23, 1, 167.18, 'TV, Air Condition, Fridge', 'Triple', 'None', TRUE, FALSE, NULL),
(23, 2, 196.39, 'TV, Air Condition, Fridge', 'Double', 'Sea', TRUE, FALSE, NULL),
(23, 3, 236.44, 'TV, Air Condition, Fridge', 'Triple', 'Sea', FALSE, FALSE, NULL),
(23, 4, 318.39, 'TV, Air Condition, Fridge', 'Triple', 'None', TRUE, FALSE, NULL),
(23, 5, 337.13, 'TV, Air Condition, Fridge', 'Single', 'Sea', TRUE, TRUE, 'Fridge not cooling properly'),
(24, 1, 142.56, 'TV, Air Condition, Fridge', 'Double', 'Sea', FALSE, FALSE, NULL),
(24, 2, 195.57, 'TV, Air Condition, Fridge', 'Double', 'Sea', TRUE, FALSE, NULL),
(24, 3, 259.71, 'TV, Air Condition, Fridge', 'Single', 'Sea', TRUE, FALSE, NULL),
(24, 4, 294.89, 'TV, Air Condition, Fridge', 'Quad', 'Mountain', FALSE, FALSE, NULL),
(24, 5, 336.33, 'TV, Air Condition, Fridge', 'Double', 'Sea', TRUE, FALSE, NULL),
(25, 1, 161.89, 'TV, Air Condition, Fridge', 'Single', 'None', FALSE, FALSE, NULL),
(25, 2, 214.25, 'TV, Air Condition, Fridge', 'Triple', 'None', FALSE, FALSE, NULL),
(25, 3, 261.9, 'TV, Air Condition, Fridge', 'Single', 'Mountain', FALSE, FALSE, NULL),
(25, 4, 295.2, 'TV, Air Condition, Fridge', 'Quad', 'Sea', FALSE, FALSE, NULL),
(25, 5, 334.58, 'TV, Air Condition, Fridge', 'Triple', 'None', TRUE, TRUE, 'Fridge not cooling properly'),
(26, 1, 162.89, 'TV, Air Condition, Fridge', 'Double', 'None', FALSE, FALSE, NULL),
(26, 2, 202.92, 'TV, Air Condition, Fridge', 'Double', 'Sea', TRUE, FALSE, NULL),
(26, 3, 242.49, 'TV, Air Condition, Fridge', 'Double', 'Sea', TRUE, FALSE, NULL),
(26, 4, 319.72, 'TV, Air Condition, Fridge', 'Triple', 'Mountain', FALSE, FALSE, NULL),
(26, 5, 355.72, 'TV, Air Condition, Fridge', 'Single', 'Sea', FALSE, FALSE, NULL),
(27, 1, 169.6, 'TV, Air Condition, Fridge', 'Single', 'None', FALSE, FALSE, NULL),
(27, 2, 190.53, 'TV, Air Condition, Fridge', 'Single', 'None', FALSE, TRUE, 'Lighting issues in bathroom'),
(27, 3, 239.32, 'TV, Air Condition, Fridge', 'Single', 'None', FALSE, FALSE, NULL),
(27, 4, 306.03, 'TV, Air Condition, Fridge', 'Single', 'Mountain', TRUE, FALSE, NULL),
(27, 5, 356.99, 'TV, Air Condition, Fridge', 'Quad', 'None', TRUE, FALSE, NULL),
(28, 1, 161.65, 'TV, Air Condition, Fridge', 'Double', 'Mountain', FALSE, FALSE, NULL),
(28, 2, 213.51, 'TV, Air Condition, Fridge', 'Double', 'None', TRUE, FALSE, NULL),
(28, 3, 251.89, 'TV, Air Condition, Fridge', 'Double', 'Sea', FALSE, FALSE, NULL),
(28, 4, 302.25, 'TV, Air Condition, Fridge', 'Triple', 'None', TRUE, TRUE, 'Stained carpet near bed'),
(28, 5, 347.49, 'TV, Air Condition, Fridge', 'Double', 'None', TRUE, TRUE, 'Broken balcony door lock'),
(29, 1, 145.68, 'TV, Air Condition, Fridge', 'Quad', 'Sea', TRUE, FALSE, NULL),
(29, 2, 204.16, 'TV, Air Condition, Fridge', 'Triple', 'None', FALSE, FALSE, NULL),
(29, 3, 239.85, 'TV, Air Condition, Fridge', 'Quad', 'Mountain', TRUE, FALSE, NULL),
(29, 4, 315.6, 'TV, Air Condition, Fridge', 'Double', 'Mountain', TRUE, FALSE, NULL),
(29, 5, 350.14, 'TV, Air Condition, Fridge', 'Single', 'Mountain', TRUE, TRUE, 'Window won''t open'),
(30, 1, 147.74, 'TV, Air Condition, Fridge', 'Double', 'Sea', FALSE, TRUE, 'Desk drawer stuck'),
(30, 2, 190.79, 'TV, Air Condition, Fridge', 'Quad', 'Sea', FALSE, FALSE, NULL),
(30, 3, 262.33, 'TV, Air Condition, Fridge', 'Quad', 'Mountain', TRUE, FALSE, NULL),
(30, 4, 295.38, 'TV, Air Condition, Fridge', 'Quad', 'Sea', TRUE, FALSE, NULL),
(30, 5, 361.93, 'TV, Air Condition, Fridge', 'Single', 'Mountain', TRUE, FALSE, NULL),
(31, 1, 145.48, 'TV, Air Condition, Fridge', 'Double', 'Mountain', TRUE, TRUE, 'Leaky faucet in bathroom'),
(31, 2, 189.03, 'TV, Air Condition, Fridge', 'Quad', 'None', FALSE, FALSE, NULL),
(31, 3, 257.68, 'TV, Air Condition, Fridge', 'Triple', 'None', TRUE, FALSE, NULL),
(31, 4, 293.94, 'TV, Air Condition, Fridge', 'Quad', 'Sea', TRUE, FALSE, NULL),
(31, 5, 330.8, 'TV, Air Condition, Fridge', 'Quad', 'Mountain', FALSE, FALSE, NULL),
(32, 1, 139.37, 'TV, Air Condition, Fridge', 'Quad', 'Mountain', FALSE, FALSE, NULL),
(32, 2, 199.7, 'TV, Air Condition, Fridge', 'Quad', 'Sea', FALSE, FALSE, NULL),
(32, 3, 252.81, 'TV, Air Condition, Fridge', 'Triple', 'Sea', TRUE, FALSE, NULL),
(32, 4, 305.84, 'TV, Air Condition, Fridge', 'Quad', 'Sea', TRUE, FALSE, NULL),
(32, 5, 366.73, 'TV, Air Condition, Fridge', 'Single', 'Mountain', TRUE, FALSE, NULL),
(33, 1, 157.1, 'TV, Air Condition, Fridge', 'Quad', 'Mountain', FALSE, TRUE, 'Window won''t open'),
(33, 2, 200.96, 'TV, Air Condition, Fridge', 'Double', 'Mountain', FALSE, FALSE, NULL),
(33, 3, 251.27, 'TV, Air Condition, Fridge', 'Quad', 'Mountain', FALSE, FALSE, NULL),
(33, 4, 286.57, 'TV, Air Condition, Fridge', 'Quad', 'Sea', TRUE, TRUE, 'Desk drawer stuck'),
(33, 5, 333.4, 'TV, Air Condition, Fridge', 'Single', 'Sea', TRUE, FALSE, NULL),
(34, 1, 144.38, 'TV, Air Condition, Fridge', 'Single', 'Mountain', FALSE, FALSE, NULL),
(34, 2, 205.02, 'TV, Air Condition, Fridge', 'Triple', 'Mountain', TRUE, FALSE, NULL),
(34, 3, 268.11, 'TV, Air Condition, Fridge', 'Single', 'None', FALSE, FALSE, NULL),
(34, 4, 312.25, 'TV, Air Condition, Fridge', 'Quad', 'Sea', FALSE, FALSE, NULL),
(34, 5, 334.89, 'TV, Air Condition, Fridge', 'Quad', 'Mountain', TRUE, FALSE, NULL),
(35, 1, 143.85, 'TV, Air Condition, Fridge', 'Triple', 'Mountain', TRUE, FALSE, NULL),
(35, 2, 186.63, 'TV, Air Condition, Fridge', 'Triple', 'None', TRUE, FALSE, NULL),
(35, 3, 231.71, 'TV, Air Condition, Fridge', 'Quad', 'Sea', TRUE, FALSE, NULL),
(35, 4, 283.75, 'TV, Air Condition, Fridge', 'Double', 'Mountain', TRUE, FALSE, NULL),
(35, 5, 340.04, 'TV, Air Condition, Fridge', 'Single', 'Sea', TRUE, TRUE, 'Desk drawer stuck'),
(36, 1, 149.37, 'TV, Air Condition, Fridge', 'Triple', 'Sea', TRUE, FALSE, NULL),
(36, 2, 212.32, 'TV, Air Condition, Fridge', 'Triple', 'Sea', TRUE, FALSE, NULL),
(36, 3, 231.32, 'TV, Air Condition, Fridge', 'Triple', 'None', FALSE, FALSE, NULL),
(36, 4, 288.18, 'TV, Air Condition, Fridge', 'Quad', 'Mountain', TRUE, TRUE, 'Desk drawer stuck'),
(36, 5, 352.6, 'TV, Air Condition, Fridge', 'Double', 'Sea', FALSE, TRUE, 'Stained carpet near bed'),
(37, 1, 138.74, 'TV, Air Condition, Fridge', 'Double', 'None', FALSE, TRUE, 'Lighting issues in bathroom'),
(37, 2, 181.47, 'TV, Air Condition, Fridge', 'Quad', 'Sea', FALSE, FALSE, NULL),
(37, 3, 261.03, 'TV, Air Condition, Fridge', 'Triple', 'Mountain', FALSE, FALSE, NULL),
(37, 4, 317.51, 'TV, Air Condition, Fridge', 'Quad', 'Sea', TRUE, FALSE, NULL),
(37, 5, 358.14, 'TV, Air Condition, Fridge', 'Double', 'Sea', TRUE, FALSE, NULL),
(38, 1, 168.39, 'TV, Air Condition, Fridge', 'Double', 'Sea', FALSE, FALSE, NULL),
(38, 2, 207.02, 'TV, Air Condition, Fridge', 'Quad', 'Mountain', TRUE, FALSE, NULL),
(38, 3, 231.42, 'TV, Air Condition, Fridge', 'Double', 'Sea', TRUE, TRUE, 'Loose tiles in shower'),
(38, 4, 280.07, 'TV, Air Condition, Fridge', 'Quad', 'None', TRUE, FALSE, NULL),
(38, 5, 340.44, 'TV, Air Condition, Fridge', 'Single', 'Mountain', TRUE, TRUE, 'Lighting issues in bathroom'),
(39, 1, 166.36, 'TV, Air Condition, Fridge', 'Double', 'Mountain', TRUE, TRUE, 'AC not working'),
(39, 2, 207.33, 'TV, Air Condition, Fridge', 'Quad', 'Sea', TRUE, FALSE, NULL),
(39, 3, 249.58, 'TV, Air Condition, Fridge', 'Quad', 'None', TRUE, FALSE, NULL),
(39, 4, 285.53, 'TV, Air Condition, Fridge', 'Double', 'Mountain', TRUE, FALSE, NULL),
(39, 5, 355.78, 'TV, Air Condition, Fridge', 'Quad', 'None', TRUE, FALSE, NULL),
(40, 1, 150.46, 'TV, Air Condition, Fridge', 'Single', 'Mountain', TRUE, TRUE, 'Leaky faucet in bathroom'),
(40, 2, 216.36, 'TV, Air Condition, Fridge', 'Triple', 'Sea', TRUE, FALSE, NULL),
(40, 3, 266.2, 'TV, Air Condition, Fridge', 'Quad', 'None', TRUE, FALSE, NULL),
(40, 4, 293.78, 'TV, Air Condition, Fridge', 'Single', 'Sea', FALSE, FALSE, NULL);

-- START OF: SQLProject/Inserts/Insert_Bookings.sql
INSERT INTO Booking (CustomerID, RoomID, StartDate, EndDate, Status)
VALUES 
-- Bookings for Hotel 1
(1, 1, '2023-11-01', '2023-11-05', 'Booked'),
(2, 2, '2023-11-10', '2023-11-15', 'Booked'),

-- Bookings for Hotel 2
(3, 6, '2023-11-20', '2023-11-25', 'Booked'),
(4, 7, '2023-12-01', '2023-12-05', 'Booked'),

-- Bookings for Hotel 3
(5, 11, '2023-12-10', '2023-12-15', 'Booked'),
(6, 12, '2023-12-20', '2023-12-25', 'Booked'),

-- Bookings for Hotel 4
(7, 16, '2024-01-01', '2024-01-05', 'Booked'),
(8, 17, '2024-01-10', '2024-01-15', 'Booked'),

-- Bookings for Hotel 5
(9, 21, '2024-01-20', '2024-01-25', 'Booked'),
(10, 22, '2024-02-01', '2024-02-05', 'Booked');

-- START OF: SQLProject/Inserts/Insert_Rentings.sql
INSERT INTO Renting (RoomID, BookingID, EmployeeID, CustomerID, CheckInDate, CheckOutDate, PaymentStatus)
VALUES 
-- Rentings for Hotel 1
(10, 1, 1, 5, '2023-11-01', '2023-11-05', 'Paid'),
(78, 2, 2, 8,'2023-11-10', '2023-11-15', 'Paid'),

-- Rentings for Hotel 2
(34, 3, 3, 2, '2023-11-20', '2023-11-25', 'Paid'),
(87, 4, 4, 6,'2023-12-01', '2023-12-05', 'Paid'),

-- Rentings for Hotel 3
(23, 5, 5, 9, '2023-12-10', '2023-12-15', 'Paid');


-- START OF: SQLProject/Queries/Queries.sql
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

-- START OF: SQLProject/Indexes/Indexes.sql
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


-- START OF: SQLProject/Triggers/Testing_Triggers.sql
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
INSERT INTO Employee (HotelID, FullName, Address, SSN_SIN, Role)
VALUES (8, 'Test Employee', '3101 Test, City 37, CA', '123-35-6729', 'Receptionist');


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

-- START OF: SQLProject/Triggers/Triggers.sql
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


-- START OF: SQLProject/Views/available_capacity_per_hotel.sql
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

-- START OF: SQLProject/Views/available_rooms_per_area.sql
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

