# Résultats des tests pour `init_database.sql`

## 1. Exécution initiale
**Commande :**
```bash
docker exec megashop-db psql -U postgres -d megashop -f /docker-entrypoint-initdb.d/init_database.sql
```
**Résultat :**
```
BEGIN
DROP TABLE
DROP TABLE
DROP TABLE
DROP TABLE
CREATE TABLE
CREATE TABLE
CREATE TABLE
CREATE TABLE
COMMIT
```
✅ **Validé** : Le script s'exécute de bout en bout sans erreur.

---

## 2. Test d'idempotence
**Commande :**
```bash
docker exec megashop-db psql -U postgres -d megashop -f /docker-entrypoint-initdb.d/init_database.sql
```
**Résultat :**
```
BEGIN
DROP TABLE
DROP TABLE
DROP TABLE
DROP TABLE
CREATE TABLE
CREATE TABLE
CREATE TABLE
CREATE TABLE
COMMIT
```
✅ **Validé** : Le script s'exécute une deuxième fois sans erreur (les `DROP TABLE IF EXISTS` fonctionnent correctement).

---

## 3. Test de la 3NF (Table `ligne_commande`)
**Commande :**
```bash
docker exec megashop-db psql -U postgres -d megashop -c "\d LIGNE_COMMANDE"
```
**Résultat :**
```
             Table "public.ligne_commande"
   Column    |         Type          | Collation | Nullable | Default 
-------------+-----------------------+-----------+----------+---------
 id_commande | uuid                  |           | not null | 
 code_prod   | character varying(20) |           | not null | 
 quantite    | integer               |           | not null | 
```
✅ **Validé** : La table ne contient **aucune colonne de calcul de total** et **aucune information textuelle sur le produit** (seulement `code_prod` et `quantite`).

---

## 4. Test de robustesse (Contrainte `CHECK`)
**Commande :**
```bash
docker exec megashop-db psql -U postgres -d megashop -c "INSERT INTO produit (code_prod, designation, prix_unitaire_ht) VALUES ('P-99', 'Gomme', -5.00);"
```
**Résultat :**
```
ERROR:  new row for relation "produit" violates check constraint "produit_prix_unitaire_ht_check"
DETAIL:  Failing row contains (P-99, Gomme, -5.00).
```
✅ **Validé** : Le SGBD rejette l'insertion avec un prix négatif en mentionnant explicitement la violation de la contrainte `CHECK`.

---

## Conclusion
Tous les **4 tests** ont été validés avec succès. Le script `init_database.sql` respecte :
- L'**idempotence** (exécution multiple sans erreur).
- La **3NF** (pas de redondance ou de dépendance transitive dans `ligne_commande`).
- La **robustesse** (contraintes `CHECK` appliquées).