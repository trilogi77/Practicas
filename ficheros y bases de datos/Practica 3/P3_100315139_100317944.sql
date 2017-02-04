CREATE OR REPLACE PACKAGE PKG_COSTES AS

-- auxiliary function converting an interval into a number (milliseconds)
	FUNCTION interval_to_seconds(x INTERVAL DAY TO SECOND) RETURN NUMBER;

-- WORKLOAD definition
	PROCEDURE PR_WORKLOAD(N NUMBER);

-- RE-STABLISH DB STATE
	PROCEDURE PR_RESET(N NUMBER);

-- Execution of workload (10 times) displaying some measurements 
	PROCEDURE RUN_TEST;

END PKG_COSTES;

/

Alter table projects pctfree 2;
Alter table contracts pctfree 2;
Alter table costs pctfree 2;
Alter table Employees pctfree 2;
Alter table reports pctfree 2;
Alter table Rep_lines pctfree 60;

DROP INDEX IND_query2;
DROP INDEX IND_query4;
DROP INDEX IND_query3;


CREATE INDEX IND_query4 ON rep_lines (REP_DATE, job, ssn, IDPROJECT) TABLESPACE TABL_16K;
CREATE INDEX IND_query2 ON rep_lines (REP_DATE, job, IDPROJECT) TABLESPACE TABL_16K;
CREATE INDEX IND_query3 ON rep_lines (REP_DATE, job, task,IDPROJECT) TABLESPACE TABL_16K;


CREATE OR REPLACE PACKAGE BODY PKG_COSTES AS FUNCTION interval_to_seconds(x INTERVAL DAY TO SECOND ) RETURN NUMBER IS
  BEGIN 
    return (((extract( day from x)*24 + extract( hour from x))*60 + extract( minute from x))*60 + extract( second from x))*1000;
  END interval_to_seconds;
  
  
PROCEDURE PR_WORKLOAD(N NUMBER) IS
  AUX DATE;
  EMP VARCHAR2(15);
  PRJ VARCHAR2(15);

BEGIN

  AUX := TO_DATE('04012016','DDMMYYYY');
  EMP := 'EMP4TEST'||TO_CHAR(N);
  PRJ := 'IN/PROJ4TEST'||TO_CHAR(N);


-- INSERTS

  INSERT INTO EMPLOYEES VALUES (EMP);
  INSERT INTO CONTRACTS VALUES (EMP, SYSDATE-100, SYSDATE, 6, NULL);
  INSERT INTO PROJECTS VALUES (PRJ, 'THIS IS A PROJECT FOR INSERTING DURING THE TESTS', 1000000, 10000, AUX, NULL, EMP);
  FOR I IN 1..20 LOOP
      AUX := AUX +7;
      INSERT INTO REPORTS VALUES (EMP, AUX, '47/41052350/06T');
      FOR J IN 1..5 LOOP
          FOR K IN 8..15 LOOP
              INSERT INTO REP_LINES VALUES (EMP, AUX, J, K, PRJ, NULL, 6, 'NOT YET');
          END LOOP; 
      END LOOP; 
  END LOOP; 

 
	
-- QUERY 1 

   FOR f IN (
-- HERE BEGINS YOUR FIRST QUERY
     WITH
     A AS (SELECT SSN from contracts where (end_date is null or end_date>sysdate)),
     B AS (SELECT SSN,start_date, NVL(end_date,sysdate) finish,(NVL(end_date,sysdate)-start_date) length
     FROM CONTRACTS NATURAL JOIN A)
     SELECT SSN
        FROM B
        GROUP BY SSN HAVING (Max(finish)-MIN(start_date)) > SUM(length)
-- HERE ENDS YOUR FIRST QUERY
           ) 
   LOOP 
      NULL;
   END LOOP;



-- QUERY 2

   FOR f IN (
-- HERE BEGINS THE SECOND QUERY
     WITH
        A AS (SELECT /*+ INDEX(C IND_query2)*/ IDPROJECT, SUM(B.wage) total
                 FROM REP_LINES C JOIN COSTS B 
                 ON C.JOB=B.CAT_NUM AND TO_NUMBER(TO_CHAR(C.REP_DATE,'YYYY'))=B.year
                 GROUP BY IDPROJECT)
     SELECT IDPROJECT
        FROM projects NATURAL JOIN A
        WHERE BUDGET<total AND (END_DATE IS NULL OR END_DATE>sysdate)
-- HERE ENDS YOUR FIRST QUERY
           ) 
   LOOP 
      NULL;
   END LOOP;



-- QUERY 3

   FOR f IN (
-- HERE BEGINS THE THIRD QUERY
     SELECT /*+ INDEX(REP_LINES IND_query3)*/ SSN 
       FROM contracts 
       WHERE start_date <= to_date('01042014','DDMMYYYY') 
             AND end_date >= to_date('30042014','DDMMYYYY') 
     MINUS 
     SELECT SSN 
       FROM rep_lines 
       WHERE task LIKE '%vacation%' 
             AND rep_date BETWEEN to_date('01042014','DDMMYYYY') 
                              AND to_date('30042014','DDMMYYYY') 
-- HERE ENDS YOUR FIRST QUERY
           ) 
   LOOP 
      NULL;
   END LOOP;



-- QUERY 4

   FOR f IN (
-- HERE BEGINS THE FOURTH QUERY
     WITH
        A AS (SELECT  /*+index(aa IND_query4) */IDPROJECT, SUM(B.wage) income, SUM(D.salary/160) outcome
               FROM REP_LINES AA JOIN COSTS B
                ON AA.JOB=B.CAT_NUM AND TO_NUMBER(TO_CHAR(AA.REP_DATE,'YYYY'))=B.year
                JOIN CONTRACTS C
                ON AA.SSN=C.SSN AND REP_DATE BETWEEN start_date AND end_date
                JOIN COSTS D
                ON C.CAT_NUM=D.CAT_NUM AND TO_NUMBER(TO_CHAR(AA.REP_DATE,'YYYY'))=D.year
                GROUP BY IDPROJECT)
     SELECT IDPROJECT, income, outcome, end_date
        FROM (SELECT IDPROJECT, end_date FROM PROJECTS) NATURAL JOIN A
        ORDER BY end_date
-- HERE ENDS YOUR FIRST QUERY
           ) 
   LOOP 
      NULL;
   END LOOP;



-- QUERY 5

   FOR f IN (
-- HERE BEGINS THE FIFTH QUERY
     WITH
        B AS (SELECT SSN, end_date FROM CONTRACTS),
        C AS (SELECT SSN, start_date FROM CONTRACTS),
        A AS (SELECT B.SSN, end_date, start_date
                FROM B JOIN C ON B.SSN=C.SSN AND B.end_date<C.start_date)
     SELECT SSN employee, (end_date+1) cease_start, (MIN(start_date)-1) cease_end
     FROM A
     GROUP BY (SSN, end_date) HAVING MIN(start_date)-end_date>1
-- HERE ENDS YOUR FIRST QUERY
           ) 
   LOOP 
      NULL;
   END LOOP;

	

-- UPDATES

AUX := TO_DATE('04012016','DDMMYYYY');
FOR I IN 1..20 LOOP
    AUX := AUX +7;
    FOR J IN 1..5 LOOP
        FOR K IN 8..15 LOOP
            UPDATE REP_LINES SET TASK=TO_CHAR(SYSTIMESTAMP,'FF9')||' THIS IS A LONGER DESCRIPTION FOR THE TASK, BECAUSE AS YOU CAN SEE, IT WAS NOT LONG ENOUGH.'
                   WHERE SSN=EMP AND REP_DATE=AUX AND DAY=J AND HOUR=K;
        END LOOP; 
    END LOOP; 
END LOOP; 
	
END PR_WORKLOAD;


  
PROCEDURE PR_RESET(N NUMBER) IS
  EMP VARCHAR2(15) := 'EMP4TEST'||TO_CHAR(N);
  PRJ VARCHAR2(15) := 'IN/PROJ4TEST'||TO_CHAR(N);
  BEGIN

     DELETE FROM PROJECTS WHERE IDPROJECT=PRJ;
     DELETE FROM REPORTS WHERE SSN=EMP;
     DELETE FROM CONTRACTS WHERE SSN=EMP;
     DELETE FROM EMPLOYEES WHERE SSN=EMP;
END PR_RESET;

  

PROCEDURE RUN_TEST IS
	t1 TIMESTAMP;
	t2 TIMESTAMP;
	auxt NUMBER;
	g1 NUMBER;
	g2 NUMBER;
	auxg NUMBER;
	localsid NUMBER;
    BEGIN
  PKG_COSTES.PR_WORKLOAD(0);  -- first run for preparing db_buffers
	select distinct sid into localsid from v$mystat; 
	SELECT SYSTIMESTAMP INTO t1 FROM DUAL;
	select S.value into g1 from (select * from v$sesstat where sid=localsid) S join (select * from v$statname where name='consistent gets') using(STATISTIC#);
    	--- EXECUTION OF THE WORKLOAD -----------------------------------
	FOR i IN 1..10 LOOP
	    PKG_COSTES.PR_WORKLOAD (i);
	END LOOP;
    	-----------------------------------
	SELECT SYSTIMESTAMP INTO t2 FROM DUAL;
	select S.value into g2 from (select * from v$sesstat where sid=localsid) S join (select * from v$statname where name='consistent gets') using(STATISTIC#);
	auxt:= interval_to_seconds(t2-t1);
	auxg:= (g2-g1) / 10;
    	--- DISPLAY RESULTS -----------------------------------
	DBMS_OUTPUT.PUT_LINE('RESULTS AT '||SYSDATE); 
	DBMS_OUTPUT.PUT_LINE('TIME CONSUMPTION: '|| auxt ||' milliseconds.'); 
	DBMS_OUTPUT.PUT_LINE('CONSISTENT GETS: '|| auxg ||' blocks'); 

	FOR J IN 0..10 LOOP
	    PKG_COSTES.PR_RESET (J);
	END LOOP;

END RUN_TEST;
  

BEGIN
   DBMS_OUTPUT.ENABLE (buffer_size => NULL);
END PKG_COSTES;

/

   