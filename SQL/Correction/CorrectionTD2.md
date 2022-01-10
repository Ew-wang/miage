## TD-2 : LDD

### LOT 0 : VERT

#### 1. Copie de L’IHM de saisie de données :

```
DROP TABLE PERSONNEL
/
CREATE TABLE PERSONNEL (
    IdPersonnel INTEGER,
    NomPersonnel VARCHAR(30) NOT NULL,
    PrenomPersonnel VARCHAR(30) NOT NULL, 
    AnneeNaissance INTEGER NOT NULL,
    -- Correction 
    CONSTRAINT PK_PERSONNEL PRIMARY KEY(IdPersonnel),
    CONSTRAINT U_PERSONNEL UNIQUE(NomPersonnel,PrenomPersonnel, AnneeNaissance)
)
/

DROP SEQUENCE SeqPersonnel
/
CREATE SEQUENCE SeqPersonnel
/

-- *** Donnée 

INSERT INTO PERSONNEL (IdPersonnel, NomPersonnel, PrenomPersonnel,AnneeNaissance) VALUES (SeqPersonnel.NEXTVAL, 'LEONARDI','LUCAS',1965)
/

-- *** Anomalie Constatée
INSERT INTO PERSONNEL (IdPersonnel, NomPersonnel, PrenomPersonnel,AnneeNaissance) VALUES (SeqPersonnel.NEXTVAL, 'LEONARDI','LUCAS',1965)
/
INSERT INTO PERSONNEL (IdPersonnel, NomPersonnel, PrenomPersonnel,AnneeNaissance) VALUES (SeqPersonnel.NEXTVAL, 'LEONARDI','LUCAS',1965)
/
-- Verification 

Select*
    FROM PERSONNEL ;
```


#### 2.

```
DROP TABLE FOURNISSEUR
/
CREATE TABLE FOURNISSEUR (
    IdFournisseur INTEGER,
    LibelleFournisseur VARCHAR(30) NOT NULL,
    VilleFournisseur VARCHAR(30) NOT NULL,

    CONSTRAINT PK_FOURNISSEUR PRIMARY KEY(IdFournisseur)    
)
/


DROP TABLE PRODUIT
/
CREATE TABLE PRODUIT(
    IdProduit INTEGER,
    LibelleProduit VARCHAR(30) NOT NULL,
    IdFournisseur INTEGER,

    CONSTRAINT PK_PRODUIT PRIMARY KEY(IdProduit),
    -- correction
    CONSTRAINT FK_FOURNISSEUR_PRODUIT FOREIGN KEY(IdFournisseur) REFERENCES FOURNISSEUR(IdFournisseur)
)
/

--Donnee 

-- Fournisseur
INSERT INTO FOURNISSEUR (IdFournisseur, LibelleFournisseur, VilleFournisseur) VALUES (1, 'NIKE','PARIS')
/

-- Produit
INSERT INTO PRODUIT (IdProduit, LibelleProduit, IdFournisseur) VALUES (1, 'Ballon Basket R300',1)
/
-- *** Anomalie Constatée
INSERT INTO PRODUIT (IdProduit, LibelleProduit, IdFournisseur) VALUES (2, 'Chaussure Running AS333',4)
/

Select*
    FROM Fournisseur;
 Select *
    FROM Produit;
```
 
 ### 3.
 
 ```
 DROP TABLE PERSONNEL
/
CREATE TABLE PERSONNEL (
    IdPersonnel INTEGER,
    NomPersonnel VARCHAR(30) NOT NULL,
    PrenomPersonnel VARCHAR(30) NOT NULL, 
    AnneeNaissance INTEGER NOT NULL,

    CONSTRAINT PK_PERSONNEL PRIMARY KEY(IdPersonnel),
    --correction 
    CONSTRAINT CK_PERSONNEL CHECK (NomPersonnel=UPPER(NomPersonnel) AND PrenomPersonnel=UPPER(PrenomPersonnel)),

)
/

DROP SEQUENCE SeqPersonnel
/
CREATE SEQUENCE SeqPersonnel
/

-- Donnee

INSERT INTO PERSONNEL (IdPersonnel, NomPersonnel, PrenomPersonnel,AnneeNaissance) VALUES (SeqPersonnel.NEXTVAL, 'LE ROYER','JEAN',1965)
/
-- *** Anomalie Constatée
INSERT INTO PERSONNEL (IdPersonnel, NomPersonnel, PrenomPersonnel,AnneeNaissance) VALUES (SeqPersonnel.NEXTVAL, 'Leonardie','LUCAS',1965)
/

Select *
    FROM Personnel;
 ```

### 4. 

```
DROP TABLE PERSONNEL CASCADE CONSTRAINTS PURGE
/
CREATE TABLE PERSONNEL (
    IdPersonnel INTEGER,
    NomPrenomPersonnel VARCHAR(40),
    NomPersonnel VARCHAR(30),
    PrenomPersonnel VARCHAR(30), 
    Sexe CHAR(1),

    CONSTRAINT PK_PERSONNEL PRIMARY KEY(IdPersonnel)
)
/

-- Donnee 
INSERT INTO PERSONNEL (IdPersonnel, NomPrenomPersonnel, Sexe) VALUES (1, 'LE ROYER,JEAN',1)
/
INSERT INTO PERSONNEL (IdPersonnel, NomPrenomPersonnel, Sexe) VALUES (2, 'PAROT,MARIE',2)
/
INSERT INTO PERSONNEL (IdPersonnel, NomPrenomPersonnel, Sexe) VALUES (3, 'LEONARDI,LUCAS',1)
/

-- *** Requête au fonctionnement partiel


UPDATE PERSONNEL SET sexe = DECODE (sexe, '1','M', '2', 'F');

UPDATE PERSONNEL SET 
NomPersonnel=SUBSTR(NomPrenomPersonnel,1,INSTR(NomPrenomPersonnel, ',')-1),
PrenomPersonnel = SUBSTR(NomPrenomPersonnel,INSTR(NomPrenomPersonnel, ',')+1, LENGTH(NomPrenomPersonnel));

```

## Orange

### 1. 

```
DROP TABLE LIVRE CASCADE CONSTRAINT
/
CREATE TABLE LIVRE (
    IdLivre INTEGER,
    TitreLivre VARCHAR(30) NOT NULL,

    CONSTRAINT PK_LIVRE PRIMARY KEY(IdLivre)
)
/

DROP TABLE EXEMPLAIRES_LIVRE CASCADE CONSTRAINT
/
CREATE TABLE EXEMPLAIRES_LIVRE (
    IdExemplaire INTEGER,
    IdLivre INTEGER,
    AnneeEdition INTEGER,

    -- CORRECTION : On met comme clé primaire de EXEMPLAIRE_LIVRE le couple (IdExemplaire,IdLivre)
    PK_EXEMPLAIRES_LIVRE PRIMARY KEY(IdExemplaire,IdLivre),
    
    -- Puis on ajoute l'option ON DELETE CASCADE dans la contrainte de REFERENCE
    CONSTRAINT FK_EXEMPLAIRES_LIVRE FOREIGN KEY(IdLivre) REFERENCES LIVRE(IdLivre) ON DELETE CASCADE

    -- VARIANTE : tout dans le meme ALTER. Attention pas de ',' entre les 2 ADD CONSTRAINT
    CONSTRAINT PK_EXEMPLAIRES_LIVRE PRIMARY KEY(IdExemplaire,IdLivre)
    CONSTRAINT FK_EXEMPLAIRES_LIVRE FOREIGN KEY(IdLivre) REFERENCES LIVRE(IdLivre) ON DELETE CASCADE
)
/

-- *** Jeu de données

INSERT INTO LIVRE (IdLivre, TitreLivre) VALUES (1, 'L''ETRANGER')
/
INSERT INTO LIVRE (IdLivre, TitreLivre) VALUES (2, 'LE PARFUN')
/
INSERT INTO LIVRE (IdLivre, TitreLivre) VALUES (3, 'HARRY POTTER')
/
INSERT INTO EXEMPLAIRES_LIVRE (IdExemplaire,IdLivre,AnneeEdition) VALUES (3,3, 1993)
/
INSERT INTO EXEMPLAIRES_LIVRE (IdExemplaire,IdLivre,AnneeEdition) VALUES (1,2, 1988)
/
INSERT INTO EXEMPLAIRES_LIVRE (IdExemplaire,IdLivre,AnneeEdition) VALUES (2,2, 1999)
/

-- ** Requêtes générant les anomalies

INSERT INTO EXEMPLAIRES_LIVRE (IdExemplaire,IdLivre,AnneeEdition) VALUES (1,1, 2000)
/
DELETE LIVRE WHERE TitreLivre='HARRY POTTER'
```

### 2. 

```

```





