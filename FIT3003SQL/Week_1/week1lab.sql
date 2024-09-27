SELECT * FROM TAB; 

CREATE TABLE LECTURER
(StaffNO NUMBER(6) NOT NULL,
Title VARCHAR2(3),
FName VARCHAR2(30),
LName VARCHAR2(30),
StreetAddress VARCHAR2(70),
Suburb VARCHAR2(40),
City VARCHAR2(40),
PostCode VARCHAR2(4),
Country VARCHAR2(30),
LecturerLevel CHAR(2),
BankNO CHAR(20),
BankName VARCHAR2(40),
Salary NUMBER(8,2),
WorkLoad NUMBER(2,1) NOT NULL,
ResearchArea VARCHAR2(40),
PRIMARY KEY(StaffNo));

SELECT * FROM TAB; 

--4

INSERT INTO LECTURER (StaffNO, Title, FName, LName,
StreetAddress, Suburb,City, PostCode, Country,
LecturerLevel, BankNO, BankName, Salary, WorkLoad,
ResearchArea)
VALUES (1000,'Dr','David','Taniar','3 Robinson Av', 'Kew',
'Melbourne', '3080', 'Australia', '5', '1000567237',
'CommBank', 89000.00, 2.0, 'O-R DB');


INSERT INTO LECTURER (StaffNO, Title, FName, LName,
StreetAddress, Suburb, City, PostCode, Country,
LecturerLevel, BankNO, BankName, Salary, WorkLoad,
ResearchArea)
VALUES (2000,'Ms','Julie','Main','6 Algorithm Av',
'Montmorency', 'Melbourne', '3089', 'Australia', '5',
'1000123456', 'CommBank', 89000.00, 2.0, 'CBR');

INSERT INTO LECTURER VALUES (3000, 'Mr', 'Daniel', 'Wright',
'22 Crystal Cres', 'Alphington', 'Melbourne', '3790',
'Australia', '5', '1000654321', 'CommBank', 89000.00, 2.0,
'DB');

INSERT INTO LECTURER (StaffNO, Title, FName, LName,
StreetAddress, Suburb, PostCode, Country, ResearchArea,
Workload)
VALUES (4000, 'Mr', 'RaiHong', 'Lam', '12 Oracle Dr',
'Fitzroy', '3424', 'Australia', 'Data Mining', 1);

--5
SELECT * FROM LECTURER; 

--6
CREATE TABLE STUDENT
(StudentNO NUMBER(6) NOT NULL,
DOB DATE,
FName VARCHAR2(30),
LName VARCHAR2(30),
-- city spelt CiTTy
CiTTy VARCHAR2(40),
PostCode VARCHAR2(4),
Country VARCHAR2(30),
FeePaid NUMBER(8,2),
LastFeeDate DATE,
PRIMARY KEY(StudentNo));

INSERT INTO STUDENT VALUES(30001,TO_DATE('12-MAR-2001 16:15', 'DD-MON-YYYY HH24:MI'),'Bob', 'Jones','Melbourne', '1123', 'Australia', 2000.00, TO_DATE('12-MAR-2023 16:15', 'DD-MON-YYYY HH24:MI'));

INSERT INTO STUDENT VALUES(30002,TO_DATE('14-MAR-2001 16:15', 'DD-MON-YYYY HH24:MI'),'Will', 'Smith','Melbourne', '1124', 'Australia', 2000.00, TO_DATE('12-MAR-2023 16:15', 'DD-MON-YYYY HH24:MI'));


INSERT INTO STUDENT VALUES(30003,TO_DATE('12-DEC-2001 16:15', 'DD-MON-YYYY HH24:MI'),'Henry', 'Moon','Melbourne', '1323', 'Australia', 2000.00, TO_DATE('12-MAR-2023 16:15', 'DD-MON-YYYY HH24:MI'));

INSERT INTO STUDENT VALUES(30004,TO_DATE('12-JUN-2001 16:15', 'DD-MON-YYYY HH24:MI'),'Ryan', 'Fields','Melbourne', '1423', 'Australia', 2000.00, TO_DATE('12-MAR-2023 16:15', 'DD-MON-YYYY HH24:MI'));

INSERT INTO STUDENT VALUES(30005,TO_DATE('12-APR-2001 16:15', 'DD-MON-YYYY HH24:MI'),'Jim','Brooks', 'Melbourne', '1133', 'Australia', 2000.00, TO_DATE('12-MAR-2023 16:15', 'DD-MON-YYYY HH24:MI'));


SELECT * FROM STUDENT;

--7
ALTER TABLE STUDENT ADD
(StreetAddress VARCHAR2(70),
Suburb VARCHAR2(40));

--8
DESC STUDENT; 

--9
ALTER TABLE STUDENT
DROP(CiTTy);

--10
ALTER TABLE STUDENT
ADD (City CHAR(40));


--11
ALTER TABLE STUDENT
MODIFY (City VARCHAR2(40));
--12
UPDATE STUDENT
SET StreetAddress = '12 New St'
WHERE StudentNo = 30001;

SELECT * FROM STUDENT WHERE StudentNo = 30001;
--13
COMMIT;


-- Part B
--14
SELECT * FROM TAB;
SELECT * FROM STUDENT;
SELECT * FROM LECTURER;

--15
Create Table SUBJECT
As Select *
From dtaniar.SUBJECT;

Create Table LECTURE
As Select *
From dtaniar.LECTURE;

Create Table TUTOR
As Select *
From dtaniar.TUTOR;

Create Table LAB
As Select *
From dtaniar.LAB;

Create Table STUDENT_ENROLMENT
As Select *
From dtaniar.STUDENT_ENROLMENT;

Create Table LAB_SIGNUP
As Select *
From dtaniar.LAB_SIGNUP;

--16 Write an SQL statement to list all the lecturers and their lecture schedules
SELECT l.STAFFNO,TITLE, FNAME, LNAME, LECTURECODE, LECTDAY, LECTTIME 
From dtaniar.LECTURER l, dtaniar.LECTURE s
where l.staffno = s.staffno;

--17 Are there any lecturers who not teaching?
SELECT STAFFNO,TITLE, FNAME, LNAME 
From dtaniar.LECTURER l
where STAFFNO not in (SELECT STAFFNO FROM dtaniar.LECTURE);


SELECT distinct STAFFNO FROM dtaniar.LECTURE;
SELECT distinct STAFFNO FROM dtaniar.LECTURER;

--18 List all the subjects offered in the first semester.
SELECT * FROM dtaniar.SUBJECT;

SELECT * 
FROM dtaniar.SUBJECT
WHERE SEMESTER = 1;


--19 List all the students by first-name, last-name, date-of-birth, and fee-paid details, who are born after 1990 and before 1995.

SELECT * FROM dtaniar.STUDENT;


SELECT FNAME, LNAME, DOB, FEEPAID, LASTFEEDATE
FROM dtaniar.STUDENT
WHERE DOB 
BETWEEN TO_DATE('31-DEC-1990', 'DD-MM-YYYY')
AND TO_DATE('31-DEC-1994', 'DD-MM-YYYY');


--20 List all the students enrolled in the database subject. (Note: database = CSE21DB, CSE31DB, CSE41FDB)

SELECT * 
FROM dtaniar.STUDENT_ENROLMENT
WHERE SUBJECTCODE LIKE '%DB%' OR SUBJECTCODE LIKE '%%DB';


SELECT * 
FROM dtaniar.STUDENT_ENROLMENT
WHERE SUBJECTCODE LIKE '%DB%' OR SUBJECTCODE LIKE '%%DB';

--21 List the students who are tutors.

SELECT s.STUDENTNO, FNAME, LNAME 
FROM dtaniar.TUTOR t, dtaniar.STUDENT s
where t.STUDENTNO = s.STUDENTNO;

--22 Select the lecturer(s) whose research area is ‘Network Management’.

SELECT * FROM dtaniar.LECTURER;


SELECT * 
FROM dtaniar.LECTURER
WHERE RESEARCHAREA = 'Network Management';



--23 Calculate the average salary of a lecturer.

SELECT AVG(SALARY)
FROM dtaniar.LECTURER;

--24 Calculate the minimum and maximum salary of the lecturers.


SELECT MIN(SALARY) AS "MINIMUM SALARY",
MAX(SALARY) AS "MAXIMUM SALARY"
FROM dtaniar.LECTURER;


SELECT * FROM dtaniar.LECTURER;


--25 List the number of tutors by each subject and semester.
SELECT * FROM dtaniar.LAB;
SELECT * FROM dtaniar.SUBJECT;

--inner query
SELECT 
    *
FROM 
    dtaniar.SUBJECT s
left outer join dtaniar.LAB l
ON s.SUBJECTCODE = l.SUBJECTCODE;

SELECT * FROM dtaniar.LAB;
SELECT * FROM dtaniar.SUBJECT;


SELECT 
    s.SUBJECTCODE,
    COUNT(l.tutorno) AS "NUM TUTORS" 
FROM 
    dtaniar.SUBJECT s
left outer join dtaniar.LAB l
ON s.SUBJECTCODE = l.SUBJECTCODE;

SELECT 
    SUBJECTCODE,
    NAME,
    SEMESTER,
    COUNT(TUTOR_NO) AS "NUM TUTORS" 
FROM 
    (SELECT 
        *
    FROM 
        dtaniar.SUBJECT s
    left outer join dtaniar.LAB l
    ON s.SUBJECTCODE = l.SUBJECTCODE)
group by
    SUBJECTCODE,TUTOR_NO;




--    COUNT(TUTOR_NO) AS "NUM TUTORS" 

--26 List the total number of students in each lab, for each subject, with the tutor’s name.

SELECT * FROM dtaniar.LAB;
SELECT * FROM dtaniar.SUBJECT;
SELECT * FROM dtaniar.lab_signup;
SELECT * FROM dtaniar.student;


select *
from 
((lab_signup s
join LAB l on s.labno = s.labno)
join TUTOR t join
student s on l.TUTORNO = t.TUTORNO;


join student s on t.TUTORNO = s.TUTORNO
)
;



select labno,
tutorname,
from 
(lab_signup s
join LAB l on s.labno = s.labno)
join TUTOR t on l.TUTORNO = t.TUTORNO

;

--27 Calculate the cost of running all the database labs per week. (Hint: lab duration * tutors’ SALARYPERHOUR)


