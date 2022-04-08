import 'package:mysql1/mysql1.dart';

import 'data.dart';

class Produit implements Data {
// Attributs
  int _id = 0;
  String _type = "";
  String _titre = "";
  String _dispoEnStock = "";
  String _dateDeParution = "";
// Ces dernières sont les valeurs dont va être conmposé un produit
// Constructeur
  Produit.vide();
  Produit(this._id, this._type, this._titre, this._dispoEnStock,
      this._dateDeParution);
  Produit.sansID(
      this._type, this._titre, this._dispoEnStock, this._dateDeParution);
  Produit.fromListString(List<String> unProduit) {
    if (unProduit.length == 5) {
      this._id = int.parse(unProduit[0]);
      this._type = unProduit[1];
      this._titre = unProduit[2];
      this._dispoEnStock = unProduit[3];
      this._dateDeParution = unProduit[4];
    }
  }
// Getter et setter
// Permet de saisir l'id d'un produit
  void setID(int id) {
    this._id = id;
  }

// Permet de saisir le type d'un produit
  void setType(String type) {
    this._type = type;
  }

// Permet de savoir si un produit est dispo ou non
  void setDispo(String dispo) {
    this._dispoEnStock = dispo;
  }

// Permet de definir la date de parution d'un produit
  void setDateParution(String dateParution) {
    this._dateDeParution = dateParution;
  }

//////////////////////////////////
  /// Ici on retourne une valeur correspondant à une valeur précises d'un produit
  int getID() {
    return this._id;
  }

  String getType() {
    return this._type;
  }

  String getTitre() {
    return this._titre;
  }

  String getDisponibilite() {
    return this._dispoEnStock;
  }

  String dateParution() {
    return this._dateDeParution;
  }
//////////////////////////////////

// Méthodes
// Retourne vrai ou faux selon si la valeur des attributs d'un auteur est vide ou non
  bool estNull() {
    bool estnull = false;
    // Si leurs valeur sont vides, on va retourner VRAI donc ESTNULL
    if (_id == 0 &&
        _type == "" &&
        _titre == "" &&
        _dateDeParution == "" &&
        _dispoEnStock == "") {
      estnull = true;
    }
    return estnull;
  }

  @override
  String getEntete() {
    return "| id | type | titre | dispoEnStock | dateDeParution";
  }

  @override
  String getInLine() {
    return "| " +
        _id.toString() +
        " | " +
        _type +
        " | " +
        _titre +
        " | " +
        _dispoEnStock +
        " | " +
        _dateDeParution +
        " | ";
  }
// FIN

}
