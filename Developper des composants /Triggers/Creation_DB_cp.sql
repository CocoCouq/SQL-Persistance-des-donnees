DROP DATABASE IF EXISTS cp;

CREATE DATABASE cp;

USE cp;

CREATE TABLE CLIENT (
	id 				INT AUTO_INCREMENT  NOT NULL,
	nom 			VARCHAR(30) NOT NULL,
	prenom 			VARCHAR(30) NOT NULL,
	adresse 		VARCHAR(30) NOT NULL,
	ville 			VARCHAR(30) NOT NULL,
	PRIMARY KEY (id)
);

CREATE TABLE produit (
	id 				INT AUTO_INCREMENT NOT NULL,
	designation 	VARCHAR(30),
	prix_achat 		DOUBLE NOT NULL,
	prix_vente 		DOUBLE NOT NULL,
	PRIMARY KEY (id)
);

CREATE TABLE commande (
	id 				INT AUTO_INCREMENT NOT NULL,
	id_client 		INT ,
	date_commande 	DATETIME DEFAULT NOW(),
	remise 			INT NOT NULL,
	total			DOUBLE,
	PRIMARY KEY (id),
	FOREIGN KEY (id_client) REFERENCES CLIENT(id)
);

CREATE TABLE lignedecommande (
	id_commande 	INT,
	id_produit 		INT,
	quantite 		INT,
	prix		 	DOUBLE,
	FOREIGN KEY (id_commande) REFERENCES commande(id),
	FOREIGN KEY (id_produit) REFERENCES produit(id)
);


INSERT INTO CLIENT (id, nom, prenom, adresse, ville) VALUES (1, 'dupontel', 'bernard', 'rue du bas', 'flichcourt');
INSERT INTO CLIENT (id, nom, prenom, adresse, ville) VALUES (2, 'gates', 'bill', 'rue du haut', 'amiens');
INSERT INTO CLIENT (id, nom, prenom, adresse, ville) VALUES (3, 'apple', 'alfred', 'rue du milieu', 'abbeville');
INSERT INTO CLIENT (id, nom, prenom, adresse, ville) VALUES (4, 'bb', 'raoul', 'rue du bas', 'dreuil');
INSERT INTO CLIENT (id, nom, prenom, adresse, ville) VALUES (5, 'dupontel', 'jacques', 'rue du bas', 'paris');

INSERT INTO produit (id, designation, prix_achat, prix_vente) VALUES (1, 'Lot de 10', 34, 6700);
INSERT INTO produit (id, designation, prix_achat, prix_vente) VALUES (2, 'Lot de 40', 34, 6700);
INSERT INTO produit (id, designation, prix_achat, prix_vente) VALUES (3, 'Gazon', 364, 700);
INSERT INTO produit (id, designation, prix_achat, prix_vente) VALUES (4, 'Lot de 1', 34, 6700);
INSERT INTO produit (id, designation, prix_achat, prix_vente) VALUES (5, 'Lot de 0', 34, 6700);

INSERT INTO commande (id_client, date_commande, remise) VALUES (2, '2018-09-01', 50);
INSERT INTO commande (id_client, date_commande, remise) VALUES (1, '2018-09-01', 10);
INSERT INTO commande (id_client, date_commande, remise) VALUES (2, '2018-09-01', 10);


INSERT INTO lignedecommande (id_commande, id_produit, prix, quantite) VALUES (2, 3, 10, 2);
INSERT INTO lignedecommande (id_commande, id_produit, prix, quantite) VALUES (2, 2, 10, 2);
INSERT INTO lignedecommande (id_commande, id_produit, prix, quantite) VALUES (2, 1, 10, 2);
INSERT INTO lignedecommande (id_commande, id_produit, prix, quantite) VALUES (2, 5, 10, 2);
INSERT INTO lignedecommande (id_commande, id_produit, prix, quantite) VALUES (2, 4, 10, 2);
INSERT INTO lignedecommande (id_commande, id_produit, prix, quantite) VALUES (1, 3, 10, 2);
INSERT INTO lignedecommande (id_commande, id_produit, prix, quantite) VALUES (1, 2, 10, 2);
INSERT INTO lignedecommande (id_commande, id_produit, prix, quantite) VALUES (1, 1, 10, 2);
INSERT INTO lignedecommande (id_commande, id_produit, prix, quantite) VALUES (3, 3, 10, 2);
INSERT INTO lignedecommande (id_commande, id_produit, prix, quantite) VALUES (3, 2, 10, 2);
INSERT INTO lignedecommande (id_commande, id_produit, prix, quantite) VALUES (3, 2, 10, 2);


