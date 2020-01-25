/* BASE NORTHWIND */

/* Pour tenir compte des coûts liés au transport, on vérifiera
que pour chaque produit d’une commande, le client réside dans
le même pays que le fournisseur du même produit */

DELIMITER |

-- Procedure de Suppression des Produits livrés dans d'autres pays
CREATE PROCEDURE DeleteEcolo()
  BEGIN
    DELETE `order details` FROM `order details`
    JOIN orders ON `order details`.`OrderID` = orders.`OrderID`
    JOIN products ON products.`ProductID` = `order details`.`ProductID`
    JOIN suppliers ON products.`SupplierID` = suppliers.`SupplierID`
    WHERE (orders.`ShipCountry` != suppliers.`Country`);
  END |

DELIMITER ;
-- Appelle de DeleteEcolo()
CALL DeleteEcolo();

DELIMITER |
-- Procedure De vérification des deux pays (Fournisseur et Client)
-- Permet d'avoir ensuite NEW.OrderID & NEW.ProductID en parametre dans le trigger
CREATE PROCEDURE InformCom(In CommID INT, In ProdID INT)
  BEGIN
    -- Declaration des Pays du fournisseur et du client
    DECLARE var_SupplCountry VARCHAR(15);
    DECLARE var_CustCountry VARCHAR(15);
    -- Recupération du pays de Suppliers (SELECT DISTINCT pour ne pas avoir une ligne pour chaque commande du meme produit)
    SET @var_SupplCountry = (SELECT DISTINCT suppliers.`Country` FROM products
                             JOIN suppliers ON products.`SupplierID` = suppliers.`SupplierID`
                             WHERE products.`ProductID` = ProdID);
    -- Recupération du pays de Customers
    SET @var_CustCountry = (SELECT DISTINCT orders.`ShipCountry` FROM orders
                            JOIN `order details` ON orders.`OrderID` = `order details`.`OrderID`
                            WHERE `order details`.`OrderID` = CommID);
    -- S'ils sont différents
    IF (@var_CustCountry) != (@var_SupplCountry) THEN
      SIGNAL SQLSTATE '40000' SET MESSAGE_TEXT = 'Impossible, merci de respecter l\'environnement';
    END IF;
  END|

-- TRIGGER avec appelle de la procedure pour récupérer les pays de NEW.ProductID et NEW.OrderID
  CREATE TRIGGER insert_Comm AFTER INSERT ON `order details`
    FOR EACH ROW
    BEGIN
      CALL InformCom(NEW.`OrderID`, NEW.`ProductID`);
    END |
-- CREATE TRIGGER AFTER UPDATE pour éviter de modifier les infos après insertion  
  CREATE TRIGGER update_Comm AFTER UPDATE ON `order details`
    FOR EACH ROW
    BEGIN
      CALL InformCom(NEW.`OrderID`, NEW.`ProductID`);
    END |
DELIMITER ;

/* INSERT */
  -- AUTRE PAYS
  INSERT INTO `order details` (`OrderID`, `ProductID`, `UnitPrice`, `Quantity`, `Discount`) VALUES
  	(10248, 11, 14.0000, 12, 0);
  -- MEME PAYS
  INSERT INTO `order details` (`OrderID`, `ProductID`, `UnitPrice`, `Quantity`, `Discount`) VALUES
  	(10248, 60, 34.8000, 5, 0);
/* UPDATE */
  -- Modification par un produit d'un autre pays
  UPDATE `order details` SET `ProductID` = 11
  WHERE `OrderID` = 10248
  AND `ProductID` = 60;
  -- Modification de la quantité pour meme pays
  UPDATE `order details` SET `Quantity` = 1
  WHERE `OrderID` = 10248
  AND `ProductID` = 60;
