import 'dart:convert';

import 'package:mygsmp/models/userModel.dart';

class Assistant {
  int idAssistant;
  String prenom;
  String adresse;
  String genre;
  Usermodel user;
  String nom;
  String tel;
  int age;
  DateTime creatAt;
  Assistant({
    required this.idAssistant,
    required this.prenom,
    required this.adresse,
    required this.genre,
    required this.user,
    required this.nom,
    required this.tel,
    required this.age,
    required this.creatAt,
  });
  int get getIdAssistant => this.idAssistant;

  set setIdAssistant(int idAssistant) => this.idAssistant = idAssistant;

  get getPrenom => this.prenom;

  set setPrenom(prenom) => this.prenom = prenom;

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

  get getAge => this.age;

  set setAge(age) => this.age = age;

  get getCreatAt => this.creatAt;

  set setCreatAt(creatAt) => this.creatAt = creatAt;

  Map<String, dynamic> toMap() {
    return {
      'idAssistant': idAssistant,
      'prenom': prenom,
      'adresse': adresse,
      'genre': genre,
      'user': user.toMap(),
      'nom': nom,
      'tel': tel,
      'age': age,
      'creatAt': creatAt.millisecondsSinceEpoch,
    };
  }

  factory Assistant.fromMap(Map<String, dynamic> map) {
    return Assistant(
      idAssistant: map['idAssistant'],
      prenom: map['prenom'],
      adresse: map['adresse'],
      genre: map['genre'],
      user: Usermodel.fromMap(map['user']),
      nom: map['nom'],
      tel: map['tel'],
      age: map['age'],
      creatAt: DateTime.fromMillisecondsSinceEpoch(map['creatAt']),
    );
  }

  String toJson() => json.encode(toMap());

  factory Assistant.fromJson(String source) =>
      Assistant.fromMap(json.decode(source));
}
