import 'dart:convert';

class Usermodel {
  int iduser;
  String email;
  String password;
  String role;
  DateTime creatAt = DateTime.now();
  Usermodel({
    required this.iduser,
    required this.email,
    required this.password,
    required this.role
  });
  int get getIduser => this.iduser;

  set setIduser(int iduser) => this.iduser = iduser;

  get getEmail => this.email;

  set setEmail(email) => this.email = email;

  get getPassword => this.password;

  set setPassword(password) => this.password = password;

  get getRole => this.role;

  set setRole(role) => this.role = role;

  get getCreatAt => this.creatAt;

  set setCreatAt(creatAt) => this.creatAt = creatAt;

  Map<String, dynamic> toMap() {
    return {
      'iduser': iduser,
      'email': email,
      'password': password,
      'role': role,
      'creatAt': creatAt.millisecondsSinceEpoch,
    };
  }

  factory Usermodel.fromMap(Map<String, dynamic> map) {
    return Usermodel(
      iduser: map['iduser'],
      email: map['email'],
      password: map['password'],
      role: map['role'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Usermodel.fromJson(String source) =>
      Usermodel.fromMap(json.decode(source));
}
