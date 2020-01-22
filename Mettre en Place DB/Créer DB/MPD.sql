/* Supprime - Crée - Utilise */
DROP DATABASE IF EXISTS MPD;
CREATE DATABASE MPD;
USE MPD;

CREATE TABLE Personne(
	per_num		INT 		AUTO_INCREMENT,
	per_nom		VARCHAR(20) NOT NULL,
	per_prenom	VARCHAR(20),
	per_adresse	VARCHAR(50),
	per_ville	VARCHAR(50),
	PRIMARY KEY (per_num)
);

CREATE TABLE Groupe(
	gro_num		INT 		AUTO_INCREMENT,
	gro_libelle	VARCHAR(20) NOT NULL,
	PRIMARY KEY (gro_num)
);
/* Clef composée de per_num et gro_num */
CREATE TABLE Appartient(
	per_num	INT,
	gro_num	INT,
	PRIMARY KEY (per_num, gro_num),
	FOREIGN KEY (per_num) REFERENCES Personne(per_num),
	FOREIGN KEY (gro_num) REFERENCES Groupe(gro_num)
);
/* Merise 

ENTITE(Personne) -- 1,1 -- ASSO(Appartient) -- 1,N -- ENTITE(Groupe)

*/