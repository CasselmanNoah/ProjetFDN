import 'baseEditeur.dart';
import 'editeur.dart';
import 'ihm_principale.dart';

class IHMEditeurs {
  // Menu afficher après avoir choisie un des choix dans le menu de l'IHM Principale
  static Future<void> menu() async {
    int choix = -1;
    while (choix != 0) {
      print("Menu - Gestion Editeurs");
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
        await IHMEditeurs.menuSelectEdi();
      } else if (choix == 2) {
        await IHMEditeurs.insertEditeur();
      } else if (choix == 3) {
        await IHMEditeurs.updateEditeur();
      } else if (choix == 4) {
        await IHMEditeurs.deleteEditeur();
      } else if (choix == 5) {
        await IHMEditeurs.deleteAllEditeurs();
      }
    }
    // Sinon retour au menu precèdent
    print("Retour menu précédent.");
    print("--------------------------------------------------");
    await Future.delayed(Duration(seconds: 1));
  }

// Méthode permettant d'afficher tout les éléments de la table editeur ou bien de
// les trier selon leurs ID
  static Future<void> menuSelectEdi() async {
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
        await IHMEditeurs.selectAuteur();
      } else if (choix == 2) {
        await IHMEditeurs.selectAllEditeurs();
      }
    }
    print("Retour menu précédent.");
    print("--------------------------------------------------");
    await Future.delayed(Duration(seconds: 1));
  }

  // Permet d'ajouter un editeur
  static Future<void> insertEditeur() async {
    print("Saisir le nom de l'editeur");
    String nom = IHMprincipale.saisieString();
    print("Saisir le prenom de l'editeur");
    String prenom = IHMprincipale.saisieString();
    print("Saisir l'adresse de l'editeur");
    String adresse = IHMprincipale.saisieString();
    // On renvoie a la méthode de confirmation
    if (IHMprincipale.confirmation()) {
      // Si l'action est confirmer alors on renvoie a la méthode insertEditeur
      // qui elle fait le travail pour ajouter les données saisie dans la table
      await BEditeur.insertEditeur(nom, prenom, adresse);
      print("Editeur inséré dans la table.");
      print("--------------------------------------------------");
    } else {
      print("Annulation de l'opération.");
      print("--------------------------------------------------");
    }
    print("Fin de l'opération.");
    print("--------------------------------------------------");
    await Future.delayed(Duration(seconds: 1));
  }

  // Permet de mettre à jour un Editeur selon un ID
  static Future<void> updateEditeur() async {
    print("Quelle Editeur voulez vous mettre à jour ?");
    // Renvoie a la méthode de saisie d'ID
    int id = IHMprincipale.saisieID();
    // Si l'ID existe alors on demande les information necéssaire à ajouter
    if (await BEditeur.exist(id)) {
      print("Saisir le nom de l'editeur");
      String nom = IHMprincipale.saisieString();
      print("Saisir le prenom de l'editeur");
      String prenom = IHMprincipale.saisieString();
      print("Saisir l'adresse de l'editeur");
      String adresse = IHMprincipale.saisieString();
      // On renvoie a la demande de confirmation une fois de plus
      if (IHMprincipale.confirmation()) {
        // Puis si l'action est confirmer alors on ajoute les données à la table
        await BEditeur.updateEditeur(id, nom, prenom, adresse);
        print("Editeur $id mis à jour.");
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

  // Permet d'afficher un Editeur selon ID
  static Future<void> selectAuteur() async {
    print("Quelle Auteur voulez vous afficher ?");
    // Demande de saisie d'un ID
    int id = IHMprincipale.saisieID();
    Editeur edi = await BEditeur.selectEditeur(id);
    // Si l'ID donnée n'est pas null donc il faut qu'il soit dan la table
    // alors on affiche les donnée correspondante a cet ID
    if (!edi.estNull()) {
      IHMprincipale.afficherUneDonnee(edi);
      print("Fin de l'opération.");
      print("--------------------------------------------------");
      // Sinon on indique que l'ID donné n'existe pas
    } else {
      print("L'Editeur $id n'existe pas");
      print("Fin de l'opération.");
      print("--------------------------------------------------");
    }
    await Future.delayed(Duration(seconds: 1));
  }

  // Permet d'afficher touts les Editeurs
  static Future<void> selectAllEditeurs() async {
    // On créer une liste d'editeurs
    List<Editeur> listeEdi = await BEditeur.selectAllEditeurs();
    // Si la liste des editeurs n'est pas vide alors on affiche
    // toutes les données de la table
    if (listeEdi.isNotEmpty) {
      IHMprincipale.afficherDesDonnees(listeEdi);
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

// Permet de supprimer un Editeur selon son ID
  static Future<void> deleteEditeur() async {
    print("Quel Editeur voulez vous supprimer ?");
    // demande de saisie d'ID
    int id = IHMprincipale.saisieID();
    // Si l'action est confirmer alors
    if (IHMprincipale.confirmation()) {
      // Grâce à la méthode deleteEditeur, on supprime les données
      // correspondante a l'ID (l'ID est lui aussi supprimé)
      BEditeur.deleteEditeur(id);
      print("Editeur $id supprimé.");
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

  // Permet de supprimer touts les Editeurs
  static Future<void> deleteAllEditeurs() async {
    // On attend la demande de confirmation, si elle est accepter alors
    if (IHMprincipale.confirmation()) {
      // on supprime touts les auteurs de la table
      BEditeur.deleteAllEditeurs();
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
