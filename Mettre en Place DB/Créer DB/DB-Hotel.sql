/* DROP DATABASE IF EXISTS pour pouvoir la recréer après l'avoir supprimé*/
DROP DATABASE IF EXISTS hotel;

/* Creation de la DATABASE */
CREATE DATABASE hotel;

/* Utilisation de la DATABASE */
USE hotel;

/* Création d'un tableau (Pas besoin de NOT NULL sur un auto_increment) */
/* La clef primaire doit toujours être unique, elle identifie */
CREATE TABLE client_hotel (
	client_num		INT AUTO_INCREMENT,
	client_nom		VARCHAR(30) NOT NULL,
	client_prenom	VARCHAR(30) NOT NULL,
	client_adress VARCHAR(100), 
	PRIMARY KEY (client_num)
);

CREATE TABLE station (
	station_num		INT AUTO_INCREMENT,
	station_nom		VARCHAR(50) NOT NULL,
	PRIMARY KEY (station_num)
);

/* Une clef étrangère lie deux TABLES mais doit avoir été initiée avant */
CREATE TABLE hotel (
	hotel_num		INT AUTO_INCREMENT,
	hotel_capacit	INT,
	hotel_categ		INT CHECK (hotel_categ BETWEEN 1 AND 4),
	hotel_nom		VARCHAR(50) NOT NULL,
	hotel_adress	VARCHAR(50) NOT NULL,
	station_num		INT,
	PRIMARY KEY (hotel_num),
	FOREIGN KEY (station_num) REFERENCES station(station_num)
);

CREATE TABLE chambre (
	chamb_num		INT AUTO_INCREMENT,
	chamb_capacit	SMALLINT NOT NULL,
	chamb_confort	TINYINT(3) CHECK (chamb_confort BETWEEN 0 AND 10),
	chamb_expos		INT,
	chamb_type		INT,
	hotel_num		INT,
	PRIMARY KEY	(chamb_num),
	FOREIGN KEY (hotel_num) REFERENCES hotel(hotel_num)
);

/* Primary Key composée permet d'avoir toujours une combinaison différente */
CREATE TABLE reservation (
	chamb_num		INT,
	client_num		INT,
	date_debut		DATETIME NOT NULL,
	date_fin		DATE NOT NULL,
	date_reserv		TIMESTAMP,
	montant_arrhes	DECIMAL(9.2),
	prix_total		DECIMAL(9.2) NOT NULL,
	PRIMARY KEY (chamb_num, client_num),
	FOREIGN KEY (chamb_num) REFERENCES chambre(chamb_num),
	FOREIGN KEY (client_num) REFERENCES client_hotel(client_num)
);
