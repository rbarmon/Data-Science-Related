--First you need to create the operational database using the following SQL:

-- ====================================================================
-- OPERATIONAL DATABASE
-- ====================================================================
--CUSTOMER
create table CUSTOMER as
select CUSTOMERID as CUSTOMER_ID, name as CUSTOMER_NAME, ADDRESS,
SUBURB, POSTCODE, STATE
from DTANIAR.CUSTOMER4;
alter table CUSTOMER add constraint CUSTOMER_PK primary key
( CUSTOMER_ID ) ;
--BOOK
create table BOOK
 (
 BOOK_ID varchar2(20) not null ,
 BOOK_TITLE varchar2(200),
 AUTHOR varchar2(200)
 ) ;
alter table BOOK add constraint BOOK_PK primary key ( BOOK_ID ) ;
insert into BOOK values('C1', 'CSIRO Diet', 'CSIRO Team');
insert into BOOK values('H6', 'Harry Potter 6', 'Rowling');
insert into BOOK values('DV', 'Da Vinci Code', 'Dan Brown');
--BOOK PRICE HISTORY
create table BOOK_PRICE_HISTORY
 (
 BOOK_ID varchar2(20) not null ,
 START_DATE varchar2(10) null ,
 END_DATE varchar2(10) not null ,
 PRICE number ,
 REMARKS varchar2(100)
 ) ;
alter table BOOK_PRICE_HISTORY add constraint BOOK_PRICE_HISTORY_PK
primary key ( BOOK_ID, START_DATE, END_DATE ) ;
alter table BOOK_PRICE_HISTORY add constraint BOOK_PRICE_HISTORY_BOOK_FK
foreign key ( BOOK_ID ) references BOOK ( BOOK_ID ) ;
insert into BOOK_PRICE_HISTORY values('C1', 'Jan2007', 'Jul2007', 45.95,
'Full Price');
insert into BOOK_PRICE_HISTORY values('C1', 'Aug2007', 'Oct2007', 36.75,
'20% Discount');
insert into BOOK_PRICE_HISTORY values('C1', 'Nov2007', 'Jan2008', 23.00,
'Half Price')
insert into BOOK_PRICE_HISTORY values('C1', 'Feb2008', 'Now', 45.95,
'Full Price');
insert into BOOK_PRICE_HISTORY values('H6', 'Jan2007', 'Mar2007', 21.95,
'Launching');
insert into BOOK_PRICE_HISTORY values('H6', 'Apr2007', 'Feb2008', 30.95,
'Full Price');
insert into BOOK_PRICE_HISTORY values('H6', 'Jan2008', 'Now', 10.00,
'End of Product Sale');
insert into BOOK_PRICE_HISTORY values('DV', 'Jan2007', 'Now', 27.95,
'Full Price');
--BRANCH
create table BRANCH
 (
 BRANCH_ID varchar2(100) not null ,
 BRANCH_ADDRESS varchar2(200)
 ) ;
alter table BRANCH add constraint BRANCH_PK primary key ( BRANCH_ID ) ;
insert into BRANCH values('City', 'VIC3622');
insert into BRANCH values('Chadstone', 'Chadstone VIC3234');
insert into BRANCH values('Camberwell', 'Camberwell VIC2451');
--TRANSACTION
create table BOOK_TRANSACTION
 (
 TRANSACTION_ID number not null ,
 BRANCH_ID varchar2 (100) not null ,
 CUSTOMER_ID varchar2 (20) not null ,
 BOOK_ID varchar2 (20) not null ,
 TRANSACTION_DATE date ,
 QUANTITY number
 ) ;
alter table BOOK_TRANSACTION add constraint BOOK_TRANSACTION_PK primary
key ( TRANSACTION_ID ) ;
alter table BOOK_TRANSACTION add constraint TRANSACTION_BOOK_FK foreign
key ( BOOK_ID ) references BOOK ( BOOK_ID ) ;
alter table BOOK_TRANSACTION add constraint TRANSACTION_BRANCH_FK
foreign key ( BRANCH_ID ) references BRANCH ( BRANCH_ID ) ;
alter table BOOK_TRANSACTION add constraint TRANSACTION_CUSTOMER_FK
foreign key ( CUSTOMER_ID ) references CUSTOMER ( CUSTOMER_ID ) ;
create sequence BOOK_TRANSACTION_TRANSACTION_I start with 1 ;
create or replace trigger BOOK_TRANSACTION_TRANSACTION_I before
 insert on BOOK_TRANSACTION for each row when (new.TRANSACTION_ID is
null)
begin
 :new.TRANSACTION_ID := BOOK_TRANSACTION_TRANSACTION_I.NEXTVAL;
end;
/
insert into BOOK_TRANSACTION values(null, 'City', 'Cus1', 'C1',
to_date('Mar 2008', 'Mon YYYY'), 2);
insert into BOOK_TRANSACTION values(null, 'City', 'Cus2', 'C1',
to_date('Mar 2008', 'Mon YYYY'), 3);
insert into BOOK_TRANSACTION values(null, 'City', 'Cus2', 'H6',
to_date('Mar 2008', 'Mon YYYY'), 10);
insert into BOOK_TRANSACTION values(null, 'City', 'Cus3', 'H6',
to_date('Mar 2008', 'Mon YYYY'), 5);
insert into BOOK_TRANSACTION values(null, 'City', 'Cus3', 'DV',
to_date('Mar 2008', 'Mon YYYY'), 10);
insert into BOOK_TRANSACTION values(null, 'City', 'Cus4', 'DV',
to_date('Mar 2008', 'Mon YYYY'), 13);
insert into BOOK_TRANSACTION values(null, 'Chadstone', 'Cus4', 'C1',
to_date('Mar 2008', 'Mon YYYY'), 10);
insert into BOOK_TRANSACTION values(null, 'Chadstone', 'Cus5', 'C1',
to_date('Mar 2008', 'Mon YYYY'), 5);
insert into BOOK_TRANSACTION values(null, 'Chadstone', 'Cus4', 'H6',
to_date('Mar 2008', 'Mon YYYY'), 3);
insert into BOOK_TRANSACTION values(null, 'Chadstone', 'Cus3', 'DV',
to_date('Mar 2008', 'Mon YYYY'), 2);
insert into BOOK_TRANSACTION values(null, 'Camberwell', 'Cus3', 'C1',
to_date('Mar 2008', 'Mon YYYY'), 1);
insert into BOOK_TRANSACTION values(null, 'Camberwell', 'Cus2', 'H6',
to_date('Mar 2008', 'Mon YYYY'), 1);
insert into BOOK_TRANSACTION values(null, 'Camberwell', 'Cus1', 'DV',
to_date('Mar 2008', 'Mon YYYY'), 2);
insert into BOOK_TRANSACTION values(null, 'City', 'Cus4', 'C1',
to_date('Dec 2007', 'Mon YYYY'), 10);
insert into BOOK_TRANSACTION values(null, 'City', 'Cus3', 'C1',
to_date('Dec 2007', 'Mon YYYY'), 5);
insert into BOOK_TRANSACTION values(null, 'City', 'Cus2', 'H6',
to_date('Dec 2007', 'Mon YYYY'), 5);
insert into BOOK_TRANSACTION values(null, 'City', 'Cus2', 'H6',
to_date('Dec 2007', 'Mon YYYY'), 1);
insert into BOOK_TRANSACTION values(null, 'City', 'Cus5', 'DV',
to_date('Dec 2007', 'Mon YYYY'), 6);
insert into BOOK_TRANSACTION values(null, 'Chadstone', 'Cus4', 'C1',
to_date('Dec 2007', 'Mon YYYY'), 5);
insert into BOOK_TRANSACTION values(null, 'Chadstone', 'Cus3', 'C1',
to_date('Dec 2007', 'Mon YYYY'), 5);
insert into BOOK_TRANSACTION values(null, 'Chadstone', 'Cus2', 'H6',
to_date('Dec 2007', 'Mon YYYY'), 4);
insert into BOOK_TRANSACTION values(null, 'Chadstone', 'Cus1', 'H6',
to_date('Dec 2007', 'Mon YYYY'), 4);
insert into BOOK_TRANSACTION values(null, 'Chadstone', 'Cus4', 'DV',
to_date('Dec 2007', 'Mon YYYY'), 1);
insert into BOOK_TRANSACTION values(null, 'Camberwell', 'Cus1', 'C1',
to_date('Dec 2007', 'Mon YYYY'), 9);
insert into BOOK_TRANSACTION values(null, 'Camberwell', 'Cus3', 'C1',
to_date('Dec 2007', 'Mon YYYY'), 9);
insert into BOOK_TRANSACTION values(null, 'Camberwell', 'Cus2', 'H6',
to_date('Dec 2007', 'Mon YYYY'), 3);
insert into BOOK_TRANSACTION values(null, 'Camberwell', 'Cus1', 'DV',
to_date('Dec 2007', 'Mon YYYY'), 2);
insert into BOOK_TRANSACTION values(null, 'Chadstone', 'Cus4', 'DV',
to_date('Dec 2007', 'Mon YYYY'), 1);
insert into BOOK_TRANSACTION values(null, 'Camberwell', 'Cus1', 'C1',
to_date('Dec 2007', 'Mon YYYY'), 9);
insert into BOOK_TRANSACTION values(null, 'Camberwell', 'Cus3', 'C1',
to_date('Dec 2007', 'Mon YYYY'), 9);
insert into BOOK_TRANSACTION values(null, 'Camberwell', 'Cus2', 'H6',
to_date('Dec 2007', 'Mon YYYY'), 3);
insert into BOOK_TRANSACTION values(null, 'Camberwell', 'Cus1', 'DV',
to_date('Dec 2007', 'Mon YYYY'), 2);
commit;


--2. Solution Model 1 – No bridge 
--a. Create a dimension table called BOOK_DIM.
create table Book_dim as
select *
from book;

--b. Create a dimension table called TIME_DIM. Year and Month are extracted from
--Transaction Date.

create table time_dim as 
select distinct
to_char(Transaction_Date, 'MonYYYY') as time_id, 
to_char(Transaction_Date, 'YYYY') as year, 
to_char(Transaction_Date, 'Mon') as month
from Book_transaction;

--c. Create a dimension table called BRANCH_DIM.

create table branch_dim as 
select * from 
branch;


--d. Create fact table (called it BOOK_SALES_FACT1).

create table book_sales_fact as 
select 
to_char(t.Transaction_Date, 'MonYYYY') as time_id, 
t.branch_id,
t.book_id,
sum(quantity) as number_of_books_sold
from 
book b, book_transaction t, branch br
where
b.book_id = t.book_id and
br.branch_id = t.branch_id
group by 
to_char(t.Transaction_Date, 'MonYYYY'), 
t.branch_id,
t.book_id;

select * from book_transaction;

--e. Display (and observe) the contents of the fact table (BOOK_SALES_FACT1).

select * from book_sales_fact;

--3. Solution Model 2 – add a Temporal Bridge
--a. Create a dimension table called BOOK_PRICE_DIM.

create table book_price_dim as
select  * 
from book_price_history;


--b. Challenge: Create the “Correct Book Sale” Report as shown in Lecture 4 Notes page
--5/page 10. Hint: Use Case When to handle END_DATE = ‘Now’. (Don’t waste time on
--this, you can come back to this task after finishing Task 3).



--4. Solution Model 3 – add a new Fact: Total Sales
--a. Create a new Fact table: BOOK_SALES_FACT2 by coping BOOK_SALES_FACT1.

create table book_sales_fact2 as 
select * from book_sales_fact;

--b. Add Column TOTAL_SALES (NUMBER) to BOOK_SALES_FACT2.

alter table book_sales_fact2
add (total_sales number(5));


--c. Use the PRICE_CURSOR (by selecting all data from BOOK_PRICE_DIM) to populate data
--for column TOTAL_SALES in BOOK_SALES_FACT2. Pay attention to the current book price
--in BOOK_PRICE_DIM, they will have END_DATE equals to ‘Now’ instead of a normal date
--(MonYYYY).




--d. Challenge: Recreate BOOK_SALES_FACT2 using Case When instead of Cursor.

