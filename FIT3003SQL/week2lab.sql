--Laboratory 2a Student Enrollment Case Study
--Tasks

--a) Create table SUBJECT2 and insert the above 5 records.
CREATE TABLE SUBJECT2 (
Ucode VARCHAR2(10),
Utitle VARCHAR2(20),
Ucredit NUMBER (2)
);

INSERT ALL 
INTO SUBJECT2 VALUES('IT001', 'Database', 5)
INTO SUBJECT2 VALUES('IT002', 'Java', 5)
INTO SUBJECT2 VALUES('IT003', 'SAP', 10)
INTO SUBJECT2 VALUES('IT004', 'Network', 5)
INTO SUBJECT2 VALUES('IT005', 'ASP.net', 5)
SELECT * FROM DUAL;

SELECT * FROM SUBJECT2;


--b) Table STUDENT2 has been created in the dtaniar account. Several records
--have been inserted to this table. You can now import table STUDENT2 to your
--account using the following SQL statement:
Create Table STUDENT2
As Select *
From dtaniar.STUDENT2;

SELECT * FROM STUDENT2;


--c) Describe the structure of table STUDENT2.

desc student2;

/* 
Each student has a student id and their details written down
*/

--d) Display all records from table STUDENT2.

SELECT * FROM STUDENT2;

--e) Insert the missing records to table STUDENT2.

INSERT ALL 
INTO STUDENT2 VALUES(10008, 'Miller', 'Larry', 'M', TO_DATE('22-Jul-73', 'DD-MON-YY'), 211)
INTO STUDENT2 VALUES(10009, 'Smith', 'Leonard','M', TO_DATE('26-May-85', 'DD-MON-YY'), 211)
INTO STUDENT2 VALUES(10010, 'Brown', 'Menson', 'M', TO_DATE('12-Jul-83', 'DD-MON-YY'), 112)
SELECT * FROM DUAL;

SELECT * FROM STUDENT2;

--f) Import Tables OFFERING2 and ENROLLMENT2 from dtaniar account. The
--method is similar to question (b) above.

Create Table OFFERING2
As Select *
From dtaniar.OFFERING2;

Create Table ENROLLMENT2
As Select *
From dtaniar.ENROLLMENT2;

--g) Using SQL to answer the questions
--1) How many students enrolled in the Database unit offered in Main campus?

select count(*) as Number_of_student
from OFFERING2 o, Enrollment2 e, Subject2 s
where e.OID = o.oid
and s.ucode = o.ucode
and o.Ocampus = 'Main'
and s.Utitle = 'Database';


--2) What is the total score of students taking the Database unit in Main campus?



--3) How many students enrolled in the Java unit offered in Semester 2, 2009?



--4) What is the total score of students taking the Java unit in Semester 2, 2009?



--5) How many students received HD in the SAP unit offered in Semester 1, 2009?




--Implementing the star schema:
--h) Draw a star schema based on the above case study? First identify the dimensions
--(and their attributes), and the fact measurements for the fact table?
--i) Use the SQL command to create and populate the dimension tables.

--campus dimension

create table campus_dim as
select distinct Ocampus
from offering2;

--semester_year dimension

create table sem_year_dim as 
select distinct Oyear||Osem as sem_id, Oyear, Osem
from offering2;

--subject dimension

create table subject_dim as 
select * 
from subject2;

--grade dimension
create table grade_dim as 
select distinct grade
from enrollment2;

-- dimension


--j) Use the SQL command to create the fact table.


--create table student_enrollment_fact as


select o.Ocampus, e.grade, sub.ucode, o.Oyear||o.Osem as sem_id, 
count(s.sid) as num_of_student, sum(e.score) as total_score
from offering2 o, enrollment2 e, subject2 sub, student2 s
where o.oid = e.oid
and e.sid = s.sid
and o.ucode = sub.ucode
group by 
o.Ocampus, e.grade, sub.ucode, o.Oyear||o.Osem;


select o.Ocampus, o.Oyear||o.Osem as sem_id, s.Ucode, e.Grade,
count(st.sid) as num_of_student, sum(e.score) as Total_score
from subject2 s, enrollment2 e, offering2 o, student2 st
where o.oid = e.oid
and e.sid = st.sid
and o.ucode = s.ucode
group by 
o.Ocampus, e.grade, s.ucode, o.Oyear||o.Osem;


select o.Ocampus, o.Oyear||o.Osem as sem_id, s.Ucode, e.Grade,
count(st.sid) as num_of_student, sum(e.score) as Total_score
from subject2 s, enrollment2 e, offering2 o, student2 st
where e.OID = o.OID
and s.Ucode = o.Ucode
and st.SID = e.SID
Group by o.Ocampus, o.Oyear||o.Osem, s.Ucode, e.Grade;


create table student_enrollment_fact as 
select o.Ocampus, o.Oyear||o.Osem as sem_id, s.Ucode, e.Grade,
count(st.sid) as num_of_student, sum(e.score) as Total_score
from subject2 s, enrollment2 e, offering2 o, student2 st
where e.OID = o.OID
and s.Ucode = o.Ucode
and st.SID = e.SID
Group by o.Ocampus, o.Oyear||o.Osem, s.Ucode, e.Grade;

--k) Use the star schema that you have created, display the average score of each unit
--offered in 2009.

select * from student_enrollment_fact;

select total_score/num_of_student
from student_enrollment_fact
where sem_id like '2009%';

select * from subject_dim;

select s.utitle, sum(total_score), sum(num_of_student)
from subject_dim s, student_enrollment_fact f
where s.ucode = f.ucode
group by utitle;

select s.utitle, sum(total_score)/ sum(num_of_student) as average_score
from subject_dim s, student_enrollment_fact f
where s.ucode = f.ucode
group by utitle;


--l) Use the star schema that you have created, display the average score of each unit
--offered in main campus.


select * from campus_dim;
select * from student_enrollment_fact;

select f.ucode, total_score/num_of_student as average_score
from campus_dim c, student_enrollment_fact f
where c.ocampus = f.ocampus
and upper(f.ocampus) = 'MAIN';

select s.utitle, total_score/num_of_student as average_score
from campus_dim c, student_enrollment_fact f, subject_dim s
where c.ocampus = f.ocampus and
f.ucode = s.ucode
and upper(f.ocampus) = 'MAIN';


select s.utitle, sum(total_score)/sum(num_of_student) as average_score
from campus_dim c, student_enrollment_fact f, subject_dim s
where c.ocampus = f.ocampus and
f.ucode = s.ucode
and upper(f.ocampus) = 'MAIN'
group by s.utitle;


select s.utitle, sum(total_score)/ sum(num_of_student) as average_score
from subject_dim s, student_enrollment_fact f
where s.ucode = f.ucode
group by utitle;



--m) Use the star schema that you have created, display the average score of Database
--unit with the grade N.

select 
from student_enrollment_fact;



