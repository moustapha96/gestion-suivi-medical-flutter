import 'dart:convert';

import 'package:mygsmp/models/assistant.dart';
import 'package:mygsmp/models/medecin.dart';

class Servicemedical {
  int idServiceMedical;
  List<Medecin> medecins;
  List<Assistant> assistants;
  String nom;
  DateTime creatAt;
  Servicemedical({
    required this.idServiceMedical,
    required this.medecins,
    required this.assistants,
    required this.nom,
    required this.creatAt,
  });
  int get getIdServiceMedical => this.idServiceMedical;

  set setIdServiceMedical(int idServiceMedical) =>
      this.idServiceMedical = idServiceMedical;

  get getMedecins => this.medecins;

  set setMedecins(medecins) => this.medecins = medecins;

  get getAssistants => this.assistants;

  set setAssistants(assistants) => this.assistants = assistants;

  get getNom => this.nom;

  set setNom(nom) => this.nom = nom;

  get getCreatAt => this.creatAt;

  set setCreatAt(creatAt) => this.creatAt = creatAt;

  Map<String, dynamic> toMap() {
    return {
      'idServiceMedical': idServiceMedical,
      'medecins': medecins.map((x) => x.toMap()).toList(),
      'assistants': assistants.map((x) => x.toMap()).toList(),
      'nom': nom,
      'creatAt': creatAt.millisecondsSinceEpoch,
    };
  }

  factory Servicemedical.fromMap(Map<String, dynamic> map) {
    return Servicemedical(
      idServiceMedical: map['idServiceMedical'],
      medecins:
          List<Medecin>.from(map['medecins']?.map((x) => Medecin.fromMap(x))),
      assistants: List<Assistant>.from(
          map['assistants']?.map((x) => Assistant.fromMap(x))),
      nom: map['nom'],
      creatAt: DateTime.fromMillisecondsSinceEpoch(map['creatAt']),
    );
  }

  String toJson() => json.encode(toMap());

  factory Servicemedical.fromJson(String source) =>
      Servicemedical.fromMap(json.decode(source));
}
