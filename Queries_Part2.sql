/*
We can use substitution variables to:
    - Temporarily store values with single-ampersand (&) and double-ampersand (&&) substitution
Use substitution variables to supplement the following:
    - WHERE conditions
    - ORDER BY clauses
    - Column expressions
    - Table names
    - Entire SELECT statements
*/

-- When using single & the variable will be discareded after is used 
SELECT employee_id, last_name, salary, department_id
FROM   EMPLOYEES
WHERE  EMPLOYEE_ID = &EMPLOYEE_NUM ;

-- Use '' when using varchar
SELECT employee_id, first_name,last_name, salary, department_id
FROM   EMPLOYEES
where FIRST_NAME='&ename'
ORDER BY 2;

-- Another way to deal with varchar is to wirte the '' included in variable example 'Adam'
SELECT employee_id, first_name,last_name, salary, department_id
FROM   EMPLOYEES
WHERE FIRST_NAME=&ename
ORDER BY 2;

--Specifying Column Names, Expressions, and Text
--&column_name=salary  &condition=salary>10000   &ORDER_COLUMN=employee_id

SELECT employee_id, last_name, job_id,&column_name
FROM   employees
WHERE  &condition
ORDER BY &ORDER_COLUMN ;

/*
We use the DEFINE command to create and assign a value to a variable.
And we use the UNDEFINE command to remove a variable
*/

-- This variable is valid for the session only
DEFINE EMPLOYEE_NUM = 200; 

SELECT employee_id, last_name, salary, department_id
FROM   employees
WHERE  EMPLOYEE_ID = &EMPLOYEE_NUM ;

UNDEFINE EMPLOYEE_NUM

-- We can change the prompt message as follow but it should be executed as a script

ACCEPT DEPT_ID PROMPT 'please enter dept id' ;
SELECT * FROM EMPLOYEES
WHERE DEPARTMENT_ID=&DEPT_ID;

UNDEFINE DEPT_ID

ACCEPT emp_from PROMPT 'please enter EMPLOYEE from ' ;
ACCEPT emp_to PROMPT 'please enter EMPLOYEE to ' ;
SELECT * FROM EMPLOYEES
WHERE EMPLOYEE_id between &emp_from and &emp_to;

UNDEFINE emp_from
UNDEFINE emp_to

--  Using the Double-Ampersand Substitution Variable
--- && define the variable and assign the value in the same time , then we can re-use it again
select * from DEPARTMENTS where DEPARTMENT_ID=&&p;

undefine p

-- This =define column_name
SELECT   employee_id, last_name, job_id, &&column_name 
FROM     EMPLOYEES
ORDER BY &COLUMN_NAME ;

undefine column_name;

/*
If you use a single & then the value will be prompted for each time it's encountered. 
If you use && then the original substitution value is used for the duration of the script.

Normally, if you have many occurrences of &variable in a script, sqlplus will prompt you each time for its value. 
By using &&variable, you have told sqlplus to use the same value for each subsequent occurence of &variable until you would undefine &variable.

Above notes taken from; https://asktom.oracle.com/pls/apex/asktom.search?tag=regarding-and and https://ask.sqlservercentral.com/questions/38243/what-is-the-significance-of-the-and-operators-in-p.html

*/

/*
  Use the VERIFY command to toggle the display of the substitution variable, 
both before and after SQL Developer replaces substitution variables with values:
*/

-- should be executed as script 
SET VERIFY ON
SELECT employee_id, last_name, salary
FROM   employees
WHERE  EMPLOYEE_ID = &E_NUM;

-- Using set define off
-- we use it to prevent oracle server to display the prompt window for specifc resons

-- In here the oracle server suppose that & is variable
SELECT * FROM DEPARTMENTS
WHERE DEPARTMENT_NAME LIKE '%&t%';

-- We use set define off

SET DEFINE OFF;

SELECT * FROM DEPARTMENTS
WHERE DEPARTMENT_NAME LIKE '%&t%';

-- We can use set define on  to show again the prompt window when using &

SET DEFINE ON;