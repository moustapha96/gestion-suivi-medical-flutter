import 'dart:convert';

import 'package:mygsmp/models/medecin.dart';
import 'package:mygsmp/models/patient.dart';
import 'package:mygsmp/models/rendezVous.dart';

class Notification {
  int idNotification;
  String titre;
  String message;
  Patient patient;
  Medecin medecin;
  Rendezvous rendezVous;
  DateTime date_creer;
  Notification({
    required this.idNotification,
    required this.titre,
    required this.message,
    required this.patient,
    required this.medecin,
    required this.rendezVous,
    required this.date_creer,
  });
  int get getIdNotification => this.idNotification;

  set setIdNotification(int idNotification) =>
      this.idNotification = idNotification;

  get getTitre => this.titre;

  set setTitre(titre) => this.titre = titre;

  get getMessage => this.message;

  set setMessage(message) => this.message = message;

  get getPatient => this.patient;

  set setPatient(patient) => this.patient = patient;

  get getMedecin => this.medecin;

  set setMedecin(medecin) => this.medecin = medecin;

  get getRendezVous => this.rendezVous;

  set setRendezVous(rendezVous) => this.rendezVous = rendezVous;

  get datecreer => this.date_creer;

  set datecreer(value) => this.date_creer = value;

  Map<String, dynamic> toMap() {
    return {
      'idNotification': idNotification,
      'titre': titre,
      'message': message,
      'patient': patient.toMap(),
      'medecin': medecin.toMap(),
      'rendezVous': rendezVous.toMap(),
      'date_creer': date_creer.millisecondsSinceEpoch,
    };
  }

  factory Notification.fromMap(Map<String, dynamic> map) {
    return Notification(
      idNotification: map['idNotification'],
      titre: map['titre'],
      message: map['message'],
      patient: Patient.fromMap(map['patient']),
      medecin: Medecin.fromMap(map['medecin']),
      rendezVous: Rendezvous.fromMap(map['rendezVous']),
      date_creer: DateTime.fromMillisecondsSinceEpoch(map['date_creer']),
    );
  }

  String toJson() => json.encode(toMap());

  factory Notification.fromJson(String source) =>
      Notification.fromMap(json.decode(source));
}
