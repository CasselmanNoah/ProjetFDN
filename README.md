# ProjetFDN                 Casselman Noah,SIO
Projet dev furets du nord,

  A) PRESENTATION DU PROJET:

Le projet qui m'est donné est la gestion d'une base de donnée proposé et donnée par les furets du nord.

Pour ce projet je suis donc developpeur envoyé par l'ESN, entreprise dans laquelle je suis salariés, mon but est donc de retravailler la BDD qui m'est donnée afin de rendre plus simple,accéssible et agréable d'utilisation cette dernière suite à la réalisation du projet.

A la fin du projet les options suivantes seront donc possibles:
- Identification à la BDD grâce au identifiant de connexion,
- Création des tables initiales et necéssaire si elles ne sont pas déjà créées ( Verifications possible pour voir si elles sont bien créées ),
- Créer de tables supplémentaire, les modifier ou bien les supprimer selon les besoins,
- Insérer des données dans chaque table, les modifier ou les supprimer selon une fois de plus les besoins,
- Un logiciel permettant d'utiliser les fonctionnalités precèdentes,
- Pouvoir modifier selon les besoins le logiciel,
- Commentaire precisant chaque méthodes,attiributs, chaque élément de ce dernier permmettant une utilisation et modification facile et simple d'accès
- *Avis et retour de ce logiciel*

  B) PRESENTATION DE LA STRUCTURE DES DONNEES:

Premièrement suite à la nouvelle structure de la base de donnée, elle sera non plus composé d'une table mais de 4 tables dont 1 "inutiles" car non utilisé, elle sera indiqué entre parenthèses.Voici donc les tables composant la BDD:
- Editeur ( Chaque editeur sera donc composé maintenant d'un nom,prénom et d'une adresse),
- Auteur ( Chaque auteur quand à lui sera composé d'un nom,prénom et de son âge),
- Produit ( Pour finir le produit sera composé d'un type, d'un titre, de savoir sa disponibilité en stock et de sa date de parution),
- (Concevoir, cette dernière n'est pas nécessaire actuellement mais peut être amener à une modification et donc être utiles dans le futur.)

  C) PRESENTATION DES FONCTIONALITE DU PROGRAMME:
  
  Pour commencer, le logiciel sera composé en plusieurs parties, voici les différent fichier présent actuellement tous en .dart:
  - "Auteur,Editeur,Produit" qui servent eux à avoir les attributs, getter et setter permettant de saisir ou d'avoir des informations précises ainsi que de savoir si selon un id (permet de différencier chaque champs dans la base de données) est "NULL" ou non donc plus précisément de savoir s'il existe ou non,
  - "Base" va permettre de savoir les attributs de connexion de la base par exemple ainsi que différentes méthodes permettant par exmple de créer supprimer les tables de la base de données,
  - Data qui lui va servir a afficher des données de la table en ajoutant les nom de colonne des table pour avoir une certaines mise en forme,
  - BaseAuteur,BaseEditeur et BaseProduit vont eux permettre d'ajouter, modifier et supprimer des données dans chaque table ainsi que d'afficher une donnée précise ou bien toutes les données d'un table,
  - Puis les "IHM Principale,editeur,auteur et produit" qui servent eux à mettre en forme le logiciel et de permettre une "discussion" avec l'utilisateur en précisant par exemple les actions possibles à faire comme le choix de créer modifier une table,etc,
  - L'IHM Principale sera plus composé du titre ou encore du message quand on quitte le logiciel mais aussi de choix qui permettent de gerer la BDD et pour finir des choix renvoyant au autre IHM par exemple,
  - Pour finir les IHM Autreur, Editeur et Produit permetteront comme préciser ci-dessus de proposer la création, modification,etc de données précises à chaque table.

Je me permet donc à vous dirigez ver le ficher





