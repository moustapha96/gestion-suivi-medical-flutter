import 'dart:convert';

import 'package:mygsmp/models/consultation.dart';
import 'package:mygsmp/models/medecin.dart';
import 'package:mygsmp/models/patient.dart';

class DossierMedical {
  int idDossierMedical;

  Medecin medecin;

  Patient patient;

  List<Consultation> consultations;

  DateTime date_creation;
  DossierMedical({
    required this.idDossierMedical,
    required this.medecin,
    required this.patient,
    required this.consultations,
    required this.date_creation,
  });
  int get getIdDossierMedical => this.idDossierMedical;

  set setIdDossierMedical(int idDossierMedical) =>
      this.idDossierMedical = idDossierMedical;

  get getMedecin => this.medecin;

  set setMedecin(medecin) => this.medecin = medecin;

  get getPatient => this.patient;

  set setPatient(patient) => this.patient = patient;

  get getConsultations => this.consultations;

  set setConsultations(consultations) => this.consultations = consultations;

  get datecreation => this.date_creation;

  set datecreation(value) => this.date_creation = value;

  Map<String, dynamic> toMap() {
    return {
      'idDossierMedical': idDossierMedical,
      'medecin': medecin.toMap(),
      'patient': patient.toMap(),
      'consultations': consultations.map((x) => x.toMap()).toList(),
      'date_creation': date_creation.millisecondsSinceEpoch,
    };
  }

  factory DossierMedical.fromMap(Map<String, dynamic> map) {
    return DossierMedical(
      idDossierMedical: map['idDossierMedical'],
      medecin: Medecin.fromMap(map['medecin']),
      patient: Patient.fromMap(map['patient']),
      consultations: List<Consultation>.from(
          map['consultations']?.map((x) => Consultation.fromMap(x))),
      date_creation: DateTime.fromMillisecondsSinceEpoch(map['date_creation']),
    );
  }

  String toJson() => json.encode(toMap());

  factory DossierMedical.fromJson(String source) =>
      DossierMedical.fromMap(json.decode(source));
}
