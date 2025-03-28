CREATE TABLE Room (
    RoomID INT PRIMARY KEY AUTO_INCREMENT,
    HotelID INT NOT NULL,
    Price DECIMAL(10, 2) NOT NULL,
    Amenities TEXT,
    Capacity ENUM('Single', 'Double', 'Triple', 'Quad') NOT NULL,
    ViewType ENUM('Sea', 'Mountain', 'None') DEFAULT 'None',
    CanBeExtended BOOLEAN DEFAULT FALSE,
    HasDamage BOOLEAN DEFAULT FALSE,
    ProblemDescription TEXT,  
    FOREIGN KEY (HotelID) REFERENCES Hotel(HotelID) ON DELETE CASCADE
);

