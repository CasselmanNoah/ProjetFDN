import 'baseProduit.dart';
import 'produit.dart';
import 'ihm_principale.dart';

class IHMProduits {
  // Menu afficher après avoir choisie un des choix dans le menu de l'IHM Principale
  static Future<void> menu() async {
    int choix = -1;
    while (choix != 0) {
      print("Menu - Gestion Produits");
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
        await IHMProduits.menuSelectPro();
      } else if (choix == 2) {
        await IHMProduits.insertProduit();
      } else if (choix == 3) {
        await IHMProduits.updateProduit();
      } else if (choix == 4) {
        await IHMProduits.deleteProduit();
      } else if (choix == 5) {
        await IHMProduits.deleteAllProduits();
      }
    }
    // Sinon retour au menu precèdent
    print("Retour menu précédent.");
    print("--------------------------------------------------");
    await Future.delayed(Duration(seconds: 1));
  }

// Méthode permettant d'afficher tout les éléments de la table editeur ou bien de
// les trier selon leurs ID
  static Future<void> menuSelectPro() async {
    int choix = -1;
    while (choix != 0) {
      print("Menu - Select Produits");
      print("1- Afficher selon ID");
      print("2- Afficher toute la table.");
      print("0- Quitter");
      choix = IHMprincipale.choixMenu(2);
      print("--------------------------------------------------");
// Renvoie à une méthode selon le choix donné
      if (choix == 1) {
        await IHMProduits.selectProduit();
      } else if (choix == 2) {
        await IHMProduits.selectAllProduits();
      }
    }
    print("Retour menu précédent.");
    print("--------------------------------------------------");
    await Future.delayed(Duration(seconds: 1));
  }

  // Permet d'ajouter un Produit
  static Future<void> insertProduit() async {
    print("Type du produit :");
    String type = IHMprincipale.saisieString();
    print("Titre du produit :");
    String titre = IHMprincipale.saisieString();
    print("Dispo en stock :");
    String dispoEnStock = IHMprincipale.saisieString();
    print("Date de parution :");
    String dateDeParution = IHMprincipale.saisieString();
    // On renvoie a la méthode de confirmation
    if (IHMprincipale.confirmation()) {
      // Si l'action est confirmer alors on renvoie a la méthode insertProduit
      // qui elle fait le travail pour ajouter les données saisie dans la table
      await BProduit.insertProduit(type, titre, dispoEnStock, dateDeParution);
      print("Produit inséré dans la table.");
      print("--------------------------------------------------");
    } else {
      print("Annulation de l'opération.");
      print("--------------------------------------------------");
    }
    print("Fin de l'opération.");
    print("--------------------------------------------------");
    await Future.delayed(Duration(seconds: 1));
  }

  // Permet de mettre à jour un Produit selon un ID
  static Future<void> updateProduit() async {
    print("Quelle Produit voulez vous mettre à jour ?");
    // Renvoie a la méthode de saisie d'ID
    int id = IHMprincipale.saisieID();
    // Si l'ID existe alors on demande les information necéssaire à ajouter
    if (await BProduit.exist(id)) {
      print("Type du produit :");
      String type = IHMprincipale.saisieString();
      print("Titre du produit :");
      String titre = IHMprincipale.saisieString();
      print("Dispo en stocc :");
      String dispoEnStock = IHMprincipale.saisieString();
      print("Date de parution :");
      String dateDeParution = IHMprincipale.saisieString();
      // On renvoie a la demande de confirmation une fois de plus
      if (IHMprincipale.confirmation()) {
        // Puis si l'action est confirmer alors on ajoute les données à la table
        await BProduit.updateProduit(
            id, type, titre, dispoEnStock, dateDeParution);
        print("Produit $id mis à jour.");
        print("--------------------------------------------------");
      } else {
        print("Annulation de l'opération.");
        print("--------------------------------------------------");
      }
      await Future.delayed(Duration(seconds: 1));
      // Sinon si l'ID n'existe pas alors on met fin à l'opération
    } else {
      print("Le produit $id n'existe pas.");
      print("Fin de l'opération.");
      print("--------------------------------------------------");
      await Future.delayed(Duration(seconds: 1));
    }
  }

  // Permet d'afficher un Produit selon ID
  static Future<void> selectProduit() async {
    print("Quelle Produit voulez vous afficher ?");
    // Demande de saisie d'un ID
    int id = IHMprincipale.saisieID();
    Produit pro = await BProduit.selectProduit(id);
    // Si l'ID donnée n'est pas null donc il faut qu'il soit dan la table
    // alors on affiche les donnée correspondante a cet ID
    if (!pro.estNull()) {
      IHMprincipale.afficherUneDonnee(pro);
      print("Fin de l'opération.");
      print("--------------------------------------------------");
      // Sinon on indique que l'ID donné n'existe pas
    } else {
      print("Le produit $id n'existe pas");
      print("Fin de l'opération.");
      print("--------------------------------------------------");
    }
    await Future.delayed(Duration(seconds: 1));
  }

  // Permet d'afficher touts les Produits
  static Future<void> selectAllProduits() async {
    // On créer une liste de Produit
    List<Produit> listePro = await BProduit.selectAllProduits();
    // Si la liste des produits n'est pas vide alors on affiche
    // toutes les données de la table
    if (listePro.isNotEmpty) {
      IHMprincipale.afficherDesDonnees(listePro);
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

// Permet de supprimer un Produit selon son ID
  static Future<void> deleteProduit() async {
    print("Quelle Produit voulez vous supprimer ?");
    // demande de saisie d'ID
    int id = IHMprincipale.saisieID();
    // Si l'action est confirmer alors
    if (IHMprincipale.confirmation()) {
      // Grâce à la méthode deleteProduit, on supprime les données
      // correspondante a l'ID (l'ID est lui aussi supprimé)
      BProduit.deleteProduit(id);
      print("Produit $id supprimé.");
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

  // Permet de supprimer touts les Produits
  static Future<void> deleteAllProduits() async {
    // On attend la demande de confirmation, si elle est accepter alors
    if (IHMprincipale.confirmation()) {
      // on supprime touts les auteurs de la table
      BProduit.deleteAllProduit();
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
