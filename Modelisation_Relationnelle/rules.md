# Methodologie

## Entités

- Clients
- Commandes
- Produits

## Règles de gestion

- Un **Client** place **0..n Commandes**
- Une **Commande** contient **1..n Produits**
- Une **Commande** est associée à **1 Client** (obligatoire)
- Un **Produit** apparaît dans **0..n Commandes**
- Le **total_ligne** est calculé (quantité × prix_unitaire_ht) et n'est pas une entité
- Une **Commande** a un **statut** parmi [LIVREE, EN_COURS]

## Cardinalités min/max

### Client

- Un **Client** peut exister sans **Commande** (0..n) ni **Produit**

### Commande

- Une **Commande** ne peut exister sans **Client** (1..1) ni **Produit** (1..n)
- Une **Commande** a **1 et 1 seul Client**

### Produit

- Un **Produit** peut exister sans **Commande** (0..n) ni **Client**
- Un **Produit** peut être référencé dans **0 ou plusieurs Commandes**
