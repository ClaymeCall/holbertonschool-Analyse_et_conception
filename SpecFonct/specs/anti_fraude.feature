Feature: Gouvernance et blocage des paiements frauduleux
  En tant que Responsable de la Gouvernance Financière
  Je veux que le système évalue le niveau de risque de chaque paiement
  Afin de bloquer les transactions potentiellement frauduleuses protégeant ainsi l'entreprise

  Scenario: Validation d'un paiement standard sans risque
    Given un client standard
    And une commande d'un montant de 5000 euros à destination de la "France"
    When le client soumet son paiement
    Then le paiement est accepté par la gouvernance

  Scenario: Exemption de contrôle pour les clients VIP
    Given un client identifié comme "Client VIP"
    And une commande d'un montant de 15000 euros à destination d'un pays sous embargo
    When le client soumet son paiement
    Then le paiement est accepté par la gouvernance

  Scenario: Bloquer une transaction à haut risque depuis un pays sous embargo
    Given un client dont le pays est référencé dans le registre des embargos
    And un panier dont le montant dépasse 10 000 €
    When le client soumet son paiement
    Then le paiement est refusé par la gouvernance
    And le client est notifié du refus de transaction

  Scenario: Autoriser une transaction standard depuis un pays non sous embargo
    Given un client dont le pays n'est pas référencé dans le registre des embargos
    And un panier dont le montant dépasse 10 000 €
    When le client soumet son paiement
    Then le paiement est accepté par la gouvernance

  Scenario: Autoriser une transaction de faible montant depuis un pays sous embargo
    Given un client dont le pays est référencé dans le registre des embargos
    And un panier dont le montant est inférieur ou égal à 10 000 €
    When le client soumet son paiement
    Then le paiement est accepté par la gouvernance

  Scenario Outline: Blocage par la gouvernance selon la matrice de risque
    Given un client standard avec une commande de <montant_cmd> euros vers la <destination>
    When le client soumet son paiement
    Then le paiement est <resultat> par la gouvernance

    Examples:
      | montant_cmd | destination | resultat |
      | 5000        | France      | accepté  |
      | 10000       | France      | accepté  |
      | 10001       | France      | refusé   |
      | 5000        | Syldavie    | accepté  |
      | 10000       | Syldavie    | refusé   |
      | 10001       | Syldavie    | refusé   |
