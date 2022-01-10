## TD 3 

### CAS 1
```
-- il manque la contrainte d'unicite qui assure la relation (0-1) (0-1)

alter table Personne 
        add constraint U_personne 
        UNIQUE(APourChef_id);

insert into Personne (IdPers,Nompers, APourChef_id) 
values (5,'Erreur',1) ;
```

### CAS 2
```
-- IL FAUT AJOUTER LA DATE DANS LA CLE PRIMAIRE D'INTERVENTION

ALTER TABLE INTERVENTION
DROP CONSTRAINT PK_INTERVENTION
ADD  CONSTRAINT PK_INTERVENTION PRIMARY KEY (IDPERS, IDORDI, DATEINTERVENTION);

-- Au niveau de la modélisation, le MCD initial est faux. Une intervention est donc exprimée comme une ternaire entre PERSONNE, ORDINATEUR et une entité CALENDRIER
-- Voir la vidéo d'explication si besoin sur le cloud "2.CAS2 ExplicationCorrection.mp4"

```

### CAS 3

```
-- CORRECTION SCRIPT GESTION DES MARCHES

DROP TABLE MARCHE CASCADE CONSTRAINT;
DROP TABLE ANNEE CASCADE CONSTRAINT;
DROP TABLE EMPLACEMENT CASCADE CONSTRAINT;
DROP TABLE MARCHAND CASCADE CONSTRAINT;
DROP TABLE RESERVE CASCADE CONSTRAINT;

CREATE TABLE MARCHAND(
   IdMarchand NUMBER(10),
   NomMarchand VARCHAR2(50) NOT NULL,
   CONSTRAINT PK_MARCHAND PRIMARY KEY(IdMarchand)
);

CREATE TABLE MARCHE(
   IdMarche NUMBER(10),
   NomMarche VARCHAR2(50) NOT NULL,
   CONSTRAINT PK_MARCHE PRIMARY KEY(IdMarche)
);

CREATE TABLE ANNEE(
   Annee VARCHAR2(50),
   CONSTRAINT PK_ANNEE PRIMARY KEY(Annee)
);

-- Pour implanter la relative, il faut ajouter IdMarche à la clé primaire de EMPLACEMENT
-- la clé primaire est donc (IdMarche, NoEmplacement)
-- Cela implique que dans RESERVE, pour identifier un emplacement on le fait par (IdMarche, NoEmplacement)

CREATE TABLE EMPLACEMENT(
   IdMarche NUMBER(10),
   NoEmplacement NUMBER(10),
   NoAllee NUMBER(10) NOT NULL,
   Metrage NUMBER(10) NOT NULL,
   CONSTRAINT PK_EMPLACEMENT PRIMARY KEY(IdMarche, NoEmplacement),
   CONSTRAINT FK_EMPLACEMENT_MARCHE FOREIGN KEY(IdMarche) REFERENCES MARCHE(IdMarche)
);

-- Pour implanter la CIF : quand on connait le couple un emplacement et une année alors on connait le marchand
-- Donc la clé primaire de RESERVE est constituée uniquement de ( (IdMarche,NoEmplacement),Annee)
CREATE TABLE RESERVE(
   IdMarche NUMBER(10),
   NoEmplacement NUMBER(10),
   Annee VARCHAR2(50),
   IdMarchand NUMBER(10) NOT NULL,
   CONSTRAINT PK_RESERVE PRIMARY KEY(IdMarche, NoEmplacement, Annee),
   CONSTRAINT FK_RESERVE_EMPLACEMENT FOREIGN KEY(IdMarche, NoEmplacement) REFERENCES EMPLACEMENT(IdMarche, NoEmplacement),
   CONSTRAINT FK_RESERVE_ANNEE FOREIGN KEY(Annee) REFERENCES ANNEE(Annee),
   CONSTRAINT FK_RESERVE_MARCHAND FOREIGN KEY(IdMarchand) REFERENCES MARCHAND(IdMarchand)
);

-- VARIANTE :

--Pour éviter d'avoir une clé double sur EMPLACEMENT, on peut créer un identifiant d'emplacement
--NE PAS OUBLIER : la clé initiale (IdMarche, NoEmplacement) devient une clé de gestion (UNIQUE)
--Il y a du coup une répercution sur la table RESERVE qui contient IdEmplacement au lieu de couple (IdMarche, NoEmplacement)


DROP TABLE EMPLACEMENT CASCADE CONSTRAINT;
CREATE TABLE EMPLACEMENT(
   IdEmplacement INTEGER, -- creation d'un nouvel ID
   IdMarche NUMBER(10),
   NoEmplacement NUMBER(10),
   NoAllee NUMBER(10) NOT NULL,
   Metrage NUMBER(10) NOT NULL,
   CONSTRAINT PK_EMPLACEMENT PRIMARY KEY(IdEmplacement), -- ID devient clé primaire
   CONSTRAINT U_EMPLACEMENT UNIQUE(IdMarche, NoEmplacement), -- Notre ancienne clé primaire qui devient clé de gestion
   CONSTRAINT FK_EMPLACEMENT_MARCHE FOREIGN KEY(IdMarche) REFERENCES MARCHE(IdMarche)
);

DROP TABLE RESERVE CASCADE CONSTRAINT;
CREATE TABLE RESERVE(
   IdMarchand NUMBER(10),
   IdEmplacement NUMBER(10), -- c'est plus simple que le couple (IdMarche, NoEmplacement)
   Annee VARCHAR2(50),
   CONSTRAINT PK_RESERVE PRIMARY KEY(IdEmplacement, Annee),
   CONSTRAINT FK_RESERVE_EMPLACEMENT FOREIGN KEY(IdEmplacement) REFERENCES EMPLACEMENT(IdEmplacement),
   CONSTRAINT FK_RESERVE_ANNEE FOREIGN KEY(Annee) REFERENCES ANNEE(Annee),
   CONSTRAINT FK_RESERVE_MARCHAND FOREIGN KEY(IdMarchand) REFERENCES MARCHAND(IdMarchand)
);

-- On ajoute quelques données

INSERT INTO MARCHE (IdMarche, NomMarche) VALUES (1, 'BAYEUX PLACE ST PATRICE');
INSERT INTO MARCHAND ( IdMarchand,NomMarchand) VALUES (1, 'LA FERME BIO');
INSERT INTO MARCHAND ( IdMarchand,NomMarchand) VALUES (2, 'OEUF COCOTTE BIO');
INSERT INTO ANNEE (annee) VALUES (2019);
INSERT INTO ANNEE (annee) VALUES (2020);

-- 2 emplacements(100,200) de 3 mètres linéaires sur le marché de BAYEUX dans l'allée 10
INSERT INTO EMPLACEMENT (IdEmplacement,IdMarche,NoEmplacement,NoAllee,Metrage) VALUES (1,1,100,10,3);
INSERT INTO EMPLACEMENT (IdEmplacement,IdMarche,NoEmplacement,NoAllee,Metrage) VALUES (2,1,200,10,3);

-- 1 réservation en 2020 sur l'emplacement 1 du marché de Bayeux pour la Ferme Bio
INSERT INTO RESERVE (IdMarchand,IdEmplacement, Annee) VALUES (1,1,2020);
-- reservation non possible
INSERT INTO RESERVE (IdMarchand,IdEmplacement, Annee) VALUES (2,1,2020);

-- EXTRACTION
-- Extraire de la base pour chaque année, et chaque emplacement, le nombre de marchands l’ayant réservé

-- On peut faire la requête SQL MAIS le modèle impose que la réponse soit 1 

SELECT A.Annee, E.IdEmplacement, COUNT(IdMarchand) AS "Nombre de Marchands"
FROM RESERVE R, EMPLACEMENT E, ANNEE A
WHERE E.IdEmplacement = R.IdEmplacement AND A.Annee=R.Annee
GROUP BY A.Annee, E.IdEmplacement;
```

### CAS 4
```

-- -----------------------------------------------------------------------------
--      Auteur : Fessy
-- -----------------------------------------------------------------------------


-- -----------------------------------------------------------------------------
--       ETAPE 1 : CREATION DE LA TABLE VILLE ET D'UNE SEQUENCE POUR IDVILLE
-- -----------------------------------------------------------------------------
DROP TABLE VILLE CASCADE CONSTRAINTS PURGE;

DROP SEQUENCE SEQVILLE;
CREATE SEQUENCE SEQVILLE START WITH 0 MINVALUE 0;

CREATE TABLE VILLE
   (
    IDVILLE NUMBER(2)  NOT NULL,
    NOMVILLE VARCHAR(32)  NOT NULL CONSTRAINT UN_NOMVILLE UNIQUE,
   CONSTRAINT PK_VILLE PRIMARY KEY (IDVILLE)  
   ) ;


-- -----------------------------------------------------------------------------
--       ETAPE 2 : AJOUT DE LA COLONNE  IDVILLE CLE ETRANGERE DANS LA TABLE FOURNISSEUR
-- -----------------------------------------------------------------------------


ALTER TABLE FOURNISSEUR ADD
IDVILLE INTEGER;

 


-- -----------------------------------------------------------------------------
--       MIGRATION DES VILLES DE LA TABLE FOURNISSEUR VERS LA TABLE VILLE
-- -----------------------------------------------------------------------------

INSERT INTO VILLE (IDVILLE, NOMVILLE)
SELECT SEQVILLE.NEXTVAL, VILLE
FROM (SELECT DISTINCT UPPER(TRIM(VILLEFOURN)) AS VILLE FROM FOURNISSEUR);

-- -----------------------------------------------------------------------------
--       MISE A JOUR DE LA COLONNE IDVILLE DE FOURNISSEUR A PARTIR DES VALEURS DANS VILLE
-- -----------------------------------------------------------------------------

UPDATE FOURNISSEUR F
SET IDVILLE = (SELECT IDVILLE FROM VILLE  V WHERE V.NOMVILLE = F.VILLEFOURN);


-- -----------------------------------------------------------------------------
--       AJOUT DE LA CONTRAINTE D'INTEGRITE REFERENTIELLE ENTRE VILLE ET FOURNISSEUR
-- -----------------------------------------------------------------------------


ALTER TABLE FOURNISSEUR ADD
     CONSTRAINT FK_FOURNISSEUR_VILLE
          FOREIGN KEY (IDVILLE) REFERENCES VILLE(IDVILLE);


-- -----------------------------------------------------------------------------
--       SUPPRESSION DE LA COLONNE NOMVILLE DE FOURNISSEUR DEVENUE OBSOLETE
-- -----------------------------------------------------------------------------

ALTER TABLE FOURNISSEUR 
DROP COLUMN VILLEFOURN;



-- -----------------------------------------------------------------------------
--                FIN DE MODIFICATION
-- -----------------------------------------------------------------------------


```


