import 'package:flutter/material.dart';
import 'package:mygsmp/models/contact.dart';
import 'package:http/http.dart' as http;

import 'dart:convert';

import 'package:mygsmp/models/medecin.dart';
import 'package:mygsmp/models/patient.dart';

String _base = "http://localhost:8888/api/patients/1";
var client = new http.Client();
String data = "";

Future<Patient> getOnePatient() async {
  final http.Response response = await client.get(
    Uri.parse(_base),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
  );
  if (response.statusCode == 200) {
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
  }
}
