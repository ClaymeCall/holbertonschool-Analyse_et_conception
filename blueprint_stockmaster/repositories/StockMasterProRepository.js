const db = require('./DatabaseConnection');

class StockMasterProRepository {
  async createEmplacement(allee, rayon) {
    const query = `
      INSERT INTO EMPLACEMENT (allee, rayon) 
      VALUES ($1, $2) 
      RETURNING id_emplacement, allee, rayon;
    `;
    const result = await db.query(query, [allee, rayon]);
    return result.rows[0];
  }

  async getEmplacementById(id) {
    const query = `
      SELECT id_emplacement, allee, rayon 
      FROM EMPLACEMENT 
      WHERE id_emplacement = $1;
    `;
    const result = await db.query(query, [id]);
    return result.rows[0];
  }

  async getStockForEmplacement(idEmplacement, idProduit) {
    const query = `
      SELECT COALESCE(SUM(
        CASE 
          WHEN type_mouvement = 'ENTREE' THEN quantite 
          WHEN type_mouvement = 'SORTIE' THEN -quantite 
        END
      ), 0) as stock
      FROM MOUVEMENT_STOCK 
      WHERE id_emplacement = $1 AND id_produit = $2;
    `;
    const result = await db.query(query, [idEmplacement, idProduit]);
    return parseInt(result.rows[0].stock, 10);
  }

  async addMouvementStock(type, idEmplacement, idProduit, quantite) {
    const query = `
      INSERT INTO MOUVEMENT_STOCK (type_mouvement, id_emplacement, id_produit, quantite, date_mouvement) 
      VALUES ($1, $2, $3, $4, NOW()) 
      RETURNING *;
    `;
    const result = await db.query(query, [type, idEmplacement, idProduit, quantite]);
    return result.rows[0];
  }

  async getProduitByDesignation(designation) {
    const query = `
      SELECT id_produit, designation 
      FROM PRODUIT 
      WHERE designation = $1;
    `;
    const result = await db.query(query, [designation]);
    return result.rows[0];
  }

  async createProduit(designation) {
    const query = `
      INSERT INTO PRODUIT (designation) 
      VALUES ($1) 
      RETURNING id_produit, designation;
    `;
    const result = await db.query(query, [designation]);
    return result.rows[0];
  }
}

module.exports = new StockMasterProRepository();
