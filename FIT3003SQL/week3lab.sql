--First you need to create the operational database using the following SQL:

Create Table Warehouse
(WarehouseID Varchar2(10) Not Null,
Location Varchar2(10) Not Null,
Primary Key (WarehouseID)
);

Create Table Truck
(TruckID Varchar2(10) Not Null,
VolCapacity Number(5,2),
WeightCategory Varchar2(10),
CostPerKm Number(5,2),
Primary Key (TruckID)
);

Create Table Trip
(TripID Varchar2(10) Not Null,
TripDate Date,
TotalKm Number(5),
TruckID Varchar2(10),
Primary Key (TripID),
Foreign Key (TruckID) References Truck(TruckID)
);
Create Table TripFrom
(TripID Varchar2(10) Not Null,
WarehouseID Varchar2(10) Not Null,
Primary Key (TripID, WarehouseID),
Foreign Key (TripID) References Trip(TripID),
Foreign Key (WarehouseID) References Warehouse(WarehouseID)
);
Create Table Store
(StoreID Varchar2(10) Not Null,
StoreName Varchar2(20),
StoreAddress Varchar2(20),
Primary Key (StoreID)
);
Create Table Destination
(TripID Varchar2(10) Not Null,
StoreID Varchar2(10) Not Null,
Primary Key (TripID, StoreID),
Foreign Key (TripID) References Trip(TripID),
Foreign Key (StoreID) References Store(StoreID)
);
--Insert Records to Operational Database
Insert Into Warehouse Values ('W1','Warehouse1');
Insert Into Warehouse Values ('W2','Warehouse2');
Insert Into Warehouse Values ('W3','Warehouse3');
Insert Into Warehouse Values ('W4','Warehouse4');
Insert Into Warehouse Values ('W5','Warehouse5');
Insert Into Truck Values ('Truck1', 250, 'Medium', 1.2);
Insert Into Truck Values ('Truck2', 300, 'Medium', 1.5);
Insert Into Truck Values ('Truck3', 100, 'Small', 0.8);
Insert Into Truck Values ('Truck4', 550, 'Large', 2.3);
Insert Into Truck Values ('Truck5', 650, 'Large', 2.5);
Insert Into Trip Values ('Trip1', to_date('14-Apr-2013', 'DD-MON-YYYY'), 370, 'Truck1');
Insert Into Trip Values ('Trip2', to_date('14-Apr-2013', 'DD-MON-YYYY'), 570, 'Truck2');
Insert Into Trip Values ('Trip3', to_date('14-Apr-2013', 'DD-MON-YYYY'), 250, 'Truck3');
Insert Into Trip Values ('Trip4', to_date('15-Jul-2013', 'DD-MON-YYYY'), 450, 'Truck1');
Insert Into Trip Values ('Trip5', to_date('15-Jul-2013', 'DD-MON-YYYY'), 175, 'Truck2');
Insert Into TripFrom Values ('Trip1', 'W1');
Insert Into TripFrom Values ('Trip1', 'W4');
Insert Into TripFrom Values ('Trip1', 'W5');
Insert Into TripFrom Values ('Trip2', 'W1');
Insert Into TripFrom Values ('Trip2', 'W2');
Insert Into TripFrom Values ('Trip3', 'W1');
Insert Into TripFrom Values ('Trip3', 'W5');
Insert Into TripFrom Values ('Trip4', 'W1');
Insert Into TripFrom Values ('Trip5', 'W4');
Insert Into TripFrom Values ('Trip5', 'W5');
Insert Into Store Values ('M1', 'Myer City', 'Melbourne');
Insert Into Store Values ('M2', 'Myer Chaddy', 'Chadstone');
Insert Into Store Values ('M3', 'Myer HiPoint', 'High Point');
Insert Into Store Values ('M4', 'Myer West', 'Doncaster');
Insert Into Store Values ('M5', 'Myer North', 'Northland');
Insert Into Store Values ('M6', 'Myer South', 'Southland');
Insert Into Store Values ('M7', 'Myer East', 'Eastland');
Insert Into Store Values ('M8', 'Myer Knox', 'Knox');
Insert Into Destination Values ('Trip1', 'M1');
Insert Into Destination Values ('Trip1', 'M2');
Insert Into Destination Values ('Trip1', 'M4');
Insert Into Destination Values ('Trip1', 'M3');
Insert Into Destination Values ('Trip1', 'M8');
Insert Into Destination Values ('Trip2', 'M4');
Insert Into Destination Values ('Trip2', 'M1');
Insert Into Destination Values ('Trip2', 'M2');


--2. Solution Model 1 – using a Bridge Table
--Your tasks:
--a. Create a dimension table called TruckDim1.

--create as copy of original truck

DROP TABLE truck_dim PURGE;

create table truck_dim1 as
select * 
from truck;

--b. Create a dimension table called TripSeason1. This table will have 4
--records (Summer, Autumn, Winter, and Spring).

create table TripSeason_dim1 
(seasonid Varchar2(10) Not Null,
seasonperiod VARCHAR(20) NOT NULL,
Primary Key (seasonid)
);

INSERT INTO TripSeason_dim1 (SeasonID, seasonperiod)
VALUES
    (1, 'Summer'),
    (2, 'Autumn'),
    (3, 'Winter'),
    (4, 'Spring');

--c. Create a dimension table called TripDim1.

create table tripdim1 as
select tripID, tripdate, totalkm
from trip;

--d. Create a bridge table called BridgeTableDim1.

create table BridgeTableDim1 as
select tripID, storeID
from destination;

--e. Create a dimension table called StoreDim1.

desc store;

create table StoreDim1 as
select storeid, STORENAME, STOREADDRESS
from store;


--f. Create a tempfact (and perform the necessary alter and update), and then
--create the final fact table (called it TruckFact1).

create 

truckid, seasonid, tripid, total_delivery_cost


--g. Display (and observe) the contents of the fact table (TruckFact1).



--3. Solution Model 2 – add a Weight attribute in the Bridge
--a. Create a dimension table called TruckDim2.
--b. Create a dimension table called TripSeason2. This table will have 4
--records (Summer, Autumn, Winter, and Spring).
--c. Create a dimension table called StoreDim2.
--d. Create a bridge table called BridgeTableDim2.
--Notes: tasks (a)-(d) to create dimension tables version 2, are identical to
--the previous tasks (a)-(d) to create dimension tables version 1 in the
--previous section. However, for the sake of completeness of Schema v2,
--you need to create the dimension tables v2. You can either copy directly
--from dimension tables v1, or create the dimension tables v2 the same way
--you did for v1.
--e. Create a dimension table called TripDim2 (Notes: this dimension is
--different from TripDim1 in the previous section).
--f. Create a tempfact (and perform the necessary alter and update), and then
--create the final fact table (called it TruckFact2).
--g. Display (and observe) the contents of the fact table (TruckFact2).
--h. What is the total delivery cost for each store?


--4. Solution Model 3 – A ListAGG version
--Your tasks:
--a. Create a dimension table called TruckDim3.
--b. Create a dimension table called TripSeason3. This table will have 4
--records (Summer, Autumn, Winter, and Spring).
--c. Create a dimension table called StoreDim3.
--d. Create a bridge table called BridgeTableDim3.
--e. Create a dimension table called TripDim3 (Note that TripDim3 is different
--from TripDim1 and TripDim2).
--f. Create a tempfact (and perform the necessary alter and update), and then
--create the final fact table (called it TruckFact3).
--g. Display (and observe) the contents of the fact table (TruckFact3).