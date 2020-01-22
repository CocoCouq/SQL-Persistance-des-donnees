USE exemple;

/* Exercices Partie Base exemple */ 


/*******************************************************************************/
/* JOINTURES Joindre deux tableaux */
SELECT `employe`.prenom, `employe`.nodep, `dept`.noregion 
FROM `employe` 
JOIN `dept` ON `employe`.nodep = `dept`.nodept;

SELECT nodep, 
`dept`.nom AS "Nom du dept", 
`employe`.nom AS "Nom Employe"
FROM `dept` 
JOIN `employe` ON `employe`.nodep = `dept`.nodept
ORDER BY nodep;

SELECT `employe`.nom AS "Employes en distribution" 
FROM `employe` 
JOIN `dept` ON `dept`.nodept = `employe`.nodep
WHERE `dept`.nom = "distribution"; 


/*****************************************************************************/
/* AUTO-JOINTURES  Sauvegarde de tableau */
SELECT `u1`.nom AS "Nom employé", 
`u1`.salaire AS "Salaire emplyé",  
`u2`.nom AS "Chef", 
`u2`.salaire AS "Salaire du Chef"
FROM `employe` AS `u1`
JOIN `employe` AS `u2` ON `u2`.noemp = `u1`.nosup
WHERE `u1`.salaire > `u2`.salaire; 


/*****************************************************************************/
/* SOUS-REQUETES Where valeur = (select ... from ... where ...)*/
SELECT nom AS Nom, 
titre AS Poste  
FROM `employe`
WHERE titre = (
	SELECT titre 
	FROM `employe`
	WHERE nom = 'amartakaldire');

/* Superieur a tous les salaires du 31 -> ALL */
SELECT nom AS Nom, 
salaire AS Salaire,
nodep AS NumDepartement
FROM `employe` 
WHERE salaire > ALL (
	SELECT salaire 
	FROM `employe` 
	WHERE nodep = 31
	) 
ORDER BY nodep, salaire;

/* Superieur a un salaire du 31 -> ANY */
SELECT nom AS Nom, 
salaire AS Salaire,
nodep AS NumDepartement
FROM `employe` 
WHERE salaire > ANY (
	SELECT salaire 
	FROM `employe` 
	WHERE nodep = 31
	) 
ORDER BY nodep, salaire;

/* 'Se trouve dans...' -> IN */
SELECT nom AS Nom, 
titre AS Poste 
FROM `employe`
WHERE nodep = 31 AND titre IN (
	SELECT titre 
	FROM `employe` 
	WHERE nodep = 32);

/* 'Ne se trouve pas dans ..' -> NOT IN */
SELECT nom AS Nom, 
titre AS Poste 
FROM `employe`
WHERE nodep = 31 AND titre NOT IN (
	SELECT titre 
	FROM `employe` 
	WHERE nodep = 32);

/* Deux sous requetes */
SELECT nom AS Nom, 
titre AS Poste, 
salaire AS Salaire
FROM `employe`
WHERE salaire = (
	SELECT salaire 
	FROM `employe` 
	WHERE nom = "fairent")
AND titre = (
	SELECT titre 
	FROM `employe` 
	WHERE nom = "fairent")
AND nom != "fairent";


/*****************************************************************************/
/* REQUETES EXTERNES Left Join*/
SELECT `dept`.nodept AS NumDepartement, 
`dept`.nom AS Departement, 
`employe`.nom AS Employes
FROM `dept`
LEFT JOIN `employe` ON nodept = nodep
ORDER BY nodep;

/* Right Join*/
SELECT `dept`.nodept AS NumDepartement, 
`dept`.nom AS Departement, 
`employe`.nom AS Employes
FROM `employe`
RIGHT JOIN `dept` ON nodept = nodep
ORDER BY nodep;


/*****************************************************************************/
/* GROUPES Select ... From ... Group by ... + COUNT() Denombrement */
SELECT titre AS Poste, 
COUNT(noemp) AS Nombre
FROM `employe`
GROUP BY titre;

/* Moyenne AVG() + Somme SUM() */
SELECT `dept`.noregion AS NumRegion, 
SUM(`employe`.salaire) AS SommeSalaires, 
AVG(`employe`.salaire) AS MoyenneSalaires
FROM `employe` 
JOIN `dept` ON `employe`.nodep = `dept`.nodept
GROUP BY `dept`.noregion;


/*****************************************************************************/
/* HAVING Proche de Where mais pour les Group by */
SELECT nodep AS NumDepartement, 
COUNT(nodep) AS NombreDep
FROM `employe`
GROUP BY (nodep)
	HAVING COUNT(*) > 2;

/* HAVING Une fonction dans une fonction - 
Attention ne pas utiliser l'Alias créé dans le Select pour Select une autre valeur 
COUNT(SUBSTRING(...)) -> OK 
COUNT(InitialNom) -> NON */
SELECT SUBSTRING(nom, 1, 1) AS InitialNom,
COUNT(SUBSTRING(nom, 1, 1)) AS Nombres
FROM `employe` 
GROUP BY InitialNom
	HAVING Nombres > 2;


/*****************************************************************************/	
/* MIN & MAX */
SELECT max(salaire) AS Max, 
min(salaire) AS Min,
max(salaire) - min(salaire) AS Ecart
FROM `employe`;

/* Select COUNT(DISTINCT ...) !=  Select Distinct COUNT(..);*/
SELECT count(DISTINCT titre) AS NombreDeTitre
FROM `employe`;

/* Select Distinct - Nombre d'employes par titre */
SELECT DISTINCT titre AS Titre, 
count(titre) AS NbrEmployes
FROM `employe`
GROUP BY titre;

/* Group by & Join */
SELECT DISTINCT `dept`.nom AS NomDepartement,
count(`employe`.noemp) AS NbrEmploye
FROM `employe` 
JOIN `dept` ON nodept = nodep
GROUP BY `dept`.nom;

/* Group by & Havin SOUS-REQUETES */
SELECT DISTINCT titre, 
AVG(salaire) AS MoyenneSalaires
FROM `employe` 
GROUP BY titre
	HAVING AVG(salaire) > (
		SELECT AVG(salaire) 
		FROM `employe`
		WHERE titre = "représentant");

/* DISTINCT */
SELECT count(DISTINCT salaire) AS NbrSalaire, 
count(DISTINCT tauxcom) AS NbrTxCom
FROM `employe`;