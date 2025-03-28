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