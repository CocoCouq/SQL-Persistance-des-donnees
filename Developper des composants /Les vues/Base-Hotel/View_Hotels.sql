USE hotel;

-- EXERCICE 1
/* 1 - Hotels par Station - CREATE VIEW */
DROP VIEW IF EXISTS v_hotelStation;

CREATE VIEW v_hotelStation
AS
SELECT hotel.`hot_nom` AS Hotels,
station.`sta_nom`
FROM hotel
JOIN station ON station.`sta_id` = hotel.`hot_sta_id`;

-- Affichage
SELECT * FROM v_hotelStation;

-- EXERCICE 2
/* 2 - Liste des chambres et leurs hotels */
DROP VIEW IF EXISTS v_chambreHotel;

CREATE VIEW v_chambreHotel
AS
SELECT  chambre.`cha_numero` AS Chambres,
hotel.`hot_nom` AS Hotels
FROM chambre
JOIN hotel ON hotel.`hot_id` = chambre.`cha_hot_id`;

SELECT * FROM v_chambreHotel;

-- EXERCICE 3
/* 3 - Liste Reservations et nom clients */
DROP VIEW IF EXISTS v_ResaClients;

CREATE VIEW v_ResaClients
AS
SELECT reservation.`res_id` AS Reservations,
`CLIENT`.`cli_nom` AS Clients
FROM `CLIENT`
JOIN reservation ON `CLIENT`.`cli_id` = reservation.`res_cli_id`;

SELECT * FROM v_ResaClients;

-- EXERCICE 4
/* 4 - Liste des chambres avec Hotel et Station */
DROP VIEW IF EXISTS v_ChambreHotelStation;

CREATE VIEW v_ChambreHotelStation
AS
SELECT chambre.`cha_numero` AS Chambres,
hotel.`hot_nom` AS Hotels,
station.`sta_nom` as Stations
FROM chambre
JOIN hotel ON hotel.`hot_id` = chambre.`cha_hot_id`
JOIN station ON hotel.`hot_sta_id` = station.`sta_id`;

SELECT * FROM v_ChambreHotelStation;

-- EXERCICE 5
/* 5 - Reservation avec Nom client et nom de l'hotel */
DROP VIEW IF EXISTS v_ResClientHotel;

CREATE VIEW v_ResClientHotel
AS
SELECT reservation.res_id AS Reservations,
`CLIENT`.`cli_nom` AS Nom,
hotel.`hot_nom` AS Hotels
FROM reservation
JOIN `CLIENT` ON `CLIENT`.`cli_id` = reservation.`res_cli_id`
JOIN chambre ON chambre.`cha_id` = reservation.`res_cha_id`
JOIN hotel ON hotel.`hot_id` = chambre.`cha_hot_id`;

SELECT * FROM v_ResClientHotel;
