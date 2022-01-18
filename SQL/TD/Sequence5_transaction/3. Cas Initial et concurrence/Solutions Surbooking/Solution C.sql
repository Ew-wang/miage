SET FEEDBACK OFF
SET LINESIZE 150
SET PAGESIZE 40

PROMPT --> DEBUT DU SCRIPT

REM **************************************************************************
REM SOLUTION C : SOLUTION AVEC TRIGGER et CLAUSE FOR UPDATE
REM ***************************************************************************


PROMPT --> CREATION DU TRIGGER DE MISE A JOUR
CREATE OR REPLACE TRIGGER SurBOOK
BEFORE INSERT ON RESERVATION
FOR EACH ROW
DECLARE
	NB_Capa INT;
	NB INT;
BEGIN

	SELECT capacite into NB_capa 
	FROM avion a, depart d 
	WHERE d.iddepart=:new.iddepart
	AND a.numav=d.numav
	FOR UPDATE;

	SELECT count(*) INTO nb 
	FROM reservation 
	WHERE iddepart=:new.iddepart;

	IF nb >= nb_capa THEN
		Raise_application_error(-20001,'Surbooking. Impossible de réserver');
	END IF;
END;
/
show err

----------- TEST ---------------
--- A tester sur 2 consoles SQLPLUS différente sur le même compte

-- ************ Transaction 1 ******************************

INSERT INTO RESERVATION VALUES (100, 3);
INSERT INTO RESERVATIOn VALUES (200, 3);
COMMIT;

-- ************ Transaction 2 ******************************

INSERT INTO RESERVATIOn VALUES (300, 3);
COMMIT;
