import 'package:flutter/material.dart';
import 'package:mygsmp/models/contact.dart';
import 'package:http/http.dart' as http;

import 'dart:convert';

import 'package:mygsmp/models/medecin.dart';
import 'package:mygsmp/models/patient.dart';

String _base = "http://localhost:8888/api/patients/1";
String _base_email = "http://localhost:8888/api/patients/user";

var client = new http.Client();
String data = "";

Future getOnePatient() async {
  final http.Response response = await client.get(
    Uri.parse(_base),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
  );
  return Patient.fromJson(response.body);
  /* if (response.statusCode == 200) {
    final responseJson = jsonDecode(response.body);
    print(responseJson);
    Patient patient = new Patient(
        adresse: responseJson['adresse'],
        genre: responseJson['genre'],
        nom: responseJson['nom'],
        tel: responseJson['tel'],
        taille: responseJson['taille'],
        age: responseJson['age'],
        creatAt: responseJson['creatAt'].toString(),
        user: null,
        statut_social: responseJson['statut_social'],
        prenom: responseJson['prenom'],
        profession: responseJson['profession'],
        idPatient: responseJson['id']);
    return patient;
  } else {
    print(json.decode(response.body).toString());
    throw Exception(json.decode(response.body));
  }*/
}

Future<Patient> getPatientById(String email, String token) async {
  final http.Response response = await http
      .get(Uri.parse(_base_email + "/" + email), headers: {
    'Accept': 'application/json',
    'Authorization': 'Bearer token $token'
  });

  print(response.body);
  Patient patient = Patient.fromMap (jsonDecode(response.body));
  print(patient.getAdresse);
  return patient;
}
