/* CREATION D'UN UTILISATEUR AVEC SON PASSWORD */
CREATE USER 'util1'@'%' IDENTIFIED BY '1Ksable';

/* ATTRIBBUTION DE TOUS LES PRIVILEGES POUR util1, 
   DEPUIS TOUTES LES ADRESSE IP */ 
GRANT ALL PRIVILEGES ON papyrus.* TO 'util1'@'%'
IDENTIFIED BY '1Ksable';


CREATE USER 'util2'@'%' IDENTIFIED BY '1Ksable';
/* Peut SELECT sur DB Papyrus */
GRANT SELECT ON papyrus.* TO 'util2'@'%'
IDENTIFIED BY '1Ksable';

CREATE USER 'util3'@'%' IDENTIFIED BY '1Ksable';
/* Peut Seleument VOIR la table fournis de papyrus */
GRANT SHOW VIEW ON papyrus.fournis TO 'util3'@'%'
IDENTIFIED BY '1Ksable';