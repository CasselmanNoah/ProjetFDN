import 'package:mysql1/mysql1.dart';
import 'base.dart';
import 'produit.dart';

// Classe Produit
class BProduit {
  // Permet de de selectionner un editeur dans la table PRODUIT
  static Future<Produit> selectProduit(int id) async {
    Produit pro = Produit.vide();
    try {
      MySqlConnection conn =
          await MySqlConnection.connect(BaseDeDonee.getSettings());
      try {
        // On prend toutes les valeur de la table EDITEUR avec comme 'ID' celui donné auparavant,
        // et s'il existe alors on donne la valeur de l'id
        String requete = "SELECT * FROM Produit WHERE id=" +
            id.toString() +
            " AND EXISTS (SELECT id FROM Produit WHERE id=" +
            id.toString() +
            " );";
        Results reponse = await conn.query(requete);
        // Puis on renvoie les valeurs correspondantes à l'id avec les valeurs en plus (type, titre, etc... ) ici
        pro = Produit(
            reponse.first['id'],
            reponse.first['type'],
            reponse.first['titre'],
            reponse.first['dispoEnStock'],
            reponse.first['dateDeParution']);
      } catch (e) {
        print(e.toString());
      }
      conn.close();
    } catch (e) {
      print(e.toString());
    }
// on retourne donc toutes les valeurs ci-dessus
    return pro;
  }

// Retourne une liste de tout les produits
  static Future<List<Produit>> selectAllProduits() async {
    List<Produit> listePro = [];
    try {
      MySqlConnection conn =
          await MySqlConnection.connect(BaseDeDonee.getSettings());
      try {
        // On selectionne toutes les valeurs de la table PRODUIT
        String requete = "SELECT * FROM Produit;";
        Results reponse = await conn.query(requete);
        for (var row in reponse) {
          // On prend donc les valeurs de chaque lignes
          Produit pro = Produit(row['id'], row['type'], row['titre'],
              row['dispoEnStock'], row['dateDeParution']);
          // On ajoute ces dernières dans une liste pour pouvoir lister tout les editeur de la table
          listePro.add(pro);

          /*
          // variante avec création d'étudiant depuis une liste
          List<String> unAut = [];
          for (var field in row) {
            unAut.add(field.toString());
          }
          listeAut.add(Etudiant.fromListString(unEtu));
          */
        }
      } catch (e) {
        print(e.toString());
      }
      conn.close();
    } catch (e) {
      print(e.toString());
    }
// On fini donc pas retourner la liste avec les produits de la table
    return listePro;
  }

// Permet d'ajouter un editeur dans la table PRODUIT
  static Future<void> insertProduit(String type, String titre,
      String dispoEnStock, String dateDeParution) async {
    // On saisie donc le nom,etc de l'editeur que l'on souhaite ajouter
    try {
      MySqlConnection conn =
          await MySqlConnection.connect(BaseDeDonee.getSettings());
      try {
        // Ensuite on l'introduit dans la table en faisant correspondre les valeurs au colonne respectives
        String requete =
            "INSERT INTO Produit (type, titre, dispoEnStock, dateDeParution) VALUES('" +
                type +
                "', '" +
                titre +
                "', '" +
                dispoEnStock +
                "', '" +
                dateDeParution +
                "');";
        await conn.query(requete);
      } catch (e) {
        print(e.toString());
      }
      conn.close();
    } catch (e) {
      print(e.toString());
    }
  }

// Permet de modifier les valeurs d'un produit
  static Future<void> updateProduit(int id, String type, String titre,
      String dispoEnStock, String dateDeParution) async {
    // On donne dans ce cas les futurs valeurs
    try {
      MySqlConnection conn =
          await MySqlConnection.connect(BaseDeDonee.getSettings());
      try {
        // Ensuite avec un UPDATE, on indique les nouvelles valeurs saisie juste avant
        String requete = "UPDATE Produit SET type = '" +
            type +
            ", titre = '" +
            titre +
            ", dispoEnStock = '" +
            dispoEnStock +
            ", dateDeParution = '" +
            dateDeParution +
            ", ' WHERE id='" +
            id.toString() +
            "'";
        await conn.query(requete);
      } catch (e) {
        print(e.toString());
      }
      conn.close();
    } catch (e) {
      print(e.toString());
    }
  }

  // Permet de supprimer un produit selon un 'ID' donné
  static Future<void> deleteProduit(int id) async {
    try {
      MySqlConnection conn =
          await MySqlConnection.connect(BaseDeDonee.getSettings());
      try {
        // On suprimme donc de la table PRODUIT à l'ID donné, toutes les valeurs,
        // dont l'ID
        String requete = "DELETE FROM Produit WHERE id='" + id.toString() + "'";
        await conn.query(requete);
      } catch (e) {
        print(e.toString());
      }
      conn.close();
    } catch (e) {
      print(e.toString());
    }
  }

  // Cette méthode est la même que celle du dessus en plus poussée,
  // cette prochaine va permettre de supprimer toutes les valeurs de la table PRODUIT
  static Future<void> deleteAllProduit() async {
    try {
      MySqlConnection conn =
          await MySqlConnection.connect(BaseDeDonee.getSettings());
      try {
        // Cette prochaine requête va permettre cela
        String requete = "TRUNCATE TABLE Produit;";
        await conn.query(requete);
      } catch (e) {
        print(e.toString());
      }
      conn.close();
    } catch (e) {
      print(e.toString());
    }
  }

  // verifie l'existance d'un produit selon son ID
  static Future<bool> exist(int id) async {
    bool exist = false;
    // Si l'id donné est différent de zéro alors il n'est pas null
    if (!(await BProduit.selectProduit(id)).estNull()) {
      exist = true;
    }
    return exist;
  }

  // Permet de retourner les valeurs d'un auteur selon un id donné
  static Future<Produit> getProduit(int id) async {
    dynamic r = await selectProduit(id);
    ResultRow rr = r.first;
    return Produit(rr['id'], rr['type'], rr['titre'], rr['dispoEnStock'],
        rr['dateDeParution']);
  }
}
