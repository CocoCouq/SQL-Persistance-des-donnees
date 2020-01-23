USE papyrus;

/* 1 - Global Commande */
DROP VIEW IF EXISTS v_GlobalCde;

CREATE VIEW v_GlobalCde
AS
SELECT ligcom.`codart` AS Article,
sum(ligcom.`qtecde`) AS QteTot,
sum(ligcom.`qtecde` * ligcom.`priuni`) AS PrixTot
FROM ligcom
GROUP BY ligcom.`codart`;

SELECT * FROM v_GlobalCde;


/* 2 - Vente du produit I100 */
DROP VIEW IF EXISTS v_VentesI100;

CREATE VIEW v_VentesI100
AS
SELECT *
FROM ligcom
WHERE ligcom.`codart` = 'I100';

SELECT * FROM v_VentesI100;

/* 3 - Produit I100 pour fournisseur 00120 */
DROP VIEW IF EXISTS v_VentesI100Grobrigan;

CREATE VIEW v_VentesI100Grobrigan
AS
SELECT ligcom.`numcom` AS NumCommande,
ligcom.`numlig` AS NumLig,
ligcom.`codart` AS CodeArticle,
ligcom.`qtecde` AS QteCommandee,
ligcom.`priuni` AS PrixUnitaire,
ligcom.`qteliv` AS QteLivree,
ligcom.`derliv` AS DerniereLivraison,
entcom.`obscom` AS Observations,
entcom.`datcom` AS DateCommande,
entcom.`numfou` AS Fournisseur,
fournis.`nomfou` AS NomFournisseur
FROM ligcom
JOIN entcom ON entcom.`numcom` = ligcom.`numcom`
JOIN fournis ON fournis.`numfou` = entcom.`numfou`
WHERE ligcom.`codart` = 'I100'
AND entcom.`numfou` = 120;

SELECT * FROM v_VentesI100Grobrigan;

/* Lister les vues existantes */
SELECT * FROM information_schema.views;
