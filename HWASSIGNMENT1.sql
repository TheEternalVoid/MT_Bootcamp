DROP TABLE IF EXISTS Statuses;
DROP TABLE IF EXISTS Classes;
DROP TABLE IF EXISTS Supplies;
DROP TABLE IF EXISTS OurServices;
DROP TABLE IF EXISTS Taverns;
DROP TABLE IF EXISTS TavernSupplies;
DROP TABLE IF EXISTS StatusTypes;
DROP TABLE IF EXISTS TavernServices;
DROP TABLE IF EXISTS ServiceSales;
DROP TABLE IF EXISTS Guests;

CREATE TABLE Taverns (
	Id INTEGER NOT NULL IDENTITY(1,1) PRIMARY KEY,
	TavernName VARCHAR(100) NOT NULL
);

CREATE TABLE Supplies (
	Id INTEGER NOT NULL IDENTITY(1,1) PRIMARY KEY,
	SupplyName VARCHAR(100) NOT NULL,
	CostInGoldPieces INTEGER NOT NULL
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

CREATE TABLE ServiceSales (
	Id INTEGER NOT NULL IDENTITY(1,1) PRIMARY KEY,
	TavernAndServiceId INTEGER NOT NULL,
	FOREIGN KEY (TavernAndServiceId) REFERENCES TavernServices(Id),
	GuestName VARCHAR(50),
	CostOfService INTEGER NOT NULL,
	DatePurchased DATE NOT NULL,
	AmountPurchased INTEGER NOT NULL
);

CREATE Table Statuses (
	Id Integer NOT NULL IDENTITY(1,1) PRIMARY KEY,
	StatusName VARCHAR(50) NOT NULL
);

CREATE Table Classes (
	Id INTEGER NOT NULL IDENTITY(1,1) PRIMARY KEY,
	ClassName VARCHAR(50),
);


CREATE TABLE Guests (
	Id INTEGER NOT NULL IDENTITY(1,1) PRIMARY KEY,
	GuestName VARCHAR(50) NOT NULL,
	NotesAboutGuest VARCHAR(100),
	GuestBday DATE NOT NULL,
	GuestStatusId INTEGER NOT NULL,
	FOREIGN KEY (GuestStatusId) REFERENCES Statuses(Id),
	GuestClassId INTEGER NOT NULL,
	FOREIGN KEY (GuestClassId) REFERENCES Classes(Id),
	GuestLevel INTEGER NOT NULL
);

INSERT INTO Taverns (TavernName)
VALUES
	('Holland'),
	('Kel'),
	('Prancing Pony'),
	('Drunken Sailor'),
	('Gangplanks Bar and Grill');

INSERT INTO Supplies (SupplyName, CostInGoldPieces)
VALUES
	('Barrels', 5),
	('Strong Ale', 2),
	('Weak Ale', 1),
	('Swords', 10),
	('Oranges', 20);

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

INSERT INTO ServiceSales (TavernAndServiceId, GuestName, CostOfService, DatePurchased, AmountPurchased)
VALUES
	(1, 'Tyler Hill', 10, '1958-01-31', 1),
	(4, 'Bob Jim', 5, '1959-01-31', 1),
	(5, 'Tyler Hill', 8, '1958-01-31', 1);

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

INSERT INTO Guests (GuestName, NotesAboutGuest, GuestBday, GuestStatusId, GuestClassId, GuestLevel)
VALUES
	('Tyler Hill', 'Dead inside', '1958-01-31', 5, 1, 1),
	('Jerome Hill', 'Also Dead inside', '1959-01-31', 3, 2, 10),
	('Larry Holland', 'Super Strong', '1997-01-31', 2, 1, 20),
	('Kayle Gross', 'An actual druid', '1969-02-14', 4, 5, 7),
	('Olley Dolley', 'Super Sweet', '1919-12-25', 1, 3, 19);