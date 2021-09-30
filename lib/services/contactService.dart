import 'package:mygsmp/models/contact.dart';
import 'package:http/http.dart' as http;

import 'dart:convert';

String url = 'http://localhost:8888/api/contact';
String path = '';
String endPath = '';
String token = '';
Future<Contact> fetchContact() async {
  final respo = await http.get(Uri.parse('http://localhost:8888/api/contact'),
      headers: {
        'Accept': 'application/json',
        'Authorization': 'Bearer token $token'
      });

  if (respo.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    return Contact.fromJson(jsonDecode(respo.body));
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load contacts');
  }

  // ignore: dead_code
  Future<Contact> createContact(String nom, String email, String subject,
      String body, String message, DateTime date_contact) async {
    int id = 1;
    Contact contact = new Contact(
        id: id,
        nom: nom,
        email: email,
        subject: subject,
        message: message,
        date_contact: date_contact);
    final response = await http.post(
      Uri.parse('http://localhost:8888/api/contact'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<Contact, Contact>{contact: contact}),
    );

    if (response.statusCode == 201) {
      // If the server did return a 201 CREATED response,
      // then parse the JSON.
      return Contact.fromJson(jsonDecode(response.body));
    } else {
      // If the server did not return a 201 CREATED response,
      // then throw an exception.
      throw Exception('Failed to create album.');
    }
  }
}
