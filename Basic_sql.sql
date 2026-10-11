

--Find the employee(s) with the highest salary.
SELECT FIRST_NAME ,MAX(SALARY) FROM HR.EMPLOYEES
SELECT * FROM  HR.EMPLOYEES;

SELECT FIRST_NAME , SALARY
FROM HR.EMPLOYEES
WHERE  SALARY = (SELECT MAX(SALARY) FROM HR.EMPLOYEES)
--Find the second highest salary in the company.
SELECT SALARY  FROM
( SELECT  SALARY,ROWNUM RN FROM
(SELECT SALARY FROM HR.EMPLOYEES
ORDER BY SALARY DESC))
WHERE RN=2

SELECT MAX(salary)
FROM hr.employees
WHERE salary < (
    SELECT MAX(salary)
    FROM hr.employees
);



SELECT FIRST_NAME, SALARY
FROM HR.EMPLOYEES
WHERE SALARY = (SELECT MAX(SALARY) FROM HR.EMPLOYEES);
--List employees who earn more than the average salary.
SELECT* FROM HR.EMPLOYEES
WHERE SALARY >(SELECT AVG(SALARY) FROM HR.EMPLOYEES)
--Show department-wise maximum salary.
SELECT DEPARTMENT_ID, MAX(SALARY) FROM HR.EMPLOYEES
GROUP BY DEPARTMENT_ID;
SELECT * FROM HR.EMPLOYEES
--Find employees who do not have a manager assigned.
SELECT * FROM HR.EMPLOYEES
WHERE MANAGER_ID IS NULL;
--Display employees hired in a specific year (e.g., 2005).
SELECT * FROM HR.EMPLOYEES
WHERE EXTRACT (YEAR FROM HIRE_DATE) = 2005;
--Count the number of employees in each department.
SELECT COUNT (*) FROM HR.EMPLOYEES
GROUP BY DEPARTMENT_ID;
--List employees whose salary is the same as some other employee.

SELECT * FROM HR.EMPLOYEES
WHERE SALARY IN (SELECT SALARY FROM HR.EMPLOYEES GROUP BY SALARY HAVING COUNT(*)>1);
---Show top 5 highest-paid employees
SELECT FROM
(SELECT SALARY FROM HR .EMPLOYEES
ORDER BY SALARY DESC
WHERE SALARY ROWNUM = 5;)
--Find employees earning more than their manager.
SELECT E.FIRST_NAME AS EMPLOYEE_NAME,
       E.SALARY AS EMPLOYEE_SALARY,
       M.FIRST_NAME AS MANAGER_NAME,
       M.SALARY AS MANAGER_SALARY
FROM HR.EMPLOYEES E
JOIN HR.EMPLOYEES M
  ON E.MANAGER_ID = M.EMPLOYEE_ID
WHERE E.SALARY > M.SALARY;

--Find the middle-paid employee in the table.
SELECT (SALARY FROM HR.EMPLOYEE
(SELECT SALARY

SELECT FIRST_NAME, SALARY
FROM (
    SELECT FIRST_NAME, SALARY,
           ROW_NUMBER() OVER (ORDER BY SALARY) AS rn,
           COUNT(*) OVER () AS total_count
    FROM HR.EMPLOYEES
)
WHERE rn = CEIL(total_count / 2);

--List all employees with their employee_id, first_name, last_name, and salary.
SELECT * FROM HR.EMPLOYEES;
SELECT EMPLOYEE_ID,FIRST_NAME,LAST_NAME,SALARY FROM HR.EMPLOYEES;
--Find employees who do not earn any commission (commission_pct is NULL).
SELECT * FROM HR.EMPLOYEES 
WHERE commission_pct IS NULL;

--Show all employees whose salary is greater than 5000.
SELECT * FROM HR.EMPLOYEES
WHERE SALARY > 5000;

--List employees who were hired in the year 2020.
SELECT * FROM  HR.EMPLOYEES 
WHERE EXTRACT (YEAR FROM  HIRE_DATE)=2020;
SELECT *
FROM HR.employees
WHERE EXTRACT(YEAR FROM hire_date) = 2005;

--Display employees sorted by salary in descending order.
SELECT * FROM EMPLOYEE
ORDER BY SALARY DESC;

--Count the total number of employees in HR.EMPLOYEES.
SELECT COUNT (EMPLOYEE_ID) FROM HR.EMPLOYEES;

--Find employees whose first name starts with 'A'.
SELECT  * FROM HR.EMPLOYEES
WHERE FIRST_NAME LIKE 'A%';



--Find the total salary per department.
SELECT SUM(SALARY) AS TOTAL_SALARY FROM HR.EMPLOYEES
GROUP BY DEPARTMENT_ID;

--Find the average salary per department.
SELECT AVG(SALARY) FROM HR.EMPLOYEES
GROUP BY DEPARTMENT_ID;

--List departments with more than 5 employees.
SELECT DEPARTMENT_ID,COUNT(*) FROM HR.EMPLOYEES
GROUP BY DEPARTMENT_ID 
HAVING COUNT (*) > 5;

--Find the maximum salary per job_id.
SELECT MAX(SALARY),JOB_ID FROM HR.EMPLOYEES
GROUP BY JOB_ID;

Count the number of employees per manager_id.
SELECT 

--Show the second highest salary in HR.EMPLOYEES.


SELECT salary
FROM (
    SELECT salary, ROWNUM AS rn
    FROM (
        SELECT salary
        FROM hr.employees
        ORDER BY salary DESC
    )
)
WHERE rn = 2;



--Find the employees earning more than the average salary.
SELECT SALARY FROM HR.EMPLOYEES 
WHERE SALARY >
(SELECT AVG(SALARY) FROM HR.EMPLOYEES)

--Advanced / Joins / Subqueries / Analytic Functions (15–20)

--List all employees along with their department name (include employees with no department).

Find employees who report to the same manager as employee_id = 101.

--List employees whose salary is equal to the highest salary in their department.
SELECT MAX(SALARY) FROM HR.EMPLOYEES 
GROUP BY DEPARTMENT_ID;
SELECT SALARY FROM HR.EMPLOYEES WHERE SALARY =
(SELECT MAX(SALARY) FROM HR.EMPLOYEES GROUP BY DEPARTMENT_ID);

Show the rank of each employee by salary (highest salary = 1).

Find employees who joined in the last 6 months.

Delete employees who have never earned a commission (simulation for practice, don’t actually delete in production).

--List all employees along with their department name.
SELECT EMPLOYEE_ID ,DEPARTMENT_NAME FROM HR.EMPLOYEES E
INNER JOIN HR.DEPARTMENTS D
ON E.DEPARTMENT_ID = D.DEPARTMENT_ID
--List all employees and their department name, including employees who do not belong to any department.
SELECT * FROM HR.EMPLOYEES E
LEFT JOIN HR.DEPARTMENTS D
ON E.DEPARTMENT_ID = D.DEPARTMENT_ID
--List all employees who work in the ‘IT’ department, showing their name, salary, and department.
SELECT E.FIRST_NAME ||'  '||LAST_NAME,E.SALARY,D.DEPATMENT_NAME FROM HR.EMPLOYEES
INNER JOIN DEPARTMENT D
ON E.DEPARTMENT_ID = D.DEPARTMENT_ID
WHERE DEPATMENT_NAME = 'IT';

SELECT E.FIRST_NAME || ' ' || E.LAST_NAME AS EMPLOYEE_NAME,
       E.SALARY,
       D.DEPARTMENT_NAME
FROM HR.EMPLOYEES E
INNER JOIN HR.DEPARTMENTS D
ON E.DEPARTMENT_ID = D.DEPARTMENT_ID
WHERE D.DEPARTMENT_NAME = 'IT';
--Find the number of employees in each department. Show department_name and employee_count.
SELECT DEPARTMENT_NAME,COUNT (EMPLOYEE_ID) FROM HR.EMPLOYEES E
LEFT JOIN HR.DEPARTMENTS D
ON E.DEPARTMENT_ID = D.DEPARTMENT_ID
GROUP BY DEPARTMENT_NAME;
--List employees along with their manager’s name. Show employee name, manager name.
SELECT E.EMPLOYEE_NAME ,E.MANAGER_NAME  E
 M.EMPLOYEE_NAME ,M.MANAGER_NAME FROM HR.EMPLOYEES M
 SELF JOIN HR.EMPLOYEES
 ON E.EMPLOYEE_ID =M.MANAGER_ID

GROUP BY DEPARTMENT_NAME;
SELECT * FROM HR.DEPARTMENTS;



--1️⃣ Basic Subquery

--List all employees who earn more than the average salary.
SELECT EMPLOYEE_ID, SALARY FROM HR.EMPLOYEES WHERE SALARY >(SELECT AVG(SALARY) FROM HR.EMPLOYEES);

--Find employees whose salary is higher than the salary of employee_id = 101.

SELECT EMPLOYEE_ID,SALARY FROM HR.EMPLOYEES WHERE SALARY >(SELECT SALARY FROM HR.EMPLOYEES WHERE employee_id = 101);

--List employees whose department has more than 5 employees.
SELECT COUNT(*),EMPLOYEE_ID FROM HR.EMPLOYEES WHERE COUNT(*)>

SELECT *
FROM HR.EMPLOYEES
WHERE DEPARTMENT_ID IN (
    SELECT DEPARTMENT_ID
    FROM HR.EMPLOYEES
    GROUP BY DEPARTMENT_ID
    HAVING COUNT(*) > 5
);



--List all employees.
SELECT * FROM HR.EMPLOYEES;

--List all employees in department 10.
SELECT * FROM  HR.EMPLOYEES
WHERE DEPARTMENT_ID =10;

--Show first name, last name, and salary of all employees.
SELECT FIRST_NAME,LAST_NAME,SALARY FROM HR.EMPLOYEES;

--Find employees with salary greater than 5000.
SELECT * FROM HR .EMPLOYEES
WHERE SALARY <5000;

--Show employees hired after 1-Jan-2015.
SELECT * FROM HR.EMPLOYEES
WHERE HIRE_DATE >'1-JAN-2015';

--List employees whose last name starts with ‘A’.
SELECT LAST_NAME  FROM HR.EMPLOYEES
WHERE LAST_NAME LIKE 'A%';

--Count the total number of employees.
SELECT COUNT(EMPLOYEE_ID) FROM HR.EMPLOYEES;

--Count employees in each department.
SELECT COUNT(EMPLOYEE_ID) FROM HR.EMPLOYEES
GROUP BY DEPARTMENT_ID;

--Find the maximum salary.
SELECT MAX(SALARY) FROM HR.EMPLOYEES;

--Find the minimum salary.
SELECT MIN(SALARY) FROM HR.EMPLOYEES;

--Find the average salary.
SELECT AVG(SALARY)FROM HR.EMPLOYEES;

--Show distinct job IDs in the table.
SELECT DISTINCT(JOB_ID) FROM HR.EMPLOYEES;

--Find employees who do not have a manager.
SELECT * FROM HR.EMPLOYEES
WHERE MANAGER_ID IS NULL;
List employees whose salary is between 3000 and 6000.

--Show employees sorted by hire date ascending.
SELECT * FROM HR.EMPLOYEES
ORDER BY HIRE_DATE;

--Find employees earning more than the average salary.
SELECT EMPLOYEE_ID,SALARY FROM HR.EMPLOYEES WHERE SALARY >(SELECT AVG(SALARY) FROM HR.EMPLOYEES);

--List employees per department.

SELECT E.EMPLOYEE_ID ,E. FIRST_NAME||' '||LAST_NAME, D.DEPARTMENT_ID FROM HR.EMPLOYEES E
INNER JOIN HR.DEPARTMENTS D
ON E.DEPARTMENT_ID =D.DEPARTMENT_ID
;



--Show employees with duplicate job IDs.
SELECT EMPLOYEE_ID , FIRST_NAME||' '||LAST_NAME,JOB_ID FROM HR.EMPLOYEES
WHERE JOB_ID>1;

--Find employees with salaries equal to the minimum in their department.
SELECT SALARY FROM HR.EMPLOYEES WHERE SALARY = (SELECT MIN (SALARY) FROM HR.EMPLOYEES);

--Show first name, last name, department, and salary.
SELECT FIRST_NAME,LAST_NAME, DEPARTMENT_ID ,SALARY FROM HR.EMPLOYEES;

--List employees with NULL commission_pct.
SELECT * FROM HR.EMPLOYEES
WHERE COMMISSION_PCT IS NULL;

--Find employees whose names contain ‘son’.
SELECT EMPLOYEE_ID , FIRST_NAME||' '||LAST_NAME AS NAME  FROM HR.EMPLOYEES
WHERE NAME LIKE 'son';

--Find the second highest salary.
select salary  from 
(select salary ,rownum rn
from
(select salary from hr.employees
order by salary desc )
)
where rn=2;




Show employees who have the same manager.
select employee_id, first_name||' '||last_name from hr.employees e
 employee_id, first_name||' '||last_name   ;


--Count employees per job ID.
select job_id,count(employee_id) from hr.employees
group by job_id;

--Show the department with the highest total salary.
select department_id,max(salary) from hr.employees
group by department_id;

--Show employees who were hired in 2020.
select employee_id,first_name||' ' last_name from hr.employees
where extract (year from hire_date)= '2006';

--Find employees with salaries greater than their manager’s salary.

List employees whose job ID is ‘IT_PROG’ or ‘SA_REP’.
select * from hr.employees
where job_id = 'IT_PROG' --or 'SA_REP'






SELECT *
FROM hr.employees
WHERE job_id = 'IT_PROG'
   OR job_id = 'SA_REP';

--find the salary 7 highest salary
select salary from 
( select salary, rownum rn
from 
(select salary from hr.employees
order by salary desc
)
)
where rn =7;
-- how to find n th salary 
SELECT salary from 
(select salary,rownum rn
from 
(select salary from hr.employees
order by salary desc )
)
where rn = :n;


SELECT salary
FROM (
    SELECT salary, ROWNUM rn
    FROM (
        SELECT salary
        FROM hr.employees
        ORDER BY salary DESC  -- or ASC depending on requirement
    )
)
WHERE rn = 2;  -- replace :n with the desired number


SELECT salary
FROM (
    SELECT salary, ROWNUM rn
    FROM (
        SELECT salary
        FROM hr.employees
        ORDER BY salary DESC
    )
)
WHERE rn = :n;




--Display employee first name, last name, and department name.

select * from hr.employees;
SELECT E.FIRST_NAME,E.LAST_NAME,D.DEPARTMENT_NAME FROM HR.EMPLOYEES E
INNER JOIN HR.DEPARTMENTS D
ON E.DEPARTMENT_ID = D.DEPARTMENT_ID
--List all employees along with their department ID and department name
SELECT E.EMPLOYEE_ID,E.FIRST_NAME||' '||E.LAST_NAME AS EMPLOYEE_NAME,D.DEPARTMENT_ID,D.DEPARTMENT_NAME FROM HR.EMPLOYEES E
INNER JOIN HR.DEPARTMENTS D
ON E.DEPARTMENT_ID = D.DEPARTMENT_ID;
--Show employees who work in the IT department.
SELECT E.EMPLOYEE_ID,E.FIRST_NAME||' ' ||E.LAST_NAME FROM HR.EMPLOYEES E
INNER JOIN HR.DEPARTMENTS D
ON E.DEPARTMENT_ID = D.DEPARTMENT_ID
WHERE DEPARTMENT_NAME ='IT';

--Display employee ID, job ID, and department name.
SELECT E.EMPLOYEE_ID,E.JOB_ID,D.DEPARTMENT_NAME  FROM HR.EMPLOYEES E
JOIN HR.DEPARTMENTS D
ON E.DEPARTMENT_ID = D.DEPARTMENT_ID;
--List all employees even if they are not assigned to any department.
SELECT EMPLOYEE_ID,MOD(EMPLOYEE_ID,2) FROM HR.EMPLOYEES E
INNER JOIN HR.DEPARTMENTS D
ON E.DEPARTMENT_ID = D.DEPARTMENT_ID
WHERE DEPARTMENT_ID IS NULL;

--Show all departments even if they have no employees
SELECT (EMPLOYEE_ID/2 = 0) FROM HR.EMPLOYEES;
--Display employee names and department names for employees earning more than 5000
SELECT E.FIRST_NAME||' '||LAST_NAME ,D.DEPARTMENT_NAME FROM HR.EMPLOYEES E
INNER JOIN HR.DEPARTMENTS D
ON E.DEPARTMENT_ID = D.DEPARTMENT_ID
WHERE E.SALARY<5000;
--List employees whose department name starts with ‘S’.
SELECT E.FIRST_NAME||' '||E.LAST_NAME FROM HR.EMPLOYEES E
INNER JOIN HR.DEPARTMENTS D
ON E.DEPARTMENT_ID = D.DEPARTMENT_ID
WHERE DEPARTMENT_NAME LIKE 'S%';
--Show employees and their departments sorted by department name.
SELECT EMPLOYEE_ID,FIRST_NAME|| ' ' ||LAST_NAME,D.DEPARTMENT_NAME FROM HR.EMPLOYEES E
INNER JOIN HR.DEPARTMENTS D
ON E.DEPARTMENT_ID = D.DEPARTMENT_ID
ORDER  BY DEPARTMENT_NAME;
--Display employee name and department name where department ID is 90.
SELECT E.FIRST_NAME||' '||E.LAST_NAME AS EMPLOYEE_NAME,D.DEPARTMENT_NAME FROM HR.EMPLOYEES E
INNER JOIN HR.DEPARTMENTS D
ON E.DEPARTMENT_ID =D.DEPARTMENT_ID 
WHERE D.DEPARTMENT_ID =90;

--List employees who do not belong to any department.
SELECT E.EMPLOYEE_ID ,E.FIRST_NAME FROM HR.EMPLOYEES E
WHERE DEPARTMENT_ID IS NULL;

SELECT E.EMPLOYEE_ID ,E.FIRST_NAME FROM HR.EMPLOYEES E
INNER JOIN HR.DEPARTMENTS D
ON E.DEPARTMENT_ID = D.DEPARTMENT_ID
WHERE DEPARTMENT_NAME IS NULL;

--Display department name and employee count for each department.
SELECT COUNT(E.EMPLOYEE_ID),D.DEPARTMENT_NAME FROM HR.EMPLOYEES E
JOIN HR.DEPARTMENTS D
ON E.DEPARTMENT_ID = E.DEPARTMENT_ID
GROUP BY DEPARTMENT_NAME;

---Show employees who belong to Administration or Finance departments.
SELECT E.EMPLOYEE_ID,E.FIRST_NAME FROM HR.EMPLOYEES E
JOIN HR.DEPARTMENTS D
ON E.DEPARTMENT_ID = D.DEPARTMENT_ID
WHERE D.DEPARTMENT_NAME = 'Finance'
or   
D.DEPARTMENT_NAME = 'Administration';

--Display employee full name and department name in a single column format.
SELECT E.FIRST_NAME||' '||E.LAST_NAME||' '||D.DEPARTMENT_NAME FROM HR.EMPLOYEES E
JOIN HR.DEPARTMENTS D
ON E.DEPARTMENT_ID = D.DEPARTMENT_ID;

--List employees working in departments located in location_id 1700.
SELECT * FROM HR.DEPARTMENTS;
SELECT E.EMPLOYEE_ID FROM HR.EMPLOYEES E
JOIN HR.DEPARTMENTS D
ON E.DEPARTMENT_ID = D.DEPARTMENT_ID
WHERE LOCATION_ID = 1700;
--Display employee name, department name, and city.
SELECT * FROM HR.EMPLOYEES;
SELECT * FROM HR.LOCATIONS;
SELECT E.FIRST_NAME,D.DEPARTMENT_NAME,L.CITY FROM HR.EMPLOYEES E
JOIN HR.DEPARTMENTS  D
ON E.DEPARTMENT_ID = D.DEPARTMENT_ID
JOIN HR.LOCATIONS L
ON D.LOCATION_ID = L.LOCATION_ID;
--List employees whose manager works in a different department.
SELECT E.EMPLOYEE_ID ,D.MANAGER_ID FROM HR.EMPLOYEES E
JOIN HR.DEPARTMENTS D
ON E.DEPARTMENT_ID = D.DEPARTMENT_ID
ORDER BY DEPARTMENT_NAME;

SELECT E.EMPLOYEE_ID,
       E.FIRST_NAME || ' ' || E.LAST_NAME AS EMPLOYEE_NAME,
       E.DEPARTMENT_ID AS EMP_DEPT,
       M.DEPARTMENT_ID AS MANAGER_DEPT
FROM HR.EMPLOYEES E
JOIN HR.EMPLOYEES M
ON E.MANAGER_ID = M.EMPLOYEE_ID
WHERE E.DEPARTMENT_ID <> M.DEPARTMENT_ID;
--Show employees who earn more than the average salary of their department.

SELECT E.EMPLOYEE_ID,AVG(SALARY) AS AVG FROM HR.EMPLOYEES E
JOIN HR.DEPARTMENTS D
ON E.DEPARTMENT_ID = D.DEPARTMENT_ID
ORDER BY DEPARTMENT_NAME
WHERE E.AVG>E.SALARY;
SELECT SALARY FROM HR.EMPLOYEES 
WHERE SALARY <
(SELECT AVG(SALARY) FROM HR.EMPLOYEES WHERE --GROUP BY DEPARTMENT_ID);

SELECT AVG(SALARY) AS AV FROM HR.EMPLOYEES
ORDER BY DEPARTMENT_ID
WHERE  AV >SALARY;


SELECT E.EMPLOYEE_ID,
       E.FIRST_NAME,
       E.SALARY,
       E.DEPARTMENT_ID
FROM HR.EMPLOYEES E
WHERE E.SALARY >
      (SELECT AVG(E2.SALARY)
       FROM HR.EMPLOYEES E2
       WHERE E2.DEPARTMENT_ID = E.DEPARTMENT_ID)
--Display department name and total salary paid in each department.
  SELECT SUM(E.SALARY),D.DEPARTMENT_NAME FROM HR.EMPLOYEES E
  JOIN HR.DEPARTMENTS D
  ON E.DEPARTMENT_ID = D.DEPARTMENT_ID
 GROUP BY DEPARTMENT_NAME;
 ---Show employees who work in the same department as Steven King.
 SELECT EMPLOYEE_ID,E.FIRST_NAME FROM HR.EMPLOYEES E
 JOIN HR.DEPARTMENTS D
 ON E.DEPARTMENT_ID = D.DEPARTMENT_ID
 WHERE DEPARTMENT_NAME ='STEVEN KING';
 ---List departments that have more than 5 employees.
 SELECT * FROM HR.EMPLOYEES E
 JOIN HR.DEPARTMENTS D
 ON E.DEPARTMENT_ID = D.DEPARTMENT_ID
--ORDER BY D.DEPARTMENT_ID
WHERE D.DEPARTMENT_ID >5;
       
SQL Mock Interview – Oracle HR Schema

Tables you can use:

HR.EMPLOYEES

HR.DEPARTMENTS

HR.JOBS

HR.LOCATIONS

HR.COUNTRIES

HR.REGIONS



--Q1: Show the first name, last name, and email of all employees in the “IT” department.
SELECT E.FIRST_NAME,E.LAST_NAME,E.EMAIL FROM HR.EMPLOYEES E
JOIN HR.DEPARTMENTS D
ON E.DEPARTMENT_ID = D.DEPARTMENT_ID
WHERE DEPARTMENT_NAME ='IT';


--Q2: List all employees whose salary is greater than 10000.
SELECT * FROM HR.EMPLOYEES
WHERE SALARY >10000;

--Q3: Display all departments with their department IDs and department names.
SELECT DEPARTMENT_ID,DEPARTMENT_NAME FROM HR.DEPARTMENTS;



--Q4: Show the employees who earn more than the average salary in their department.
SELECT E.EMPLOYEE_ID, SALARY FROM HR.EMPLOYEES E WHERE SALARY < (SELECT AVG(SALARY) FROM HR.EMPLOYEES
WHERE E.DEPARTMENT_ID = DEPARTMENT_ID)

--Q5: List all employees and their manager’s name.

--Q6: Display departments that have more than 5 employees.
SELECT COUNT(E.EMPLOYEE_ID ) AS  EMPLOYEE FROM HR.EMPLOYEES E
JOIN HR.DEPARTMENTS D
ON E.DEPARTMENT_ID = D.DEPARTMENT_ID
GROUP BY D.DEPARMENT_NAME
HAVING EMPLOYEE >5;

Q7: Show the total salary paid in each department.
SELECT SUM(SALARY) AS TOTAL_SALARY ,D.DEPARTMENT_ID FROM HR.EMPLOYEES E
JOIN HR.DEPARTMENTS D
ON E.DEPARTMENT_ID = D.DEPARTMENT_ID
GROUP BY D.DEPARTMENT_ID;




Q
--List all employees whose salary is above the average salary of their department.
select * from employees where salary >
(select avg(salary) from hr.employees);

--Find employees whose salary is above the overall company average.
select * from hr.employees
where salary>(select avg(salary) from hr.employees);

--List employees who work in departments located in the United States.
select * from hr.locations;
select * from hr.departments;
SELECT employee_id,
       first_name,
       last_name,
       department_id
FROM hr.employees
WHERE department_id IN (
    SELECT department_id
    FROM hr.departments d
    JOIN hr.locations l
    ON d.location_id = l.location_id
    WHERE l.country_id = 'US'
);


--Find employees whose salary is higher than the maximum salary in department 60.
select * from hr.employees where salary >
(select max(salary) from hr.employees
where department_id = 90);

SELECT *
FROM hr.employees
WHERE salary > (
    SELECT MAX(salary)
    FROM hr.employees
    WHERE department_id = 60
);


--List the employee(s) with the second highest salary in the company.
select salary from
(select salary,rownum rn from
( select salary from hr.employees
order by salary desc
)
)
where rn =2;

--Find employees whose salary is not equal to the minimum salary in their department.
select salary from hr.employees e
where e.salary !=
(
select min(e1.salary) from hr.employees e1

order by e1.salary
where e1.department_id = e.department_id);

SELECT employee_id,
       first_name,
       last_name,
       salary,
       department_id
FROM hr.employees e
WHERE e.salary != (
    SELECT MIN(e1.salary)
    FROM hr.employees e1
    WHERE e1.department_id = e.department_id
);


--List departments that have no employees.
select * from hr.departments
(select * hr.employees )

--Find employees whose salary is between the minimum and maximum salary of department 90.
select * from hr.employees where salary between (select min(salary), max(salary)
 from hr.employees where deaprtment_id =90);

--List employees whose manager earns a higher salary than themselves.

Find employees whose department average salary is less than 10,000.
SELECT * FROM EMPLOYEE;
SELECT EMP_ID,FIRST_NAME,LAST_NAME,AVG(SALARY), DEPARTMENT FROM EMPLOYEE
WHERE SALARY >10000
GROUP BY DEPARTMENT ;





--Q1: List all employees’ first names, last names, and their job titles.

select first_name,last_name , job_id from hr.employees;
select * from hr.employees;
--Find the number of employees in each department, and display the department name along with the count of employees. Only show departments that have more than 3 employees.
select e.first_name,e.last_name,e.department_id,count(employee_id) cemp,d.department_name from hr.employees e
join hr.departments d
on e.department_id=d.department_id
group by d.department_name
having count(employee_id > 3);
(Tables: employees, departments)

SELECT d.department_name,
       COUNT(e.employee_id) AS cemp
FROM hr.employees e
JOIN hr.departments d
  ON e.department_id = d.department_id
GROUP BY d.department_name
HAVING COUNT(e.employee_id) > 3;
--For each department, find the employee(s) with the highest salary. Display:

Department name

Employee first name and last name

Salary
select d.department_name,max(salary),from hr.employees e
join hr.departments d
on e.department_id = d.department_id 
group by department_name

--1
select max(salary) ,department_id from hr.employees
group by department_id;
--
select salary from  (select salary,rownum from (
select salary from hr.employees order by salary desc))
where rownum =2;
--
select * from hr.employees;
select first_name||' '||last_name employee_name ,department_id,salary,
Dense_rank over( partition by salary order by salary  )


SELECT NAME FROM EMPLOYEE
WHERE DEPARTMENT ='IT' AND SALARY>600000;
SELECT AVG(SALARY)DAVG,DEPARTMENT  FROM EMPLOYEES
WHERE DAVG >55000
GROUP BY DEPARTMENT;
SELECT E.NAME,D.DEPARTMENT_NAME FROM EMPLOYEES
JOIN DEPARTMENTD D
ON E.DEPARTMENT_ID = D.DEPARTMENT_ID
WHERE MOD(EMP_ID,2)=0;
SELECT SALARY FROM(
SELECT SALARY,ROWNUM RN,
(SELECT SALARY FROM EMPLOYEES
ORDER BY DESC))
WHERE RN=2;
SELECT SALARY FROM
(SELECT DENSE OVER (PARTITION BY SALARY) RNK FROM 
EMPLOYEES ))
WHERE RNK=2;
SELECT EMAIL,COUNT (EMAIL) FROM EMPLOYEES
GROUP BY EMAIL
HAVING EMAIL >1;
1--
SELECT * FROM HR.JOBS
SELECT * FROM HR.EMPLOYEES;
SELECT E.FIRST_NAME||' '||E.LAST_NAME AS EMPLOYEE_NAME,J.JOB_TITLE,E.SALARY FROM HR.EMPLOYEES E
LEFT JOIN HR.JOBS J
ON E.JOB_ID =J.JOB_ID;
--2️⃣ Employees by department

--Question: List employees grouped by department with department name and number of employees.
SELECT COUNT(E.EMPLOYEE_ID),D.DEPARTMENT_NAME FROM HR.EMPLOYEES E
LEFT JOIN HR.DEPARTMENTS D
ON E.DEPARTMENT_ID = D.DEPARTMENT_ID
GROUP BY D.DEPARTMENT_NAME;
--3️⃣ Highest salary in each department

--Question: Find the highest-paid employee in each department.

--Key concepts:
SELECT MAX(E.SALARY),D.DEPARTMENT_NAME FROM HR.EMPLOYEES E
LEFT JOIN HR.DEPARTMENTS D
ON E.DEPARTMENT_ID =D.DEPARTMENT_ID
GROUP BY DEPARTMENT_NAME;
--Second highest salary

--Question: Find the second highest salary in the company.
SELECT SALARY FROM 
( SELECT SALARY ,ROWNUM RN FROM 
(SELECT SALARY FROM HR.EMPLOYEES 
ORDER BY SALARY DESC))
WHERE RN= 2;

--Employees without manager

--Question: List employees who do not have a manager (manager_id IS NULL).
SELECT * FROM HR.EMPLOYEES 
WHERE MANAGER_ID IS NULL;
--6️⃣ Employees with salary > department average

--Question: List employees who earn more than their department’s average salary.
SELECT SALARY FROM HR.EMPLOYEES WHERE SALARY > (
SELECT AVG(SALARY),D.DEPARTMENT_NAME FROM  HR.EMPLOYEES )
GROUP BY DEPARTMENT_NAME;
WHERE E.DEPARTMENT_ID = D.DEPARTMENT_ID
SELECT SALARY FROM HR.EMPLOYEES WHERE SALARY > 
(SELECT AVG(SALARY) FROM  HR.EMPLOYEES )
SELECT E.SALARY ,AVG(E.SALARY),D.DEPARTMENT_NAME  FROM HR.EMPLOYEES E
JOIN HR.DEPARTMENTS D
ON E.DEPARTMENT_ID = D.DEPARTMENT_ID 
GROUP BY DEPARTMENT_NAME
HAVING SALARY>AVG(E.SALARY);
--Duplicate email or phone

Question: Find duplicate emails in the employees table.

--Key concepts:

--GROUP BY + HAVING COUNT(email) > 1Common test of aggregation skills
SELECT EMAIL,COUNT(EMAIL) FROM HR.EMPLOYEES
GROUP BY EMAIL
HAVING COUNT(EMAIL)>1;

--Top N employees per department

--Question: List top 2 highest-paid employees per department.

SELECT SALARY  FROM 
(SELECT SALARY,DEPARTMENT_ID,ROWNUM RN FROM
(SELECT SALARY,DEPARTMENT_ID FROM HR.EMPLOYEES))
WHERE RN =2
;
--A. Aggregation & Grouping (10 Questions)

--Count the number of employees in each department.
SELECT DEPARTMENT_ID,COUNT(EMPLOYEE_ID) FROM HR.EMPLOYEES
GROUP BY DEPARTMENT_ID ;


--Find the average salary per department.
SELECT AVG(SALARY), DEPARTMENT_ID FROM HR.EMPLOYEES
GROUP BY DEPARTMENT_ID 

--List departments where the average salary is greater than 50,000.
SELECT AVG(SALARY), DEPARTMENT_ID FROM HR.EMPLOYEES
GROUP BY DEPARTMENT_ID 
HAVING AVG(SALARY) > 50000

--Find the highest salary in each department.
SELECT MAX(SALARY) ,DEPARTMENT_ID FROM HR.EMPLOYEES
GROUP BY DEPARTMENT_ID


--Find the lowest salary in each department.
SELECT MIN(SALARY),DEPARTMENT_ID FROM HR.EMPLOYEES
GROUP BY DEPARTMENT_ID;

=--List departments with more than 5 employees.
SELECT COUNT(EMPLOYEE_ID),DEPARTMENT_ID FROM HR.EMPLOYEES
GROUP BY DEPARTMENT_ID
HAVING COUNT(EMPLOYEE_ID)<5;

--Find the total salary expense per department.
SELECT SUM(SALARY),DEPARTMENT_ID FROM HR.EMPLOYEES
GROUP BY DEPARTMENT_ID

--Find departments where the maximum salary exceeds 15,000.
select max(salary*15000),department_id from hr.employees;
select * from hr.employees;



Count the number of employees under each manager.

--Find the average, minimum, and maximum salary of employees for each job_id.
select E.JOB_ID,avg(e.salary),min(e.salary),max(e.salary) from hr.employees e
left join hr.jobs j
on e.job_id = j.job_id;
select* from hr.employees;
