import 'package:mysql1/mysql1.dart';
import 'base.dart';
import 'editeur.dart';

// Classe Editeur
class BEditeur {
  // Permet de de selectionner un editeur dans la table EDITEUR
  static Future<Editeur> selectEditeur(int id) async {
    Editeur edi = Editeur.vide();
    try {
      MySqlConnection conn =
          await MySqlConnection.connect(BaseDeDonee.getSettings());
      try {
        // On prend toutes les valeur de la table EDITEUR avec comme 'ID' celui donné auparavant,
        // et s'il existe alors on donne la valeur de l'id
        String requete = "SELECT * FROM Editeur WHERE id=" +
            id.toString() +
            " AND EXISTS (SELECT id FROM Editeur WHERE id=" +
            id.toString() +
            " );";
        Results reponse = await conn.query(requete);
        // Puis on renvoie les valeurs correspondantes à l'id avec les valeurs en plus (nom, prénom, et adresse ) ici
        edi = Editeur(reponse.first['id'], reponse.first['nomEditeur'],
            reponse.first['prenomEditeur'], reponse.first['adresseEditeur']);
      } catch (e) {
        print(e.toString());
      }
      conn.close();
    } catch (e) {
      print(e.toString());
    }
// on retourne donc toutes les valeurs ci-dessus
    return edi;
  }

// Retourne une liste de tout les editeurs
  static Future<List<Editeur>> selectAllEditeurs() async {
    List<Editeur> listeEdi = [];
    try {
      MySqlConnection conn =
          await MySqlConnection.connect(BaseDeDonee.getSettings());
      try {
        // On selectionne toutes les valeurs de la table EDITEUR
        String requete = "SELECT * FROM Editeur;";
        Results reponse = await conn.query(requete);
        for (var row in reponse) {
          // On prend donc les valeurs de chaque lignes
          Editeur edi = Editeur(row['id'], row['nomEditeur'],
              row['prenomEditeur'], row['adresseEditeur']);
          // On ajoute ces dernières dans une liste pour pouvoir lister tout les editeur de la table
          listeEdi.add(edi);

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
// On fini donc pas retourner la liste avec les editeurs de la table
    return listeEdi;
  }

// Permet d'ajouter un editeur dans la table EDITEUR
  static Future<void> insertEditeur(
      String nomEditeur, String prenomEditeur, String adresseEditeur) async {
    // On saisie donc le nom,etc de l'editeur que l'on souhaite ajouter
    try {
      MySqlConnection conn =
          await MySqlConnection.connect(BaseDeDonee.getSettings());
      try {
        // Ensuite on l'introduit dans la table en faisant correspondre les valeurs au colonne respectives
        String requete =
            "INSERT INTO Editeur (nomEditeur, prenomEditeur, adresseEditeur) VALUES('" +
                nomEditeur +
                "', '" +
                prenomEditeur +
                "', '" +
                adresseEditeur +
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

// Permet de modifier les valeurs d'un editeur
  static Future<void> updateEditeur(int id, String nomEditeur,
      String prenomEditeur, String adresseEditeur) async {
    // On donne dans ce cas les futurs valeurs
    try {
      MySqlConnection conn =
          await MySqlConnection.connect(BaseDeDonee.getSettings());
      try {
        // Ensuite avec un UPDATE, on indique les nouvelles valeurs saisie juste avant
        String requete = "UPDATE Editeur SET nomEditeur = '" +
            nomEditeur +
            ", prenomEditeur = '" +
            prenomEditeur +
            ", adresseEditeur = '" +
            adresseEditeur +
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

  // Permet de supprimer un editeur selon un 'ID' donné
  static Future<void> deleteEditeur(int id) async {
    try {
      MySqlConnection conn =
          await MySqlConnection.connect(BaseDeDonee.getSettings());
      try {
        // On suprimme donc de la table EDITEUR à l'ID donné, toutes les valeurs,
        // dont l'ID
        String requete = "DELETE FROM Editeur WHERE id='" + id.toString() + "'";
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
  // cette prochaine va permettre de supprimer toutes les valeurs de la table EDITEUR
  static Future<void> deleteAllEditeurs() async {
    try {
      MySqlConnection conn =
          await MySqlConnection.connect(BaseDeDonee.getSettings());
      try {
        // Cette prochaine requête va permettre cela
        String requete = "TRUNCATE TABLE Editeur;";
        await conn.query(requete);
      } catch (e) {
        print(e.toString());
      }
      conn.close();
    } catch (e) {
      print(e.toString());
    }
  }

  // verifie l'existance d'un editeur selon son ID
  static Future<bool> exist(int id) async {
    bool exist = false;
    // Si l'id donné est différent de zéro alors il n'est pas null
    if (!(await BEditeur.selectEditeur(id)).estNull()) {
      exist = true;
    }
    return exist;
  }

  // Permet de retourner les valeurs d'un auteur selon un id donné
  static Future<Editeur> getEditeur(int id) async {
    dynamic r = await selectEditeur(id);
    ResultRow rr = r.first;
    return Editeur(
        rr['id'], rr['nomEditeur'], rr['prenomEditeur'], rr['adresseEditeur']);
  }
}
