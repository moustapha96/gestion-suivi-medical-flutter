import 'dart:convert';

import 'package:mygsmp/models/medecin.dart';

class Memos {
  int idMemos;
  String titre;
  String message;
  Medecin? medecin;
  DateTime date_creer;
  Memos({
    required this.idMemos,
    required this.titre,
    required this.message,
    required this.medecin,
    required this.date_creer,
  });

  Map <String, dynamic> toDatabaseJson() => {
    "idMemos": this.idMemos,
    "titre": this.titre,
    "message": this.message,
    "medecin": this.medecin,
    "date_creer": this.date_creer,
  };

  get getIdMemos => this.idMemos;

  set setIdMemos(idMemos) => this.idMemos = idMemos;

  get getTitre => this.titre;

  set setTitre(titre) => this.titre = titre;

  get getMessage => this.message;

  set setMessage(message) => this.message = message;

  get getMedecin => this.medecin;

  set setMedecin(medecin) => this.medecin = medecin;

  get datecreer => this.date_creer;

  set datecreer(value) => this.date_creer = value;

  Map<String, dynamic> toMap() {
    return {
      'idMemos': idMemos,
      'titre': titre,
      'message': message,
      'medecin': medecin!.toMap(),
      'date_creer': date_creer.millisecondsSinceEpoch,
    };
  }

  factory Memos.fromMap(Map<String, dynamic> map) {
    return Memos(
      idMemos: map['idMemos'],
      titre: map['titre'],
      message: map['message'],
      medecin: Medecin.fromMap(map['medecin']),
      date_creer: DateTime.fromMillisecondsSinceEpoch(map['date_creer']),
    );
  }

  String toJson() => json.encode(toMap());

  factory Memos.fromJson(String source) => Memos.fromMap(json.decode(source));
}
