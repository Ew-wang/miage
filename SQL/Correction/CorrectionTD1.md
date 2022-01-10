## TD-1 : Bilan Compétence SQL LMD

### LOT 0 : requêtes à exprimer en SQL

#### 1. Quelle est la liste des passagères de la base ?
*Résultat attendu :*

| NUMPASSAGER | NOMPRENOMPASSAGER |
|-:|:-|
|  300 | BLANCA MARIE         | 
|  700 | MARTION ELISE        | 
| 1000 | BIERUNI JACQUELINE   | 
| 1300 | VENDOVSKY ERICA      | 
| 1400 | GARDARIAN GEORGETTE  | 
| 1600 | VENTRCU ATMANA       | 

```
SELECT numpassager, nomprenompassager
    FROM PASSAGER
        WHERE sexe='F';
```

#### 2. Quels avions de type « Boeing » ont moins de 5 places ?
*Résultat attendu :*

| NUMAV |	TYPE |
|-:|:-|
| 16 | B747 |
| 17 | B807 |

```
SELECT numav, type
    FROM avion
        WHERE type LIKE 'B%' 
             AND capacite <5;
```

#### 3. Liste des pilote sans grade ?
*Résultat attendu :*

| MATRICULE|	NOMPRENOMPILOTE	| AGE |
|-:|:-:|:-:|
| 120	| FRONA,FIONA	|55 ans|
| 140	| ZARIA,FIONA	|21 ans|

```
SELECT matricule, nomprenompilote, To_CHAR(SYSDATE,'YYYY')-AnneeNaiss || ' ans'AS "AGE"
    FROM pilote
        WHERE grade IS NULL ;
```


### LOT 1 : requêtes à exprimer en SQL

#### 4. Les passagers qui ont fait des réservations ?
*Résultat attendu :*

| Numéro du Passager | Nom Prénom du passager | 
|-:|:-|
|  100 |  LEONCE PIERRE       | 
|  200 |  BORIEN JACQUES      |  
|  300 |  BLANCA MARIE        | 
|  400 |  MARRONI SYLVIE      | 
|  600 |  GARDONI GEORGES     | 
|  700 |  MARTION ELISE       | 
|  800 |  VENANU ATILA        | 
|  900 |  RAMI PIERRIC        | 
| 1000 |  BIERUNI JACQUELINE  | 
| 1200 |  MARZE SYLVAIN       |

```
SELECT DISTINCT P.numPassager AS "Numéro du Passager", 
      P.NomPrenomPassager AS "Nom Prénom du passager" 
    FROM passager P, Reservation R
        WHERE P.NumPassager = R.NumPassager
    ORDER BY 1 ;
```

#### 5. Quels passagers ont des réservations pour le 25 décembre 2019 ?
*Résultat attendu :*

| Numéro du Passager	| Nom Prénom du passager |
|-:|:-|
|100|	LEONCE PIERRE  |
|200| BORIEN JACQUES   |

```
SELECT P.numPassager AS "Numéro du Passager", 
       P.NomPrenomPassager AS "Nom Prénom du passager" 
    FROM passager P, Reservation R, Depart D
        WHERE P.NumPassager = R.NumPassager 
            AND R.Iddepart = D.Iddepart 
            AND D.datedepart='25-12-2019'
    ORDER BY 1;
```

#### 6. Quels passagers ont réservé sur un vol à destination de PARIS ?
*Résultat attendu :*

| Numéro du Passager	| Nom Prénom du passager |
|-:|:-|
|  100 |  LEONCE PIERRE  |
|  200 |  BORIEN JACQUES |
|  400 |  MARRONI SYLVIE |
|  800 |  VENANU ATILA   |
| 1200 |  MARZE SYLVAIN  |

```
SELECT P.numPassager AS "Numéro du Passager", 
       P.NomPrenomPassager AS "Nom Prénom du passager" 
    FROM passager P, Reservation R, Depart D, Vol V
        WHERE P.NumPassager = R.NumPassager 
            AND R.Iddepart = D. Iddepart 
            AND D.numvol = V.numvol 
            AND V.villearrivee ='PARIS'
    ORDER BY 1;
```


### LOT 2 : requêtes à exprimer en SQL

#### 7. Les passagers et leurs réservations ?
*Résultat attendu :*

| Numéro du Passager | Nom Prénom du passager | ID Reservation |
|-:|:-|:-|
| 1600	| VENTRCU ATMANA	      | Pas de réservation    | 
| 1500	| MARTZA ELIE	          | Pas de réservation    | 
| 1400	| GARDARIAN GEORGETTE	  | Pas de réservation    | 
| 1300	| VENDOVSKY ERICA	      | Pas de réservation    | 
| 1200	| MARZE SYLVAIN	          | 1                     | 
| 1200	| MARZE SYLVAIN	          | 10                    |
| 1200	| MARZE SYLVAIN	          | 5                     | 
| 1200	| MARZE SYLVAIN	          | 8                     | 
| 1100	| BLYAR MARC	          | Pas de réservation    | 
| 1000	| BIERUNI JACQUELINE	  | 10                    |
|  900	| RAMI PIERRIC	          | 10                    |
|  800	| VENANU ATILA	          | 1                     | 
|  800	| VENANU ATILA	          | 10                    |
|  800	| VENANU ATILA	          | 5                     | 
|  800	| VENANU ATILA	          | 8                     | 
|  700	| MARTION ELISE	          | 10                    |
|  600	| GARDONI GEORGES	      | 10                    |
|  500	| VENDEUVRE ERIC	      | Pas de réservation    | 
|  400	| MARRONI SYLVIE	      | 8                     |
|  300	| BLANCA MARIE	          | 2                     |
|  300	| BLANCA MARIE	          | 5                     |
|  200	| BORIEN JACQUES	      | 1                     |
|  200	| BORIEN JACQUES	      | 10                    |
|  200	| BORIEN JACQUES	      | 2                     |
|  200	| BORIEN JACQUES	      | 4                     |
|  200	| BORIEN JACQUES	      | 7                     |
|  200	| BORIEN JACQUES	      | 8                     |
|  100	| LEONCE PIERRE	          | 2                     |
|  100	| LEONCE PIERRE	          | 7                     |      
|  100	| LEONCE PIERRE	          | 8                     |

```
SELECT DISTINCT P.numPassager AS "Numéro du Passager", 
       P.NomPrenomPassager AS "Nom Prénom du passager", 
       NVL(TO_CHAR(R.Iddepart),'Pas de réservation') AS "ID Reservation"
    FROM passager P LEFT JOIN Reservation R ON P.NumPassager = R.NumPassager
    ORDER BY 1 DESC ;
```

### LOT 3 : requêtes à exprimer en SQL

#### 8. Les passagers sans réservations ?
*Résultat attendu :*

| Numero du Passager | Nom Prenom du Passager |
|-:|:-|
| 500|	VENDEUVRE ERIC      |
|1100|	BLYAR MARC          |
|1300|	VENDOVSKY ERICA     |
|1400|	GARDARIAN GEORGETTE |
|1500|	MARTZA ELIE         |
|1600|	VENTRCU ATMANA      |

```
SELECT  P.NumPassager AS "Numero du Passager", 
        P.NomPrenomPassager AS "Nom Prenom du Passager"
    FROM Passager P
    WHERE P.NumPassager NOT IN (SELECT .NumPassager 
                                      FROM Reservation R)
    ORDER BY 1,2;  
```

#### 9. Les passagers qui n’ont aucune réservation pour le 25 décembre 2019 ?
*Résultat attendu :*


| Numero du Passager | Nom Prénom du Passager |
|-:|:-|
|  100 |	LEONCE PIERRE       |
|  200 |	BORIEN JACQUES      |
|  300 |	BLANCA MARIE        |
|  400 |	MARRONI SYLVIE      |
|  500 |	VENDEUVRE ERIC      |
|  600 |	GARDONI GEORGES     |
|  700 |	MARTION ELISE       |
|  800 |	VENANU ATILA        |
|  900 |	RAMI PIERRIC        |
| 1000 |	BIERUNI JACQUELINE  |
| 1100 |	BLYAR MARC          |
| 1200 |	MARZE SYLVAIN       |
| 1300 |	VENDOVSKY ERICA     |
| 1400 |	GARDARIAN GEORGETTE |
| 1500 |	MARTZA ELIE         |
| 1600 |	VENTRCU ATMANA      |

```
SELECT P.NumPassager "Numero du Passager", 
       P.NomPrenomPassager "Nom Prénom du Passager"
    FROM Passager P
    WHERE P.numPassager NOT IN (SELECT R.numPassager 
                                    FROM reservation R, depart D 
                                    WHERE R.IdDepart=D.IdDepart 
                                        AND D.DateDepart='25/12/2019')
    ORDER BY 1,2 ;
```

### LOT 4 : requêtes à exprimer en SQL

#### 10. Pour chaque passager répertorié dans la base, afficher son nombre de réservations ?
*Résultat attendu :*

| Numero Passager | Nom Prénom du Passager | Nombre de Reservation |
|-:|:-|:-|
|  200 |	BORIEN JACQUES	    | 6 |
|  800 |	VENANU ATILA	    | 4 |
| 1200 |	MARZE SYLVAIN	    | 4 |
|  100 |	LEONCE PIERRE	    | 3 |
|  300 |	BLANCA MARIE	    | 2 |
|  700 |	MARTION ELISE	    | 1 |
|  900 |	RAMI PIERRIC	    | 1 |
|  600 |	GARDONI GEORGES	    | 1 |
|  400 |	MARRONI SYLVIE	    | 1 |
| 1000 |	BIERUNI JACQUELINE	| 1 |
| 1400 |	GARDARIAN GEORGETTE	| 0 |
| 1600 |	VENTRCU ATMANA	    | 0 |
| 1500 |	MARTZA ELIE	        | 0 |
| 1100 |	BLYAR MARC	        | 0 |
|  500 |	VENDEUVRE ERIC	    | 0 |
| 1300 |	VENDOVSKY ERICA	    | 0 |

```
SELECT P. NumPassager “Numero Passager”, P.NomPrenomPassager “Nom Prénom du Passager”, COUNT(R.IdDepart) ”Nombre de Reservation”  
FROM PASSAGER P LEFT JOIN RESERVATION R  ON P.numPassager =R.numPassager
GROUP BY P. numPassager, P. NomPrenomPassager
ORDER BY 3 DESC
```
#### 11. Les pilotes totalisant plus de 3 départs ?
*Résultat attendu :*

| Numero du Pilote | Nom Prénom du Pilote |
|-:|:-|
|10|	AMANDIER,PAUL   |
|20|	DUPOND,REMY     |
|30|	CITRAE,LOUISE   |

```
SELECT P.matricule AS "Numero du Pilote", 
       P.nomPrenomPilote AS "Nom Prénom du Pilote" 
    FROM Pilote P,Depart D
    WHERE P.matricule = D.matricule
    GROUP BY P.matricule, P.nomPrenomPilote
        HAVING count(*) > =3
    ORDER BY 1,2 ;
```


### LOT 5 : requêtes à exprimer en SQL

#### 12. Le nombre de départs par mois
*Résultat attendu :*

| ANNEE | MOIS | Nombre de départs |
|:-:|:-:|:-:|
| 2020 | 01	| 2 |
| 2021 | 01	| 1 |
| 2021 | 04	| 1 |
| 2021 | 10	| 2 |
| 2021 | 11	| 3 |
| 2021 | 12	| 7 |
| 2022 | 03	| 1 |
| 2022 | 04 | 1 |

```
SELECT TO_CHAR(D.DateDepart, 'YYYY') AS "ANNEE" , 
        TO_CHAR(D.DateDepart, 'MM') AS "MOIS" ,
        COUNT(*) AS "Nombre de départs"
    FROM Depart D
    GROUP BY TO_CHAR(D.DateDepart, 'YYYY'), TO_CHAR(D.DateDepart, 'MM')
    ORDER BY 1,2;
```
