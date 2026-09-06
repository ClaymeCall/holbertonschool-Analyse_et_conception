Feature: Traçabilité et sécurisation des mouvements d'inventaire.
  En tant que Responsable Logistique
  Je veux que le système évalue l'état actuel des stocks
  Afin d'empêcher de prélever plus de produits qu'il y en a dans un emplacement.

  Scenario: Réception de produits augmentant le stock
    Given un emplacement avec un stock de 5 produits
    When un opérateur scanne 7 produits en entrée
    Then le stock passe à 12 produits pour cet emplacement.

  Scenario Outline: Validation des prélèvements selon le stock disponible
    Given un emplacement avec un stock de <stock> produits
    When un opérateur tente de prélever <quantité> produits
    Then le mouvement est <resultat>

    Examples:
      | stock | quantité | resultat |
      | 10    | 7        | accepté  |
      | 10    | 10       | accepté  |
      | 10    | 11       | refusé   |
