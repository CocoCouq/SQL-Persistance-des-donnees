/* Utilisation de la base papyrus */
USE papyrus;

/* EXERCICE 1 - Principes de base */
START TRANSACTION;
	SELECT nomfou FROM fournis WHERE numfou=120;
-- > Utilisateur(s)(Celui qui fait la requete) : GROBRIGAN
	UPDATE fournis  SET nomfou= 'GROSBRIGAND' WHERE numfou=120;
	SELECT nomfou FROM fournis WHERE numfou=120;
-- > Utilisateur : GROSBRIGAND | Autre(s) Utilisateur(s)(Nouvelle fenetre de requete) : GROBRIGAN

/* A cette ligne, une transaction a été ouverte et le numero de numfou a été changé.
Tant que je n'ai pas de donné d'instruction COMMIT (Pour publier) ou bien ROLLBACK (Annuler la transaction),
les utilisateurs ET MOI, DEPUIS UN AUTRE SUPPORT, (Sequel Pro & phpMyAdmin) ne peuvent pas voir la modification.
Il faut terminer la transaction commencée */

  ROLLBACK;
	SELECT nomfou FROM fournis WHERE numfou=120;
--> Utilisateur(s) : GROBRIGAN
	COMMIT;
	SELECT nomfou FROM fournis WHERE numfou=120;
--> Utilisateur(s) : GROSBRIGAND

/* EXERCICE 1 - Pour aller plus loin */
START TRANSACTION;
  -- Mise en procedure de la commande
  DELIMITER |

  CREATE PROCEDURE v_NomFournisseur(In NomF VARCHAR (50), In NUMFOUNISS INT)
  BEGIN
    UPDATE fournis  SET nomfou= NomF WHERE numfou=NUMFOUNISS;
  END |

  DELIMITER ;
  -- Appelle de la PROCEDURE
  CALL v_NomFournisseur('Changement', 120);
  -- Je supprime la procedure la base une fois éffectué
  DROP PROCEDURE v_NomFournisseur;
COMMIT;
SELECT nomfou FROM fournis WHERE numfou=120;
-- > numfou = 120 & nomfou = 'Test'



/* EXERCICE 2 - UNCOMMITTED */
START TRANSACTION;
  DELIMITER |
    CREATE PROCEDURE v_NomFournisseur(In NomF VARCHAR (50), In NUMFOUNISS INT)
    BEGIN
      UPDATE fournis  SET nomfou= NomF WHERE numfou=NUMFOUNISS;
    END |
  DELIMITER ;

  CALL v_NomFournisseur('Changement', 120);

  DROP PROCEDURE v_NomFournisseur;
--  SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
  /* EN AUTRE UTILISATEUR */
--  SELECT nomfou FROM fournis WHERE numfou=120;
  -- > Utilisateur(s) : Changement
COMMIT;
SELECT nomfou FROM fournis WHERE numfou=120;
-- > numfou = 120 & nomfou = 'Changement'
