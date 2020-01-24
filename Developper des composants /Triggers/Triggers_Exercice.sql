/* Exercice Base cp */

-- 1 : interdire la modification des réservations (on autorise l'ajout et la suppression).
-- Changement de DELIMITER pour ne pas stopper après '[...]les reservations';
DELIMITER |
  -- Avant que reservation ne soit modifier
  CREATE TRIGGER modif_reservation BEFORE UPDATE ON reservation
    FOR EACH ROW
    BEGIN
      -- Pour toutes les modifications, j'envoie un signal
      SIGNAL SQLSTATE '40000' SET MESSAGE_TEXT = 'Il est impossible de modifier les reservations';
    END|
DELIMITER ;

UPDATE reservation SET res_prix = 4.2 WHERE res_id = 1;
-- > Revenvoie le message 'Il est impossible de modifier les reservations'

--------------------------------------------------------------------------------
/* A FINIR */
-- 2 : interdire l'ajout de réservation pour les hôtels possédant déjà 10 réservations.
DELIMITER |
  CREATE PROCEDURE ResaHotelMAX(IN NbrResa INT)
    BEGIN
      IF 10 <  (SELECT count(reservation.res_id)
			   FROM reservation
			   JOIN chambre ON reservation.res_cha_id = chambre.cha_id
			   WHERE chambre.cha_hot_id = NbrResa)
	    THEN
    	   SIGNAL SQLSTATE '40000' SET MESSAGE_TEXT = 'Trop de réservation pour l\'hotel';
  	  END IF;
    END |
DELIMITER ;
/* Trigger */
DELIMITER |
  CREATE TRIGGER insert_reservation2 AFTER INSERT ON reservation
    FOR EACH ROW
    BEGIN
  CALL ResaHotelMAX(1);
END |
DELIMITER ;

INSERT INTO reservation (res_cha_id, res_cli_id, res_date, res_date_debut, res_date_fin, res_prix, res_arrhes)VALUES
(1, 1, '2017-01-10', '2017-07-01', '2017-07-15', 220, 700),
(1, 1, '2017-01-10', '2017-07-01', '2017-07-15', 220, 700),
(1, 2, '2017-01-10', '2017-07-01', '2017-07-15', 220, 700);

--------------------------------------------------------------------------------

-- 3 : interdire les réservations si le client possède déjà 3 réservations.
/* Procedure Stocké */
DELIMITER |
  CREATE PROCEDURE ThreeResa(IN NumeroCli INT)
    BEGIN
      IF 3 < (SELECT count(res_cli_id) FROM reservation WHERE res_cli_id = NumeroCli) THEN
    	   SIGNAL SQLSTATE '40000' SET MESSAGE_TEXT = 'Déjà 3 réservations';
  	  END IF;
    END |
DELIMITER ;
/* Trigger */
DELIMITER |
  CREATE TRIGGER insert_reservation2 AFTER INSERT ON reservation
    FOR EACH ROW
    BEGIN
      CALL ThreeResa(1);
    END |
DELIMITER ;

INSERT INTO reservation (res_cha_id, res_cli_id, res_date, res_date_debut, res_date_fin, res_prix, res_arrhes)
VALUES (10, 1, '2017-01-10', '2017-07-01', '2017-07-15', 220, 700);
-- > Renvie : 'Déjà 3 reservations'

--------------------------------------------------------------------------------

-- 4 : lors d'une insertion, on calcule le total des capacités des
-- chambres pour l'hôtel, si ce total est supérieur à 50, on interdit l'insertion de la chambre.
DELIMITER |
  CREATE PROCEDURE Capacite_max (IN NumeroFou INT)
  BEGIN
    IF 50 < (SELECT sum(cha_capacite) FROM chambre WHERE cha_hot_id = NumeroFou) THEN
    	 SIGNAL SQLSTATE '40000' SET MESSAGE_TEXT = 'Capacité max dépassée';
  	END IF;
  END |
DELIMITER ;
/* Trigger */
DELIMITER |
  CREATE TRIGGER insert_chambre AFTER INSERT ON chambre
  FOR EACH ROW
  BEGIN
    CALL Capacite_max(7);
  END |
DELIMITER ;

INSERT INTO chambre (cha_numero, cha_hot_id, cha_capacite, cha_type) VALUES (210, 7, 10, 1);
