DROP DATABASE hotel;
CREATE DATABASE hotel; 
USE hotel;


CREATE TABLE client_hotel (
	client_num		SMALLINT AUTO_INCREMENT NOT NULL,
	client_nom		VARCHAR(30) NOT NULL, 
	client_prenom	VARCHAR(30) NOT NULL, 
	PRIMARY KEY (client_num)
);
	
CREATE TABLE station (
	station_num		INT AUTO_INCREMENT NOT NULL,
	station_nom		VARCHAR(50) NOT NULL,
	PRIMARY KEY (station_num)
);

CREATE TABLE hotel (
	hotel_num		INT AUTO_INCREMENT NOT NULL, 
	hotel_capacit	INT,
	hotel_categ		INT CHECK (hotel_categ BETWEEN 1 AND 4),
	hotel_nom		VARCHAR(50) NOT NULL, 
	hotel_adress	VARCHAR(50) NOT NULL, 
	station_num		INT,
	PRIMARY KEY (hotel_num)
);

CREATE TABLE chambre (
	chamb_num		INT AUTO_INCREMENT, 
	chamb_capacit	SMALLINT NOT NULL,
	chamb_confort	TINYINT(3) CHECK (chamb_confort BETWEEN 0 AND 10), 
	chamb_expos		INT, 
	chamb_type		INT, 
	hotel_num		INT, 
	PRIMARY KEY	(chamb_num)
);

CREATE TABLE reservation (
	chamb_num		INT,
	client_num		SMALLINT, 
	date_debut		DATETIME NOT NULL, 
	date_fin			DATE NOT NULL, 
	date_reserv		TIMESTAMP,
	montant_arrhes	DECIMAL(9.2), 
	prix_total		DECIMAL(9.2) NOT NULL, 
	PRIMARY KEY (chamb_num, client_num),
	FOREIGN KEY (chamb_num) REFERENCES chambre(chamb_num),
	FOREIGN KEY (client_num) REFERENCES client_hotel(client_num)
);