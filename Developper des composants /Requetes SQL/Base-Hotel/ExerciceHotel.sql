USE hotel;

/* LOT 1 */

/* Liste des hotels */
SELECT hot_nom AS NomHotels,
hot_ville AS Ville
FROM `hotel`;

/* Mr White */
SELECT cli_nom AS Nom,
cli_prenom AS Prenom,
cli_ville AS Ville
FROM `CLIENT`
WHERE cli_nom = "White";

/* Station > 1000m */
SELECT sta_nom AS NomStation,
sta_altitude AS Altitude
FROM `station`
WHERE sta_altitude > 1000;

/* Capacite Chambre > 1 */
SELECT cha_numero,
cha_capacite
FROM `chambre`
WHERE cha_capacite > 1;

/* N'habitant pas à Londres */
SELECT cli_nom, 
cli_ville
FROM `CLIENT`
WHERE cli_ville != "Londre";

/* A Bretou & categorie > 3 */
SELECT hot_nom, 
hot_ville, 
hot_categorie
FROM `hotel` 
WHERE hot_ville = "Bretou" 
AND hot_categorie > 3;




/* LOT 2 */

/* hotels et stations */
SELECT `station`.sta_nom, 
`hotel`.hot_nom, 
`hotel`.hot_categorie, 
`hotel`.hot_ville
FROM `hotel` 
JOIN `station` ON `hotel`.hot_sta_id = `station`.sta_id;

/* chambres et hotels */
SELECT `hotel`.hot_nom,
`hotel`.hot_categorie, 
`hotel`.hot_ville, 
`chambre`.cha_numero
FROM `hotel` 
JOIN `chambre` ON `chambre`.cha_hot_id = `hotel`.hot_id;

/* chambre > 1 place à Bretou */
SELECT `hotel`.hot_nom,
`hotel`.hot_categorie,
`hotel`.hot_ville, 
`chambre`.cha_numero, 
`chambre`.cha_capacite
FROM `chambre` 
JOIN `hotel` ON `chambre`.cha_hot_id = `hotel`.hot_id
WHERE `chambre`.cha_capacite > 1 
AND `hotel`.hot_ville = "Bretou";

/* Reservations */
SELECT `CLIENT`.cli_nom AS NomClient, 
`hotel`.hot_nom AS NomHotel,
`reservation`.res_date AS DateReservation
FROM `reservation`
JOIN `CLIENT` ON `CLIENT`.cli_id = `reservation`.res_cli_id
JOIN `chambre` ON `chambre`.cha_id = `reservation`.res_cha_id
JOIN `hotel` ON `hotel`.hot_id = `chambre`.cha_hot_id;

/* Listes des chambres par Stations et Hotels */
SELECT station.`sta_nom` AS Station, 
hotel.hot_nom AS Hotel, 
chambre.`cha_numero` AS Chambre, 
chambre.`cha_capacite`
FROM chambre 
JOIN hotel ON hotel.`hot_id` = chambre.`cha_hot_id`
JOIN station ON station.`sta_id` = hotel.`hot_sta_id`;

/* DATEDIFF( date1, date2 ) Difference entre deux dates */
SELECT `CLIENT`.`cli_nom` AS Nom, 
hotel.hot_nom AS Hotel, 
reservation.`res_date_debut` AS Debut, 
DATEDIFF(`res_date_fin`, `res_date_debut`) AS Duree
FROM reservation 
JOIN `CLIENT` ON `CLIENT`.cli_id = reservation.res_cli_id
JOIN chambre ON chambre.cha_id = reservation.res_cha_id
JOIN hotel ON hotel.hot_id = chambre.cha_hot_id;




/* LOT 3 */

/* Hotels par station */
SELECT station.`sta_nom` AS Station, 
count(hotel.`hot_id`) AS NbrHotels
FROM station 
JOIN hotel ON station.`sta_id` = hotel.`hot_sta_id`
GROUP BY station.`sta_nom`;

/* Chambre par station */
SELECT station.`sta_nom` AS Stations,
count(chambre.`cha_id`)
FROM station
JOIN hotel ON hotel.`hot_sta_id` = station.`sta_id`
JOIN chambre ON chambre.`cha_hot_id` = hotel.`hot_id`
GROUP BY station.`sta_nom`;

/* Chambre par station + capacite > 1 */
SELECT station.sta_nom AS Stations,
count(chambre.`cha_id`)
FROM station
JOIN hotel ON hotel.`hot_sta_id` = station.sta_id
JOIN chambre ON chambre.`cha_hot_id` = hotel.`hot_id`
WHERE chambre.`cha_capacite` > 1
GROUP BY station.sta_nom;

/* Mr Squire Hotels */
SELECT hotel.hot_nom AS ListeHotels
FROM hotel 
JOIN chambre ON chambre.`cha_hot_id` = hotel.`hot_id`
JOIN reservation ON reservation.`res_cha_id` = chambre.`cha_id`
JOIN `CLIENT` ON `CLIENT`.`cli_id` = `reservation`.`res_cli_id`
WHERE `CLIENT`.`cli_nom` = "Squire";

/* Reservation moyenne DUREE */
SELECT station.`sta_nom` AS Station, 
AVG(DATEDIFF(reservation.res_date_fin, reservation.res_date_debut)) AS Moyenne
FROM station 
JOIN hotel ON hotel.`hot_sta_id` = station.sta_id
JOIN chambre ON chambre.`cha_hot_id` = hotel.`hot_id`
JOIN reservation ON reservation.`res_cha_id` = chambre.`cha_id`
GROUP BY station.`sta_nom`;

