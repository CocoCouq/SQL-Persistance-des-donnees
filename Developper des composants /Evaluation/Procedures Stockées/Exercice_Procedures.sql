/* BASE NORTHWIND */

/* I - Dernière commande d'un fournisseur */
-- Changement de DELIMITER pour passer la procedure
DELIMITER |
-- Creation de la PROCEDURE lastOrder
CREATE PROCEDURE lastOrder(IN NameFournisseur VARCHAR(40))
  -- Debut de la PROCEDURE
  BEGIN
    SELECT orders.`OrderDate` AS 'Date Dernière Commande'
    FROM orders
    JOIN customers ON customers.`CustomerID` = orders.`CustomerID`
    WHERE customers.`CompanyName` = NameFournisseur
    ORDER BY orders.`OrderDate` DESC
    LIMIT 1;
  -- Fin de la PROCEDURE
  END |
-- Application de DELIMITER initial
DELIMITER ;
-- Appelle de lastOrder pour le fournisseur 'Du monde entier'
CALL lastOrder('Du monde entier');

--------------------------------------------------------------------------------

/* II - Délais moyen de livraison */
DELIMITER |

CREATE PROCEDURE DelaisMoyen()
  BEGIN
    -- SUBSTRING_INDEX : Sépare le '1' '.'(le premier point)
    SELECT(SUBSTRING_INDEX((AVG(DATEDIFF(orders.`ShippedDate`, orders.`OrderDate`))), '.', 1))
	  AS 'Delais Moyen'
		FROM orders;
  END |

DELIMITER ;

CALL DelaisMoyen();

--------------------------------------------------------------------------------

/* III - Délais moyen de livraison par fournisseur */
DELIMITER |

CREATE PROCEDURE DelaisMoyenFour(In NameFournis VARCHAR(40))
  BEGIN
    SELECT(SUBSTRING_INDEX((AVG(DATEDIFF(orders.`ShippedDate`, orders.`OrderDate`))), '.', 1)) AS 'Delais Moyen',
    customers.`CompanyName` AS Fournisseur
    FROM orders
    JOIN customers ON customers.`CustomerID` = orders.`CustomerID`
    WHERE customers.`CompanyName` = NameFournis;
  END |

DELIMITER ;

CALL DelaisMoyenFour('Du monde entier');
