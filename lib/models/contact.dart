import 'dart:convert';

class Contact {
  int id;
  String nom;
  String email;
  String subject;
  String message;
  // ignore: non_constant_identifier_names
  final DateTime date_contact;

  Contact(
      {required this.id,
      required this.nom,
      required this.email,
      required this.subject,
      required this.message,
      required this.date_contact});

  factory Contact.fromJson(Map<String, dynamic> json) {
    return Contact(
        id: json['id'],
        nom: json['nom'],
        email: json['email'],
        subject: json['subject'],
        date_contact: json['date_contact'],
        message: json['message']);
  }
}
