import 'package:mysql1/mysql1.dart';
import 'base.dart';
import 'auteur.dart';

// Classe AUTEUR
class BAuteur {
  // Permet de selectionner un auteur selon son 'ID'
  static Future<Auteur> selectAuteur(int id) async {
    Auteur aut = Auteur.vide();
    try {
      MySqlConnection conn =
          await MySqlConnection.connect(BaseDeDonee.getSettings());
      try {
        // On selectionne toutes les valeurs de la table 'AUTEUR' avec comme 'ID' celui donné,
        // et s'il existe, on selectionne seulement L'(id) donné dans la table 'AUTEUR'
        String requete = "SELECT * FROM Auteur WHERE id=" +
            id.toString() +
            " AND EXISTS (SELECT id FROM Auteur WHERE id=" +
            id.toString() +
            " );";
        Results reponse = await conn.query(requete);
        // On renvoie ensuite les valeurs suivantes concernant l'(id) donné
        aut = Auteur(reponse.first['id'], reponse.first['nomAuteur'],
            reponse.first['prenomAuteur']);
      } catch (e) {
        print(e.toString());
      }
      conn.close();
    } catch (e) {
      print(e.toString());
    }

    return aut;
  }

// Renvoie la listes de tous les Auteurs
  static Future<List<Auteur>> selectAllAuteurs() async {
    List<Auteur> listeAut = [];
    try {
      MySqlConnection conn =
          await MySqlConnection.connect(BaseDeDonee.getSettings());
      try {
        // Ici on prend toutes les valeurs de la table 'AUTEUR'
        String requete = "SELECT * FROM Auteur;";
        Results reponse = await conn.query(requete);
        for (var row in reponse) {
          // Puis pour toutes les valeurs de ta table, on renvoie les valeurs ci-dessous
          Auteur aut = Auteur(row['id'], row['nomAuteur'], row['prenomAuteur']);
          // Liste d'auteurs dans laquelles on ajoutes les valeurs ci-dessus pour toutes les valeurs de la table 'AUTEUR'
          listeAut.add(aut);

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
// retourne la lsites des auteurs
    return listeAut;
  }

// Permet d'inserer un auteur dans la table 'AUTEUR'
  static Future<void> insertAuteur(
      String nomAuteur, String prenomAuteur) async {
    try {
      MySqlConnection conn =
          await MySqlConnection.connect(BaseDeDonee.getSettings());
      try {
        // Ici on insert dans la table 'Auteur' et dans les colonnes entre les premières (), les valeurs données (nomAuteur et prenomAuteur)
        String requete =
            "INSERT INTO Auteur (nomAuteur, prenomAuteur) VALUES('" +
                nomAuteur +
                "', '" +
                prenomAuteur +
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

// Permet de modifier les valeur d'un auteur
  static Future<void> updateAuteur(
      int id, String nomAuteur, String prenomAuteur) async {
    try {
      MySqlConnection conn =
          await MySqlConnection.connect(BaseDeDonee.getSettings());
      try {
        // La requête UPDATE est utilisé ici un peu comme dans la methode ci-dessus,
        // sauf qu'ici elle n'ajoute pas un auteur mais elle en modifie un selon
        // l'id donné par l'utilisateur
        String requete = "UPDATE Auteur SET nomAuteur = '" +
            nomAuteur +
            ", prenomAuteur = '" +
            prenomAuteur +
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

  // Permet de supprimer les données d'un auteur precis
  static Future<void> deleteAuteur(int id) async {
    try {
      MySqlConnection conn =
          await MySqlConnection.connect(BaseDeDonee.getSettings());
      try {
        // Ici on supprime dans la table auteur, l'id donné donc en même temps son nom et prenom,
        // ces denières valeurs sont donc supprimer de la table
        String requete = "DELETE FROM Auteur WHERE id='" + id.toString() + "'";
        await conn.query(requete);
      } catch (e) {
        print(e.toString());
      }
      conn.close();
    } catch (e) {
      print(e.toString());
    }
  }

  // Permet de supprimer tous les auteur de la table
  static Future<void> deleteAllAuteur() async {
    try {
      MySqlConnection conn =
          await MySqlConnection.connect(BaseDeDonee.getSettings());
      try {
        // Pour cette requête, son but est assez équivalent a celle de la méthode ci-dessus,
        // mais en plus avancé, cela veut dire que ca ne va pas supprimer les valeurs
        // d'un auteur seulement mais plutôt celles de tous les auteurs de la table
        String requete = "TRUNCATE TABLE Auteur;";
        await conn.query(requete);
      } catch (e) {
        print(e.toString());
      }
      conn.close();
    } catch (e) {
      print(e.toString());
    }
  }

  // verifie l'existance d'un Auteur selon son ID
  static Future<bool> exist(int id) async {
    bool exist = false;
    // Si l'id de l'auteur donné n'est pas null (= a 0), alors il existe,

    if (!(await BAuteur.selectAuteur(id)).estNull()) {
      exist = true;
    }

    return exist;
  }

  // Permet de retourner les valeurs d'un auteur selon un id donné
  static Future<Auteur> getAuteur(int id) async {
    dynamic r = await selectAuteur(id);
    ResultRow rr = r.first;
    return Auteur(rr['id'], rr['nomAuteur'], rr['prenomAuteur']);
  }
}
