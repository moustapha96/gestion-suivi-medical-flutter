import 'dart:convert';

import 'package:mygsmp/models/admin.dart';
import 'package:mygsmp/models/assistant.dart';
import 'package:mygsmp/models/medecin.dart';
import 'package:mygsmp/models/patient.dart';

class Usermodel {
  int iduser;
  String email;
  String password;
  String role;
  Assistant assistant;
  Medecin medecin;
  Patient patient;
  Admin admin;
  DateTime creatAt;
  Usermodel({
    required this.iduser,
    required this.email,
    required this.password,
    required this.role,
    required this.assistant,
    required this.medecin,
    required this.patient,
    required this.admin,
    required this.creatAt,
  });
  int get getIduser => this.iduser;

  set setIduser(int iduser) => this.iduser = iduser;

  get getEmail => this.email;

  set setEmail(email) => this.email = email;

  get getPassword => this.password;

  set setPassword(password) => this.password = password;

  get getRole => this.role;

  set setRole(role) => this.role = role;

  get getAssistant => this.assistant;

  set setAssistant(assistant) => this.assistant = assistant;

  get getMedecin => this.medecin;

  set setMedecin(medecin) => this.medecin = medecin;

  get getPatient => this.patient;

  set setPatient(patient) => this.patient = patient;

  get getAdmin => this.admin;

  set setAdmin(admin) => this.admin = admin;

  get getCreatAt => this.creatAt;

  set setCreatAt(creatAt) => this.creatAt = creatAt;

  Map<String, dynamic> toMap() {
    return {
      'iduser': iduser,
      'email': email,
      'password': password,
      'role': role,
      'assistant': assistant.toMap(),
      'medecin': medecin.toMap(),
      'patient': patient.toMap(),
      'admin': admin.toMap(),
      'creatAt': creatAt.millisecondsSinceEpoch,
    };
  }

  factory Usermodel.fromMap(Map<String, dynamic> map) {
    return Usermodel(
      iduser: map['iduser'],
      email: map['email'],
      password: map['password'],
      role: map['role'],
      assistant: Assistant.fromMap(map['assistant']),
      medecin: Medecin.fromMap(map['medecin']),
      patient: Patient.fromMap(map['patient']),
      admin: Admin.fromMap(map['admin']),
      creatAt: DateTime.fromMillisecondsSinceEpoch(map['creatAt']),
    );
  }

  String toJson() => json.encode(toMap());

  factory Usermodel.fromJson(String source) =>
      Usermodel.fromMap(json.decode(source));
}
