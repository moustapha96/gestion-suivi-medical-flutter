import 'dart:convert';

import 'package:mygsmp/models/userModel.dart';

class Admin {
  int idAdmin;
  String prenom;
  String nom;
  Usermodel user;
  String profession;
  String tel;
  DateTime creatAt;
  Admin({
    required this.idAdmin,
    required this.prenom,
    required this.nom,
    required this.user,
    required this.profession,
    required this.tel,
    required this.creatAt,
  });

  int get getIdAdmin => this.idAdmin;

  set setIdAdmin(int idAdmin) => this.idAdmin = idAdmin;

  get getPrenom => this.prenom;

  set setPrenom(prenom) => this.prenom = prenom;

  get getNom => this.nom;

  set setNom(nom) => this.nom = nom;

  get getUser => this.user;

  set setUser(user) => this.user = user;

  get getProfession => this.profession;

  set setProfession(profession) => this.profession = profession;

  get getTel => this.tel;

  set setTel(tel) => this.tel = tel;

  get getCreatAt => this.creatAt;

  set setCreatAt(creatAt) => this.creatAt = creatAt;

  Map<String, dynamic> toMap() {
    return {
      'idAdmin': idAdmin,
      'prenom': prenom,
      'nom': nom,
      'user': user.toMap(),
      'profession': profession,
      'tel': tel,
      'creatAt': creatAt.millisecondsSinceEpoch,
    };
  }

  factory Admin.fromMap(Map<String, dynamic> map) {
    return Admin(
      idAdmin: map['idAdmin'],
      prenom: map['prenom'],
      nom: map['nom'],
      user: Usermodel.fromMap(map['user']),
      profession: map['profession'],
      tel: map['tel'],
      creatAt: DateTime.fromMillisecondsSinceEpoch(map['creatAt']),
    );
  }

  String toJson() => json.encode(toMap());

  factory Admin.fromJson(String source) => Admin.fromMap(json.decode(source));
}
