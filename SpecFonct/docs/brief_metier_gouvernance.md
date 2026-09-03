# Brief : Système Anti-Fraude (Brouillon du client)

Salut l'équipe technique,

Nous avons un gros problème de fraude. Je veux qu'on ajoute un contrôle au moment du paiement.
Si le montant du panier dépasse 10 000 euros, le système doit faire une requête SQL (SELECT * FROM blacklist_pays) pour vérifier l'adresse IP du client.
Si le pays est sur la liste noire (ex: "Syldavie", "Bordurie"), l'API doit renvoyer une erreur 403 et l'écran du front-end doit afficher une popup rouge (div class="alert-danger") avec écrit "Transaction bloquée pour suspicion de fraude".
Aussi, si le client est un "Client VIP", on s'en fiche du pays et du montant, on valide toujours.

Merci de coder ça vite.

## Reformulation

### Règles métier identifiées
- **Règle 1** : L'évaluation du risque croisant le montant de 10 000€ et le pays.
- **Règle 2** : Le passe-droit du statut VIP.

### User Story (US) principale
En tant que **client**, je veux que ma transaction soit évaluée selon les règles anti-fraude afin de **protéger mes intérêts et ceux du marchand contre les fraudes**. 

### Critères d'Acceptation
1. Si le montant du panier dépasse 10 000€, le pays de livraison est évalué selon le registre des embargos.
2. Si le pays est sur la liste noire, le client est notifié du refus de transaction.
3. Si le client a le statut VIP, la transaction est validée automatiquement, indépendamment du montant ou du pays.
