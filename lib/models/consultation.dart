import 'dart:convert';

import 'package:mygsmp/models/dossier_medical.dart';

class Consultation {
  int idConsultation;

  String diagnostic;
  String traitement;


  DateTime date_consultation = DateTime.now();

  int get getIdConsultation => this.idConsultation;

  set setIdConsultation(int idConsultation) =>
      this.idConsultation = idConsultation;
  Consultation(
      {required this.idConsultation,
      required this.diagnostic,
      required this.traitement,
      //required this.date_consultation
      });

  get getDiagnostic => this.diagnostic;
  set setDiagnostic(diagnostic) => this.diagnostic = diagnostic;
  get getTraitement => this.traitement;
  set setTraitement(traitement) => this.traitement = traitement;
  get dateconsultation => this.date_consultation;
  set dateconsultation(value) => this.date_consultation = value;

  Map<String, dynamic> toMap() {
    return {
      'idConsultation': idConsultation,
      'diagnostic': diagnostic,
      'traitement': traitement,
      'date_consultation': date_consultation.millisecondsSinceEpoch
    };
  }

  factory Consultation.fromMap(Map<String, dynamic> map) {
    return Consultation(
        idConsultation: map['idConsultation'],
        diagnostic: map['diagnostic'],
        traitement: map['traitement'],
        // date_consultation:
        //     DateTime.fromMillisecondsSinceEpoch(map['date_consultation'])
    );
  }


  String toJson() => json.encode(toMap());

  factory Consultation.fromJson(String source) =>
      Consultation.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Consultation{idConsultation: $idConsultation, diagnostic: $diagnostic, traitement: $traitement,'
        'date_consultation: $date_consultation}';
  }

}
