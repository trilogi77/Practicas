INSERT INTO NSSE 
SELECT DISTINCT SSN
FROM oldcontracts;

INSERT INTO EMPLEADOS
SELECT NAME, SURNAME, SURNAME2, PHONE, EMAIL, DNI, SSN, TO_DATE(BIRTHDATE, 'YYYY_MM_DD'), ADDRESS
FROM oldcontracts
WHERE TO_DATE(replace(ENDDATE, 'INDEFINIDO','9999-12-31'), 'YYYY_MM_DD') >SYSDATE;

INSERT INTO CONTRATOS
SELECT SSN, TO_DATE(STARTDATE, 'YYYY_MM_DD'), TO_DATE(replace(ENDDATE, 'INDEFINIDO','9999-12-31'), 'YYYY_MM_DD'), DECODE(JOB,'Bigwig',0,
                                                                                          'Trustee', 1,
                                                                                          'Executive Vice President',2,
                                                                                          'Managing Director', 3,
                                                                                          'Business Manager',4,
                                                                                          'Account Administrator',5,
                                                                                          'Senior Consultant',6,
                                                                                          'Junior Consultant',7,
                                                                                          'Analyst',8,
                                                                                          'Intern',9),
        TO_NUMBER(SALARY, '9999999999.99'), CEASING
FROM oldcontracts;

INSERT INTO JEFE_PROYECTO
SELECT DISTINCT PRJ_MANAGER
FROM OLDFOUNDING;

INSERT INTO JEFE_EQUIPO
SELECT DISTINCT TEAM_LEADER
FROM OLDREPORTS
WHERE TEAM_LEADER IS NOT NULL;

INSERT INTO PROYECTO
SELECT PROJ_ID, MAX(NAME), MAX(TO_NUMBER(BUDGET)), MAX(CASE WHEN TO_CHAR(TO_DATE(STARTDATE, 'YYYY-MM-DD'), 'D') =2 THEN (TO_DATE(STARTDATE, 'YYYY-MM-DD')-1)
                 WHEN TO_CHAR(TO_DATE(STARTDATE, 'YYYY-MM-DD'), 'D') = 3 THEN (TO_DATE(STARTDATE, 'YYYY-MM-DD')-2)
                 WHEN TO_CHAR(TO_DATE(STARTDATE, 'YYYY-MM-DD'), 'D') = 4 THEN (TO_DATE(STARTDATE, 'YYYY-MM-DD')-3)
                 WHEN TO_CHAR(TO_DATE(STARTDATE, 'YYYY-MM-DD'), 'D') = 5 THEN (TO_DATE(STARTDATE, 'YYYY-MM-DD')-4)
                 WHEN TO_CHAR(TO_DATE(STARTDATE, 'YYYY-MM-DD'), 'D') = 6 THEN (TO_DATE(STARTDATE, 'YYYY-MM-DD')-5)
                 WHEN TO_CHAR(TO_DATE(STARTDATE, 'YYYY-MM-DD'), 'D') = 7 THEN (TO_DATE(STARTDATE, 'YYYY-MM-DD')-6)
				 ELSE TO_DATE(STARTDATE, 'YYYY-MM-DD') END),
				 MAX(CASE WHEN TO_CHAR(TO_DATE(ENDDATE, 'YYYY-MM-DD'), 'D') = 1 THEN (TO_DATE(ENDDATE, 'YYYY-MM-DD')+6)
				 WHEN TO_CHAR(TO_DATE(ENDDATE, 'YYYY-MM-DD'), 'D') =2 THEN (TO_DATE(ENDDATE, 'YYYY-MM-DD')+5)
                 WHEN TO_CHAR(TO_DATE(ENDDATE, 'YYYY-MM-DD'), 'D') = 3 THEN (TO_DATE(ENDDATE, 'YYYY-MM-DD')+4)
                 WHEN TO_CHAR(TO_DATE(ENDDATE, 'YYYY-MM-DD'), 'D') = 4 THEN (TO_DATE(ENDDATE, 'YYYY-MM-DD')+3)
                 WHEN TO_CHAR(TO_DATE(ENDDATE, 'YYYY-MM-DD'), 'D') = 5 THEN (TO_DATE(ENDDATE, 'YYYY-MM-DD')+2)
                 WHEN TO_CHAR(TO_DATE(ENDDATE, 'YYYY-MM-DD'), 'D') = 6 THEN (TO_DATE(ENDDATE, 'YYYY-MM-DD')+1)
                 
				 ELSE TO_DATE(ENDDATE, 'YYYY-MM-DD') END),
				 MAX(PRJ_MANAGER)
FROM OLDFOUNDING
GROUP BY PROJ_ID;


INSERT INTO E_EXTERNA 
SELECT DISTINCT TAX_ID, COMPANY
FROM OLDFOUNDING
WHERE TAX_ID IS NOT NULL AND COMPANY IS NOT NULL;

INSERT INTO P_EXTERNA 
SELECT DISTINCT TAX_ID, PROJ_ID, DEPARTMENT, TO_NUMBER(REPLACE(FUNDS, '%', ''))
FROM OLDFOUNDING
WHERE TAX_ID IS NOT NULL;

INSERT INTO EQUIPO 
SELECT DISTINCT PROJECT, TEAM, TEAM_LEADER
FROM (SELECT PROJECT, TEAM, TEAM_LEADER
FROM OLDREPORTS
INNER JOIN OLDFOUNDING
ON OLDREPORTS.PROJECT = OLDFOUNDING.PROJ_ID)
WHERE TEAM IS NOT NULL AND TEAM_LEADER IS NOT NULL;


INSERT INTO COSTE_CATEGORIA
SELECT DECODE(CATEGORY,'Bigwig',0,
                                                                                          'Trustee', 1,
                                                                                          'Executive Vice President',2,
                                                                                          'Managing Director', 3,
                                                                                          'Business Manager',4,
                                                                                          'Account Administrator',5,
                                                                                          'Senior Consultant',6,
                                                                                          'Junior Consultant',7,
                                                                                          'Analyst',8,
                                                                                          'Intern',9), 
      TO_NUMBER(SALARY, '9999999999.99')
       
FROM OLDCOSTS
WHERE YEAR=to_char(sysdate, 'YYYY');

INSERT INTO MIEMBROS_EQUIPO
SELECT DISTINCT TEAM, PROJECT, TEAM_LEADER, SSN, MIN (TO_DATE(DAY, 'YYYY_MM_DD')),MAX (TO_DATE(DAY, 'YYYY_MM_DD')), DECODE(JOB,'Bigwig',0,
                                                                                          'Trustee', 1,
                                                                                          'Executive Vice President',2,
                                                                                          'Managing Director', 3,
                                                                                          'Business Manager',4,
                                                                                          'Account Administrator',5,
                                                                                          'Senior Consultant',6,
                                                                                          'Junior Consultant',7,
                                                                                          'Analyst',8,
                                                                                          'Intern',9)
FROM (SELECT * 
FROM OLDREPORTS
INNER JOIN OLDFOUNDING
ON OLDREPORTS.PROJECT = OLDFOUNDING.PROJ_ID)
WHERE TEAM IS NOT NULL  AND TEAM_LEADER IS NOT NULL
GROUP BY TEAM, PROJECT, TEAM_LEADER, SSN,  DECODE(JOB,'Bigwig',0,
                                                                                          'Trustee', 1,
                                                                                          'Executive Vice President',2,
                                                                                          'Managing Director', 3,
                                                                                          'Business Manager',4,
                                                                                          'Account Administrator',5,
                                                                                          'Senior Consultant',6,
                                                                                          'Junior Consultant',7,
                                                                                          'Analyst',8,
                                                                                          'Intern',9);


																						  
																						  
																						  
INSERT INTO INFORME_SEMANA
SELECT DISTINCT SSN, CASE WHEN TO_CHAR(TO_DATE(DAY, 'YYYY-MM-DD'), 'D') = 2 THEN (TO_DATE(DAY, 'YYYY-MM-DD')-1)
                 WHEN TO_CHAR(TO_DATE(DAY, 'YYYY-MM-DD'), 'D') = 3 THEN (TO_DATE(DAY, 'YYYY-MM-DD')-2)
                 WHEN TO_CHAR(TO_DATE(DAY, 'YYYY-MM-DD'), 'D') = 4 THEN (TO_DATE(DAY, 'YYYY-MM-DD')-3)
                 WHEN TO_CHAR(TO_DATE(DAY, 'YYYY-MM-DD'), 'D') = 5 THEN (TO_DATE(DAY, 'YYYY-MM-DD')-4)
                 WHEN TO_CHAR(TO_DATE(DAY, 'YYYY-MM-DD'), 'D') = 6 THEN (TO_DATE(DAY, 'YYYY-MM-DD')-5)
                 WHEN TO_CHAR(TO_DATE(DAY, 'YYYY-MM-DD'), 'D') = 7 THEN (TO_DATE(DAY, 'YYYY-MM-DD')-6)
                 ELSE TO_DATE(DAY, 'YYYY-MM-DD') END, MANAGER
FROM OLDREPORTS;



INSERT INTO DEDICACION_HORAS
SELECT DISTINCT SSN, CASE WHEN TO_CHAR(TO_DATE(DAY, 'YYYY-MM-DD'), 'D') = 2 THEN (TO_DATE(DAY, 'YYYY-MM-DD')-1)
                 WHEN TO_CHAR(TO_DATE(DAY, 'YYYY-MM-DD'), 'D') = 3 THEN (TO_DATE(DAY, 'YYYY-MM-DD')-2)
                 WHEN TO_CHAR(TO_DATE(DAY, 'YYYY-MM-DD'), 'D') = 4 THEN (TO_DATE(DAY, 'YYYY-MM-DD')-3)
                 WHEN TO_CHAR(TO_DATE(DAY, 'YYYY-MM-DD'), 'D') = 5 THEN (TO_DATE(DAY, 'YYYY-MM-DD')-4)
                 WHEN TO_CHAR(TO_DATE(DAY, 'YYYY-MM-DD'), 'D') = 6 THEN (TO_DATE(DAY, 'YYYY-MM-DD')-5)
                 WHEN TO_CHAR(TO_DATE(DAY, 'YYYY-MM-DD'), 'D') = 7 THEN (TO_DATE(DAY, 'YYYY-MM-DD')-6)
                 ELSE TO_DATE(DAY, 'YYYY-MM-DD') END, 
TO_NUMBER(TO_CHAR(TO_DATE(DAY, 'YYYY-MM-DD'),'D')), TO_NUMBER(SUBSTR(STARTTIME,1,2),'99'), REPLACE(PROJECT, 'IN/UNDEFINED', 'IN/52Q832848DX7'), TASK

FROM OLDREPORTS;