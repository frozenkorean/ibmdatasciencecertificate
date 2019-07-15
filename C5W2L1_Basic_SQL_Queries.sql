------------------------------------------
--DDL statement for table 'HR' database--
--------------------------------------------

CREATE TABLE EMPLOYEES (
                            EMP_ID CHAR(9) NOT NULL,
                            F_NAME VARCHAR(15) NOT NULL,
                            L_NAME VARCHAR(15) NOT NULL,
                            SSN CHAR(9),
                            B_DATE DATE,
                            SEX CHAR,
                            ADDRESS VARCHAR(30),
                            JOB_ID CHAR(9),
                            SALARY DECIMAL(10,2),
                            MANAGER_ID CHAR(9),
                            DEP_ID CHAR(9) NOT NULL,
                            PRIMARY KEY (EMP_ID));

CREATE TABLE JOB_HISTORY (
                            EMPL_ID CHAR(9) NOT NULL,
                            START_DATE DATE,
                            JOBS_ID CHAR(9) NOT NULL,
                            DEPT_ID CHAR(9),
                            PRIMARY KEY (EMPL_ID,JOBS_ID));

CREATE TABLE JOBS (
                            JOB_IDENT CHAR(9) NOT NULL,
                            JOB_TITLE VARCHAR(15) ,
                            MIN_SALARY DECIMAL(10,2),
                            MAX_SALARY DECIMAL(10,2),
                            PRIMARY KEY (JOB_IDENT));

CREATE TABLE DEPARTMENTS (
                            DEPT_ID_DEP CHAR(9) NOT NULL,
                            DEP_NAME VARCHAR(15) ,
                            MANAGER_ID CHAR(9),
                            LOC_ID CHAR(9),
                            PRIMARY KEY (DEPT_ID_DEP));

CREATE TABLE LOCATIONS (
                            LOCT_ID CHAR(9) NOT NULL,
                            DEP_ID_LOC CHAR(9) NOT NULL,
                            PRIMARY KEY (LOCT_ID,DEP_ID_LOC));

/*
Question 1: Were there any warnings loading data into the JOBS table? What can
be done to resolve this?
Answer: Yes, there were warnings about data being truncated. Some job titles were
longer than the specified length for the column. The number of characters allowed
for the column should be increased.
*/

/*
Question 2: Did all rows from the source file load successfully in the DEPARTMENT
table? If not, are you able to figure out why not?
Answer: No. There were two DEPT_ID_DEP with the same value (5). As DEPT_ID_DEP is
a primary key, duplicates are not allowed.
*/

--Query 1: Retrieve all employees whose address is in Elgin,IL
SELECT *
  FROM employees
  WHERE address LIKE '%Elgin,IL';

--Query 2: Retrieve all employees who were born during the 1970's.
SELECT *
  FROM employees
  WHERE b_date BETWEEN '1970-01-01' AND '1980-01-01';

--Query 3: Retrieve all employees in department 5 whose salary is between
--60000 and 70000 .
SELECT *
  FROM employees
  WHERE dep_id = 5 AND (salary BETWEEN 60000 AND 70000);

--Query 4A: Retrieve a list of employees ordered by department ID.
SELECT *
  FROM employees
  ORDER BY dep_id;

--Query 4B: Retrieve a list of employees ordered in descending order by department
--ID and within each department ordered alphabetically in descending order by
--last name.
SELECT *
  FROM employees
  ORDER BY dep_id DESC l_name DESC;

--Query 5A: For each department ID retrieve the number of employees in the department.
SELECT dep_id, COUNT(*)
  FROM employees
  GROUP BY dep_id;

--Query 5B: For each department retrieve the number of employees in the department,
--and the average employees salary in the department.
SELECT dep_id, COUNT(emp_id), AVG(salary)
  FROM employees
  GROUP BY dep_id;

--Query 5C: Label the computed columns in the result set of Query 5B as
--“NUM_EMPLOYEES” and “AVG_SALARY”.
SELECT dep_id, COUNT(emp_id) AS 'num_employees',
       AVG(salary) AS 'avg_salary'
  FROM employees
  GROUP BY dep_id;

--Query 5D: In Query 5C order the result set by Average Salary.
SELECT dep_id, COUNT(emp_id) AS 'num_employees',
       AVG(salary) AS 'avg_salary'
  FROM employees
  ORDER BY avg_salary
  GROUP BY dep_id;

--Query 5E: In Query 5D limit the result to departments with fewer than 4 employees.
SELECT dep_id, COUNT(emp_id) AS 'num_employees',
       AVG(salary) AS 'avg_salary'
  FROM employees
  ORDER BY avg_salary
  GROUP BY DEP_ID
  HAVING num_employees < 4;

--BONUS Query 6: Similar to 4B but instead of department ID use department
--name. Retrieve a list of employees ordered by department name, and within
--each department ordered alphabetically in descending order by last name.
SELECT *
  FROM employees e
  JOIN departments d
  ON e.dep_id = d.dept_id_dep
  ORDER BY dep_name, l_name DESC;
