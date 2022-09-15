DROP TABLE IF EXISTS Taverns;
DROP TABLE IF EXISTS Supplies;
DROP TABLE IF EXISTS TavernSupplies;
DROP TABLE IF EXISTS OurServices;
DROP TABLE IF EXISTS StatusTypes;
DROP TABLE IF EXISTS TavernServices;
DROP TABLE IF EXISTS ServiceSales;

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
