import 'dart:convert';

import 'package:mygsmp/models/DemandeRv.dart';
import 'package:mygsmp/models/dossier_medical.dart';
import 'package:mygsmp/models/notification.dart';
import 'package:mygsmp/models/rendezVous.dart';
import 'package:mygsmp/models/userModel.dart';

class Patient {
  int idPatient;
  String statut_social;
  String prenom;
  String profession;
  String adresse;
  String genre;
  Usermodel user;
  String nom;
  String tel;
  int taille;
  int age;
  DateTime creatAt = DateTime.now();
  List<Rendezvous>? rendezVous;
  DossierMedical? dossierMedical;
  List<Demanderv>? demandeRV;
  Patient({
    required this.idPatient,
    required this.statut_social,
    required this.prenom,
    required this.profession,
    required this.adresse,
    required this.genre,
    required this.user,
    required this.nom,
    required this.tel,
    required this.taille,
    required this.age,
    required this.rendezVous,
    required this.dossierMedical,
    required this.demandeRV,
  });


  int get getIdPatient => this.idPatient;

  set setIdPatient(int idPatient) => this.idPatient = idPatient;

  get statutsocial => this.statut_social;

  set statutsocial(value) => this.statut_social = value;

  get getPrenom => this.prenom;

  set setPrenom(prenom) => this.prenom = prenom;

  get getProfession => this.profession;

  set setProfession(profession) => this.profession = profession;

  get getAdresse => this.adresse;

  set setAdresse(adresse) => this.adresse = adresse;

  get getGenre => this.genre;

  set setGenre(genre) => this.genre = genre;

  get getUser => this.user;

  set setUser(user) => this.user = user;

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

  get getRendezVous => this.rendezVous;

  set setRendezVous(rendezVous) => this.rendezVous = rendezVous;

  get getDossierMedical => this.dossierMedical;

  set setDossierMedical(dossierMedical) => this.dossierMedical = dossierMedical;

  get getDemandeRV => this.demandeRV;

  set setDemandeRV(demandeRV) => this.demandeRV = demandeRV;

  Map<String, dynamic> toMap() {
    return {
      'idPatient': idPatient,
      'statut_social': statut_social,
      'prenom': prenom,
      'profession': profession,
      'adresse': adresse,
      'genre': genre,
      'user': user.toMap(),
      'nom': nom,
      'tel': tel,
      'taille': taille,
      'age': age,
      'creatAt': creatAt.millisecondsSinceEpoch,
      'rendezVous': rendezVous!.map((x) => x.toMap()).toList(),
      'dossierMedical': dossierMedical!.toMap(),
      'demandeRV': demandeRV!.map((x) => x.toMap()).toList(),
    };
  }

  factory Patient.fromMap(Map<String, dynamic> map) {
    return Patient(
      idPatient: map['idPatient'],
      statut_social: map['statut_social'],
      prenom: map['prenom'],
      profession: map['profession'],
      adresse: map['adresse'],
      genre: map['genre'],
      user: Usermodel.fromMap(map['user']),
      nom: map['nom'],
      tel: map['tel'],
      taille: map['taille'],
      age: map['age'],
      rendezVous: List<Rendezvous>.from(
          map['rendezVous']?.map((x) => Rendezvous.fromMap(x))),
      dossierMedical: DossierMedical.fromMap(map['dossierMedical']),
      demandeRV: List<Demanderv>.from(
          map['demandeRV']?.map((x) => Demanderv.fromMap(x))),
    );
  }

  String toJson() => json.encode(toMap());


  factory Patient.fromJson(String source) =>
      Patient.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Patient{idPatient: $idPatient, statut_social: $statut_social, prenom: $prenom, profession: $profession, adresse: $adresse, genre: $genre, user: $user, nom: $nom, tel: $tel, taille: $taille, age: $age, creatAt: $creatAt, rendezVous: $rendezVous, dossierMedical: $dossierMedical, demandeRV: $demandeRV}';
  }
}
