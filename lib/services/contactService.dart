import 'package:flutter/material.dart';
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
    return Contact.fromJson(jsonDecode(respo.body));
  } else {
    throw Exception('Failed to load contacts');
  }
}

  // ignore: dead_code
  Future<Contact> createContact(String nom, String email, String subject,
      String body, String message, DateTime date_contact) async {
    int id = 1;
    Contact contact = new Contact(
        id: id, nom: nom, email: email, subject: subject, message: message, date_contact: date_contact);
    final response = await http.post(
      Uri.parse('http://localhost:8888/api/contact'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<Contact, Contact>{contact: contact}),
    );

    if (response.statusCode == 201) {
      return Contact.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to create contact.');
    }
  }

  Future<Contact> getOneContact(int id) async {
  int idcontact = id;
    final respo = await http.get(Uri.parse(url+ "/"+ idcontact.toString()),
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer token $token'
        });
    if (respo.statusCode == 200) {
      return Contact.fromJson(jsonDecode(respo.body));
    } else {
      throw Exception('Failed to load contact with id'+ idcontact.toString() );
    }

  }
