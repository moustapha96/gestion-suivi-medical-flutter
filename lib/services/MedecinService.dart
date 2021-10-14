import 'package:flutter/material.dart';
import 'package:mygsmp/models/contact.dart';
import 'package:http/http.dart' as http;

import 'dart:convert';


String _base = "http://localhost:8888/api/medecins/1";
var client = new http.Client();
String data="";

Future<String> getOneMedecin() async {
  final http.Response response = await client.get(
    Uri.parse(_base),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
  );

  data = json.decode(response.body);
  return "suceess";
}

