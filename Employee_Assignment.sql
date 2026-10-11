--1.  Write create table syntax for employee table and Incentive table
CREATE TABLE EMPLOYEE(Emp_id int primary key, 
First_name varchar(50),
Last_name varchar(50),
Salary int,
Joining_date date,
Department varchar (50)
);

CREATE TABLE Incentives
(Employee_ref_id INT,
Incentive_date DATE,
Incentive_amount INT);


--2.  Writesyntax forinsert data into table of employee table and Incentive table
INSERT INTO  EMPLOYEE(Emp_id,First_name,Last_name,Salary,Joining_date,Department)
values
(1,	'John',	'Abraham',	1000000,	'01-JAN-13' ,	'Banking');
INSERT INTO  EMPLOYEE(Emp_id,First_name,Last_name,Salary,Joining_date,Department)
values
(2,	'Michael',	'Clarke',	800000	,'01-JAN-13','Insurance');
INSERT INTO  EMPLOYEE(Emp_id,First_name,Last_name,Salary,Joining_date,Department)
values
(3, 'Roy',  'Thomas', 700000, '01-FEB-13' , 'Banking');

INSERT INTO  EMPLOYEE(Emp_id,First_name,Last_name,Salary,Joining_date,Department)
values
(4, 'Tom','Jose', 600000, '01-FEB-13' , 'Insurance');

INSERT INTO  EMPLOYEE(Emp_id,First_name,Last_name,Salary,Joining_date,Department)
values
(5, 'Jerry',  'Pinto',  650000, '01-FEB-13',  'Insurance');

INSERT INTO  EMPLOYEE(Emp_id,First_name,Last_name,Salary,Joining_date,Department)
values
(6, 'Philip', 'Mathew', 750000, '01-JAN-13',  'Services');

SELECT * FROM EMPLOYEE;


INSERT INTO Incentives(Employee_ref_id,Incentive_date,Incentive_amount)
VALUES
(1,'01-Feb-13',	5000);
INSERT INTO Incentives(Employee_ref_id,Incentive_date,Incentive_amount)
values
(2,	'01-Feb-13',	3000);
INSERT INTO Incentives(Employee_ref_id,Incentive_date,Incentive_amount)
values
(3,	('01-Feb-13''DD/MM/YYYY'),	4000);
INSERT INTO Incentives(Employee_ref_id,Incentive_date,Incentive_amount)
values
(1,	'01-Jan-13',	4500);

INSERT INTO Incentives(Employee_ref_id,Incentive_date,Incentive_amount)
values
(2,	'01-Jan-13',	3500);





--3.  Get all employee details from the employee table
SELECT Emp_id,
First_name,
Last_name,
Salary,
TO_CHAR (Joining_date ,'DD-MON-YYY')AS Joining_date,
Department FROM EMPLOYEE;

--4.  Get First_Name,Last_Name from employee table

SELECT FIRST_NAME,
LAST_NAME FROM EMPLOYEE;

--5.  Get First_Name from employee table using alias name “Employee Name”
SELECT 
FIRST_NAME AS "Employee Name" FROM EMPLOYEE;

--6.  Get First_Name from employee table in upper case

SELECT UPPER(FIRST_NAME) FROM EMPLOYEE;

--7.  Select first 3 characters of FIRST_NAME from EMPLOYEE

SELECT SUBSTR(FIRST_NAME,1,3)FROM EMPLOYEE;


--8.  Get position of 'o' in name 'John' from employee table
SELECT INSTR(FIRST_NAME,'o',1)
  FROM EMPLOYEE
  WHERE FIRST_NAME = 'John';

--9.  Get FIRST_NAME from employee table after removing white spaces from right side.

 SELECT RTRIM (FIRST_NAME)FROM EMPLOYEE;

--10. Get First_Name from employee table after replacing 'o' with '$'
 SELECT  REPLACE (FIRST_NAME,'o','$') FROM EMPLOYEE;

SELECT * FROM EMPLOYEE;
--11. Get First_Name and Last_Name as single column from employee table separated by a '_'
select  (first_name ||'_'||last_name) from employee;

--12. Get FIRST_NAME, Joiningyear, Joining Month and Joining Date from employee table
SELECT FIRST_NAME ,
EXTRACT(year FROM Joining_Date),
EXTRACT(Month FROM Joining_Date),
Joining_Date FROM EMPLOYEE;

--13. Get all employee details from the employee table order by First_Name Ascending

SELECT * FROM EMPLOYEE
ORDER BY FIRST_NAME ASC;


--14. Get all employee details from the employee table order by First_Name Ascending and Salary Descending?
SELECT * FROM EMPLOYEE
ORDER BY FIRST_NAME ASC,
 SALARY DESC;

--15. Get employee details from employee table whose employee name is “John”
SELECT * FROM EMPLOYEE 
WHERE FIRST_NAME = 'John';

--16. Get employee details from employee table whose employee name are “John” and “Roy”
SELECT  * FROM EMPLOYEE 
WHERE FIRST_NAME IN('John','Roy');


--17. Get employee details from employee table whose employee name are not “John” and “Roy”.

SELECT * FROM EMPLOYEE 
WHERE FIRST_NAME NOT IN('John','Roy');


--18. Get employee details from employee table whose first name starts with 'J'.

 SELECT * FROM EMPLOYEE 
 WHERE FIRST_NAME LIKE 'J%';

--19. Get employee details from employee table whose first name contains 'o'.
SELECT * FROM EMPLOYEE 
 WHERE FIRST_NAME LIKE '%o%';


--20. Get employee details from employee table whose first name ends with 'n'.
select * from employee
where first_name like '%n';

--21. Get employee details from employee table whose first name ends with 'n' and name contains 4 letters.
select * from employee
where first_name like '___n';

--22. Get employee details from employee table whose first name starts with 'J' and name contains 4 letters.
select * from employee
where first_name like 'J___';

--23. Get employee details from employee table who’s Salary greater than 600000.
select * from employee
where salary > 600000;

--24. Get employee details from employee table whose joining year is “2013”.
select * from employee
where TO_CHAR (JOINING_DATE,'YYYY')='2013';

--25. Get employee details from employee table whose joining month is “January”.
SELECT *
 FROM EMPLOYEE
WHERE TO_CHAR (JOINING_DATE,'MM')='01';


select *from employee 
WHERE to_char(joining_date,'MM')='01';
--26. Get employee details from employee table who joined before January 1st 2013.
SELECT * 
FROM EMPLOYEE
WHERE TO_CHAR (JOINING_DATE,'DD-MM-YYYY')<'01-01-2013';

SELECT * FROM 
EMPLOYEE
WHERE JOINING_DATE<
TO_DATE ('01-01-2013','DD-MM-YYYY');


--27. Get employee details from employee table who joined after January 31st

 SELECT
 * FROM EMPLOYEE
 WHERE JOINING_DATE>
 TO_DATE('31-01-2013','DD-MM-YYYY');


--28. Get Joining Date and Time from employee table

SELECT TO_CHAR
(JOINING_DATE, 'DD-MONTH-YYYY')FROM EMPLOYEE;


--29. Get Joining Date, Time including milliseconds from employee table
SELECT TO_CHAR 
(JOINING_DATE, 'DD-MONTH-YYYY')FROM EMPLOYEE;


--30. Get difference between JOINING_DATE and INCENTIVE_DATE from employee and incentives table.
SELECT e.Emp_id,
       e.First_name,
       e.Joining_date,
       i.Incentive_date,
       (i.Incentive_date - e.Joining_date) AS Date_Difference
FROM EMPLOYEE e
JOIN Incentives i
  ON e.Emp_id = i.Employee_ref_id;

--31. Get department, total salary with respect to a department from employee table.
SELECT * FROM EMPLOYEE;
SELECT DEPARTMENT ,SUM(SALARY) AS TOAL_SALARY FROM EMPLOYEE
GROUP BY DEPARTMENT;

--32. Get department, total salary with respect to a department from employee table order by total salary descending.
SELECT DEPARTMENT,
SUM(SALARY)AS TOTAL_SALARY
FROM EMPLOYEE
GROUP BY DEPARTMENT
ORDER BY TOTAL_SALARY DESC 
;

--33. Get department, no of employees in a department, total salary with respect to a department from employee table order by total salary descending.
SELECT DEPARTMENT,
COUNT (DEPARTMENT) AS NO_OF_EMPLOYEE,
SUM (SALARY) AS TOTAL_SALARY
FROM EMPLOYEE
GROUP BY DEPARTMENT 
ORDER BY TOTAL_SALARY DESC;


--34. Get department wise average salary from employee table order by salary ascending?
SELECT DEPARTMENT,AVG (SALARY) AS AVG_SALARY
FROM EMPLOYEE
GROUP BY DEPARTMENT
ORDER BY AVG_SALARY

--35. Get department wise maximum salary from employee table order by salary ascending?

SELECT DEPARTMENT,MAX(SALARY) AS MAX_SALARY
FROM EMPLOYEE
GROUP BY DEPARTMENT
ORDER BY MAX_SALARY;


--36. Get department wise minimum salary from employee table order by salary ascending?
SELECT DEPARTMENT , 
MIN(SALARY) AS MIN_SALARY
FROM EMPLOYEE
GROUP BY DEPARTMENT
ORDER BY MIN_SALARY;


--37. Select no of employees joined with respect to year and month from employee table.

      SELECT TO_CHAR(JOINING_DATE, 'YYYY') AS JOIN_YEAR,
       TO_CHAR(JOINING_DATE, 'MM') AS JOIN_MONTH,
       COUNT(*) AS NO_OF_EMPLOYEES
FROM EMPLOYEE
GROUP BY TO_CHAR(JOINING_DATE, 'YYYY'), TO_CHAR(JOINING_DATE, 'MM')
ORDER BY JOIN_YEAR, JOIN_MONTH;


--38. Select department,total salary with respect to a department from employee table where total salary greater than 800000 order by Total_Salary descending
SELECT DEPARTMENT,
SUM (SALARY) AS TOTAL_SALARY
FROM EMPLOYEE
GROUP BY DEPARTMENT

HAVING SUM (SALARY)>800000
ORDER BY TOTAL_SALARY DESC;

--39. Select employee details from employee table if data in incentive table?
SELECT * FROM EMPLOYEE
WHERE EMP_ID IN(
SELECT EMPLOYEE_REF_ID FROM INCENTIVES
);
 


SELECT e.emp_id,
       e.FIRST_NAME,
       LAST_NAME,
       SALARY,
       TO_CHAR(e.joining_date, 'DD-MON-YYYY') AS joining_date,
       DEPARTMENT
       
FROM employee e
INNER JOIN incentives i
ON e.emp_id = i.EMPLOYEE_REF_ID;


 SELECT *
FROM employee e
INNER JOIN incentives i
ON e.emp_id = i.EMPLOYEE_REF_ID;

--40. Select 20 % of salary from John, 10% of Salary for Roy and for other 15 % of salary from employee table1
SELECT FIRST_NAME,
SALARY,
CASE 
WHEN FIRST_NAME ='John' THEN SALARY * 0.20
WHEN FIRST_NAME = 'Roy'  THEN SALARY * 0.10
ELSE SALARY * 0.15
END AS  SALARY_PER
FROM EMPLOYEE;

--41. Select Banking as 'Bank Dept', Insurance as 'Insurance Dept' and Services as    'Services Dept' from employee table.
SELECT DISTINCT 
DECODE (DEPARTMENT, 'Banking', 'Bank Dept', 'Insurance', 'Insurance Dept',
 'Services', 'Services Dept')
FROM EMPLOYEE;


--42. Delete employee data from employee table who got incentives in incentive table
DELETE FROM EMPLOYEE
WHERE EMP_ID 
IN (SELECT EMPLOYEE_REF_ID FROM INCENTIVES)





--43. Select first_name, incentive amount from employee and incentives table for those employees who have incentives.


SELECT FIRST_NAME,INCENTIVE_AMOUNT
FROM EMPLOYEE E
INNER JOIN INCENTIVES  I
ON E.EMP_ID = I.EMPLOYEE_REF_ID;

--44. Select first_name, incentive amount from employee and incentives table for those employees who have incentives and incentive amount greater than 3000
SELECT FIRST_NAME,INCENTIVE_AMOUNT
FROM EMPLOYEE E
INNER JOIN INCENTIVES  I
ON E.EMP_ID = I.EMPLOYEE_REF_ID
WHERE INCENTIVE_AMOUNT >3000;
--45. Select first_name, incentive amount from employee and incentives table for all employees even if they didn't get incentives
SELECT 
    e.First_name,
    i.Incentive_amount
FROM EMPLOYEE e
LEFT JOIN Incentives i
ON e.Emp_id = i.Employee_ref_id
ORDER BY e.Emp_id;



--46. Select first_name, incentive amount from employee and incentives table for all employees even if they didn't get incentives and set incentive amount as 0 for those employees who didn't get incentives.
SELECT 
    e.First_name,
    NVL(i.Incentive_amount, 0) AS Incentive_Amount
FROM EMPLOYEE e
LEFT JOIN Incentives i
ON e.Emp_id = i.Employee_ref_id
ORDER BY e.Emp_id;

--47. Select first_name, incentive amount from employee and incentives table for all employees who got incentives using left join
SELECT FIRST_NAME,INCENTIVE_AMOUNT
FROM EMPLOYEE E
LEFT JOIN INCENTIVES  I
ON E.EMP_ID = I.EMPLOYEE_REF_ID
--48. Select max incentive with respect to employee from employee and incentives table using sub query.
SELECT e.Emp_id,
       e.First_name,
       e.Last_name,
       i.Incentive_amount AS Max_Incentive
FROM EMPLOYEE e
JOIN Incentives i
  ON e.Emp_id = i.Employee_ref_id
WHERE i.Incentive_amount = (
    SELECT MAX(i2.Incentive_amount)
    FROM Incentives i2
    WHERE i2.Employee_ref_id = e.Emp_id
);

SELECT * FROM INCENTIVES


