-- The insert Statement
-- 1 always desc the table before making any insert to know the columns and the constraints
DESC DEPARTMENTS;

/* 2 try to have a look on table constraints
   go to tables from the tree on the left, select the table, and then see the constraints
   note: the constraint will be discussed in details later*/
 
-- 3 list the columns in same table order, then put Related values ( this is the Recommendation ) 
INSERT INTO DEPARTMENTS (DEPARTMENT_ID,DEPARTMENT_NAME,MANAGER_ID,LOCATION_ID)
VALUES                  (71,'Development 1',100,1700);
commit; -- use the commit command to save the changes

/* We can make insert without puting the columns names, but the order in values should be same order of table
   this way of insert you need to put values for all the tables */

INSERT INTO DEPARTMENTS 
VALUES   (72,'Development 2',100,1700);
COMMIT;

-- We can change the order as you like when put the columns names, but you should mapp the values same
INSERT INTO DEPARTMENTS (DEPARTMENT_NAME,MANAGER_ID,LOCATION_ID,DEPARTMENT_ID)
VALUES                  ('Development 3',100,1700,73);
COMMIT;

/* 4 inserting rows with null values
   the Implicit method: dont put the column in the list, make sure the column can have null value
   the oracle server automatically make the value null
   so the MANAGER_ID,LOCATION_ID will be null in below insert */
INSERT INTO DEPARTMENTS (DEPARTMENT_ID,DEPARTMENT_NAME)
VALUES                  (74,'Development 4');

-- the explicit method, done by the user by soecify the NULL keyword
INSERT INTO DEPARTMENTS (DEPARTMENT_ID,DEPARTMENT_NAME,MANAGER_ID,LOCATION_ID )
VALUES                  (75,'Development 5',null,null);

--5 inserting special values like sysdate, or some other functions

INSERT INTO EMPLOYEES (EMPLOYEE_ID,FIRST_NAME,LAST_NAME,EMAIL,HIRE_DATE ,JOB_ID)
VALUES               (1,'khaled','khudari','khaled@hotmail.com',SYSDATE,'IT_PROG' );

INSERT INTO EMPLOYEES (EMPLOYEE_ID,FIRST_NAME,LAST_NAME,EMAIL,HIRE_DATE ,JOB_ID)
VALUES               (2,'Samer','ali','samer@hotmail.com',to_date('20-07-2015','dd-mm-yyyy'),'IT_PROG' );

--6 using the & with insert 
INSERT INTO DEPARTMENTS (DEPARTMENT_ID,DEPARTMENT_NAME)
VALUES                  (&dpet_id,'&dname');

--7 you can make insert with subquery
--lets create table xx_emp
CREATE TABLE XX_EMP
(EMPNO NUMBER,
 FNAME VARCHAR2(100),
 SALARY NUMBER
 );
 
 SELECT * FROM XX_EMP;
 
 
 --so you insert into XX_EMP using select
 
 INSERT INTO XX_EMP(EMPNO,FNAME,SALARY)
 SELECT EMPLOYEE_ID,FIRST_NAME,SALARY
 FROM
 EMPLOYEES;
 
 SELECT * from XX_EMP;
 
 --------------------------------------------------------------------------------------------------------------
 --now lets see some errors in inserting

--1 inserting existing value, and this value is PK  
--DEPARTMENT_ID=10
INSERT INTO DEPARTMENTS (DEPARTMENT_ID,DEPARTMENT_NAME,MANAGER_ID,LOCATION_ID)
VALUES                  (10,'Development 1',100,1700);

--2 inserting FK value not exists in the reference table
--LOCATION_ID=1
INSERT INTO DEPARTMENTS (DEPARTMENT_ID,DEPARTMENT_NAME,MANAGER_ID,LOCATION_ID)
VALUES                  (5,'Development 1',100,1);

--3 inserting missmatch data type
--LOCATION_ID='D1'
INSERT INTO DEPARTMENTS (DEPARTMENT_ID,DEPARTMENT_NAME,MANAGER_ID,LOCATION_ID)
VALUES                  (5,'Development 1',100,'D1');

--4 inserting value too long
--DEPARTMENT_NAME=' The development and research department'
INSERT INTO DEPARTMENTS (DEPARTMENT_ID,DEPARTMENT_NAME,MANAGER_ID,LOCATION_ID)
VALUES                  (5,'The development and research department',100,1700);

--the update 
--1 it is logical to make update always based on the PK for the table
select * from EMPLOYEES
where EMPLOYEE_ID=100;

UPDATE EMPLOYEES
SET SALARY =24100
WHERE EMPLOYEE_ID=100;
COMMIT;

select * from EMPLOYEES
where EMPLOYEE_ID=100;

-- 2 making update on another condition (not using the PK) could be dangerous
UPDATE EMPLOYEES
SET SALARY =24000
WHERE FIRST_NAME='Steven'; -- it could be more than one employee with name='Steven'
COMMIT;

SELECT * from EMPLOYEES
WHERE FIRST_NAME='Steven';



-- 3 to do more practice on update, lets create table called copy_emp,
-- this table is a copy from employees table, we dont want to make changes on the orginal table 

CREATE TABLE COPY_EMP
AS 
SELECT * FROM EMPLOYEES;

SELECT * FROM COPY_EMP;

-- 4 you can update more than one column in the same time
UPDATE COPY_EMP
SET SALARY =24100, DEPARTMENT_ID=10
WHERE EMPLOYEE_ID=100;
COMMIT;

SELECT * FROM COPY_EMP
WHERE EMPLOYEE_ID=100;


-- 5 if there is no where condition then the update will be for all the tables 

UPDATE COPY_EMP
SET PHONE_NUMBER='515.123.4567';

SELECT * FROM COPY_EMP;

-- 6 in update , you can set the column to null value

UPDATE COPY_EMP
SET DEPARTMENT_ID=NULL
WHERE EMPLOYEE_ID=100;

COMMIT;

SELECT * FROM COPY_EMP
WHERE EMPLOYEE_ID=100;

-- 7 using subquery in update
-- make the salary for employee 100 like the salary for employee  200
SELECT * FROM COPY_EMP
where EMPLOYEE_ID in (100,200);

UPDATE COPY_EMP
SET salary=(select salary from COPY_EMP where EMPLOYEE_ID=200)
WHERE EMPLOYEE_ID=100;
COMMIT;

SELECT * FROM COPY_EMP
where EMPLOYEE_ID in (100,200)

-- another example
-- make the salary and department id for employee 105 like the salary and department id for employee 108

SELECT * FROM COPY_EMP
WHERE EMPLOYEE_ID IN (105,108);

--method 1 
UPDATE COPY_EMP
SET (salary,department_id) =(select salary, department_id  from COPY_EMP where EMPLOYEE_ID=108)
WHERE EMPLOYEE_ID=105;

--method 2 
UPDATE COPY_EMP
SET SALARY    =(SELECT SALARY  FROM COPY_EMP WHERE EMPLOYEE_ID=108),
department_id =(select department_id  from COPY_EMP where EMPLOYEE_ID=108)
WHERE EMPLOYEE_ID=105;

--the delete
--1 lets create table dept_copy to be a copy from departments table

CREATE TABLE dept_copy
AS SELECT * FROM DEPARTMENTS;

SELECT * FROM DEPT_COPY;

DESC DEPT_COPY;

--2
SELECT * FROM DEPT_COPY
where DEPARTMENT_ID=10;

DELETE from DEPT_COPY
WHERE DEPARTMENT_ID=10;
COMMIT;

SELECT * FROM DEPT_COPY
WHERE DEPARTMENT_ID=10;

--3 the keyword from is optional in delete 
DELETE DEPT_COPY
WHERE DEPARTMENT_ID=10;
COMMIT;

--4 if there is no where condition then all rows in the table will be deleted 

DELETE  from DEPT_COPY;

--5 you can rollback the delete 
ROLLBACK;

SELECT * FROM DEPT_COPY;

-- 6 delete based on subquery

DELETE FROM DEPT_COPY
WHERE DEPARTMENT_ID IN (SELECT DEPARTMENT_ID FROM  DEPT_COPY WHERE DEPARTMENT_name LIKE '%Public%');

-- so here you can not delete , child record found
-- how you will remove this DEPARTMENT which have employees?????
delete from DEPARTMENTs
WHERE DEPARTMENT_ID=90;

-- 9 truncate

TRUNCATE TABLE DEPT_COPY; --you can not rollback

SELECT * FROM DEPT_COPY; --the table is empty