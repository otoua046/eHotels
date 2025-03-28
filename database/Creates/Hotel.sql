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