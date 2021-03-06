-- Note that DEPARTMENT_ID fk to table DEPARTMENTS
SELECT EMPLOYEE_ID , first_name, DEPARTMENT_ID
FROM EMPLOYEES;

SELECT DEPARTMENT_ID, DEPARTMENT_NAME 
FROM DEPARTMENTS;

-- If we try to display data from multiple tables without join, this called  cartesian product
SELECT 
EMPLOYEES.EMPLOYEE_ID , 
EMPLOYEES.FIRST_NAME, 
DEPARTMENTS.DEPARTMENT_ID, 
DEPARTMENTS.DEPARTMENT_NAME
FROM EMPLOYEES,
DEPARTMENTS
ORDER BY EMPLOYEE_ID;


-- Join will be like this and this called Equijoins or simple join or inner join

SELECT 
EMPLOYEES.EMPLOYEE_ID , 
EMPLOYEES.FIRST_NAME, 
EMPLOYEES.DEPARTMENT_ID, 
DEPARTMENTS.DEPARTMENT_NAME
FROM EMPLOYEES,
DEPARTMENTS
where EMPLOYEES.DEPARTMENT_ID=DEPARTMENTS.DEPARTMENT_ID
ORDER BY EMPLOYEE_ID;

-- Using additional conditions
SELECT 
EMPLOYEES.EMPLOYEE_ID , 
EMPLOYEES.FIRST_NAME, 
EMPLOYEES.DEPARTMENT_ID, 
DEPARTMENTS.DEPARTMENT_NAME
FROM EMPLOYEES,
DEPARTMENTS
WHERE EMPLOYEES.DEPARTMENT_ID=DEPARTMENTS.DEPARTMENT_ID
and EMPLOYEES.DEPARTMENT_ID >40
ORDER BY EMPLOYEE_ID;

-- Using table alias
SELECT 
EMP.EMPLOYEE_ID , 
EMP.FIRST_NAME, 
EMP.DEPARTMENT_ID, 
dept.DEPARTMENT_NAME
FROM EMPLOYEES EMP ,
DEPARTMENTS DEPT
WHERE emp.DEPARTMENT_ID=dept.DEPARTMENT_ID
ORDER BY EMPLOYEE_ID;

-- Join more than 2 tables
SELECT 
EMP.EMPLOYEE_ID , 
EMP.FIRST_NAME, 
emp.DEPARTMENT_ID, 
DEPT.DEPARTMENT_NAME,
DEPT.location_id,
loc.city
FROM 
EMPLOYEES EMP ,
DEPARTMENTS DEPT,
locations loc
WHERE EMP.DEPARTMENT_ID=DEPT.DEPARTMENT_ID
and dept.location_id=loc.location_id
ORDER BY EMPLOYEE_ID;


/* nonEquijoins(Very weird to use)
   Lets create the table, the creation of table will be discussed in details later */
CREATE TABLE JOB_GRADES 
(
 GRADE_LEVEL VARCHAR2(3),
 LOWEST_SAL NUMBER,
 HIGHEST_SAL NUMBER
 );

-- We insert the records for this table 
 insert into JOB_GRADES (GRADE_LEVEL, LOWEST_SAL,HIGHEST_SAL)
 values ('A',1000, 2999);
 insert into JOB_GRADES (GRADE_LEVEL, LOWEST_SAL,HIGHEST_SAL)
 values ('B',3000, 5999);
 insert into JOB_GRADES (GRADE_LEVEL, LOWEST_SAL,HIGHEST_SAL)
 values ('C',6000, 9999);
 insert into JOB_GRADES (GRADE_LEVEL, LOWEST_SAL,HIGHEST_SAL)
 values ('D',10000, 14999);
 insert into JOB_GRADES (GRADE_LEVEL, LOWEST_SAL,HIGHEST_SAL)
 values ('E',15000, 24999);
 insert into JOB_GRADES (GRADE_LEVEL, LOWEST_SAL,HIGHEST_SAL)
 VALUES ('F',25000, 40000);
 commit; 
 select * from job_grades;
 
 -- This is the nonEquijoins, try to make join using another operators other than =
 SELECT EMP.EMPLOYEE_ID, EMP.FIRST_NAME, EMP.SALARY, grades.grade_level
 FROM
 EMPLOYEES EMP ,
 JOB_GRADES GRADES 
 where EMP.salary between GRADES.lowest_sal and grades.highest_sal 
 
 
SELECT EMP.EMPLOYEE_ID, EMP.FIRST_NAME, EMP.SALARY, grades.grade_level
 FROM
 EMPLOYEES EMP ,
 JOB_GRADES GRADES 
 WHERE EMP.SALARY >= GRADES.LOWEST_SAL 
 and EMP.SALARY<=grades.highest_sal 

SELECT 
EMPLOYEES.EMPLOYEE_ID , 
EMPLOYEES.FIRST_NAME, 
EMPLOYEES.DEPARTMENT_ID, 
DEPARTMENTS.DEPARTMENT_NAME
FROM EMPLOYEES,
DEPARTMENTS
WHERE EMPLOYEES.DEPARTMENT_ID=DEPARTMENTS.DEPARTMENT_ID
ORDER BY EMPLOYEE_ID;

-- Outer join, case1
SELECT 
EMPLOYEES.EMPLOYEE_ID , 
EMPLOYEES.FIRST_NAME, 
EMPLOYEES.DEPARTMENT_ID, 
DEPARTMENTS.DEPARTMENT_NAME
FROM EMPLOYEES,
DEPARTMENTS
WHERE EMPLOYEES.DEPARTMENT_ID=DEPARTMENTS.DEPARTMENT_ID(+)
ORDER BY EMPLOYEE_ID;

--- Outer join, case2
SELECT 
EMPLOYEES.EMPLOYEE_ID , 
EMPLOYEES.FIRST_NAME, 
DEPARTMENTS.DEPARTMENT_ID, 
DEPARTMENTS.DEPARTMENT_NAME
FROM EMPLOYEES,
DEPARTMENTS
WHERE EMPLOYEES.DEPARTMENT_ID(+)=DEPARTMENTS.DEPARTMENT_ID
ORDER BY EMPLOYEE_ID;

-- Self join

SELECT EMPLOYEE_ID, FIRST_NAME, MANAGER_ID
FROM EMPLOYEES;

-- I want to display manager name, so it is self join

SELECT 
worker.EMPLOYEE_ID, 
WORKER.FIRST_NAME, 
WORKER.MANAGER_ID,
manager.first_name
FROM 
EMPLOYEES WORKER,
EMPLOYEES MANAGER
WHERE WORKER.MANAGER_ID=MANAGER.EMPLOYEE_ID;

SELECT 
worker.EMPLOYEE_ID, 
WORKER.FIRST_NAME, 
WORKER.MANAGER_ID,
manager.first_name
FROM 
EMPLOYEES WORKER,
EMPLOYEES MANAGER
WHERE WORKER.MANAGER_ID=MANAGER.EMPLOYEE_ID(+)

--Example: 

/*
Retrieve all the employees (employee id, first name, dept. id ) who???s salary >2500
And display their department name, and department location and department city and country
All employees should appear even if they have no department
*/

-- First, the number of records should be like this because the employees table is the main table 

SELECT count(1) 
FROM 
EMPLOYEES
WHERE  SALARY>2500;

/*
  Now we detrmine the column we need to pick it
  From EMPLOYEES we need employee_id, first_name,department_id
  From departments we need department_name and location_id
  Frorm locations we need city and country_id
  From countries try we need country_name
*/

SELECT EMP.EMPLOYEE_ID,EMP.FIRST_NAME,EMP.DEPARTMENT_ID,
DEPT.DEPARTMENT_NAME , DEPT.LOCATION_ID,
LOC.CITY,
cont.country_name
FROM
EMPLOYEES EMP,
DEPARTMENTS DEPT,
LOCATIONS LOC ,
COUNTRIES CONT
WHERE EMP.DEPARTMENT_ID=DEPT.DEPARTMENT_ID(+)
AND DEPT.LOCATION_ID=LOC.LOCATION_ID(+)
AND LOC.COUNTRY_ID=CONT.COUNTRY_id(+)
and SALARY>2500;

-- Cross join (cartesian product in 1999 format)
SELECT 
EMPLOYEES.EMPLOYEE_ID , 
EMPLOYEES.FIRST_NAME, 
DEPARTMENTS.DEPARTMENT_ID, 
DEPARTMENTS.DEPARTMENT_NAME
FROM EMPLOYEES
cross join
DEPARTMENTS
ORDER BY EMPLOYEE_ID;

-- Cartesian product in old format  ( 1 and 2 are same  )
SELECT 
EMPLOYEES.EMPLOYEE_ID , 
EMPLOYEES.FIRST_NAME, 
DEPARTMENTS.DEPARTMENT_ID, 
DEPARTMENTS.DEPARTMENT_NAME
FROM EMPLOYEES,
DEPARTMENTS
ORDER BY EMPLOYEE_ID;


-- Natural join

-- Natural join between DEPARTMENTS and LOCATIONS

-- We can not prefix table name in the match column
SELECT 
DEPARTMENTS.DEPARTMENT_ID,
DEPARTMENTS.DEPARTMENT_NAME,
LOCATION_ID, 
LOCATIONS.city
FROM
DEPARTMENTS
NATURAL JOIN LOCATIONS

-- Making natural join using old format as equijoun ( 3 and 4 same)

SELECT 
DEPARTMENTS.DEPARTMENT_ID,
DEPARTMENTS.DEPARTMENT_NAME,
DEPARTMENTS.LOCATION_ID, --here you should put the prefix
LOCATIONS.city
FROM
DEPARTMENTS,
LOCATIONS
WHERE DEPARTMENTS.LOCATION_ID=LOCATIONS.LOCATION_ID;

/* IF WE TRY TO MAKE NATURAL JOIN BETWEEN EMPLOYEES AND DEPARTMENTS, THIS IS WRONG
   because it will join 2 columns DEPARTMENT_ID and  MANAGER_ID */

-- Use where in additional condition in NATURAL JOIN, then and if required  
SELECT 
DEPARTMENTS.DEPARTMENT_ID,
DEPARTMENTS.DEPARTMENT_NAME,
LOCATION_ID, -- We can not prefix table name in the match column
LOCATIONS.city
FROM
DEPARTMENTS
NATURAL JOIN LOCATIONS
where DEPARTMENTS.DEPARTMENT_ID>20 

-- Retriving records with USING
SELECT 
EMPLOYEES.EMPLOYEE_ID , 
EMPLOYEES.FIRST_NAME, 
DEPARTMENT_ID, -- We can not prefix table name in the match column
DEPARTMENTS.DEPARTMENT_NAME
FROM EMPLOYEES join
DEPARTMENTS
USING(DEPARTMENT_ID) -- only one column can be used
ORDER BY EMPLOYEE_ID;

-- We can do query 6 with equijoin as follow
SELECT 
EMPLOYEES.EMPLOYEE_ID , 
EMPLOYEES.FIRST_NAME, 
EMPLOYEES.DEPARTMENT_ID, 
DEPARTMENTS.DEPARTMENT_NAME
FROM EMPLOYEES,
DEPARTMENTS
WHERE EMPLOYEES.DEPARTMENT_ID=DEPARTMENTS.DEPARTMENT_ID
ORDER BY EMPLOYEE_ID;

-- Creaing join with the ON clause, this is better than natural join and using
SELECT 
EMPLOYEES.EMPLOYEE_ID , 
EMPLOYEES.FIRST_NAME, 
DEPARTMENTS.DEPARTMENT_ID, ---here prefix should be use 
DEPARTMENTS.DEPARTMENT_NAME
FROM EMPLOYEES join
DEPARTMENTS
ON (EMPLOYEES.DEPARTMENT_ID=DEPARTMENTS.DEPARTMENT_ID)
-----where EMPLOYEE_ID=100
ORDER BY EMPLOYEE_ID;

-- We can wirte query 8 as follow 
SELECT 
EMPLOYEES.EMPLOYEE_ID , 
EMPLOYEES.FIRST_NAME, 
EMPLOYEES.DEPARTMENT_ID, 
DEPARTMENTS.DEPARTMENT_NAME
FROM EMPLOYEES,
DEPARTMENTS
WHERE EMPLOYEES.DEPARTMENT_ID=DEPARTMENTS.DEPARTMENT_ID
ORDER BY EMPLOYEE_ID;

-- Also we can use on  for nonequijoin

 SELECT EMP.EMPLOYEE_ID, EMP.FIRST_NAME, EMP.SALARY, grades.grade_level
 FROM
 EMPLOYEES EMP join 
 JOB_GRADES GRADES 
 ON EMP.SALARY BETWEEN GRADES.LOWEST_SAL AND GRADES.HIGHEST_SAL 
 
 SELECT EMP.EMPLOYEE_ID, EMP.FIRST_NAME, EMP.SALARY, grades.grade_level
 FROM
 EMPLOYEES EMP ,
 JOB_GRADES GRADES 
 where EMP.salary between GRADES.lowest_sal and grades.highest_sal 

-- Also we can  make self join by ( ON )
SELECT 
worker.EMPLOYEE_ID, 
WORKER.FIRST_NAME, 
WORKER.MANAGER_ID,
manager.first_name
FROM 
EMPLOYEES WORKER join
EMPLOYEES MANAGER
on( WORKER.MANAGER_ID=MANAGER.EMPLOYEE_ID);

SELECT 
worker.EMPLOYEE_ID, 
WORKER.FIRST_NAME, 
WORKER.MANAGER_ID,
manager.first_name
FROM 
EMPLOYEES WORKER,
EMPLOYEES MANAGER
WHERE WORKER.MANAGER_ID=MANAGER.EMPLOYEE_ID;

-- Join 3 tables
SELECT 
EMP.EMPLOYEE_ID , 
EMP.FIRST_NAME, 
emp.DEPARTMENT_ID, 
DEPT.DEPARTMENT_NAME,
DEPT.location_id,
loc.city
FROM 
EMPLOYEES EMP 
join
DEPARTMENTS DEPT
on (EMP.DEPARTMENT_ID=DEPT.DEPARTMENT_ID )
JOIN LOCATIONS LOC
on ( DEPT.LOCATION_ID=LOC.LOCATION_ID)
ORDER BY EMPLOYEE_ID;

-- Also we can do query 10 as follow

SELECT 
EMP.EMPLOYEE_ID , 
EMP.FIRST_NAME, 
emp.DEPARTMENT_ID, 
DEPT.DEPARTMENT_NAME,
DEPT.location_id,
loc.city
FROM 
EMPLOYEES EMP ,
DEPARTMENTS DEPT,
locations loc
WHERE EMP.DEPARTMENT_ID=DEPT.DEPARTMENT_ID
AND DEPT.LOCATION_ID=LOC.LOCATION_ID
ORDER BY EMPLOYEE_ID;


-- Left outer join 
SELECT 
EMPLOYEES.EMPLOYEE_ID , 
EMPLOYEES.FIRST_NAME, 
EMPLOYEES.DEPARTMENT_ID, 
DEPARTMENTS.DEPARTMENT_NAME
FROM EMPLOYEES
left OUTER JOIN DEPARTMENTS
on( EMPLOYEES.DEPARTMENT_ID=DEPARTMENTS.DEPARTMENT_ID)
ORDER BY EMPLOYEE_ID;

-- We can write query 12 as follow 
SELECT 
EMPLOYEES.EMPLOYEE_ID , 
EMPLOYEES.FIRST_NAME, 
EMPLOYEES.DEPARTMENT_ID, 
DEPARTMENTS.DEPARTMENT_NAME
FROM EMPLOYEES,
DEPARTMENTS
WHERE EMPLOYEES.DEPARTMENT_ID=DEPARTMENTS.DEPARTMENT_ID(+)
ORDER BY EMPLOYEE_ID;


-- Right  outer join
SELECT 
EMPLOYEES.EMPLOYEE_ID , 
EMPLOYEES.FIRST_NAME, 
EMPLOYEES.DEPARTMENT_ID, 
DEPARTMENTS.DEPARTMENT_NAME
FROM EMPLOYEES
right OUTER JOIN DEPARTMENTS
ON( EMPLOYEES.DEPARTMENT_ID=DEPARTMENTS.DEPARTMENT_ID)
ORDER BY EMPLOYEE_ID;

-- We can write query 14 as follow
SELECT 
EMPLOYEES.EMPLOYEE_ID , 
EMPLOYEES.FIRST_NAME, 
EMPLOYEES.DEPARTMENT_ID, 
DEPARTMENTS.DEPARTMENT_NAME
FROM EMPLOYEES,
DEPARTMENTS
WHERE EMPLOYEES.DEPARTMENT_ID(+)=DEPARTMENTS.DEPARTMENT_ID
ORDER BY EMPLOYEE_ID;


-- Full outer join 
SELECT 
EMPLOYEES.EMPLOYEE_ID , 
EMPLOYEES.FIRST_NAME, 
EMPLOYEES.DEPARTMENT_ID, 
DEPARTMENTS.DEPARTMENT_NAME
FROM EMPLOYEES
FULL OUTER JOIN DEPARTMENTS
ON( EMPLOYEES.DEPARTMENT_ID=DEPARTMENTS.DEPARTMENT_ID)
ORDER BY EMPLOYEE_ID;
