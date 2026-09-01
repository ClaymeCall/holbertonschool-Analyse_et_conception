-- Script d'initialisation de la base MegaShop-B2B
-- Auteur : [ClemCall]

BEGIN;

DROP TABLE IF EXISTS LIGNE_COMMANDE CASCADE;
DROP TABLE IF EXISTS PRODUIT CASCADE;
DROP TABLE IF EXISTS COMMANDE CASCADE;
DROP TABLE IF EXISTS CLIENT CASCADE;

CREATE TABLE CLIENT (
  id_client UUID PRIMARY KEY,
  nom VARCHAR(64) NOT NULL,
  adresse VARCHAR(255) NOT NULL
);

CREATE TABLE COMMANDE (
  id_commande UUID PRIMARY KEY,
  id_client UUID NOT NULL,
  FOREIGN KEY (id_client) REFERENCES CLIENT(id_client),
  date_achat DATE NOT NULL,
  statut VARCHAR(16) NOT NULL CHECK(statut IN ('LIVREE', 'EN_COURS'))
);

CREATE TABLE PRODUIT (
  code_prod VARCHAR(20) PRIMARY KEY,
  designation VARCHAR(128) NOT NULL,
  prix_unitaire_ht DECIMAL(10,2) NOT NULL CHECK (prix_unitaire_ht > 0)
);

CREATE TABLE LIGNE_COMMANDE (
  id_commande UUID,
  code_prod VARCHAR(20),
  FOREIGN KEY (id_commande) REFERENCES COMMANDE(id_commande),
  FOREIGN KEY (code_prod) REFERENCES PRODUIT(code_prod),
  quantite INT NOT NULL CHECK (quantite > 0),
  PRIMARY KEY (id_commande, code_prod)
);

COMMIT;

