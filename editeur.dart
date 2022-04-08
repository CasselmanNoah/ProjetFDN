import 'package:mysql1/mysql1.dart';

import 'data.dart';

class Editeur implements Data {
// Attributs
  int _id = 0;
  String _nomEditeur = "";
  String _prenomEditeur = "";
  String _adresseEditeur = "";
  // Ces dernières sont les valeurs dont va être conmposé un editeur

// Constructeur
  Editeur.vide();
  Editeur(
      this._id, this._nomEditeur, this._prenomEditeur, this._adresseEditeur);
  Editeur.sansID(this._nomEditeur, this._prenomEditeur, this._adresseEditeur);
  Editeur.fromListString(List<String> unEditeur) {
    if (unEditeur.length == 4) {
      this._id = int.parse(unEditeur[0]);
      this._nomEditeur = unEditeur[1];
      this._prenomEditeur = unEditeur[2];
      this._adresseEditeur = unEditeur[3];
    }
  }
// Getter et setter
// Permet de saisir l'id de l'editeur
  void setID(int id) {
    this._id = id;
  }

// Permet de saisir le nom de l'editeur
  void setNomEditeur(String nom) {
    this._nomEditeur = nom;
  }

// Permet de saisir le prénom de l'editeur
  void setPrenomEditeur(String prenom) {
    this._prenomEditeur = prenom;
  }

// Permet de saisir l'adresse de l'editeur
  void serAdrEditeur(String adresse) {
    this._adresseEditeur = adresse;
  }

//////////////////////////////////
  /// Ici on retourne un 'ID' , un 'nom d'un editeur' ou bien le 'prenom d'un editeur' ou bien autre chose correspondant à une valeur attribuer à un editeur
  int getID() {
    return this._id;
  }

  String getNomEditeur() {
    return this._nomEditeur;
  }

  String getPrenomEditeur() {
    return this._prenomEditeur;
  }

  String gettAdrEditeur() {
    return this._adresseEditeur;
  }

//////////////////////////////////
// Méthodes

// Retourne vrai ou faux selon si la valeur des attributs d'un auteur est vide ou non
  bool estNull() {
    bool estnull = false;
    // Si leurs valeur sont vides, on va retourner VRAI donc ESTNULL
    if (_id == 0 &&
        _nomEditeur == "" &&
        _prenomEditeur == "" &&
        _adresseEditeur == "") {
      estnull = true;
    }
    return estnull;
  }

  @override
  String getEntete() {
    return "| id | nomEditeur | prenomEditeur | adresseEditeur";
  }

  @override
  String getInLine() {
    return "| " +
        _id.toString() +
        " | " +
        _nomEditeur +
        " | " +
        _prenomEditeur +
        " | " +
        _adresseEditeur +
        " | ";
  }
// FIN
}
