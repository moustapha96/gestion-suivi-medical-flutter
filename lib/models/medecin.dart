import 'dart:convert';

import 'package:mygsmp/models/DemandeRv.dart';
import 'package:mygsmp/models/dossier_medical.dart';
import 'package:mygsmp/models/memos.dart';
import 'package:mygsmp/models/notification.dart';
import 'package:mygsmp/models/rendezVous.dart';
import 'package:mygsmp/models/serviceMedical.dart';
import 'package:mygsmp/models/userModel.dart';

class Medecin {
  int idMedecin;
  String specialisation;
  String initial;
  String prenom;
  String num_licence;
  String adresse;
  Usermodel? user;
  String genre;
  String nom;
  String tel;
  int taille;
  int age;
  String creatAt;
  //Servicemedical? serviceMedical;
  /*List<Rendezvous> rendezVous;

  List<DossierMedical> dossierMedical;

  List<Memos> memos;

  List<Demanderv> deamndeRv;*/
  get getIdMedecin => this.idMedecin;

  set setIdMedecin(idMedecin) => this.idMedecin = idMedecin;

  get getSpecialisation => this.specialisation;

  set setSpecialisation(specialisation) => this.specialisation = specialisation;

  get getInitial => this.initial;

  set setInitial(initial) => this.initial = initial;

  get getPrenom => this.prenom;

  set setPrenom(prenom) => this.prenom = prenom;

  get numlicence => this.num_licence;

  set numlicence(value) => this.num_licence = value;

  get getAdresse => this.adresse;

  set setAdresse(adresse) => this.adresse = adresse;

  get getUser => this.user;

  set setUser(user) => this.user = user;

  get getGenre => this.genre;

  set setGenre(genre) => this.genre = genre;

  get getNom => this.nom;

  set setNom(nom) => this.nom = nom;

  get getTel => this.tel;

  set setTel(tel) => this.tel = tel;

  get getTaille => this.taille;

  set setTaille(taille) => this.taille = taille;

  get getAge => this.age;

  set setAge(age) => this.age = age;

  get getCreatAt => this.creatAt;

  set setCreatAt(creatAt) => this.creatAt = creatAt;



  Medecin({
    required this.idMedecin,
    required this.specialisation,
    required this.initial,
    required this.prenom,
    required this.num_licence,
    required this.adresse,
    required this.user,
    required this.genre,
    required this.nom,
    required this.tel,
    required this.taille,
    required this.age,
    required this.creatAt,
   // required this.serviceMedical,
  });


  Map<String, dynamic> toMap() {
    return {
      'idMedecin': idMedecin,
      'specialisation': specialisation,
      'initial': initial,
      'prenom': prenom,
      'num_licence': num_licence,
      'adresse': adresse,
      'user': user!.toMap(),
      'genre': genre,
      'nom': nom,
      'tel': tel,
      'taille': taille,
      'age': age,
      'creatAt': creatAt,
     // 'serviceMedical': serviceMedical!.toMap(),
    };
  }

  factory Medecin.fromMap(Map<String, dynamic> map) {
    return Medecin(
      idMedecin: map['idMedecin'],
      specialisation: map['specialisation'],
      initial: map['initial'],
      prenom: map['prenom'],
      num_licence: map['num_licence'],
      adresse: map['adresse'],
      user: Usermodel.fromMap(map['user']),
      genre: map['genre'],
      nom: map['nom'],
      tel: map['tel'],
      taille: map['taille'],
      age: map['age'],
      creatAt: map['creatAt'],
      //serviceMedical: Servicemedical.fromMap(map['serviceMedical']),
    );
  }

  String toJson() => json.encode(toMap());

  factory Medecin.fromJson(String source) =>
      Medecin.fromMap(json.decode(source));
}
