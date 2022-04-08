import 'package:mysql1/mysql1.dart';

import 'data.dart';

class Auteur implements Data {
// Attributs
  int _id = 0;
  String _nomAuteur = "";
  String _prenomAuteur = "";
// Donnée concernant un auteur

// Constructeur
  Auteur.vide();
  Auteur(this._id, this._nomAuteur, this._prenomAuteur);
  Auteur.sansID(this._nomAuteur, this._prenomAuteur);
  Auteur.fromListString(List<String> unAuteur) {
    if (unAuteur.length == 3) {
      this._id = int.parse(unAuteur[0]);
      this._nomAuteur = unAuteur[1];
      this._prenomAuteur = unAuteur[2];
    }
  }
// Getter et setter

// Permet de saisir l'id de l'auteur
  void setID(int id) {
    this._id = id;
  }

// Permet de saisir le nom de l'auteur
  void setNomAuteur(String nomAuteur) {
    this._nomAuteur = nomAuteur;
  }

// Permet de saisir le prenom de l'auteur
  void setPrenomAuteur(String prenomAuteur) {
    this._prenomAuteur = prenomAuteur;
  }

//////////////////////////////////
  /// Ici on retourne un 'ID' , un 'nom d'un auteur' ou bien le 'prenom d'un auteur'
  int getID() {
    return this._id;
  }

  String getNomAuteur() {
    return this._nomAuteur;
  }

  String prenomAuteur() {
    return this._prenomAuteur;
  }
//////////////////////////////////

// Méthodes

// Retourne vrai ou faux selon si la valeur des attributs d'un auteur est vide ou non
  bool estNull() {
    bool estnull = false;
    // Si leurs valeur sont vides, on va retourner VRAI donc ESTNULL
    if (_id == 0 && _nomAuteur == "" && _prenomAuteur == "") {
      estnull = true;
    }
    return estnull;
  }

  @override
  String getEntete() {
    return "| id | nomAuteur | prenomAuteur";
  }

  @override
  String getInLine() {
    return "| " +
        _id.toString() +
        " | " +
        _nomAuteur +
        " | " +
        _prenomAuteur +
        " | ";
  }
// FIN
}
