-- Script d'initialisation de la base MegaShop-B2B
-- Auteur : [ClemCall]

BEGIN;

DROP TABLE IF EXISTS MOVEMENT_STOCK CASCADE;
DROP TABLE IF EXISTS EMPLACEMENT CASCADE;
DROP TABLE IF EXISTS PRODUIT CASCADE;

CREATE EXTENSION IF NOT EXISTS pgcrypto;

CREATE TABLE PRODUIT (
  id_produit UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  designation VARCHAR(64) NOT NULL
);

CREATE TABLE EMPLACEMENT (
  id_emplacement UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  allee VARCHAR(16) NOT NULL,
  rayon VARCHAR(16) NOT NULL
);

CREATE TABLE MOUVEMENT_STOCK (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  type_mouvement VARCHAR(16) NOT NULL CHECK (type_mouvement IN('ENTREE', 'SORTIE')),
  id_emplacement UUID NOT NULL,
  id_produit UUID NOT NULL,
  FOREIGN KEY (id_emplacement) REFERENCES EMPLACEMENT(id_emplacement),
  FOREIGN KEY (id_produit) REFERENCES PRODUIT(id_produit),
  quantite INT NOT NULL CHECK (quantite > 0),
  date_mouvement TIMESTAMP NOT NULL
);

COMMIT;

