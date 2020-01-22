USE hotel;

/* Insert 3 stations */
DELETE FROM station;

INSERT INTO station(station_num, station_nom)
VALUE (1, 'Les deux Plâtres');

INSERT INTO station(station_nom)
VALUE ('ALAFPA 2000');

INSERT INTO station(station_nom)
VALUE ('Charge Onix');


/* Insert 9 hotels */
DELETE FROM hotel; 

INSERT INTO hotel(hotel_num, hotel_capacit, hotel_categ, hotel_nom, hotel_adress, station_num)
VALUE (1, 250, 3, 'HotelO', '10 rue des Points Blancs', 1);

INSERT INTO hotel( hotel_capacit, hotel_categ, hotel_nom, hotel_adress, station_num)
VALUE (40, 4, 'Hoteléphone', '158 avenue du Réseau', 1);

INSERT INTO hotel( hotel_capacit, hotel_categ, hotel_nom, hotel_adress, station_num)
VALUE (24, 1, 'BofTel', '12 impasse Patop', 1);

INSERT INTO hotel( hotel_capacit, hotel_categ, hotel_nom, hotel_adress, station_num)
VALUE (600, 4, 'Hotel Mecontrole', '8 de Savoie', 2);

INSERT INTO hotel( hotel_capacit, hotel_categ, hotel_nom, hotel_adress, station_num)
VALUE (25, 3, 'Hotel Egraphe', '987 boulevard du Générale Morce', 2);

INSERT INTO hotel( hotel_capacit, hotel_categ, hotel_nom, hotel_adress, station_num)
VALUE (60, 2, 'ASkyp', '158 rue Delarue', 2);

INSERT INTO hotel( hotel_capacit, hotel_categ, hotel_nom, hotel_adress, station_num)
VALUE (52, 4, 'Hôtes et Elles', '1 avnue Pasloin', 3);

INSERT INTO hotel( hotel_capacit, hotel_categ, hotel_nom, hotel_adress, station_num)
VALUE (40, 2, 'AutresAiles', '52 boulevard des Fauxcon', 3);

INSERT INTO hotel( hotel_capacit, hotel_categ, hotel_nom, hotel_adress, station_num)
VALUE (100, 1, 'Otel', '1 rue de la Maison', 3);

/* Insert 27 chambres */

DELETE FROM chambre; 

INSERT INTO chambre(chamb_capacit, chamb_confort, chamb_expos, chamb_type, hotel_num) VALUE 
(4, 6, 2, 2, 1), 
(2, 6, 2, 1, 1),
(5, 7, 2, 3, 1),
(4, 8, 2, 2, 2),
(4, 8, 2, 2, 2),
(4, 9, 2, 2, 2),
(4, 2, 2, 1, 3),
(2, 2, 2, 2, 3),
(4, 3, 2, 3, 3),
(4, 8, 2, 1, 4),
(2, 7, 2, 2, 4),
(4, 9, 2, 3, 4),
(4, 6, 2, 2, 5),
(3, 7, 2, 2, 5),
(4, 8, 2, 2, 5),
(4, 6, 2, 2, 6),
(3, 5, 2, 2, 6),
(4, 5, 2, 3, 6),
(2, 9, 2, 2, 7),
(4, 9, 2, 2, 7),
(6, 9, 2, 1, 7),
(4, 6, 2, 1, 8),
(4, 5, 2, 1, 8),
(2, 4, 2, 2, 8),
(2, 2, 2, 3, 9),
(4, 2, 2, 1, 9),
(2, 1, 2, 2, 9);
