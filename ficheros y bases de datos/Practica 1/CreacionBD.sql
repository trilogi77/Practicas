CREATE TABLE NSSE(
SSocial VARCHAR2(15) NOT NULL,
CONSTRAINT PK_NSSE PRIMARY KEY (SSocial)
);

CREATE TABLE EMPLEADOS(
nombre VARCHAR2(35) NOT NULL,
ap1 VARCHAR2(30) NOT NULL,
ap2 VARCHAR2(30),
movil NUMBER(9) UNIQUE,
email VARCHAR2(55) NOT NULL UNIQUE,
DNI VARCHAR2(9) NOT NULL UNIQUE,
SSocial VARCHAR2(15) NOT NULL,
f_nac DATE NOT NULL,
dir_postal VARCHAR2(200) NOT NULL,
CONSTRAINT PK_EMPLEADOS PRIMARY KEY (SSocial),
CONSTRAINT FK_EMPLEADOS FOREIGN KEY (SSocial) REFERENCES NSSE );

CREATE TABLE CONTRATOS (
SSocial VARCHAR2(15) NOT NULL,
f_ini DATE NOT NULL,
f_fin DATE NOT NULL,
cat_profesional NUMBER(1) NOT NULL,
salario DECIMAL(12,2) NOT NULL,
motivo_baja VARCHAR2(200),
CONSTRAINT CH_CONTRATOS CHECK (f_ini<f_fin),
CONSTRAINT PK_CONTRATOS PRIMARY KEY (SSocial, f_ini),
CONSTRAINT FK_CONTRATOS FOREIGN KEY (SSocial) REFERENCES NSSE);

CREATE TABLE JEFE_EQUIPO(
SSocial VARCHAR2(15) NOT NULL,
CONSTRAINT PK_JEFE_EQUIPO PRIMARY KEY (SSocial),
CONSTRAINT FK_JEFE_EQUIPO FOREIGN KEY (SSocial) REFERENCES NSSE);

CREATE TABLE JEFE_PROYECTO(
SSocial VARCHAR2(15) NOT NULL,
CONSTRAINT PK_JEFE_PROYECTO PRIMARY KEY (SSocial),
CONSTRAINT FK_JEFE_PROYECTO FOREIGN KEY (SSocial) REFERENCES NSSE);

CREATE TABLE PROYECTO(
id_proyecto VARCHAR2(15) NOT NULL,
nombre_proyecto VARCHAR2(70) NOT NULL,
presupuesto NUMBER(12) NOT NULL,
f_ini DATE NOT NULL,
f_fin DATE,
jefe_proyecto VARCHAR2(15) NOT NULL,
CONSTRAINT CH_PROYECTO CHECK (SUBSTR(ID_PROYECTO,1,2)='IN' OR SUBSTR(ID_PROYECTO,1,2)='EX'),
CONSTRAINT PK_PROYECTO PRIMARY KEY (id_proyecto),
CONSTRAINT FK_PROYECTO FOREIGN KEY (jefe_proyecto) REFERENCES JEFE_PROYECTO ON DELETE CASCADE);


CREATE TABLE E_EXTERNA (
CIF VARCHAR2(10) NOT NULL,
nombre_emp VARCHAR2(100) NOT NULL,
CONSTRAINT PK_E_EXTERNA PRIMARY KEY (CIF));

CREATE TABLE P_EXTERNA(
CIF VARCHAR2(10) NOT NULL,
id_proyecto VARCHAR2(15) NOT NULL,
departamento VARCHAR2(150) NOT NULL,
presupuesto NUMBER(12) NOT NULL, 
CONSTRAINT PK_P_EXTERNA PRIMARY KEY (CIF, id_proyecto, departamento),
CONSTRAINT FK_P_EXTERNA FOREIGN KEY (ID_PROYECTO) REFERENCES PROYECTO ON DELETE CASCADE,
CONSTRAINT FK_P_EXTERNA1 FOREIGN KEY (CIF) REFERENCES E_EXTERNA ON DELETE CASCADE);


CREATE TABLE EQUIPO(
id_proyecto VARCHAR2(15) NOT NULL,
id_equipo VARCHAR2(30) NOT NULL,
jefe_equipo VARCHAR2(15) NOT NULL,

CONSTRAINT PK_EQUIPO PRIMARY KEY (id_proyecto, id_equipo),
CONSTRAINT FK_EQUIPO FOREIGN KEY (jefe_equipo) REFERENCES JEFE_EQUIPO ON DELETE CASCADE,
CONSTRAINT FK_EQUIPO1 FOREIGN KEY (id_proyecto) REFERENCES PROYECTO);

CREATE TABLE COSTE_CATEGORIA(
cat_profesional NUMBER(1) NOT NULL,
coste DECIMAL(12,2) NOT NULL,
CONSTRAINT PK_COSTE_CATEGORIA PRIMARY KEY (cat_profesional));


CREATE TABLE MIEMBROS_EQUIPO(
id_equipo VARCHAR2(30) NOT NULL,
id_proyecto VARCHAR2(15) NOT NULL,
jefe_equipo VARCHAR2(15) NOT NULL,
SSocial VARCHAR2(15) NOT NULL,
semana_ini DATE NOT NULL,
semna_fin DATE NOT NULL,
cat_profesional NUMBER(1) NOT NULL,
CONSTRAINT CH_MIEMBROS_EQUIPO CHECK (semana_ini<=semna_fin),
CONSTRAINT PK_MIEMBROS_EQUIPO PRIMARY KEY (id_equipo, SSocial, id_proyecto),
CONSTRAINT FK_MIEMBROS_EQUIPO3 FOREIGN KEY (jefe_equipo) REFERENCES JEFE_EQUIPO,
CONSTRAINT FK_MIEMBROS_EQUIPO1 FOREIGN KEY ( id_proyecto, id_equipo) REFERENCES EQUIPO ON DELETE CASCADE,
CONSTRAINT FK_MIEMBROS_EQUIPO2 FOREIGN KEY (SSocial) REFERENCES NSSE,

CONSTRAINT FK_MIEMBROS_EQUIPO4 FOREIGN KEY (id_proyecto) REFERENCES PROYECTO,
CONSTRAINT FK_MIEMBROS_EQUIPO5 FOREIGN KEY (cat_profesional) REFERENCES COSTE_CATEGORIA) ;

CREATE TABLE INFORME_SEMANA(
SSocial VARCHAR2(15) NOT NULL,
f_lunes DATE NOT NULL,
gerente VARCHAR2(15) NOT NULL,
CONSTRAINT CH_INFORME_SEMANA CHECK (SSocial!=gerente),
CONSTRAINT PK_INFORME_SEMANA PRIMARY KEY (SSocial, f_lunes),
CONSTRAINT FK_INFORME_SEMANA1 FOREIGN KEY (SSocial) REFERENCES NSSE,
CONSTRAINT FK_INFORME_SEMANA2 FOREIGN KEY (gerente) REFERENCES NSSE);



CREATE TABLE DEDICACION_HORAS(
SSocial VARCHAR2(15) NOT NULL,
f_lunes DATE NOT NULL,
dia_semana NUMBER(1) NOT NULL,
hora NUMBER(2) NOT NULL,
id_proyecto VARCHAR2(15) NOT NULL,
descripcion VARCHAR2(300) NOT NULL,
CONSTRAINT CH_DEDICACION_HORAS CHECK (dia_semana in (1,2,3,4,5,6,7)),
CONSTRAINT CH_DEDICACION_HORAS1 CHECK (hora in (0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23)),
CONSTRAINT PK_DEDICACION_HORAS PRIMARY KEY (SSocial, f_lunes, dia_semana, hora),
CONSTRAINT FK_DEDICACION_HORAS1 FOREIGN KEY (SSocial, f_lunes) REFERENCES INFORME_SEMANA ON DELETE CASCADE,
CONSTRAINT FK_DEDICACION_HORAS2 FOREIGN KEY (id_proyecto) REFERENCES PROYECTO);








                                                    



