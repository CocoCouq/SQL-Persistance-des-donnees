/* TRIGGER BASE PAPYRUS */
-- Création de la TABLE a comamnder
CREATE TABLE article_a_commander (
  `codart` CHAR(4),
  `date_alert` DATE,
  `qte_comm` INT,
  PRIMARY KEY (`codart`, `date_alert`),
  FOREIGN KEY (`codart`) REFERENCES produit(`codart`)
);

DELIMITER |

CREATE PROCEDURE a_comm(In Code_article INT)
  BEGIN
    -- DECLARATION DES VARIABLES
    DECLARE stk_alert INT;
    DECLARE stk_physi INT;
    DECLARE qte_a_comm INT;
    DECLARE qte_final INT;
    -- DEFINITION DES VARIABLES
    SET @stk_alert = (SELECT stkale FROM produit WHERE `codart` = Code_article);
    SET @stk_physi = (SELECT stkphy FROM produit WHERE `codart` = Code_article);
    SET @qte_a_comm = ((SELECT stkale FROM produit WHERE `codart` = Code_article) - (SELECT stkphy FROM produit WHERE `codart` = Code_article));
    -- VERIFICATION QU'IL N"Y A PAS EU DE COMMANDE
    IF (SELECT count(`codart`) FROM article_a_commander WHERE `codart` = Code_article) > 0 THEN
      SET @qte_final = (@qte_a_comm - (SELECT sum(`qte_comm`) FROM article_a_commander WHERE `codart` = Code_article));
      ELSE
        SET @qte_final = @qte_a_comm;
    END IF;
    -- SI LE STOCK ALERTE EST SUPERIEUR, j'insert le resultat 
    IF @stk_alert > @stk_physi THEN
      INSERT INTO article_a_commander(`codart`, `qte_comm`) VALUES (Code_article, @qte_final);
    END IF;
  END |

CREATE TRIGGER trig_a_commander AFTER UPDATE ON produit
  FOR EACH ROW
  BEGIN
    CALL a_comm(NEW.`codart`);
  END |
DELIMITER ;


-- VERIFICATION INSERTION
UPDATE produit SET stkphy = 10 WHERE `codart` = 'B001';
-- VERIFICATION CALCUL
UPDATE produit SET stkphy = 10 WHERE `codart` = 'B001';
