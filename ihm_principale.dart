import 'dart:io';
import 'package:mysql1/mysql1.dart';

import 'data.dart';
import 'base.dart';
import 'ihm_editeur.dart';
import 'ihm_auteur.dart';
import 'ihm_produit.dart';

class IHMprincipale {
  // Permet d'afficher le titre au lancement du programme
  static void titre() {
    print("");
    print("Bienvenue dans :");
    print("Furet du Nord - projet SQL");
    print("--------------------------------------------------");
  }

// Permet d'afficher le message au moment de quitter le programme
  static void quitter() {
    print("Au revoir !");
  }

// Permet d'afficher une donnée précise donnée par l'utilisateur
  static void afficherUneDonnee(Data data) {
    print(data.getEntete());
    print(data.getInLine());
  }

// Affiche une liste des données d'un table par exemple
  static void afficherDesDonnees(List<Data> dataList) {
    print(dataList.first.getEntete());
    for (var donnee in dataList) {
      print(donnee.getInLine());
    }
  }

  // methodes de saisie
  // retourne un chiffre entre 0 et nbChoix pour les menus
  static int choixMenu(int nbChoix) {
    // on saisie un entier en fonction du choix que l'on souhaite et le choix proposé
    bool saisieValide = false;
    int i = -1;
    // Tant que la saisie donnée est non valide on redemande la saisie
    while (!saisieValide) {
      print("> Veuillez saisir une action (0-$nbChoix)");
      try {
        i = int.parse(stdin.readLineSync().toString());
        // Si la saisie est > à 0 et < au nombre de choix indiqué,
        // alors la valeur saisie est valide
        if (i >= 0 && i <= nbChoix) {
          saisieValide = true;
          // Sinon on affiche le message suivant
        } else {
          print("La saisie ne correspond à aucune action.");
        }
      } catch (e) {
        print("Erreur dans la saisie.");
      }
    }
    return i;
  }

  // retourne un boolean en fonction de la demande donnée
  // Si on souhaite confirmer notre action alors on confirme
  // sinon on annule
  static bool confirmation() {
    bool saisieValide = false;
    bool confirme = false;
    while (!saisieValide) {
      print("Confirmer vous l'action ? (o/n)");
      String reponse = stdin.readLineSync().toString();
      if (reponse.toLowerCase() == "o") {
        saisieValide = true;
        confirme = true;
      } else if (reponse.toLowerCase() == "n") {
        saisieValide = true;
        print("Annulation.");
      } else {
        print("Erreur dans la saisie.");
      }
    }
    return confirme;
  }

  // retourne un string pour saisie de chaine de caractère
  static String saisieString() {
    bool saisieValide = false;
    String s = "";
    // Demande de saisie d'une chaine de caractère et
    // tant qu'elle est pas valide, on demande à resaisir
    while (!saisieValide) {
      print("> Veuillez saisir une chaine de caractère :");
      try {
        s = stdin.readLineSync().toString();
        saisieValide = true;
      } catch (e) {
        print("Erreur dans la saisie.");
      }
    }
    return s;
  }

// retourne un string pour saisie de chaine de caractère
  static String saisirUser() {
    bool saisieValide = false;
    String s = "";
    // Demande de saisie d'une chaine de caractère et
    // tant qu'elle est pas valide, on demande à resaisir
    while (!saisieValide) {
      print("> Veuillez saisir l'utilisateur :");
      try {
        s = stdin.readLineSync().toString();
        saisieValide = true;
      } catch (e) {
        print("Erreur dans la saisie.");
      }
    }
    return s;
  }

  static String saisirBDD() {
    bool saisieValide = false;
    String s = "";
    // Demande de saisie d'une chaine de caractère et
    // tant qu'elle est pas valide, on demande à resaisir
    while (!saisieValide) {
      print("> Veuillez saisir le nom de la base de donnée :");
      try {
        s = stdin.readLineSync().toString();
        saisieValide = true;
      } catch (e) {
        print("Erreur dans la saisie.");
      }
    }
    return s;
  }

  // retourne un int pour saisie d'entier positif
  // Même méthode que la méthode pour la saisie de chaine de caractère,
  // mais pour un entier
  static int saisieInt() {
    bool saisieValide = false;
    int i = -1;
    while (!saisieValide) {
      print("> Veuillez saisir un entier :");
      try {
        i = int.parse(stdin.readLineSync().toString());
        saisieValide = true;
      } catch (e) {
        print("Erreur dans la saisie.");
      }
    }
    return i;
  }

  // retourne un int pour saisie d'entier positif
  // Même méthde que la saisie d'entier mais pour cette fois ci,
  // une demande de saisie d'id
  static int saisieID() {
    bool saisieValide = false;
    int i = -1;
    while (!saisieValide) {
      print("> Veuillez saisir l'id correspondant:");
      try {
        i = int.parse(stdin.readLineSync().toString());
        if (i > 0) {
          saisieValide = true;
        } else {
          print("La valeur saisie est inférieur ou égale à zéro.");
        }
      } catch (e) {
        print("Erreur dans la saisie.");
      }
    }
    return i;
  }

  // retourne un string pour saisie de chaine de caractère masqué
  static String saisieMDP() {
    bool saisieValide = false;
    String s = "";
    while (!saisieValide) {
      print("> Veuillez saisir le mot de passe :");
      try {
        stdin.echoMode = false;
        s = stdin.readLineSync().toString();
        saisieValide = true;
        stdin.echoMode = true;
      } catch (e) {
        print("Erreur dans la saisie.");
      }
    }
    return s;
  }

// Demande de saisie du nom de la BDD et du USER ainsi que du mot de passe
// pour pouvoir permettre une connexion après verification
  static ConnectionSettings setting() {
    bool saisieValide = false;
    String bdd = "";
    String user = "";
    String mdp = "";
    while (!saisieValide) {
      bdd = IHMprincipale.saisirBDD();
      user = IHMprincipale.saisirUser();
      mdp = IHMprincipale.saisieMDP();
      if (bdd == BaseDeDonee.settings.db &&
          user == BaseDeDonee.settings.user &&
          mdp == BaseDeDonee.settings.password) {
        saisieValide = true;
        break;
      }
    }
    return ConnectionSettings(
      host: 'localhost',
      port: 3306,
      user: user, // DartUser
      password: mdp, // dartmdp
      db: bdd, // DartDB
    );
  }

  static Future<bool> connectToBDD() async {
    bool valide = false;
    try {
      MySqlConnection conn = await MySqlConnection.connect(setting());
      valide = true;
    } catch (e) {
      print(e.toString());
    }
    return valide;
  }

  static Future disconnectToBDD() async {
    print("Deconnexion !");
    IHMprincipale.quitter();
    exit(1);
  }

// Permet de se connecter à la base indiqué dans les settings
  static Future choixConnectBDD() async {
    int choix = -1;
    print("Souhaiter vous vous conneter a la Base De Donnée ?");
    print("1- Se connecter à la BDD");
    print("2- Ne rien faire / Quitter");
    choix = IHMprincipale.choixMenu(2);
    print("--------------------------------------------------");
    try {
      if (choix == 1) {
        await IHMprincipale.connectToBDD();
      } else if (choix == 2) {
        IHMprincipale.quitter();
        exit(1);
      }
    } catch (e) {
      print(e.toString());
    }
  }

  // methode des menus et actions
  // menu d'accueil
  static Future<int> menu() async {
    int choix = -1;
    while (choix != 0) {
      print("Menu Principal");
      print("1- Gestion de la BDD");
      print("2- Gestion de la table Auteur");
      print("3- Gestion de la table Editeur");
      print("4- Gestion de la table Produit");
      print("5- Deconnexion");
      print("0- Quitter");
      // On indique qu'il y aura 4 choix possible ici
      choix = IHMprincipale.choixMenu(5);
      print("--------------------------------------------------");
      // Si le choix saisie == une des valeurs alors on lance le menu
      // correspondant
      if (choix == 1) {
        await IHMprincipale.menuBDD();
      } else if (choix == 2) {
        await IHMAuteurs.menu();
      } else if (choix == 3) {
        await IHMEditeurs.menu();
      } else if (choix == 4) {
        await IHMProduits.menu();
      } else if (choix == 5) {
        await IHMprincipale.disconnectToBDD();
      }
    }
    return 0;
  }

  // menu pour la gestion basic de la BDD
  static Future<void> menuBDD() async {
    int choix = -1;
    while (choix != 0) {
      print("Menu - Gestion BDD");
      print("1- Création des tables de la BDD");
      print("2- Verification des tables de la BDD");
      print("3- Afficher les tables de la BDD");
      print("4- Supprimer une table dans la BDD");
      print("5- Supprimer toutes les tables dans la BDD");
      print("0- Quitter");
      // On indique qu'il y aura 5 choix possible ici
      choix = IHMprincipale.choixMenu(5);
      print("--------------------------------------------------");
      // Si le choix saisie == une des valeurs alors on lance le menu
      // correspondant
      if (choix == 1) {
        await IHMprincipale.createTable();
      } else if (choix == 2) {
        await IHMprincipale.checkTable();
      } else if (choix == 3) {
        await IHMprincipale.selectTable();
      } else if (choix == 4) {
        await IHMprincipale.deleteTable();
      } else if (choix == 5) {
        await IHMprincipale.deleteAllTables();
      }
    }
    print("Retour menu précédent.");
    print("--------------------------------------------------");
    // Permet un retour au menu precèdent
    await Future.delayed(Duration(seconds: 1));
  }

  // action pour creer les tables
  static Future<void> createTable() async {
    print("Création des tables manquantes dans la BDD ...");
    await BaseDeDonee.createTables();
    print("Fin de l'opération.");
    print("--------------------------------------------------");
    await Future.delayed(Duration(seconds: 1));
  }

// action pour vérifier les tables
  static Future<void> checkTable() async {
    print("Verification des tables dans la BDD ...");
    if (await BaseDeDonee.checkTables()) {
      print("Toutes les tables sont présentes dans la BDD.");
    } else {
      print("Il manque des tables dans la BDD.");
    }
    print("Fin de l'opération.");
    print("--------------------------------------------------");
    await Future.delayed(Duration(seconds: 1));
  }

// action pour afficher les tables
  static Future<void> selectTable() async {
    List<String> listTable = await BaseDeDonee.selectTables();
    print("Liste des tables :");
    for (var table in listTable) {
      print("- $table");
    }
    print("Fin de l'opération.");
    print("--------------------------------------------------");
    await Future.delayed(Duration(seconds: 1));
  }

// action pour supprimer une table
  static Future<void> deleteTable() async {
    print("Quelle table voulez vous supprimer ?");
    String table = IHMprincipale.saisieString();
    if (IHMprincipale.confirmation()) {
      BaseDeDonee.dropTable(table);
      print("Table supprimée.");
      print("Fin de l'opération.");
      print("--------------------------------------------------");
      await Future.delayed(Duration(seconds: 1));
    } else {
      print("Annulation de l'opération.");
      print("--------------------------------------------------");
      await Future.delayed(Duration(seconds: 1));
    }
  }

// action pour supprimer les tables
  static Future<void> deleteAllTables() async {
    if (IHMprincipale.confirmation()) {
      BaseDeDonee.dropAllTable();
      print("Tables supprimées.");
      print("Fin de l'opération.");
      print("--------------------------------------------------");
      await Future.delayed(Duration(seconds: 1));
    } else {
      print("Annulation de l'opération.");
      print("--------------------------------------------------");
      await Future.delayed(Duration(seconds: 1));
    }
  }
}
