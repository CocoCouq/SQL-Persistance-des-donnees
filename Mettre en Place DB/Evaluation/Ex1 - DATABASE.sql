/* DROP DATABASE si elle existe
- Permet d'eviter une erreur lors de la premiere création 
- Tout en pouvant ecraser une base précédente et la remplacer */
DROP DATABASE IF EXISTS EvalDB;

/* Creation de la DATABASE EvalDB */
CREATE DATABASE EvalDB;

/* Utilisation de la DATABASE pour la suite de la requête */
USE EvalDB;



/* Creation des TABLES avec les PRIMARY KEY et FOREIGN KEY 
- Clefs primaires : Différentes (Identifiant)
- Clefs etrangeres : Liens entre deux TABLES 
Je définis l'ordre pour convenir avec les foreign key : 
- Produit
- Client 
- Commande 
- Vente 
(Produit et Client peuvent être inversés && Client et Commande aussi) */

CREATE TABLE produit (
	pro_num		INT			AUTO_INCREMENT,
	pro_lib		VARCHAR(50) NOT NULL,
	pro_desc	VARCHAR(100),
	PRIMARY KEY (pro_num));
	
CREATE TABLE `client` (
	cli_num		INT 		 AUTO_INCREMENT, 
	cli_nom		VARCHAR(50)  NOT NULL,
	cli_adres	VARCHAR(100) NOT NULL, 
	cli_tel		CHAR(12),
	PRIMARY KEY (cli_num));

CREATE TABLE commande (
	com_num			INT 		 AUTO_INCREMENT, 
	com_cli_num		INT,
	com_date		DATETIME 	 NOT NULL,
	com_obs			VARCHAR(100),
	PRIMARY KEY (com_num),
	FOREIGN KEY (com_cli_num) REFERENCES `client`(cli_num)
	);

CREATE TABLE vente (
	vnt_com_num		INT, 
	vnt_pro_num		INT, 
	vnt_est_qte		INT, 
	PRIMARY KEY (vnt_com_num, vnt_pro_num),
	FOREIGN KEY (vnt_com_num) REFERENCES commande(com_num),
	FOREIGN KEY (vnt_pro_num) REFERENCES produit(pro_num)
	);
	
/* Creation d'un index sur cli_nom */
CREATE INDEX NomClient
ON `client`(`cli_nom`);
