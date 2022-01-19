/* Character functions:
   There are 2 types for character functions
   1. Case conversion functions 
   2. Character manipulation
*/

-- Case conversion functions = ( upper, lower, initcap )

SELECT EMPLOYEE_ID, FIRST_NAME,upper(FIRST_NAME), lower(FIRST_NAME),initcap(first_name) 
FROM EMPLOYEES;

-- Single row function can be used in select, where, order by 

SELECT EMPLOYEE_ID, FIRST_NAME,UPPER(FIRST_NAME), LOWER(FIRST_NAME),INITCAP(FIRST_NAME) 
FROM EMPLOYEES
WHERE UPPER(FIRST_NAME)='PATRICK';

-- Example perferct when creating search screens
SELECT EMPLOYEE_ID, FIRST_NAME,UPPER(FIRST_NAME), LOWER(FIRST_NAME),INITCAP(FIRST_NAME) 
FROM EMPLOYEES
WHERE UPPER(FIRST_NAME)=UPPER('patrick')
ORDER BY UPPER(FIRST_NAME); 

-- Character manipulation functions:

-- Concat function
SELECT EMPLOYEE_ID,FIRST_NAME, LAST_NAME, CONCAT(FIRST_NAME,LAST_NAME)
FROM EMPLOYEES;

-- Concat function only took 2 args, but || more flixable
SELECT EMPLOYEE_ID,FIRST_NAME, LAST_NAME, FIRST_NAME||' '||LAST_NAME||salary name
FROM EMPLOYEES;

/* Substr function, substr(column|expersion ,m,n)
   where m is the starting posistion, n the characters long */

SELECT EMPLOYEE_ID, 
FIRST_NAME, 
SUBSTR(FIRST_NAME,1,3), 
SUBSTR(FIRST_NAME,2,4),
--if you didnt specify the n value, then it will be to the end of string
SUBSTR(FIRST_NAME,2), 
--if m is negative , then the count start from the end
SUBSTR(FIRST_NAME,-3)
FROM EMPLOYEES;

-- Length function

-- It takes char and return number
SELECT FIRST_NAME, LENGTH(FIRST_NAME)
FROM EMPLOYEES;

/*
    instr function
    instr function
    instr(column|expersion ,m,n)
    m is the start searching position , n the occourence
    1 is the default for m and n
*/
SELECT FIRST_NAME, 
INSTR(FIRST_NAME,'e') ,
INSTR(FIRST_NAME,'e',2),
INSTR(FIRST_NAME,'e',5),
INSTR(FIRST_NAME,'e',1,2)
FROM EMPLOYEES
where FIRST_NAME='Nanette';


-- lpad and rpad
SELECT EMPLOYEE_ID, FIRST_NAME, SALARY, LPAD(SALARY,10,'#'), rPAD(SALARY,10,'*')
FROM EMPLOYEES;

-- Replace function

SELECT EMPLOYEE_ID, FIRST_NAME,replace(FIRST_NAME,'a','*'),replace(FIRST_NAME,'en','#')
FROM EMPLOYEES;

/*
  Trim function:
  Examples using dual table, dual is a public table that you can use to view result from functions and calculation
*/

-- It is a table contain one column and ony dummy value x
SELECT * FROM DUAL;

SELECT 1+1+3 FROM DUAL;

-- Shows the results but the number of results equal number of records
SELECT 1+5 FROM EMPLOYEES;


--TRIM( [ [ LEADING | TRAILING | BOTH ] trim_character FROM ] string1 )

SELECT TRIM (' ' FROM '  khaled khudari  ') V  FROM DUAL;

SELECT TRIM (LEADING ' ' FROM '  khaled khudari  ') V  FROM DUAL; 


SELECT TRIM (TRAILING ' ' FROM '  khaled khudari  ') V  FROM DUAL; 


SELECT TRIM (BOTH ' ' FROM '  khaled khudari  ') V  FROM DUAL;


SELECT TRIM ('k' FROM 'khaled khudari') V  FROM DUAL; 


SELECT TRIM (LEADING 'k' FROM 'khaled khudari') V  FROM DUAL; 

SELECT TRIM (TRAILING 'k' FROM 'khaled khudari') V  FROM DUAL; 

SELECT TRIM ('  khaled       khudai  ') v  FROM DUAL;

-- Number functions, take number and return number

-- Round function

-- If you didnt sepecify decimal places , then round without decimal 
SELECT ROUND(10.5) FROM DUAL; 

-- If you didnt sepecify decimal places , then round without decimal 
SELECT ROUND(150.49) FROM DUAL;

SELECT ROUND(10.48, 1) FROM DUAL;

SELECT ROUND(10.499, 1) FROM DUAL;

SELECT ROUND(10.499, 2) FROM DUAL;

SELECT ROUND(10.493, 2) FROM DUAL;

SELECT ROUND(55.993, 1) FROM DUAL;

SELECT ROUND(55.993, -1) FROM DUAL;

SELECT ROUND(55.493, -2) FROM DUAL;

SELECT ROUND(555.493, -2) FROM DUAL;

SELECT ROUND(570.493, -3) FROM DUAL;

SELECT ROUND(470.493, -3) FROM DUAL;

SELECT ROUND(1470.493, -2) FROM DUAL;

-- Trunc function

SELECT TRUNC(10.6565) FROM DUAL;

SELECT TRUNC(10.6565, 2) FROM DUAL;

SELECT TRUNC(998.6565, -2) FROM DUAL;

SELECT TRUNC(9998.6565, -2) FROM DUAL;

SELECT TRUNC(998.6565, -3) FROM DUAL;

-- MOD FUNCTION, return the remainder of devision

SELECT MOD(15,2) FROM DUAL;

SELECT MOD(15,3) FROM DUAL;

-- Mod function is often use to know if the number id odd or even by divided by 2 

-- If return 0 then even
SELECT MOD(100,2) FROM DUAL; 

-- If return non zero value  then odd
SELECT MOD(101,2) FROM DUAL; 

-- Date functions, the default date format in oracle is DD-MON-RR

SELECT FIRST_NAME, HIRE_DATE
FROM EMPLOYEES;

/*
  rr fomrat:
  in general if the value between  50-99 THIS return a 19xx year
  A value between 0-49 will return a 20xx year
*/

-- Sysdate: sysdate is a function that return the current database server date and time 
SELECT SYSDATE FROM DUAL;

-- Using airthmetic operators with dates:

-- Date + number = date

-- Adding days
SELECT SYSDATE, SYSDATE +3 FROM DUAL; 

-- Date - number =date 

SELECT SYSDATE, SYSDATE -3 FROM DUAL;

-- Date - date = number of days

SELECT EMPLOYEE_ID, SYSDATE, hire_date, SYSDATE- hire_date, round( SYSDATE- hire_date ) 
FROM EMPLOYEES;

-- Date+ number/24 = adding number of hours to date

SELECT  SYSDATE+ 5/24   FROM DUAL;

--Example: I need how many weeks the employees 'Adam' work till now

SELECT EMPLOYEE_ID, FIRST_NAME, SYSDATE-HIRE_DATE "no of days" ,  (SYSDATE-HIRE_DATE)/7
FROM EMPLOYEES
WHERE FIRST_NAME='Adam';

-- Months_between

-- MONTHs_BETWEEN more Accurate than number of days/30
SELECT EMPLOYEE_ID,FIRST_NAME, MONTHs_BETWEEN(SYSDATE, HIRE_DATE ), (SYSDATE-HIRE_DATE)/30
FROM EMPLOYEES;


-- If the date1 less than date 2, then result become negative
SELECT EMPLOYEE_ID,FIRST_NAME, MONTHS_BETWEEN(HIRE_DATE,SYSDATE )
FROM EMPLOYEES;

-- Add_months

SELECT EMPLOYEE_ID,FIRST_NAME,hire_date, add_months(hire_date,4) 
FROM EMPLOYEES;

SELECT EMPLOYEE_ID,FIRST_NAME,HIRE_DATE, ADD_MONTHS(HIRE_DATE,-2) 
FROM EMPLOYEES;

-- Next_day

SELECT SYSDAte,NEXT_DAY(SYSDATE,'FRIDAY') FROM DUAL;

SELECT SYSDATE,NEXT_DAY(SYSDATE,1) FROM DUAL;
/* OR YOU CAN enter number from 1 to 7
   note that 1='sunday' and continue till 7 ---NLS_DATE_LANGUAGE
*/

-- Last_day: pick the last date of the month 

SELECT LAST_DAY(SYSDATE)  FROM DUAL;

-- Example:
/*
display the employee number, first_name, hiredate,number of months employeed,
six month review date, first friday after hire date
for all employees who have been employeed for fewer than 150 months
*/

SELECT EMPLOYEE_ID, FIRST_NAME, HIRE_DATE, MONTHS_BETWEEN(SYSDATE,HIRE_DATE),
ADD_MONTHS( hire_date,6), next_day(hire_date,'FRIDAY')
FROM 
EMPLOYEES
WHERE MONTHS_BETWEEN(SYSDATE,HIRE_DATE)<150

-- Round and trunc functions in date:

SELECT EMPLOYEE_ID, 
FIRST_NAME, 
HIRE_DATE, 
round(HIRE_DATE,'MONTH'),trunc(HIRE_DATE,'MONTH')
FROM EMPLOYEES
ORDER BY HIRE_DATE;

SELECT EMPLOYEE_ID, 
FIRST_NAME, 
HIRE_DATE, 
round(HIRE_DATE,'year'),trunc(HIRE_DATE,'year')
FROM EMPLOYEES
ORDER BY HIRE_DATE;

-- Wecan make nested functions

SELECT FIRST_NAME,UPPER(FIRST_NAME), SUBSTR(UPPER(FIRST_NAME),1,3), 
lpad( SUBSTR(UPPER(first_name),1,3),10,'*')
FROM EMPLOYEES;

/*
  Assume that there is column in table contain name with 3 segments.
  We need to split the string 'ahmed ali naser' to first_name, middle_name, last_name using select stat.
*/
 SELECT 'ahmed ali naser' FULL_NAME,
 SUBSTR('ahmed ali naser',1,INSTR('ahmed ali naser',' ',1,1)-1 ) FIRST_NAME,
 SUBSTR('ahmed ali naser', INSTR('ahmed ali naser',' ',1,1)+1,
 INSTR('ahmed ali naser',' ',1,2)-INSTR('ahmed ali naser',' ',1,1)  -1)  MIDDLE_NAME,
 SUBSTR('ahmed ali naser', INSTR('ahmed ali naser',' ',1,2)+1) last_name
 FROM DUAL;
