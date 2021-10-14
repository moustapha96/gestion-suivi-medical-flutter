import 'dart:js';

import 'package:flutter/material.dart';
import 'package:mygsmp/models/userLogin.dart';
import 'package:mygsmp/models/userModel.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

String _base = "http://localhost:8888/api/User/login";

Future<Usermodel> getUserByLogin(UserLogin userLogin) async {

  final http.Response response = await http.post( Uri.parse(_base) ,
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(userLogin.toDatabaseJson()),
  );
  if (response.statusCode == 200) {

    var responseJson = json.decode(response.body);

    Usermodel user = Usermodel(iduser: responseJson["id"], email: responseJson["email"], password: responseJson["password"],
                    role: responseJson['role']);
    print( responseJson );
    return (user);
  } else {

    print(json.decode(response.body).toString());
    throw Exception(json.decode(response.body));
  }
}
