import 'dart:convert';

import 'package:mygsmp/models/medecin.dart';
import 'package:mygsmp/models/notification.dart';
import 'package:mygsmp/models/patient.dart';

class Rendezvous {
  int idRendezVous;
  DateTime date_rv;
  String heure;
  Medecin? medecin;
  Patient? patient;
  DateTime creatAt = DateTime.now();
  Rendezvous({
    required this.idRendezVous,
    required this.date_rv,
    required this.heure,
    required this.medecin,
    required this.patient,
  });
  get getIdRendezVous => this.idRendezVous;

  set setIdRendezVous(idRendezVous) => this.idRendezVous = idRendezVous;

  get daterv => this.date_rv;

  set daterv(value) => this.date_rv = value;

  get getHeure => this.heure;

  set setHeure(heure) => this.heure = heure;

  get getMedecin => this.medecin;

  set setMedecin(medecin) => this.medecin = medecin;

  get getPatient => this.patient;

  set setPatient(patient) => this.patient = patient;

  get getCreatAt => this.creatAt;

  set setCreatAt(creatAt) => this.creatAt = creatAt;

  Map<String, dynamic> toMap() {
    return {
      'idRendezVous': idRendezVous,
      'date_rv': date_rv.millisecondsSinceEpoch,
      'heure': heure,
      'medecin': medecin!.toMap(),
      'patient': patient!.toMap(),
      'creatAt': creatAt.millisecondsSinceEpoch,
    };
  }

  factory Rendezvous.fromMap(Map<String, dynamic> map) {
    return Rendezvous(
      idRendezVous: map['idRendezVous'],
      date_rv: DateTime.fromMillisecondsSinceEpoch(map['date_rv']),
      heure: map['heure'],
      medecin: Medecin.fromMap(map['medecin']),
      patient: Patient.fromMap(map['patient']),
      );
  }

  String toJson() => json.encode(toMap());

  factory Rendezvous.fromJson(String source) =>
      Rendezvous.fromMap(json.decode(source));

  Map<String, dynamic> toDatabaseJson() => {
    "idRendzVous": this.idRendezVous,
    "date_rv": this.date_rv,
    "heure": this.heure,
    "medecin": this.medecin,
    "patient": this.patient,
  };
}
