---------------------------
    /* SCHEMA TYPE */    --
---------------------------
CREATE TRIGGER nom       --
   [MOMENT] [EVENEMENT]  --
   ON [table]            --
   FOR EACH ROW          --
   BEGIN                 --
      -- [requête]       --
   END                   --
---------------------------

/**** PAPYRUS *****/
/* Delimitation pour passer l'execution du trigger */
DELIMITER |
CREATE TRIGGER trig_Fournisseur AFTER INSERT ON fournis
    -- Pour prendre en compte toutes les lignes du tableau
    FOR EACH ROW
    -- Début du trigger
    BEGIN
        -- Déclaration d'une variable en VARCHAR pour correspondre à numfou
        DECLARE NomFourni VARCHAR(15);
        -- S'il y a une nouvelle 'sta_altitude'(New.sta_altitude) -> On la passe dans la variable altitude
        SET NomFourni = NEW.nomfou;
        -- Si altitude inférieur à 1000 Alors
        IF NomFourni = 'GROS' THEN
            -- On envoie un signal une erreur et un message d'erreur
            SIGNAL SQLSTATE '40000' SET MESSAGE_TEXT = 'Ne pas insulter la DATABASE';
        END IF;
END|
DELIMITER ;

INSERT INTO `fournis` (`numfou`, `nomfou`, `ruefou`, `posfou`, `vilfou`, `confou`, `satisf`) VALUES
	(00123, 'GROS', '20 rue du papier', '92200', 'papercitys', 'Georges', 7);
  -- > Renverra Le message d'erreur avec le script papyrus
