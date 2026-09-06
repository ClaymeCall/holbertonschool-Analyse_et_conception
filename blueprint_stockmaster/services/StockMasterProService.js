const stockMasterProRepo = require('../repositories/StockMasterProRepository');

class StockMasterProService {
  async getStock(idEmplacement, idProduit) {
    return stockMasterProRepo.getStockForEmplacement(idEmplacement, idProduit);
  }

  async scannerEntree(idEmplacement, idProduit, quantite) {
    await stockMasterProRepo.addMouvementStock('ENTREE', idEmplacement, idProduit, quantite);
    return this.getStock(idEmplacement, idProduit);
  }

  async prelever(idEmplacement, idProduit, quantite) {
    const stock = await this.getStock(idEmplacement, idProduit);
    if (quantite > stock) {
      return 'refusé';
    }
    await stockMasterProRepo.addMouvementStock('SORTIE', idEmplacement, idProduit, quantite);
    return 'accepté';
  }

  async setupTestData() {
    const produit = await stockMasterProRepo.createProduit('TestProduct');
    const emplacement = await stockMasterProRepo.createEmplacement('A1', 'R1');
    return { produit, emplacement };
  }

  async cleanTestData() {
    const client = await require('../repositories/DatabaseConnection').getClient();
    try {
      await client.query('DELETE FROM MOUVEMENT_STOCK');
      await client.query('DELETE FROM EMPLACEMENT');
      await client.query('DELETE FROM PRODUIT');
    } finally {
      client.release();
    }
  }
}

module.exports = new StockMasterProService();
