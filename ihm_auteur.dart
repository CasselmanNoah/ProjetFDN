import 'baseAuteur.dart';
import 'auteur.dart';
import 'ihm_principale.dart';

class IHMAuteurs {
  // Menu afficher après avoir choisie un des choix dans le menu de l'IHM Principale
  static Future<void> menu() async {
    int choix = -1;
    while (choix != 0) {
      print("Menu - Gestion Auteurs");
      print("1- Afficher des données de la table");
      print("2- Inserer une données dans la table");
      print("3- Modifier une données dans la table");
      print("4- Supprimer une données dans la tables");
      print("5- Supprimer toutes les données dans la tables");
      print("0- Quitter");
      choix = IHMprincipale.choixMenu(5);
      print("--------------------------------------------------");
// lance la méthode correspondante au choix donné par l'utilisateur
      if (choix == 1) {
        await IHMAuteurs.menuSelectAut();
      } else if (choix == 2) {
        await IHMAuteurs.insertAuteur();
      } else if (choix == 3) {
        await IHMAuteurs.updateAuteur();
      } else if (choix == 4) {
        await IHMAuteurs.deleteAuteur();
      } else if (choix == 5) {
        await IHMAuteurs.deleteAllAuteurs();
      }
    }
    // Sinon retour au menu precèdent
    print("Retour menu précédent.");
    print("--------------------------------------------------");
    await Future.delayed(Duration(seconds: 1));
  }

// Méthode permettant d'afficher tout les éléments de la table auteur ou bien de
// les trier selon leurs ID
  static Future<void> menuSelectAut() async {
    int choix = -1;
    while (choix != 0) {
      print("Menu - Select Auteur");
      print("1- Afficher selon ID");
      print("2- Afficher toute la table.");
      print("0- Quitter");
      choix = IHMprincipale.choixMenu(2);
      print("--------------------------------------------------");
// Renvoie à une méthode selon le choix donné
      if (choix == 1) {
        await IHMAuteurs.selectAuteur();
      } else if (choix == 2) {
        await IHMAuteurs.selectAllAuteurs();
      }
    }
    print("Retour menu précédent.");
    print("--------------------------------------------------");
    await Future.delayed(Duration(seconds: 1));
  }

  // Permet d'ajouter un auteur
  static Future<void> insertAuteur() async {
    print("Saisir le nom de l'auteur");
    String nom = IHMprincipale.saisieString();
    print("Saisir le prenom de l'auteur");
    String prenom = IHMprincipale.saisieString();
    // On renvoie a la méthode de confirmation
    if (IHMprincipale.confirmation()) {
      // Si l'action est confirmer alors on renvoie a la méthode insertAuteur
      // qui elle fait le travail pour ajouter les données saisie dans la table
      await BAuteur.insertAuteur(nom, prenom);
      print("Auteur inséré dans la table.");
      print("--------------------------------------------------");
    } else {
      print("Annulation de l'opération.");
      print("--------------------------------------------------");
    }
    print("Fin de l'opération.");
    print("--------------------------------------------------");
    await Future.delayed(Duration(seconds: 1));
  }

  // Permet de mettre à jour un Auteur selon un ID
  static Future<void> updateAuteur() async {
    print("Quelle Auteur voulez vous mettre à jour ?");
    // Renvoie a la méthode de saisie d'ID
    int id = IHMprincipale.saisieID();
    // Si l'ID existe alors on demande les information necéssaire à ajouter
    if (await BAuteur.exist(id)) {
      print("Saisir le nom de l'auteur");
      String nom = IHMprincipale.saisieString();
      print("Saisir le prenom de l'auteur");
      String prenom = IHMprincipale.saisieString();
// On renvoie a la demande de confirmation une fois de plus
      if (IHMprincipale.confirmation()) {
        // Puis si l'action est confirmer alors on ajoute les données à la table
        await BAuteur.updateAuteur(id, nom, prenom);
        print("Auteur $id mis à jour.");
        print("--------------------------------------------------");
      } else {
        print("Annulation de l'opération.");
        print("--------------------------------------------------");
      }
      await Future.delayed(Duration(seconds: 1));
      // Sinon si l'ID n'existe pas alors on met fin à l'opération
    } else {
      print("L'auteur $id n'existe pas.");
      print("Fin de l'opération.");
      print("--------------------------------------------------");
      await Future.delayed(Duration(seconds: 1));
    }
  }

  // Permet d'afficher un Auteur selon ID
  static Future<void> selectAuteur() async {
    print("Quelle Auteur voulez vous afficher ?");
    // Demande de saisie d'un ID
    int id = IHMprincipale.saisieID();
    Auteur aut = await BAuteur.selectAuteur(id);
    // Si l'ID donnée n'est pas null donc il faut qu'il soit dan la table
    // alors on affiche les donnée correspondante a cet ID
    if (!aut.estNull()) {
      IHMprincipale.afficherUneDonnee(aut);
      print("Fin de l'opération.");
      print("--------------------------------------------------");
      // Sinon on indique que l'ID donné n'existe pas
    } else {
      print("L'auteur $id n'existe pas");
      print("Fin de l'opération.");
      print("--------------------------------------------------");
    }
    await Future.delayed(Duration(seconds: 1));
  }

  // Permet d'afficher touts les Auteurs
  static Future<void> selectAllAuteurs() async {
    // On créer une liste d'auteurs
    List<Auteur> listeAut = await BAuteur.selectAllAuteurs();
    // Si la liste des auteurs n'est pas vide alors on affiche
    // toutes les données de la table
    if (listeAut.isNotEmpty) {
      IHMprincipale.afficherDesDonnees(listeAut);
      print("Fin de l'opération.");
      print("--------------------------------------------------");
      // Sinon si la liste est vide alors on indique que la table est vide
    } else {
      print("la table est vide");
      print("Fin de l'opération.");
      print("--------------------------------------------------");
    }
    await Future.delayed(Duration(seconds: 1));
  }

// Permet de supprimer un Auteur selon son ID
  static Future<void> deleteAuteur() async {
    print("Quel Auteur voulez vous supprimer ?");
    // demande de saisie d'ID
    int id = IHMprincipale.saisieID();
    // Si l'action est confirmer alors
    if (IHMprincipale.confirmation()) {
      // Grâce à la méthode deleteAuteur, on supprime les données
      // correspondante a l'ID (l'ID est lui aussi supprimé)
      BAuteur.deleteAuteur(id);
      print("Auteur $id supprimé.");
      print("Fin de l'opération.");
      print("--------------------------------------------------");
      await Future.delayed(Duration(seconds: 1));
      // Sinon on annule
    } else {
      print("Annulation de l'opération.");
      print("--------------------------------------------------");
      await Future.delayed(Duration(seconds: 1));
    }
  }

  // Permet de supprimer touts les Auteurs
  static Future<void> deleteAllAuteurs() async {
    // On attend la demande de confirmation, si elle est accepter alors
    if (IHMprincipale.confirmation()) {
      // on supprime touts les auteurs de la table
      BAuteur.deleteAllAuteur();
      print("Tables supprimées.");
      print("Fin de l'opération.");
      print("--------------------------------------------------");
      await Future.delayed(Duration(seconds: 1));
      // Sinon on annule
    } else {
      print("Annulation de l'opération.");
      print("--------------------------------------------------");
      await Future.delayed(Duration(seconds: 1));
    }
  }
}
