DROP TABLE IF EXISTS OurServices;
DROP TABLE IF EXISTS StatusTypes;
DROP TABLE IF EXISTS Supplies;
DROP TABLE IF EXISTS RoomStatuses;
DROP TABLE IF EXISTS Classes; 
DROP TABLE IF EXISTS GuestClasses;
DROP TABLE IF EXISTS Guests;
DROP TABLE IF EXISTS Taverns;
DROP TABLE IF EXISTS TavernServices;
DROP TABLE IF EXISTS TavernSupplies;
DROP TABLE IF EXISTS Rooms;
DROP TABLE IF EXISTS ServiceSales;
DROP TABLE IF EXISTS RoomSales;
DROP TABLE IF EXISTS Statuses;
DROP TABLE IF EXISTS Roles;

CREATE TABLE Taverns (
	Id INTEGER NOT NULL IDENTITY(1,1) PRIMARY KEY,
	TavernName VARCHAR(100) NOT NULL
);

CREATE TABLE Supplies (
	Id INTEGER NOT NULL IDENTITY(1,1) PRIMARY KEY,
	SupplyName VARCHAR(100) NOT NULL,
	CostInGoldPieces INTEGER NOT NULL,
	SupplyUnit VARCHAR(50) NOT NULL
);

CREATE TABLE TavernSupplies (
	Id INTEGER NOT NULL IDENTITY(1,1) PRIMARY KEY,
	TavernId INTEGER NOT NULL,
	FOREIGN KEY (TavernId) REFERENCES Taverns(Id),
	SupplyId INTEGER NOT NULL,
	FOREIGN KEY (SupplyId) REFERENCES Supplies(Id),
	SupplyAmount INTEGER,
	LastUpdated DATE
);

CREATE TABLE OurServices (
	Id INTEGER NOT NULL IDENTITY(1,1) PRIMARY KEY,
	ServiceName VARCHAR(50) NOT NULL
);

CREATE TABLE StatusTypes (
	Id INTEGER NOT NULL IDENTITY(1,1) PRIMARY KEY,
	Status VARCHAR(50) NOT NULL
);

CREATE TABLE TavernServices (
	Id INTEGER NOT NULL IDENTITY(1,1) PRIMARY KEY,
	TavernId INTEGER NOT NULL,
	FOREIGN KEY (TavernId) REFERENCES Taverns(Id),
	ServiceId INTEGER NOT NULL,
	FOREIGN KEY (ServiceId) REFERENCES OurServices(Id),
	StatusId INTEGER NOT NULL
	FOREIGN KEY (StatusId) REFERENCES StatusTypes(Id),
);

CREATE Table Statuses (
	Id Integer NOT NULL IDENTITY(1,1) PRIMARY KEY,
	StatusName VARCHAR(50) NOT NULL
);

CREATE TABLE Classes (
	Id INTEGER NOT NULL IDENTITY(1,1) PRIMARY KEY,
	ClassName VARCHAR(50),
);

CREATE TABLE Roles (
	Id INTEGER NOT NULL IDENTITY(1,1) PRIMARY KEY,
	RoleName VARCHAR(50) NOT NULL

);

CREATE TABLE Guests (
	Id INTEGER NOT NULL IDENTITY(1,1) PRIMARY KEY,
	GuestName VARCHAR(50) NOT NULL,
	NotesAboutGuest VARCHAR(100),
	GuestBday DATE NOT NULL,
	GuestStatusId INTEGER NOT NULL,
	FOREIGN KEY (GuestStatusId) REFERENCES Statuses(Id),
	GuestLevel INTEGER NOT NULL,
	GuestTavernId INTEGER NOT NULL,
	FOREIGN KEY (GuestTavernId) REFERENCES Taverns(Id),
	RoleId INTEGER NOT NULL,
	FOREIGN KEY (RoleId) REFERENCES Roles(Id),

);

CREATE TABLE GuestClasses (
	Id INTEGER NOT NULL IDENTITY(1,1) PRIMARY KEY,
	GuestId INTEGER NOT NULL,
	FOREIGN KEY (GuestId) REFERENCES Guests(Id),
	ClassOne INTEGER NOT NULL,
	FOREIGN KEY (ClassOne) REFERENCES Classes(Id),
	ClassTwo INTEGER,
	FOREIGN KEY (ClassTwo) REFERENCES Classes(Id),
	ClassThree INTEGER,
	FOREIGN KEY (ClassThree) REFERENCES Classes(Id),
);

CREATE TABLE ServiceSales (
	Id INTEGER NOT NULL IDENTITY(1,1) PRIMARY KEY,
	TavernAndServiceId INTEGER NOT NULL,
	FOREIGN KEY (TavernAndServiceId) REFERENCES TavernServices(Id),
	GuestId INTEGER NOT NULL,
	FOREIGN KEY (GuestId) REFERENCES Guests(Id),
	CostOfService INTEGER NOT NULL,
	DatePurchased DATE NOT NULL,
	AmountPurchased INTEGER NOT NULL
);

CREATE TABLE RoomStatuses (
	Id INTEGER NOT NULL IDENTITY(1,1) PRIMARY KEY,
	RoomStatus VARCHAR(25) NOT NULL
);

CREATE TABLE Rooms (
	Id INTEGER NOT NULL IDENTITY(1,1) PRIMARY KEY,
	TavernsId INTEGER NOT NULL,
	FOREIGN KEY (TavernsId) REFERENCES Taverns(Id),
	RoomStatusId INTEGER NOT NULL,
	FOREIGN KEY (RoomStatusId) REFERENCES RoomStatuses(Id)
);

CREATE TABLE RoomSales (
	Id INTEGER NOT NULL IDENTITY(1,1) PRIMARY KEY,
	GuestId INTEGER NOT NULL,
	FOREIGN KEY (GuestId) REFERENCES Guests(Id),
	RoomId INTEGER NOT NULL,
	FOREIGN KEY (RoomId) REFERENCES Rooms(Id),
	RoomSaleDate DATE NOT NULL,
	RoomSellCost INTEGER NOT NULL,
);

INSERT INTO Taverns (TavernName)
VALUES
	('Holland'),
	('Kel'),
	('Prancing Pony'),
	('Drunken Sailor'),
	('Gangplanks Bar and Grill');

INSERT INTO Supplies (SupplyName, CostInGoldPieces, SupplyUnit)
VALUES
	('Steaks', 5, 'lbs'),
	('Strong Ale', 2, 'barrels'),
	('Weak Ale', 1, 'barrels'),
	('Swords', 10, 'blades'),
	('Oranges', 20, 'bags');

INSERT INTO TavernSupplies (TavernId, SupplyId, SupplyAmount, LastUpdated)
VALUES
	(1, 1, 50, '1958-01-31'),
	(1, 2, 13, '1958-01-31'),
	(1, 3, 6, '1958-01-31'),
	(1, 4, 21, '1958-01-31'),
	(1, 5, 203, '1958-01-31'),
	(2, 1, 32, '1932-11-29'),
	(2, 3, 50, '1932-11-29'),
	(3, 1, 50, '1958-01-31'),
	(4, 1, 50, '1958-01-31'),
	(5, 1, 50, '1958-01-31');

INSERT INTO OurServices (ServiceName)
VALUES
	('Weapon Sharpening'),
	('Armor Polishing'),
	('Hair Styling');

INSERT INTO StatusTypes (Status)
VALUES
	('Active'),
	('Inactive');

INSERT INTO TavernServices (TavernId, ServiceId, StatusId)
VALUES 
	(1, 1, 1),
	(1, 2, 2),
	(2, 1, 2),
	(2, 2, 1),
	(3, 1, 1),
	(4, 1, 2),
	(5, 2, 1);

INSERT INTO Statuses (StatusName)
VALUES
	('sick'),
	('fine'),
	('hangry'),
	('raging'),
	('placid');

INSERT INTO Classes (ClassName)
VALUES
	('Fighter'),
	('Paladin'),
	('Mage'),
	('Rogue'),
	('Druid');

INSERT INTO Roles (RoleName)
VALUES
	('Guest'),
	('Admin');

INSERT INTO RoomStatuses (RoomStatus)
VALUES
	('Occupied'),
	('Vacant');

INSERT INTO Guests (GuestName, NotesAboutGuest, GuestBday, GuestStatusId, GuestLevel, GuestTavernId, RoleId)
VALUES
	('Tyler Hill', 'Dead inside', '1958-01-31', 5, 1, 1, 2),
	('Jerome Hill', 'Also Dead inside', '1959-01-31', 3, 10, 1, 1),
	('Larry Holland', 'Super Strong', '1997-01-31', 2, 20, 1, 2),
	('Kayle Gross', 'An actual druid', '1969-02-14', 4, 7, 2, 1),
	('Olley Dolley', 'Super Sweet', '1919-12-25', 1, 19, 3, 2);

INSERT INTO GuestClasses (GuestId, ClassOne, ClassTwo)
VALUES
	(1, 1, 3),
	(2, 1, 4),
	(3, 2, NULL),
	(4, 3, NULL),
	(5, 4, NULL);

INSERT INTO ServiceSales (TavernAndServiceId, GuestId, CostOfService, DatePurchased, AmountPurchased)
VALUES
	(1, 1, 10, '1958-01-31', 1),
	(4, 3, 5, '1959-01-31', 1),
	(5, 4, 8, '1958-01-31', 1);

INSERT INTO Rooms (TavernsId, RoomStatusId)
VALUES
	(1, 1),
	(1, 1),
	(1, 1),
	(1, 2),
	(2, 2),
	(2, 2),
	(2, 2),
	(2, 2),
	(2, 2),
	(2, 2);

INSERT INTO RoomSales (GuestId, RoomId, RoomSaleDate, RoomSellCost)
VALUES
	(1, 1, '1959-01-31', 100),
	(3, 5, '1959-04-20', 150),
	(2, 2, '1959-02-14', 100),
	(4, 4, '1959-02-14', 100);

SELECT GuestName FROM Guests WHERE RoleId = 2;

Select GuestName, TavernName

FROM Guests
LEFT JOIN Taverns
ON Guests.GuestTavernId = Taverns.Id
WHERE RoleId = 2;

Select GuestName, GuestLevel, ClassOne, ClassTwo

FROM Guests
LEFT JOIN GuestClasses
ON Guests.Id = GuestClasses.Id
LEFT JOIN Classes
ON Classes.Id = GuestClasses.Id
ORDER BY GuestName ASC;

SELECT TOP 10 CostOfService FROM ServiceSales ORDER BY CostOfService DESC;

SELECT TOP 10 TavernAndServiceId, CostOfService, ServiceName 

FROM ServiceSales 

LEFT JOIN TavernServices
ON ServiceSales.TavernAndServiceId = TavernServices.Id
LEFT JOIN OurServices
ON TavernServices.ServiceId = OurServices.Id

ORDER BY CostOfService DESC;

SELECT *

FROM GuestClasses

WHERE ClassTwo > 0;

SELECT *

FROM GuestClasses

WHERE ClassTwo > 0 AND ClassTwo > 5;

--My Levels are associated globally. I can change this if required I also will have questions for this in class

SELECT GuestName, RoomSaleDate 

FROM RoomSales
LEFT JOIN Guests
ON RoomSales.GuestId = Guests.Id
WHERE RoomSaleDate BETWEEN '1959-01-30' AND '1959-02-15';

