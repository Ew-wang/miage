SET FEEDBACK OFF
SET LINESIZE 150
SET PAGESIZE 40

REM **************************************************************************
REM BASE AERO
REM Auteur : Jerome FESSY
REM ***************************************************************************

ALTER SESSION SET NLS_DATE_FORMAT = 'dd/mm/yyyy';

PROMPT --> DEBUT DU SCRIPT

REM ** Requête SQL de création des tables **

DROP TABLE reservation CASCADE CONSTRAINTS PURGE
/
DROP TABLE vol CASCADE CONSTRAINTS PURGE
/
DROP TABLE depart CASCADE CONSTRAINTS PURGE
/
DROP TABLE avion CASCADE CONSTRAINTS PURGE
/
DROP TABLE pilote CASCADE CONSTRAINTS PURGE
/
DROP TABLE passager CASCADE CONSTRAINTS PURGE
/

PROMPT CREATION DES TABLES

CREATE TABLE avion
(
Numav INTEGER CONSTRAINT pk_avion PRIMARY KEY,
Capacite INTEGER,
type VARCHAR2(10),
Entrepot VARCHAR2(30),
Autonomie INTEGER
)
/

CREATE TABLE pilote
(
Matricule INTEGER CONSTRAINT pk_pilote PRIMARY KEY,
NomPrenomPilote VARCHAR2(25) NOT NULL,
VilleDomicile VARCHAR2(30),
AnneeNaiss INTEGER,
Salaire INTEGER,
Grade CHAR(1)
)
/

CREATE TABLE passager
(
NumPassager INTEGER CONSTRAINT pk_passager PRIMARY KEY,
NomPrenomPassager VARCHAR2(25),
Sexe CHAR(1)
)
/


CREATE TABLE vol
(
Numvol VARCHAR2(10) CONSTRAINT pk_vol PRIMARY KEY,
HeureDepart DATE,
HeureArrivee DATE,
VilleDepart VARCHAR2(25),
VilleArrivee VARCHAR2(25)
)
/

CREATE TABLE depart
(
IdDepart INTEGER,
Numvol VARCHAR2(10),
DateDepart DATE,
numav INTEGER,
Matricule INTEGER,
NombrePlaces INTEGER DEFAULT 0,
CONSTRAINT PK_depart PRIMARY KEY(Iddepart),
CONSTRAINT U_depart UNIQUE (numvol, DateDepart)
)
/

CREATE TABLE Reservation
(
NumPassager INTEGER,
IdDepart INTEGER,
CONSTRAINT pk_reservation PRIMARY KEY (NumPassager,IdDepart)
)
/

ALTER TABLE depart
ADD CONSTRAINT fk_depart_vol
	FOREIGN KEY(numvol)
	REFERENCES Vol(numvol)
	ON DELETE CASCADE
ADD CONSTRAINT fk_depart_avion
	FOREIGN KEY(numav)
	REFERENCES Avion(numav)
	ON DELETE CASCADE
ADD CONSTRAINT fk_depart_pilote
	FOREIGN KEY(matricule)
	REFERENCES Pilote(matricule)
	ON DELETE CASCADE
/

ALTER TABLE Reservation
ADD CONSTRAINT fk_reservation_depart
	FOREIGN KEY(IdDepart)
	REFERENCES Depart(IdDepart)
	ON DELETE CASCADE
/

REM ** Les Requêtes d'insertion de données

PROMPT INSERTION D'AVIONS

insert into avion (Numav, Capacite, Type, Entrepot, autonomie)
values(1,2,'AR2','BLAGNAC',120);
insert into avion (Numav, Capacite, Type, Entrepot, autonomie)
values(2,10,'ICBM','NANTES',140);
insert into avion (Numav, Capacite, Type, Entrepot, autonomie)
values(3,10,'B907','NANTES',180);
insert into avion (Numav, Capacite, Type, Entrepot, autonomie)
values(4,25,'A320','PARIS',380);
insert into avion (Numav, Capacite, Type, Entrepot, autonomie)
values(5,50,'A220','LYON',320);
insert into avion (Numav, Capacite, Type, Entrepot, autonomie)
values(6,20,'A320','LYON',430);
insert into avion (Numav, Capacite, Type, Entrepot, autonomie)
values(7,42,'ICBM','CARPIQUET',320);
insert into avion (Numav, Capacite, Type, Entrepot, autonomie)
values(8,50,'ICBM','PARIS',720);
insert into avion (Numav, Capacite, Type, Entrepot, autonomie)
values(9,15,'AJ2000','PARIS',230);
insert into avion (Numav, Capacite, Type, Entrepot, autonomie)
values(10,20,'CR299','LYON',300);
insert into avion (Numav, Capacite, Type, Entrepot, autonomie)
values(11,18,'A320','NANTES',230);
insert into avion (Numav, Capacite, Type, Entrepot, autonomie)
values(12,20,'ICBM','CARPIQUET',120);
insert into avion (Numav, Capacite, Type, Entrepot, autonomie)
values(13,15,'AJ3000','BLAGNAC',130);
insert into avion (Numav, Capacite, Type, Entrepot, autonomie)
values(14,7,'A380','TOULOUSE',640);
insert into avion (Numav, Capacite, Type, Entrepot, autonomie)
values(15,2,'CR120','LILLE',550);
insert into avion (Numav, Capacite, Type, Entrepot, autonomie)
values(16,4,'B747','CARPIQUET',720);
insert into avion (Numav, Capacite, Type, Entrepot, autonomie)
values(17,3,'B807','PARIS',720);
insert into avion (Numav, Capacite, Type, Entrepot, autonomie)
values(666,5,'B907','BLAGNAC',360);

PROMPT INSERTION DE PILOTES

insert into pilote (Matricule, NomPrenomPilote, VilleDomicile, AnneeNaiss, Salaire,Grade)
values(10,'AMANDIER,PAUL','CHERBOURG',1966,4000,'A');
insert into pilote (Matricule, NomPrenomPilote, VilleDomicile, AnneeNaiss, Salaire,Grade)
values(20,'DUPOND,REMY','COUTANCE',1989,2600,'B');
insert into pilote (Matricule, NomPrenomPilote, VilleDomicile, AnneeNaiss, Salaire,Grade)
values(30,'CITRAE,LOUISE','COUTANCE',1969,3300,'A');
insert into pilote (Matricule, NomPrenomPilote, VilleDomicile, AnneeNaiss, Salaire,Grade)
values(40,'SOBLET,JEAN','CAEN',1995,3350,'B');
insert into pilote (Matricule, NomPrenomPilote, VilleDomicile, AnneeNaiss, Salaire,Grade)
values(50,'OLIVER,PIERRE','BAYEUX',1994,3600,'A');
insert into pilote (Matricule, NomPrenomPilote, VilleDomicile, AnneeNaiss, Salaire,Grade)
values(60,'RAZLI,EMILIE','CAEN',1961,6500,'C');
insert into pilote (Matricule, NomPrenomPilote, VilleDomicile, AnneeNaiss, Salaire,Grade)
values(70,'TRALY,MARIE','CAEN',1993,4000,'A');
insert into pilote (Matricule, NomPrenomPilote, VilleDomicile, AnneeNaiss, Salaire,Grade)
values(80,'BUOIN,MARISE','CHERBOURG',1987,8600,'B');
insert into pilote (Matricule, NomPrenomPilote, VilleDomicile, AnneeNaiss, Salaire,Grade)
values(90,'DATRU,CAROLINE','SAINT LO',1945,7300,'A');
insert into pilote (Matricule, NomPrenomPilote, VilleDomicile, AnneeNaiss, Salaire,Grade)
values(100,'SABLEAU,BOBY','HEROUVILLE',1959,2300,'B');
insert into pilote (Matricule, NomPrenomPilote, VilleDomicile, AnneeNaiss, Salaire,Grade)
values(110,'OLIVER,JEAN','HEROUVILLE',1995,5600,'C');
insert into pilote (Matricule, NomPrenomPilote, VilleDomicile, AnneeNaiss, Salaire,Grade)
values(120,'FRONA,FIONA','SAINT MALO',1967,6330,NULL);
insert into pilote (Matricule, NomPrenomPilote, VilleDomicile, AnneeNaiss, Salaire,Grade)
values(130,'MACLEON,JULIE','COUTANCE',2002,5200,'C');
insert into pilote (Matricule, NomPrenomPilote, VilleDomicile, AnneeNaiss, Salaire,Grade)
values(140,'ZARIA,FIONA','CARENTAN',2001,NULL,NULL);

PROMPT INSERTION DE PASSAGERS

insert into passager (NumPassager, NomPrenomPassager, Sexe)
values(100,'LEONCE PIERRE', 'M');
insert into passager (NumPassager, NomPrenomPassager, Sexe)
values(200,'BORIEN JACQUES', 'M');
insert into passager (NumPassager, NomPrenomPassager, Sexe)
values(300,'BLANCA MARIE','F');
insert into passager (NumPassager, NomPrenomPassager, Sexe)
values(400,'MARRONI SYLVIE','I');
insert into passager (NumPassager, NomPrenomPassager, Sexe)
values(500,'VENDEUVRE ERIC','M');
insert into passager (NumPassager, NomPrenomPassager, Sexe)
values(600,'GARDONI GEORGES','M');
insert into passager (NumPassager, NomPrenomPassager, Sexe)
values(700,'MARTION ELISE','F');
insert into passager (NumPassager, NomPrenomPassager, Sexe)
values(800,'VENANU ATILA','M');
insert into passager (NumPassager, NomPrenomPassager, Sexe)
values(900,'RAMI PIERRIC', 'M');
insert into passager (NumPassager, NomPrenomPassager, Sexe)
values(1000,'BIERUNI JACQUELINE', 'F');
insert into passager (NumPassager, NomPrenomPassager, Sexe)
values(1100,'BLYAR MARC','M');
insert into passager (NumPassager, NomPrenomPassager, Sexe)
values(1200,'MARZE SYLVAIN','M');
insert into passager (NumPassager, NomPrenomPassager, Sexe)
values(1300,'VENDOVSKY ERICA','F');
insert into passager (NumPassager, NomPrenomPassager, Sexe)
values(1400,'GARDARIAN GEORGETTE','F');
insert into passager (NumPassager, NomPrenomPassager, Sexe)
values(1500,'MARTZA ELIE','M');
insert into passager (NumPassager, NomPrenomPassager, Sexe)
values(1600,'VENTRCU ATMANA','F');

PROMPT INSERTION DE VOLS

insert into vol (Numvol, HeureDepart, HeureArrivee, VilleDepart, VilleArrivee)
values('AF421', to_date('12:30','hh24:mi'), to_date('13:30','hh24:mi'),'PARIS','LYON');
insert into vol (Numvol, HeureDepart, HeureArrivee, VilleDepart, VilleArrivee)
values('AF422', to_date('8:30','hh24:mi'), to_date('9:30','hh24:mi'),'PARIS','CARPIQUET');
insert into vol (Numvol, HeureDepart, HeureArrivee, VilleDepart, VilleArrivee)
values('AF333', to_date('12:30','hh24:mi'), to_date('13:40','hh24:mi'),'CARPIQUET','BLAGNAC');
insert into vol (Numvol, HeureDepart, HeureArrivee, VilleDepart, VilleArrivee)
values('AL1989', to_date('11:30','hh24:mi'), to_date('14:30','hh24:mi'),'LILLE','NICE');
insert into vol (Numvol, HeureDepart, HeureArrivee, VilleDepart, VilleArrivee)
values('AF300', to_date('13:30','hh24:mi'), to_date('16:30','hh24:mi'),'TOULOUSE','PARIS');
insert into vol (Numvol, HeureDepart, HeureArrivee, VilleDepart, VilleArrivee)
values('AF900', to_date('13:30','hh24:mi'), to_date('15:30','hh24:mi'),'NANTES','PARIS');
insert into vol (Numvol, HeureDepart, HeureArrivee, VilleDepart, VilleArrivee)
values('AF800', to_date('11:30','hh24:mi'), to_date('16:30','hh24:mi'),'NICE','CARPIQUET');
insert into vol (Numvol, HeureDepart, HeureArrivee, VilleDepart, VilleArrivee)
values('AL902', to_date('9:30','hh24:mi'), to_date('15:30','hh24:mi'),'PARIS','BLAGNAC');
insert into vol (Numvol, HeureDepart, HeureArrivee, VilleDepart, VilleArrivee)
values('A80', to_date('19:30','hh24:mi'), to_date('21:30','hh24:mi'),'NANTES','LILLE');
insert into vol (Numvol, HeureDepart, HeureArrivee, VilleDepart, VilleArrivee)
values('AF990', to_date('17:30','hh24:mi'), to_date('19:30','hh24:mi'),'NANTES','PARIS');
insert into vol (Numvol, HeureDepart, HeureArrivee, VilleDepart, VilleArrivee)
values('AB300', to_date('11:50','hh24:mi'), to_date('12:30','hh24:mi'),'NICE','BREST');
insert into vol (Numvol, HeureDepart, HeureArrivee, VilleDepart, VilleArrivee)
values('R333', to_date('9:40','hh24:mi'), to_date('15:30','hh24:mi'),'PARIS','BREST');
insert into vol (Numvol, HeureDepart, HeureArrivee, VilleDepart, VilleArrivee)
values('AL90', to_date('9:10','hh24:mi'), to_date('10:30','hh24:mi'),'PARIS','NICE');

PROMPT INSERTION DE DEPARTS

insert into depart (IdDepart,Numvol, DateDepart, Numav, Matricule)
values(1,'AF421','19-12-2021',1,10);
insert into depart (IdDepart,Numvol, DateDepart, Numav, Matricule)
values(2,'AF422','19-12-2021',1,10);
insert into depart (IdDepart,Numvol, DateDepart, Numav, Matricule)
values(3,'AF300','19-12-2021',1,10);
insert into depart (IdDepart,Numvol, DateDepart, Numav, Matricule)
values(4,'AL1989','1-4-2021',1,20);
insert into depart (IdDepart,Numvol, DateDepart, Numav, Matricule)
values(5,'AF333','13-10-2021',2,30);
insert into depart (IdDepart,Numvol, DateDepart, Numav, Matricule)
values(6,'AF900','07-10-2021',666,30);
insert into depart (IdDepart,Numvol, DateDepart, Numav, Matricule)
values(7,'AF333','25-12-2021',3,30);
insert into depart (IdDepart,Numvol, DateDepart, Numav, Matricule)
values(8,'AF300','25-01-2021',666,20);
insert into depart (IdDepart,Numvol, DateDepart, Numav, Matricule)
values(9,'AF900','07-11-2021',666,20);
insert into depart (IdDepart,Numvol, DateDepart, Numav, Matricule)
values(10,'AF800','07-11-2021',666,20);
insert into depart (IdDepart,Numvol, DateDepart, Numav, Matricule)
values(11,'AL902','07-12-2021',666,10);
insert into depart (IdDepart,Numvol, DateDepart, Numav, Matricule)
values(12,'R333','27-12-2021',17,30);
insert into depart (IdDepart,Numvol, DateDepart, Numav, Matricule)
values(13,'AB300','25-01-2020',666,20);
insert into depart (IdDepart,Numvol, DateDepart, Numav, Matricule)
values(14,'AF990','07-01-2020',666,20);
insert into depart (IdDepart,Numvol, DateDepart, Numav, Matricule)
values(15,'A80','07-11-2021',666,20);
insert into depart (IdDepart,Numvol, DateDepart, Numav, Matricule)
values(16,'AL90','07-12-2021',666,10);
insert into depart (IdDepart,Numvol, DateDepart, Numav, Matricule)
values(17,'A80','07-03-2022',666,90);
insert into depart (IdDepart,Numvol, DateDepart, Numav, Matricule)
values(18,'AL90','07-04-2022',666,90);

PROMPT INSERTION DE RESERVATIONS

insert into reservation (NumPassager, IdDepart)
values(100,7);
insert into reservation (NumPassager, IdDepart)
values(100,8);
insert into reservation (NumPassager, IdDepart)
values(200,7);
insert into reservation (NumPassager, IdDepart)
values(300,5);
insert into reservation (NumPassager, IdDepart)
values(200,1);
insert into reservation (NumPassager, IdDepart)
values(400,8);
insert into reservation (NumPassager, IdDepart)
values(200,4);
insert into reservation (NumPassager, IdDepart)
values(200,8);
insert into reservation (NumPassager, IdDepart)
values(200,10);
insert into reservation (NumPassager, IdDepart)
values(800,10);
insert into reservation (NumPassager, IdDepart)
values(800,5);
insert into reservation (NumPassager, IdDepart)
values(800,1);
insert into reservation (NumPassager, IdDepart)
values(800,8);
INSERT INTO RESERVATION (numpassager,iddepart) 
VALUES (100, 2);
INSERT INTO RESERVATION (numpassager,iddepart) 
VALUES (200, 2);
INSERT INTO RESERVATION (numpassager,iddepart) 
VALUES (300, 2);

insert into reservation (NumPassager, IdDepart)
values(1000,10);
insert into reservation (NumPassager, IdDepart)
values(1200,10);
insert into reservation (NumPassager, IdDepart)
values(1200,5);
insert into reservation (NumPassager, IdDepart)
values(1200,1);
insert into reservation (NumPassager, IdDepart)
values(1200,8);
INSERT INTO RESERVATION (numpassager,iddepart) 
VALUES (900, 10);
INSERT INTO RESERVATION (numpassager,iddepart) 
VALUES (700, 10);
INSERT INTO RESERVATION (numpassager,iddepart) 
VALUES (600, 10);

UPDATE DEPART D SET NombrePlaces = (SELECT COUNT(*) FROM RESERVATION  R WHERE R.iddepart=D.iddepart)
/

UPDATE DEPART D SET NombrePlaces = NombrePlaces + 2 WHERE D.datedepart < '12-10-2021'
/

PROMPT --> SCRIPT COMPLETEMENT TERMINE

commit;


SET FEEDBACK ON
