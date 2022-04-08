import 'package:mysql1/mysql1.dart';
import 'dart:io';

class BaseDeDonee {
// attributs

// Information concernant notre base de donnée
  static ConnectionSettings settings = new ConnectionSettings(
    host: 'localhost',
    port: 3306,
    user: 'FDNUSER',
    password: 'FDNMDP',
    db: 'FDN',
  );

// Constructeur

// Getter et setter

// Permet de retourner la liste des settings données en attributs ci-dessus
  static ConnectionSettings getSettings() {
    return settings;
  }

  // Méthodes

// Permet de créer les tables
  static Future<void> createTables() async {
    bool checkAuteur = false;
    bool checkEditeur = false;
    bool checkProduit = false;

    try {
      MySqlConnection conn =
          await MySqlConnection.connect(BaseDeDonee.getSettings());
      try {
        String requete = "SHOW TABLES;";
        Results reponse = await conn.query(requete);
        // Comme pour la fonction qui suit, verifie l'existence des tables suivantes
        for (var rows in reponse) {
          for (var fields in rows) {
            if (fields.toString() == "Auteur") {
              checkAuteur = true;
            }
            if (fields.toString() == "Editeur") {
              checkEditeur = true;
            }
            if (fields.toString() == "Produit") {
              checkProduit = true;
            }
          }
        }
        // Si la table Auteur n'existe pas, on la créer
        if (!checkAuteur) {
          requete =
              'CREATE TABLE Auteur (id int NOT NULL AUTO_INCREMENT PRIMARY KEY, nomAuteur varchar(255), prenomAuteur varchar(255));';
          await conn.query(requete);
        }
        // Si la table Editeur n'existe pas, on la créer
        if (!checkEditeur) {
          requete =
              'CREATE TABLE Editeur (id int NOT NULL AUTO_INCREMENT PRIMARY KEY,nomEditeur varchar(255), prenomEditeur varchar(255), adresseEditeur varchar(255));';
          await conn.query(requete);
        }
        // Si la table Produit n'existe pas, on la créer
        if (!checkProduit) {
          requete =
              'CREATE TABLE Produit (id int NOT NULL AUTO_INCREMENT PRIMARY KEY, type varchar(255), titre varchar(255), dispoEnStock varchar(255), dateDeParution varchar(255));';
          await conn.query(requete);
        }
      } catch (e) {
        print(e.toString());
      }
      conn.close();
    } catch (e) {
      print(e.toString());
    }
  }

  // retourne vrai si toute les tables sont créé, faux sinon
  static Future<bool> checkTables() async {
    bool checkAuteur = false;
    bool checkEditeur = false;
    bool checkProduit = false;
    bool checkAll = false;
    try {
      MySqlConnection conn =
          await MySqlConnection.connect(BaseDeDonee.getSettings());
      String requete = "SHOW TABLES;";
      try {
        Results reponse = await conn.query(requete);
        for (var rows in reponse) {
          for (var fields in rows) {
            // Si une des tables a pour nom 'AUTEUR' le booleen  checkAuteur retourne vrai sinon il reste a faux
            if (fields.toString() == "Auteur") {
              checkAuteur = true;
            }
            // Si une des tables a pour nom 'EDITEUR' le booleen  checkAuteur retourne vrai sinon il reste a faux
            if (fields.toString() == "Editeur") {
              checkEditeur = true;
            }
            // Si une des tables a pour nom 'PRODUIT' le booleen  checkAuteur retourne vrai sinon il reste a faux
            if (fields.toString() == "Produit") {
              checkProduit = true;
            }
          }
        }
      } catch (e) {
        print(e.toString());
      }
      conn.close();
    } catch (e) {
      print(e.toString());
    }
// Si après avoir checker si toutes les tables étaient présentes, on indique que le booleen checkAll est vrai,
// donc ici que tout les tables on étaient verifiées pour leur présences
    if (checkAuteur && checkEditeur && checkProduit) {
      checkAll = true;
    }
    return checkAll;
  }

  // retourne la liste des noms des tables dans la BDD;
  static Future<List<String>> selectTables() async {
    List<String> listTable = [];
    try {
      MySqlConnection conn =
          await MySqlConnection.connect(BaseDeDonee.getSettings());
      try {
        String requete = "SHOW TABLES;";
        Results reponse = await conn.query(requete);
        for (var rows in reponse) {
          for (var fields in rows) {
            // Liste de tables, permet d'ajouter chaque table (VARIABLE Fields ici) dans une liste
            // Donc dans notre cas, pour chaque table, on m'ajoute a une liste.
            listTable.add(fields);
          }
        }
      } catch (e) {
        print(e.toString());
      }
      conn.close();
    } catch (e) {
      print(e.toString());
    }
    return listTable;
  }

  // permet de supprimer une table via son nom passé en parametre, si elle existe dans la database
  static Future<void> dropTable(String table) async {
    try {
      MySqlConnection conn =
          await MySqlConnection.connect(BaseDeDonee.getSettings());
      try {
        await conn.query("DROP TABLES IF EXISTS " + table + ";");
      } catch (e) {
        print(e.toString());
      }
      conn.close();
    } catch (e) {
      print(e.toString());
    }
  }

// supprime toute les tables dans la DB
  static Future<void> dropAllTable() async {
    try {
      MySqlConnection conn =
          await MySqlConnection.connect(BaseDeDonee.getSettings());
      try {
        String requete = "SHOW TABLES;";
        Results reponse = await conn.query(requete);
        for (var rows in reponse) {
          for (var fields in rows) {
            await conn.query("DROP TABLES IF EXISTS " + fields + ";");
          }
        }
      } catch (e) {
        print(e.toString());
      }

      conn.close();
    } catch (e) {
      print(e.toString());
    }
  }

// Permet d'éxecuter une reqête
  static Future<dynamic> executerRequete(String requete) async {
    Results? reponse;
    try {
      MySqlConnection conn =
          await MySqlConnection.connect(BaseDeDonee.getSettings());
      try {
        reponse = await conn.query(requete);
      } catch (e) {
        print(e.toString());
      }
      conn.close();
    } catch (e) {
      print(e.toString());
    }
    return reponse;
  }
}
