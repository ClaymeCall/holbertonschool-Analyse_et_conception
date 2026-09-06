const { Given, When, Then, Before, After } = require('@cucumber/cucumber');
const stockMasterProService = require('../services/StockMasterProService');

Before(async function () {
  await stockMasterProService.cleanTestData();
});

After(async function () {
  await stockMasterProService.cleanTestData();
});

Given('un emplacement avec un stock de {int} produits', async function (stock) {
  const { produit, emplacement } = await stockMasterProService.setupTestData();
  this.produit = produit;
  this.emplacement = emplacement;
  
  if (stock > 0) {
    await stockMasterProService.scannerEntree(emplacement.id_emplacement, produit.id_produit, stock);
  }
});

When('un opérateur scanne {int} produits en entrée', async function (quantite) {
  this.newStock = await stockMasterProService.scannerEntree(
    this.emplacement.id_emplacement,
    this.produit.id_produit,
    quantite
  );
});

When('un opérateur tente de prélever {int} produits', async function (quantite) {
  this.resultat = await stockMasterProService.prelever(
    this.emplacement.id_emplacement,
    this.produit.id_produit,
    quantite
  );
});

Then('le stock passe à {int} produits pour cet emplacement\.', async function (expectedStock) {
  const currentStock = await stockMasterProService.getStock(
    this.emplacement.id_emplacement,
    this.produit.id_produit
  );
  if (currentStock !== expectedStock) {
    throw new Error(`Expected stock to be ${expectedStock}, but got ${currentStock}`);
  }
});

Then('le mouvement est {word}', function (resultat) {
  if (this.resultat !== resultat) {
    throw new Error(`Expected mouvement to be ${resultat}, but got ${this.resultat}`);
  }
});
