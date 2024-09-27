--Laboratory 2b – Star Schemas
--PART I: The USELOG Case Study

--Tasks
--Given the requirements above, complete the following:
--1. Create a star schema for the USELOG data.
--2. Define the dimensions and attributes for the USELOG star schema.
--3. Write the SQL statements for the implementation of the star schema.
--The following operational databases have been provided for you:
--dw.Class: table that stores information about classification ids and descriptions
--dw.Major: table that stores information about major codes and descriptions
--dw.Student: table that stores information about students as described above
--dw.Uselog: table that stores information about lab usage as described above
--You do not need to copy these four tables (dw.Class, dw.Major, dw.Student,
--and dw.Uselog) into your account. You can just simply use these tables.

--create Major Dim
select * from dw.major;

create table major_dim as
select major_code, major_name 
from dw.major;

--Create Time_Period_Dim
select * from dw.uselog;

create table LabTime_Dim (
 Time_ID NUMBER,
 Time_Desc VARCHAR2(15),
 Begin_Time DATE,
 End_Time DATE
);

--Create Semester DIM
select * from dw.uselog;

create table semester_dim
(Sem_ID varchar2(10), sem_desc varchar2(20), begin_date date, end_date date );

--Create Class DIM
select * from dw.Class;

create table class_dim as
select class_id, class_description 
from dw.class;


-- populate semester dimension for Semester 1 and Semester 2
-- (the begin and end date can be changed according to the case)
INSERT INTO Semester_DIM
 VALUES ('S1', 'Semester1', TO_DATE('01-JAN', 'DD-MON'),
 TO_DATE('15-JUL', 'DD-MON'));
INSERT INTO Semester_DIM
 VALUES ('S2', 'Semester2', TO_DATE('16-JUL', 'DD-MON'),
 TO_DATE('31-DEC', 'DD-MON'));

select * from Semester_DIM;


--populate labtime dimension
-- populate labtime dimension for morning, afternoon and night
-- (the begin and end time can be changed according to the case)
INSERT INTO LabTime_DIM
 VALUES(1, 'morning', TO_DATE('06:01', 'HH24:MI'),
 TO_DATE('12:00', 'HH24:MI'));
INSERT INTO LabTime_DIM
 VALUES(2, 'afternoon', TO_DATE('12:01', 'HH24:MI'),
 TO_DATE('18:00', 'HH24:MI'));
INSERT INTO LabTime_DIM
 VALUES(3, 'night', TO_DATE('18:01', 'HH24:MI'),
 TO_DATE('06:00', 'HH24:MI'));
---------------------------------------


--The Fact Table

select * from dw.uselog;
select * from dw.student;


DROP TABLE Temp_Fact_Uselog CASCADE CONSTRAINTS PURGE;
--create table temp_fact_uselog as 

select * 
from dw.uselog u,
dw.student s 
where 
u.student_id = s.student_id;

create table uselog_fact as 
select 
s.sem_id,
m.major_code,
l.time_id,
c.class_id,


--4. Write the SQL statements to produce the following reports:
--a. Show the usage numbers by different time periods (e.g. morning,
--afternoon, night)




--b. Show the usage numbers by time period (e.g. morning, afternoon,
--night), by major, and by student's class



--c. Show the usage numbers for different majors and semesters (e.g.
--semester 1, semester 2).



--PART II: The ROBCOR Aviation Charters Case Study

--Given these requirements, complete the following:
--1. Create a star schema for the charter data.

--2. Define the dimensions and attributes for the charter operation’s star schema.

--3. Define the SQL statements for the implementation of the star schema.

--4. Write the SQL statements to produce the following reports:

--a. Show the total revenue each year

--b. Show the total hours flown by each pilot

--c. Show the total fuel used by each aircraft model
