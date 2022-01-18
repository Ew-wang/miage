
SET FEEDBACK OFF
SET LINESIZE 150
SET PAGESIZE 40

PROMPT --> DEBUT DU SCRIPT

REM **************************************************************************
REM SOLUTION B : SOLUTION AVEC PROCEDURE STOCKEE
REM ***************************************************************************

PROMPT --> AJOUT DE LA COLONNE NbPlacesResa A LA TABLE DEPART

ALTER TABLE DEPART 
DROP COLUMN NbPlacesResa
/

ALTER TABLE DEPART 
ADD ( NbPlacesResa INTEGER)
/

REM -> Synchronisation de la colonne NbPlacesResa  de la table départ

Update depart d  set NbPlacesResa=(Select count(*) from reservation r where r.iddepart = d.iddepart)
/


PROMPT --> CREATION D'UNE PROCEDURE STOCKEE DE RESERVATION

CREATE OR REPLACE PROCEDURE P_SURBOOK(Ppassager INT, Piddep INT)
IS
diff int;
Surbook exception;

BEGIN

UPDATE DEPART SET NbPlacesResa = NbPlacesResa+1 WHERE idDepart = PidDep;

SELECT capacite - NbPlacesResa into diff from depart d, avion a where d.numav=a.numav 
AND d.iddepart = Piddep;
If diff >=0 tHEN
INSERT INTO RESERVATION VALUES (Ppassager, PidDep);
ELSE 
RAISE Surbook;
END IF;
EXCEPTION

WHEN surbook THEN 
Raise_application_error(-20001,'Surbooking');
END;
/
SHOW ERR


SET FEEDBACK ON

----------- TEST ---------------
--- A tester sur 2 consoles SQLPLUS différente sur le même compte

------ T1 -----
EXEC P_SURBOOK(100,3)
EXEC P_SURBOOK(200,3)
COMMIT;

------ T2 ------
EXEC P_SURBOOK(300,3)
COMMIT;