-- Group Functions

-- Max and Min functions

SELECT SALARY
FROM employees
order by SALARY desc;

SELECT MAX(SALARY), MIN(SALARY)
FROM 
EMPLOYEES;

-- We can use max and min with varchar
SELECT MAX(first_name), MIN(first_name)
FROM 
EMPLOYEES;

-- We can use max and min with dates also 
SELECT MAX(hire_date), MIN(hire_date)
FROM 
EMPLOYEES;

-- Sum and Avg functions

SELECT sum(SALARY), avg(SALARY)
FROM 
EMPLOYEES;

-- We can not use sum and avg with varchar or dates
SELECT sum(first_name), avg(first_name)
FROM 
EMPLOYEES;

-- Count function

SELECT * FROM EMPLOYEES;

-- Count(*) return number of rows in a table including duplicate rows and include null values
SELECT COUNT(*) FROM EMPLOYEES;

SELECT COUNT(1) FROM EMPLOYEES; -- this is equal to count(*)

SELECT COUNT(COMMISSION_PCT)
FROM EMPLOYEES;   -- count (column) name ignore null values, null not counted 

SELECT COUNT(DEPARTMENT_ID) FROM EMPLOYEES; --null not counted

SELECT COUNT(DISTINCT DEPARTMENT_ID) FROM EMPLOYEES;

SELECT COUNT(COMMISSION_PCT) FROM EMPLOYEES;

-- We can handle null values using nvl function
SELECT COUNT(nvl(COMMISSION_PCT,0)) FROM EMPLOYEES;

-- We can use where in select 
SELECT count(EMPLOYEE_ID)
FROM 
EMPLOYEES
WHERE DEPARTMENT_ID=90; -- this the count for employees for department 90

-- LISTAGG function

select first_name
FROM 
EMPLOYEES
WHERE  DEPARTMENT_ID = 30
order by FIRST_NAME;

SELECT LISTAGG(FIRST_NAME, ', ')
         WITHIN GROUP (ORDER BY  FIRST_NAME) "Emp_list" 
  FROM EMPLOYEES
  WHERE department_id = 30;
  

--- Using group by 

SELECT DEPARTMENT_ID, SUM(SALARY)
FROM  EMPLOYEES;
/*
ORA-00937: not a single-group group function
00937. 00000 -  "not a single-group group function"
*/

SELECT DEPARTMENT_ID, SUM(SALARY)
FROM  EMPLOYEES
group by DEPARTMENT_ID  ; -- all columns in the select should appear in group by 

SELECT DEPARTMENT_ID,job_id, SUM(SALARY)
FROM  EMPLOYEES
GROUP BY DEPARTMENT_ID,JOB_ID  -- all columns in the select should appear in group by
order by 1, 2 ; 

/* This will retrive error , job_id also should be in group by 
the error will be: not a GROUP BY expression */

SELECT DEPARTMENT_ID,job_id, SUM(SALARY)
FROM  EMPLOYEES
GROUP BY DEPARTMENT_ID  
order by 1, 2 ; -- all columns in the select should appear in group by


-- We can not make group by using alias 
SELECT DEPARTMENT_ID d , SUM(SALARY)
FROM  EMPLOYEES
GROUP BY D;

-- But we can make order using alias 
SELECT DEPARTMENT_ID d , SUM(SALARY)
FROM  EMPLOYEES
GROUP BY DEPARTMENT_ID
order by d;

-- Where and group by and order by. Where first then group by then order by 
SELECT DEPARTMENT_ID, SUM(SALARY)
FROM  EMPLOYEES
where DEPARTMENT_ID>30
GROUP BY DEPARTMENT_ID  
order by DEPARTMENT_ID ;
 
-- Important note: We can not use where to restrict groups
SELECT DEPARTMENT_ID, SUM(SALARY)
FROM  EMPLOYEES
where SUM(SALARY)>156400 -- this not coorect , you should use having
GROUP BY DEPARTMENT_ID  
order by DEPARTMENT_ID ;

-- So use having 
SELECT DEPARTMENT_ID, SUM(SALARY)
FROM  EMPLOYEES
GROUP BY DEPARTMENT_ID  
having SUM(SALARY)>150000
order by DEPARTMENT_ID ;

-- It could be using having before group by, but not recomnded

SELECT DEPARTMENT_ID, SUM(SALARY)
FROM  EMPLOYEES
HAVING SUM(SALARY)>150000
GROUP BY DEPARTMENT_ID  
order by DEPARTMENT_ID ;

-- We can make nested group function

SELECT DEPARTMENT_ID,sum(salary)
FROM EMPLOYEES
GROUP BY DEPARTMENT_ID 
order by 1;

-- Only 2 group functions can be nested 
SELECT max(sum(salary)) 
FROM EMPLOYEES
GROUP BY DEPARTMENT_ID 
order by 1;
