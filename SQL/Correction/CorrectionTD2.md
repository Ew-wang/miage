## TD-2 : LDD

### LOT 0 : VERT

#### 1. Copie de L’IHM de saisie de données :

```
CREATE TABLE PERSONNEL (
IdPersonnel INTEGER,
NomPersonnel VARCHAR(30) NOT NULL,
PrenomPersonnel VARCHAR(30) NOT NULL, 
AnneeNaissance INTEGER NOT NULL,

CONSTRAINT PK_PERSONNEL PRIMARY KEY (IdPersonnel),
CONSTRAINT U_PERSONNEL UNIQUE  (NomPersonnel, PrenomPersonnel, AnneeNaissance)
)

```
*Verification :*
```
Select*
    FROM PERSONNEL ;
 ```
 
 
  ```
CREATE TABLE PRODUIT(
IdProduit INTEGER,
LibelleProduit VARCHAR(30) NOT NULL,
IdFournisseur INTEGER,

CONSTRAINT PK_PRODUIT PRIMARY KEY(IdProduit),
CONSTRAINT PK_FOURNISSEUR_PRODUIT FOREIGN KEY (IdFournisseur) REFERENCES FOURNISSEUR (IdFournisseur) 
)
 ```
 ```
Select *
    FROM Produit;
 ```
 
 
