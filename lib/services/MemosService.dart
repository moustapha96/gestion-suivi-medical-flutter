import 'dart:js';

import 'package:flutter/material.dart';
import 'package:mygsmp/models/memos.dart';
import 'package:mygsmp/models/userLogin.dart';
import 'package:mygsmp/models/userModel.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

String _base = "http://localhost:8888/api/memos";
var client = new http.Client();

Future<String> getAllMemos() async {
  final http.Response response = await client.post( Uri.parse(_base) ,
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
  );
  if (response.statusCode == 200) {
    List data = json.decode(response.body);
    return (data[1]['message']);
  } else {
    print(json.decode(response.body).toString());
    throw Exception(json.decode(response.body));
  }
}