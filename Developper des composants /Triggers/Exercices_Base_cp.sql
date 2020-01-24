/* TRIGGER sur la Base 'cp' */

/* EXERCICE 1 - Mettez en place le trigger, puis ajoutez un produit
dans une commande, vérifiez que le champ total est bien mis à jour. */
-- ATTENTION PEUT NE PAS MARCHER AVEC LES COMMENTAIRES */
-- Création du trigger après un ajout dans lignedecommande
DELIMITER |
CREATE TRIGGER maj_total AFTER INSERT ON lignedecommande
    FOR EACH ROW
    BEGIN
        -- DECLARATION de id_c & tot
        DECLARE id_c INT;
        DECLARE tot DOUBLE;
        -- id_c = Numero de commande (récupération)
        SET @id_c = NEW.id_commande;
        -- tot = SOMME du prix par article en fonction de la quantité
        -- QUAND id_commande = id_c (numero de la commande récupérée)
        SET @tot = (SELECT sum(prix*quantite) FROM lignedecommande WHERE id_commande=@id_c);
        -- Après le recalcul, on stock le nouveau total dans la table commande
        -- pour l'id de la commande concernée
        UPDATE commande SET total=@tot WHERE id=@id_c;
    END|
DELIMITER ;
-- J'insère les valeurs
INSERT INTO lignedecommande(id_commande, id_produit, quantite, prix) VALUES
(1, 1, 10, 6700);
-- > L'insertion à bin lieu dans ligne de commande et dans total
INSERT INTO lignedecommande(id_commande, id_produit, quantite, prix) VALUES
(1, 1, 5, 6700);
-- > Il y a bien un ajout à total de commande et non un remplacement
-- > On prend dans notre UPDATE du TRIGGER toutes les valeurs pour un seul id de commande

--------------------------------------------------------------------------------

/* EXERCICE 2 - Ce trigger ne fonctionne que lorsque l'on ajoute
des produits dans la commande, les modifications ou suppressions
ne permettent pas de recalculer le total. Modifiez le code ci-dessus
pour faire en sorte que la modification ou la suppression de produit
recalcul le total de la commande. */

DELIMITER |
-- PROCEDURE stockée Mise à jour du total
CREATE PROCEDURE MiseAJTot(IN id_c INT)
	BEGIN
        DECLARE tot DOUBLE;
        SET @tot = (SELECT sum(prix*quantite) FROM lignedecommande WHERE id_commande=@id_c);
        UPDATE commande SET total=@tot WHERE id=@id_c;
  END |
-- TRIGGER INSERT
CREATE TRIGGER maj_totalIns AFTER INSERT ON lignedecommande
    FOR EACH ROW
    BEGIN
       CALL MiseAJTot(New.`id_commande`);
	  END|
-- TRIGGER DELETE (Pas de New.nom_valeur dans un DELETE)
CREATE TRIGGER maj_totalDel AFTER DELETE ON lignedecommande
    FOR EACH ROW
    BEGIN
       CALL MiseAJTot(`id_commande`);
	  END|
-- TRIGGER UPDATE
CREATE TRIGGER maj_totalUpd AFTER UPDATE ON lignedecommande
    FOR EACH ROW
    BEGIN
       CALL MiseAJTot(New.`id_commande`);
	  END|
DELIMITER ;

-- VARIFICATIONS
INSERT INTO lignedecommande(id_commande, id_produit, quantite, prix) VALUES
(1, 1, 10, 6700);
UPDATE lignedecommande SET `quantite` = 1 WHERE `id_commande` = 1;
DELETE FROM lignedecommande WHERE `id_commande` = 1 AND `id_produit` = 1;

--------------------------------------------------------------------------------

/* EXERCICE 3 - Un champ remise était prévu dans la table commande.
Prenez en compte ce champ dans le code de votre trigger. */

CREATE PROCEDURE MiseAJTot(IN id_c INT)
	BEGIN
        DECLARE tot DOUBLE;
        -- Déclaration & Recuperation de la remise  
        DECLARE remTot FLOAT;
        SET @remTot = (SELECT remise FROM commande WHERE id = @id_c);

        SET @tot = (SELECT sum(prix*quantite) FROM lignedecommande WHERE id_commande=@id_c);
        -- Mise en application de la remise
        SET @tot = @tot - @tot * ((100 - @remTot)/100);
        UPDATE commande SET total=@tot WHERE id=@id_c;
  END |
-- TRIGGER INSERT
CREATE TRIGGER maj_totalIns AFTER INSERT ON lignedecommande
    FOR EACH ROW
    BEGIN
       CALL MiseAJTot(New.`id_commande`);
	  END|
-- TRIGGER DELETE
CREATE TRIGGER maj_totalDel AFTER DELETE ON lignedecommande
    FOR EACH ROW
    BEGIN
       CALL MiseAJTot(`id_commande`);
	  END|
-- TRIGGER UPDATE
CREATE TRIGGER maj_totalUpd AFTER UPDATE ON lignedecommande
    FOR EACH ROW
    BEGIN
       CALL MiseAJTot(New.`id_commande`);
	  END|
DELIMITER ;

-- VARIFICATIONS
INSERT INTO lignedecommande(id_commande, id_produit, quantite, prix) VALUES
(1, 1, 10, 6700);
UPDATE lignedecommande SET `quantite` = 1 WHERE `id_commande` = 1;
DELETE FROM lignedecommande WHERE `id_commande` = 1 AND `id_produit` = 1;
