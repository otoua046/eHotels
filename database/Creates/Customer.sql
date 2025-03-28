CREATE TABLE Customer (
    CustomerID INT PRIMARY KEY AUTO_INCREMENT,
    FullName VARCHAR(100) NOT NULL,
    Address VARCHAR(255) NOT NULL,
    IDType ENUM('SSN', 'SIN', 'Driving License') NOT NULL,
    RegistrationDate DATE NOT NULL
);

ALTER TABLE Customer
MODIFY COLUMN RegistrationDate DATE DEFAULT (CURRENT_DATE);