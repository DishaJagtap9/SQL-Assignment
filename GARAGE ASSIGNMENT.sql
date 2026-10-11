CREATE TABLE PURCHASE(
PID NUMBER PRIMARY KEY,
VID NUMBER ,
SPID NUMBER(10),
PQRY NUMBER ,
SPRATE NUMBER,
SPGST NUMBER,
PDATE DATE,
TRANCOST NUMBER, 
TOTAL NUMBER,
RCV_EID NUMBER(10),
FOREIGN KEY (VID) REFERENCES VENDORS(VID),
FOREIGN KEY (SPID) REFERENCES SPAREPART(SPID),
FOREIGN KEY (RCV_EID) REFERENCES EMPLOYEES1(EID));

INSERT INTO PURCHASE VALUES(5001,2001,4001,10,250,350,TO_DATE('01-JAN-11'),1300,4150,3001);
INSERT INTO PURCHASE VALUES(5002,2002,4002,4,400,288,TO_DATE('02-MARCH-11'),100,1988,3001);
INSERT INTO PURCHASE VALUES(5003,2003,4004,8,680,761.6,TO_DATE('12-JUN-11'),50,6251.6,3003);
INSERT INTO PURCHASE VALUES(5004,2004,4005,10,129,154.8,TO_DATE('22-AUG-11'),125,1569.8,3004);
INSERT INTO PURCHASE VALUES(5005,2005,4006,20,100,300,TO_DATE('07-SEP-11'),20,2320,3003);
INSERT INTO PURCHASE VALUES(5006,2006,4007,30,150,630,TO_DATE('12-OCT-11'),60,5190,3000);
INSERT INTO PURCHASE VALUES(5007,2001,4003,20,5000,14000,TO_DATE('07-SEP-11'),1000,115000,3000);
INSERT INTO PURCHASE VALUES(5008,2006,4005,1,129,15.48,TO_DATE('2-OCT-11'),50,194.48,3005);
INSERT INTO PURCHASE VALUES(5009,2006,4005,1,129,15.48,TO_DATE('15-OCT-11'),50,194.48,3005);
INSERT INTO PURCHASE VALUES(5010,2006,4009,5,3400,238,TO_DATE('20-OCT-11'),0,2938,3005);

CREATE TABLE SER_DET(
SID NUMBER PRIMARY KEY,
CID NUMBER ,
EID NUMBER,
SPID NUMBER,
TYP_VEH VARCHAR2(50),
VEH_NO VARCHAR2(50),
TYP_SER VARCHAR(50),
SER_DATE DATE,
QTY NUMBER,
SP_RATE NUMBER ,
SP_AMT NUMBER,
SP_G NUMBER,
SER_AMT NUMBER,
COMM NUMBER,
TOTAL NUMBER,
FOREIGN KEY (CID) REFERENCES CUSTOMERS1(CID),
FOREIGN KEY (EID) REFERENCES EMPLOYEES1(EID),
FOREIGN KEY (SPID) REFERENCES SPAREPART(SPID));

INSERT INTO SER_DET VALUES(6001,1001,3001,4001,'TWO WHEELER', 'MH15CA3228', 'TUBE DAMAGED ',TO_DATE('02-Jan-11'),1,250,250,35,50,0,335);
INSERT INTO SER_DET VALUES(6002,1002,3002,4002,'TWO WHEELER', 'MH-16U5713', 'FULL SERVICING',TO_DATE('04-MAR-11'),1,400,400,52,300,50,752);
INSERT INTO SER_DET VALUES(6003,1003,3004,4005,'TWO WHEELER', 'MH12PQ1313', 'CLUCH WIRE ',TO_DATE('22-AUG-11'),1,129,129,0,10,0,139);
INSERT INTO SER_DET VALUES(6004,1002,3002,4002,'TWO WHEELER', 'MH-16U5713', 'FULL SERVICING ',TO_DATE('05-MAY-11'),1,400,400,52,300,50,752);
INSERT INTO SER_DET VALUES(6005,1004,3001,4009,'TWO WHEELER', 'MH-14PA335', 'COLOR ',TO_DATE('22-OCT-11'),1,340,850,119,500,150,1469);
INSERT INTO SER_DET VALUES(6006,1006,3001,4009,'TWO WHEELER', 'MH-12WE334', 'COLOR ',TO_DATE('01-DEC-11'),2.5,340,850,119,500,150,1469);
INSERT INTO SER_DET VALUES(6007,1007,3001,4001,'FOUR WHEELER', 'MH17BB1345', 'TUBE DAMAGED ',TO_DATE('01-Jan-12'),1,250,250,35,150,0,435);


Select * from EMPLOYEES1
select * from Customers1
select * from SER_DET

--Q.1 List all the customers serviced.
SELECT S.CID FROM SER_DET  S
JOIN CUSTOMERS1  C 
ON C.CID = S.CID;

--Q.2 Customers who are not serviced.
SELECT c.CID, c.CNAME
FROM CUSTOMERS1 c
WHERE c.CID NOT IN (
    SELECT s.CID
    FROM SER_DET s
);

--Q.3 Employees who have not received the commission.
SELECT * FROM SER_DET
where COMM ='0';
----------------------------------------------------------------------------
SELECT distinct E.ENAME FROM EMPLOYEES1 E
JOIN SER_DET S
ON E.EID = S.EID
WHERE COMM = 0;

----Q.4 Name the employee who have maximum Commission.
SELECT E.ENAME FROM EMPLOYEES1 E
JOIN SER_DET S
ON E.EID=S.EID
WHERE S.COMM=(SELECT MAX(COMM) FROM SER_DET);

--Q.5 Show employee name and minimum commission amount received by an employee.
SELECT E.ENAME, S.COMM
FROM EMPLOYEES1 E
JOIN SER_DET S
  ON E.EID = S.EID
WHERE S.COMM = (SELECT MIN(COMM) FROM SER_DET);



--6.Display the Middle record from any table.

SELECT *
FROM (
    SELECT e.*, ROW_NUMBER() OVER (ORDER BY EID) AS rn
    FROM EMPLOYEES1 e
)
WHERE rn = (
    SELECT CEIL(COUNT(*) / 2)
    FROM EMPLOYEES1
);



SELECT *
FROM EMPLOYEES
ORDER BY EID
LIMIT 1 OFFSET (SELECT FLOOR(COUNT(*)/2) FROM EMPLOYEES);

---Q.7 Display last 4 records of any table.
SELECT *
FROM (
    SELECT e.*
    FROM EMPLOYEES1 e
    ORDER BY EID DESC
)
WHERE ROWNUM <= 4;

--Q.8 Count the number of records without count function from any table.
--Count the number of records without count function from any table
SELECT SUM(1) FROM EMPLOYEES;
SELECT MAX (ROWNUM) FROM CUSTOMERS1

---9 Delete duplicate records from "Ser_det" table on cid.(note Please rollback after execution).
DELETE FROM SER_DET 
WHERE ROWID NOT IN (SELECT MIN(ROWID)
FROM SER_DET GROUP BY CID);

ROLLBACK;

--Q.10 Show the name of Customer who have paid maximum amount 
SELECT c.CNAME
FROM CUSTOMERS1 c
JOIN SER_DET s ON c.CID = s.CID
WHERE s.TOTAL = (SELECT MAX(TOTAL) FROM SER_DET);


--11 Display Employees who are not currently working.
--SELECT * FROM Employees WHERE EDOL = 0;

SELECT E.*
FROM EMPLOYEES1 E
LEFT JOIN SER_DET S
  ON E.EID = S.EID
WHERE S.EID IS NULL;


-----12 How many customers serviced their two wheelers.
SELECT  CID,CNAME FROM CUSTOMERS1
WHERE CID IN (SELECT CID FROM SER_DET WHERE TYP_VEH = 'TWO WHEELER');

SELECT C.CID,C.CNAME FROM CUSTOMERS1 C
JOIN SER_DET S
ON C.CID = S.CID
WHERE TYP_VEH = 'TWO WHEELER';

---13 List the Purchased Items which are used for Customer Service with Unit of that Item.
SELECT * FROM PURCHASE;

SELECT DISTINCT sp.SPNAME, sp.SPUNIT
FROM PURCHASE p
JOIN SPAREPART sp
    ON p.SPID = sp.SPID
JOIN SER_DET sd
    ON p.SPID = sd.SPID;
    
-- Q.14 Customers who have Colored their vehicles.
SELECT DISTINCT c.CNAME
FROM CUSTOMERS1 c
JOIN SER_DET s ON c.CID = s.CID
WHERE UPPER(s.TYP_SER) LIKE '%COLOR%';

--Q.15 Find the annual income of each employee inclusive of Commission
SELECT E.EID,ENAME ,
(E.ESAL*12+S.COMM)  ANNUAL_INCOME FROM EMPLOYEES1 E
JOIN SER_DET S
ON E.EID=S.EID





--Q.16 Vendor Names who provides the engine oil.
SELECT DISTINCT v.VNAME
FROM VENDORS v
JOIN PURCHASE p ON v.VID = p.VID
JOIN SPAREPART s ON p.SPID = s.SPID
WHERE UPPER(s.SPNAME) LIKE '%ENGINE OIL%';

--Q.17 Total Cost to purchase the Color and name the color purchased.
SELECT 
    s.SPNAME AS COLOR_NAME,
    SUM(p.TOTAL) AS TOTAL_COST
FROM PURCHASE p
JOIN SPAREPART s ON p.SPID = s.SPID
WHERE UPPER(s.SPNAME) LIKE '%COLOUR%'
GROUP BY s.SPNAME;

--Q.18 Purchased Items which are not used in "Ser_det".
SELECT DISTINCT s.SPNAME
FROM PURCHASE p
JOIN SPAREPART s ON p.SPID = s.SPID
WHERE p.SPID NOT IN (
    SELECT SPID
    FROM SER_DET
);
--Q.19 Spare Parts Not Purchased but existing in Sparepart
SELECT s.SPNAME
FROM SPAREPART s
WHERE s.SPID NOT IN (
    SELECT p.SPID
    FROM PURCHASE p
);

--Q.20 Calculate the Profit/Loss of the Firm. consider one month salary of each employee for Calculation.
--Q.21 Specify the names of customers who have serviced their vehicles more than one time.
SELECT c.CNAME
FROM CUSTOMERS1 c
JOIN SER_DET s ON c.CID = s.CID
GROUP BY c.CNAME
HAVING COUNT(s.SID) > 1;

--Q.22 List the Items purchased from vendors locationwise.
SELECT 
    v.VADD AS VENDOR_LOCATION,
    v.VNAME AS VENDOR_NAME,
    s.SPNAME AS ITEM_PURCHASED
FROM PURCHASE p
JOIN VENDORS v ON p.VID = v.VID
JOIN SPAREPART s ON p.SPID = s.SPID
ORDER BY v.VADD, v.VNAME;

--Q.23 Display count of two wheeler and four wheeler from ser_details
SELECT 
    TYP_VEH,
    COUNT(*) AS VEHICLE_COUNT
FROM SER_DET
GROUP BY TYP_VEH;

--Q24 Display name of customers who paid highest SPGST and for which item 
SELECT 
    c.CNAME AS CUSTOMER_NAME,
    s.SPNAME AS ITEM_NAME,
    sd.SP_G AS SPGST_PAID
FROM SER_DET sd
JOIN CUSTOMERS1 c ON sd.CID = c.CID
JOIN SPAREPART s ON sd.SPID = s.SPID
WHERE sd.SP_G = (
    SELECT MAX(SP_G) 
    FROM SER_DET
);

--Q25 Display vendors name who have charged highest SPGST rate  for which item
SELECT 
    v.VNAME AS VENDOR_NAME,
    s.SPNAME AS ITEM_NAME,
    p.SPGST AS SPGST_CHARGED
FROM PURCHASE p
JOIN VENDORS v ON p.VID = v.VID
JOIN SPAREPART s ON p.SPID = s.SPID
WHERE p.SPGST = (
    SELECT MAX(SPGST) 
    FROM PURCHASE
);

--Q26   list name of item and employee name who have received item 
SELECT 
    s.SPNAME AS ITEM_NAME,
    e.ENAME AS RECEIVED_BY
FROM PURCHASE p
JOIN SPAREPART s ON p.SPID = s.SPID
JOIN EMPLOYEES1 e ON p.RCV_EID = e.EID
ORDER BY e.ENAME;

 --Q27 Display the Name and Vehicle Number of Customer who serviced his vehicle, And Name the Item used for Service, And specify the purchase date of that Item with his vendor and Item Unit and Location, And employee Name who serviced the vehicle. for Vehicle NUMBER "MH-14PA335".'
 SELECT 
    c.CNAME AS CUSTOMER_NAME,
    sd.VEH_NO AS VEHICLE_NUMBER,
    sp.SPNAME AS ITEM_USED,
    p.PDATE AS PURCHASE_DATE,
    v.VNAME AS VENDOR_NAME,
    sp.SPUNIT AS ITEM_UNIT,
    v.VADD AS VENDOR_LOCATION,
    e.ENAME AS SERVICED_BY
FROM SER_DET sd
JOIN CUSTOMERS1 c ON sd.CID = c.CID
JOIN SPAREPART sp ON sd.SPID = sp.SPID
JOIN PURCHASE p ON sd.SPID = p.SPID
JOIN VENDORS v ON p.VID = v.VID
JOIN EMPLOYEES1 e ON sd.EID = e.EID
WHERE sd.VEH_NO = 'MH-14PA335';

--Q28 who belong this vehicle  MH-14PA335" Display the customer name 
SELECT c.CNAME AS CUSTOMER_NAME
FROM SER_DET sd
JOIN CUSTOMERS1 c ON sd.CID = c.CID
WHERE sd.VEH_NO = 'MH-14PA335';

--Q29 Display the name of customer who belongs to New York and when he /she service their  vehicle on which date    
SELECT 
    c.CNAME AS CUSTOMER_NAME,
    sd.SER_DATE AS SERVICE_DATE
FROM CUSTOMERS1 c
JOIN SER_DET sd ON c.CID = sd.CID
WHERE UPPER(c.CADD) = 'NEW YORK';

--Q 30 from whom we have purchased items having maximum cost?
SELECT 
    v.VNAME AS VENDOR_NAME,
    p.TOTAL AS PURCHASE_COST,
    s.SPNAME AS ITEM_NAME
FROM PURCHASE p
JOIN VENDORS v ON p.VID = v.VID
JOIN SPAREPART s ON p.SPID = s.SPID
WHERE p.TOTAL = (
    SELECT MAX(TOTAL)
    FROM PURCHASE
);

--Q31 Display the names of employees who are not working as Mechanic and that employee done services   .
SELECT DISTINCT e.ENAME AS EMPLOYEE_NAME
FROM EMPLOYEES1 e
JOIN SER_DET s ON e.EID = s.EID
WHERE UPPER(e.EJOB) != 'MECHANIC';

--Q32 Display the various jobs along with total number of employees in each job. The output should contain only those jobs with more than two employees.
SELECT 
    EJOB AS JOB,
    COUNT(*) AS TOTAL_EMPLOYEES
FROM EMPLOYEES1
GROUP BY EJOB
HAVING COUNT(*) > 2;



-- Q33 Display the details of employees who done service  and give them rank according to their no. of services .
SELECT e.eid,
       e.ename,
       e.ejob,
       COUNT(s.sid) AS no_of_services,
       RANK() OVER (
           ORDER BY COUNT(s.sid) DESC
       ) AS service_rank
FROM employees1 e
JOIN ser_det s
     ON e.eid = s.eid
GROUP BY e.eid, e.ename, e.ejob;

--Q 34 Display those employees who are working as Painter and fitter and who provide service and total count of service done by fitter and painter  
SELECT e.eid,
       e.ename,
       e.ejob,
       COUNT(s.sid) AS total_services
FROM employees1 e
JOIN ser_det s
     ON e.eid = s.eid
WHERE UPPER(e.ejob) IN ('PAINTER', 'FITTER')
GROUP BY e.eid, e.ename, e.ejob;
--Q35 Display employee salary and as per highest  salary provide Grade to employee 
SELECT eid,
       ename,
       esal,
       DENSE_RANK() OVER (
           ORDER BY esal DESC
       ) AS grade
FROM employees1
WHERE esal IS NOT NULL;
--Q36  display the 4th record of emp table without using group by and rowid
SELECT * FROM EMPLOYEES1
WHERE ENAME = 'BRUCE ERNST';

SELECT *
FROM (
    SELECT e.*, ROWNUM rn
    FROM (
        SELECT *
        FROM employees1
        ORDER BY eid
    ) e
)
WHERE rn = 4;


--Q37 Provide a commission 100 to employees who are not earning any commission.
SELECT * FROM EMPLOYEES1


UPDATE ser_det
SET comm = 100
WHERE comm IS NULL
AND eid IN (SELECT eid FROM employees1);


--Q38 write a query that totals no. of services  for each day and place the results in descending order
SELECT ser_date,
       COUNT(*) AS total_services
FROM ser_det
GROUP BY ser_date
ORDER BY total_services DESC;

--Q39 Display the service details of those customer who belong from same city 
SELECT s.*
FROM ser_det s
JOIN customers1 c
     ON s.cid = c.cid
WHERE c.cadd IN (
    SELECT cadd
    FROM customers1
    GROUP BY cadd
    HAVING COUNT(*) > 1
)
ORDER BY c.cadd, s.ser_date;

SELECT c.CID, c.CNAME, c.CADD, s.*
FROM SER_DET s
JOIN CUSTOMERS1 c
    ON s.CID = c.CID
WHERE c.CADD IN (
    SELECT CADD
    FROM CUSTOMERS1
    GROUP BY CADD
    HAVING COUNT(*) > 1
)
ORDER BY c.CADD, s.SER_DATE;

--Q40 write a query join customers table to itself to find all pairs of customers service by a single employee
SELECT s1.cid AS customer1,
       s2.cid AS customer2,
       s1.eid AS employee_id
FROM ser_det s1
JOIN ser_det s2
     ON s1.eid = s2.eid
    AND s1.cid < s2.cid
ORDER BY s1.eid, s1.cid, s2.cid;

--Q41 List each service number follow by name of the customer who made  that service
SELECT s.sid AS service_number,
       c.cname AS customer_name
FROM ser_det s
JOIN customers1 c
     ON s.cid = c.cid
ORDER BY s.sid;

--Q42 Write a query to get details of employee and provide rating on basis of  maximum services provide by employee  .Note (rating should be like A,B,C,D)
SELECT e.eid,
       e.ename,
       e.ejob,
       e.eadd,
       e.esal,
       NVL(s.total_services, 0) AS total_services,
       CASE 
           WHEN NVL(s.total_services,0) = MAX(NVL(s.total_services,0)) OVER () THEN 'A'
           WHEN NVL(s.total_services,0) >= 0.75 * MAX(NVL(s.total_services,0)) OVER () THEN 'B'
           WHEN NVL(s.total_services,0) >= 0.5 * MAX(NVL(s.total_services,0)) OVER () THEN 'C'
           ELSE 'D'
       END AS rating
FROM employees1 e
LEFT JOIN (
    SELECT eid, COUNT(*) AS total_services
    FROM ser_det
    GROUP BY eid
) s ON e.eid = s.eid
ORDER BY rating DESC, total_services DESC;

--Q43 Write a query to get maximum service amount of each customer with their customer details ?
SELECT c.cid,c.cname, c.cadd, c.c_contact,c.c_creditdays,
   c.cj_date,c.sex,
MAX(s.ser_amt) AS max_service_amount
FROM customers1 c
JOIN ser_det s
     ON c.cid = s.cid
GROUP BY c.cid, c.cname, c.cadd, c.c_contact, c.c_creditdays, c.cj_date, c.sex
ORDER BY max_service_amount DESC;

--Q44 Get the details of customers with his total no of services ?
SELECT c.cid,c.cname,c.cadd,c.c_contact,c.c_creditdays, c.cj_date,c.sex,
COUNT(s.sid) AS total_services
FROM customers1 c
LEFT JOIN ser_det s
ON c.cid = s.cid
GROUP BY c.cid, c.cname, c.cadd, c.c_contact, c.c_creditdays, c.cj_date, c.sex
ORDER BY total_services DESC;

SELECT * FROM CUSTOMERS1
--Q45 From which location sparpart purchased  with highest cost ?
SELECT * FROM SPAREPART;
SELECT v.vname,v.vadd AS location,p.total AS purchase_amount
FROM purchase p
JOIN vendors v ON p.vid = v.vid
WHERE p.total = (
SELECT MAX(total)
FROM purchase
);

--Q46 Get the details of employee with their service details who has salary is null


SELECT * FROM EMPLOYEES1
WHERE ESAL = NULL;


SELECT e.*,
       s.sid,
       s.veh_no,
       s.typ_ser,
       s.ser_date,
       s.ser_amt
FROM employees1 e
LEFT JOIN ser_det s
       ON e.eid = s.eid
WHERE e.esal IS NULL;


--Q47 find the sum of purchase location wise 
SELECT v.vadd AS location,
SUM(p.total) AS total_purchase
FROM purchase p
JOIN vendors v
ON p.vid = v.vid
GROUP BY v.vadd
ORDER BY total_purchase DESC;
;
--Q48 write a query sum of purchase amount in word location wise ?
SELECT v.vadd AS location,
       SUM(p.total) AS total_purchase
FROM purchase p
JOIN vendors v
     ON p.vid = v.vid
GROUP BY v.vadd
ORDER BY SUM(p.total) DESC;

SELECT v.vadd AS location,
       SUM(p.total) AS total_purchase,
       (SELECT SPELL_NUMBER(SUM(p1.total))
        FROM purchase p1
        WHERE p1.vid = v.vid) AS total_in_words
FROM vendors v
JOIN purchase p ON v.vid = p.vid
GROUP BY v.vadd
ORDER BY SUM(p.total) DESC;


--Q49 Has the customer who has spent the largest amount money has been give highest rating
SELECT c.cid,
       c.cname,
       SUM(s.total) AS total_spent
FROM customers1 c
JOIN ser_det s ON c.cid = s.cid
GROUP BY c.cid, c.cname
ORDER BY total_spent DESC;

SELECT c.cid,
c.cname,
SUM(s.total) AS total_spent,
CASE 
  WHEN SUM(s.total) = (SELECT MAX(total_spent)
         FROM (SELECT cid, SUM(total) AS total_spent
            FROM ser_det
            GROUP BY cid))
 THEN 'A'
  ELSE 'B' 
 END AS rating
FROM customers1 c
JOIN ser_det s ON c.cid = s.cid
GROUP BY c.cid, c.cname
ORDER BY total_spent DESC;


--Q50 select the total amount in service for each customer for which the total is greater than the amount of the largest service amount in the table
SELECT c.cname AS customer_name,
       SUM(s.ser_amt) AS total_service_amt
FROM customers1 c
JOIN ser_det s ON c.cid = s.cid
GROUP BY c.cname
HAVING SUM(s.ser_amt) > (SELECT MAX(ser_amt) FROM ser_det)
ORDER BY total_service_amt DESC;

--Q51  List the customer name and sparepart name used for their vehicle and  vehicle type
SELECT c.cname AS customer_name,
sp.spname AS sparepart_name,
s.typ_veh AS vehicle_type
FROM ser_det s
JOIN customers1 c ON s.cid = c.cid
JOIN sparepart sp ON s.spid = sp.spid
ORDER BY c.cname;

--Q52 Write a query to get spname ,ename,cname quantity ,rate ,service amount for record exist in service table
SELECT sp.spname AS sparepart_name,
       e.ename AS employee_name,
       c.cname AS customer_name,
       s.qty AS quantity,
       s.sp_rate AS rate,
       s.ser_amt AS service_amount
FROM ser_det s
JOIN customers1 c ON s.cid = c.cid
JOIN employees1 e ON s.eid = e.eid
JOIN sparepart sp ON s.spid = sp.spid
ORDER BY s.sid;
 
--Q53 specify the vehicles owners who’s tube damaged.
SELECT DISTINCT c.cname AS customer_name,
                s.veh_no AS vehicle_number,
                s.typ_veh AS vehicle_type
FROM ser_det s
JOIN customers1 c ON s.cid = c.cid
WHERE UPPER(s.typ_ser) LIKE '%TUBE DAMAGED%'
ORDER BY c.cname;
--Q.54 Specify the details who have taken full service.

SELECT sp.spname AS sparepart_name,
e.ename AS employee_name,
c.cname AS customer_name,
s.qty AS quantity,
s.sp_rate AS rate,
s.ser_amt AS service_amount
FROM ser_det s
JOIN customers1 c ON s.cid = c.cid
JOIN employees1 e ON s.eid = e.eid
JOIN sparepart sp ON s.spid = sp.spid
ORDER BY s.sid;

--Q.55 Select the employees who have not worked yet and left the job.
SELECT e.eid,
e.ename, e.ejob,
e.eadd,
e.econtact,
e.esal,
e.edoj,
e.edol
FROM employees1 e
LEFT JOIN ser_det s ON e.eid = s.eid
WHERE s.sid IS NULL       
AND e.edol IS NOT NULL; 

--Q.56  Select employee who have worked first ever.
SELECT e.eid,e.ename,e.ejob,e.eadd,e.econtact,e.esal,e.edoj
FROM employees1 e
JOIN ser_det s ON e.eid = s.eid
WHERE s.ser_date = (SELECT MIN(ser_date) FROM ser_det);

--Q.57 Display all records falling in odd date
SELECT *
FROM ser_det
WHERE MOD(TO_NUMBER(TO_CHAR(ser_date, 'DD')), 2) = 1
ORDER BY ser_date;

--Q.58 Display all records falling in even date
SELECT *
FROM ser_det
WHERE MOD(TO_NUMBER(TO_CHAR(ser_date, 'DD')), 2) = 0
ORDER BY ser_date;

--Q.59 Display the vendors whose material is not yet used.
SELECT DISTINCT v.vid,
v.vname,v.vadd,v.vcontact,v.vcreditdays,v.vj__date
FROM vendors v
JOIN purchase p ON v.vid = p.vid
WHERE p.spid NOT IN (SELECT spid FROM ser_det)
ORDER BY v.vname;

--Q.60 Difference between purchase date and used date of spare part
SELECT p.pid,p.spid, sp.spname, p.pdate AS purchase_date,s.ser_date AS used_date,
(s.ser_date - p.pdate) AS days_difference
FROM purchase p
JOIN ser_det s ON p.spid = s.spid
JOIN sparepart sp ON p.spid = sp.spid
ORDER BY days_difference;



SELECT * FROM employees1
