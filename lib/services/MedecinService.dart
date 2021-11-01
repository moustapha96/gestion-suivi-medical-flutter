import 'package:flutter/material.dart';
import 'package:mygsmp/models/contact.dart';
import 'package:http/http.dart' as http;

import 'dart:convert';

import 'package:mygsmp/models/medecin.dart';

String _base = "http://localhost:8888/api/medecins/1";
var client = new http.Client();
String data = "";

Future<Medecin> getOneMedecin() async {
  final http.Response response = await client.get(
    Uri.parse(_base),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
  );
  if (response.statusCode == 200) {
    final responseJson = jsonDecode(response.body);
    Medecin medecin = new Medecin(
        idMedecin: responseJson['idMedecin'],
        specialisation: responseJson['specialisation'],
        initial: responseJson['initial'],
        prenom: responseJson['prenom'],
        num_licence: responseJson['num_licence'],
        adresse: responseJson['adresse'],
        genre: responseJson['genre'],
        nom: responseJson['nom'],
        tel: responseJson['tel'],
        taille: responseJson['taille'],
        age: responseJson['age'],
        creatAt: responseJson['creatAt'].toString(), user: null );
    return medecin;
  } else {
    print(json.decode(response.body).toString());
    throw Exception(json.decode(response.body));
  }
}

Future<List<Medecin>> fetchMedecins() async {
  final response =
      await http.get(Uri.parse("http://localhost:8888/api/medecins"));

  if (response.statusCode == 200) {
    var responseJson = json.decode(response.body);
    print((responseJson as List).map((p) => Medecin.fromJson(p)).toList());

    return (responseJson).map((p) => Medecin.fromJson(p)).toList();
  } else {
    throw Exception('Failed to load server data');
  }
}
