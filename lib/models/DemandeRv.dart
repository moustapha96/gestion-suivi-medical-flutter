import 'dart:convert';

import 'package:mygsmp/models/medecin.dart';
import 'package:mygsmp/models/patient.dart';

class Demanderv {
  int id;
  DateTime date_demnande;
  Patient? patient;
  Medecin? medecin;

  Demanderv({
    required this.id,
    required this.date_demnande,
    required this.patient,
    required this.medecin,
  });

  int get getId => this.id;

  set setId(int id) => this.id = id;

  get datedemnande => this.date_demnande;

  set datedemnande(value) => this.date_demnande = value;

  get getPatient => this.patient;

  set setPatient(patient) => this.patient = patient;

  get getMedecin => this.medecin;

  set setMedecin(medecin) => this.medecin = medecin;

  @override
  String toString() {
    return 'Demanderv(id: $id, date_demnande: $date_demnande, patient: $patient, medecin: $medecin)';
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'date_demnande': date_demnande.millisecondsSinceEpoch,
      'patient': patient?.toMap(),
      'medecin': medecin?.toMap(),
    };
  }

  factory Demanderv.fromMap(Map<String, dynamic> map) {
    return Demanderv(
      id: map['id'],
      date_demnande: DateTime.fromMillisecondsSinceEpoch(map['date_demnande']),
      patient: Patient.fromMap(map['patient']),
      medecin: Medecin.fromMap(map['medecin']),
    );
  }

  String toJson() => json.encode(toMap());

  factory Demanderv.fromJson(String source) =>
      Demanderv.fromMap(json.decode(source));

  Map<String, dynamic> toDatabaseJson() => {
    "id": this.id,
    "date_demande": this.date_demnande,
    "patient": this.patient?.toDatabaseJson(),
    "medecin": this.medecin?.toDatabaseJson(),
  };

}
