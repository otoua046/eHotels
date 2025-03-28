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