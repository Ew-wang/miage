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

 
