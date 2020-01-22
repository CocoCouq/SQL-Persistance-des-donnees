#------------------------------------------------------------
#        Script MySQL.
#------------------------------------------------------------
DROP DATABASE IF EXISTS EvalMCD;
CREATE DATABASE EvalMCD;
USE EvalMCD;

#------------------------------------------------------------
# Table: Client
#------------------------------------------------------------

CREATE TABLE CLIENT(
        cli_num    INT  AUTO_INCREMENT  NOT NULL ,
        cli_nom    VARCHAR (50) NOT NULL ,
        cli_prenom VARCHAR (50) NOT NULL
	,CONSTRAINT Client_PK PRIMARY KEY (cli_num)
)ENGINE=INNODB;


#------------------------------------------------------------
# Table: Commande
#------------------------------------------------------------

CREATE TABLE Commande(
        com_num     INT  AUTO_INCREMENT  NOT NULL ,
        com_date    DATE NOT NULL ,
        com_montant DECIMAL (10,2) NOT NULL ,
        cli_num     INT NOT NULL
	,CONSTRAINT Commande_PK PRIMARY KEY (com_num)

	,CONSTRAINT Commande_Client_FK FOREIGN KEY (cli_num) REFERENCES CLIENT(cli_num)
)ENGINE=INNODB;


#------------------------------------------------------------
# Table: Article
#------------------------------------------------------------

CREATE TABLE Article(
        art_num     INT  AUTO_INCREMENT  NOT NULL ,
        art_libelle VARCHAR (50) NOT NULL ,
        art_PU      DECIMAL (10,2) NOT NULL
	,CONSTRAINT Article_PK PRIMARY KEY (art_num)
)ENGINE=INNODB;


#------------------------------------------------------------
# Table: se_compose_de
#------------------------------------------------------------

CREATE TABLE se_compose_de(
        art_num  INT NOT NULL ,
        com_num  INT NOT NULL ,
        Quantite INT NOT NULL ,
        TVA      DECIMAL (3,1) NOT NULL
	,CONSTRAINT se_compose_de_PK PRIMARY KEY (art_num,com_num)

	,CONSTRAINT se_compose_de_Article_FK FOREIGN KEY (art_num) REFERENCES Article(art_num)
	,CONSTRAINT se_compose_de_Commande0_FK FOREIGN KEY (com_num) REFERENCES Commande(com_num)
)ENGINE=INNODB;
