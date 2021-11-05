import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:mygsmp/models/medecin.dart';
import 'package:mygsmp/models/patient.dart';
import 'package:mygsmp/models/userLogin.dart';
import 'package:mygsmp/models/userModel.dart';
import 'package:mygsmp/pages/medecin/accueil.dart';
import 'package:mygsmp/pages/patient/accueilPatient.dart';
import 'package:mygsmp/services/UserModelService.dart';

import 'package:http/http.dart' as http;

import '../main.dart';

class Login extends StatefulWidget {
  @override
  _Login createState() => _Login();
}

class _Login extends State<Login> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  late Usermodel user;
  late Medecin medecin;
  late Patient patient;


  void creerCompte() {
    Navigator.pushNamed(context, '/inscription');
  }

  void login() {
    print("connexion");
    UserLogin login = new UserLogin(
      email: emailController.text,
      password: passwordController.text,
    );
    var data = getUserByLogin(login);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
            appBar: AppBar(
              title: Text("GSMP"),
              backgroundColor: Colors.amber,
              elevation: 10.0,
              automaticallyImplyLeading: true,
            ),
            body: Center(
              child: Container(
                padding: EdgeInsets.all(10),
                margin: EdgeInsets.all(2),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(2),
                    image: DecorationImage(
                        image: AssetImage("images/md.jpg"), fit: BoxFit.cover)),
                child: Column(
                  children: <Widget>[
                    Container(
                        margin: EdgeInsets.fromLTRB(0, 50, 0, 0),
                        alignment: Alignment.center,
                        child: Text(
                          'Connexion',
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 25),
                        )),
                    Container(
                      padding: EdgeInsets.all(10),
                      margin: EdgeInsets.fromLTRB(0, 20, 0, 0),
                      child: TextField(
                        controller: emailController,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Email',
                        ),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
                      child: TextField(
                        obscureText: true,
                        controller: passwordController,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Password',
                        ),
                      ),
                    ),
                    Container(
                        height: 50,
                        width: 200,
                        child: TextButton(
                          child: Text(
                            'Se Connecter',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                                color: Colors.black),
                          ),
                          onPressed: login,
                        )),
                    Container(
                        margin: EdgeInsets.fromLTRB(0, 0, 10, 0),
                        alignment: Alignment.bottomRight,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: <Widget>[
                            TextButton(
                              onPressed: () {
                                print("bouton forget password");
                              },
                              child: Text(
                                'Forgot Password',
                                style: TextStyle(fontStyle: FontStyle.italic),
                              ),
                            ),
                            TextButton(
                                onPressed: creerCompte,
                                child: Text(
                                  'creer un compte',
                                  style: TextStyle(fontSize: 20),
                                ))
                          ],
                        ))
                  ],
                ),
              ),
            )));
  }

  Future<String> getUserByLogin(UserLogin userLogin) async {
    String _base = "http://localhost:8888/api/User/login";
    final http.Response response = await http.post(
      Uri.parse(_base),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(userLogin.toDatabaseJson()),
    );
    setState(() {
      var data = json.decode(response.body);
      print(data);
      user = new Usermodel(
          iduser: data['id'],
          email: data['email'],
          password: data['password'],
          role: data['role']);

      if (user.getRole == 'patient') {
        var rr = getPatientById(user.getEmail, data['token']);
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AccueilPatient(),
            ));
      } else if (user.getRole == 'medecin') {
        var rr = getMedecinById(user.getEmail, data['token']);
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AcceuilMedecin(medecin: this.medecin),
            ));
      }
    });
    return ("success");
  }

  Future<String> getPatientById(String email, String token) async {
    String _base_email = "http://localhost:8888/api/patients/user";
    final http.Response response = await http
        .get(Uri.parse(_base_email + "/" + email), headers: {
      'Accept': 'application/json',
      'Authorization': 'Bearer token $token'
    });
    setState(() {
      Patient patient = new Patient.fromMap(jsonDecode(response.body));
      this.patient = patient;
    });
    return "Success";
  }

  Future<String> getMedecinById(String email, String token) async {
    String _base_email_me = "http://localhost:8888/api/medecins/user";
    final http.Response response = await http
        .get(Uri.parse(_base_email_me + "/" + email), headers: <String, String>{
      'Accept': 'application/json',
      'Authorization': 'Bearer token $token'
    });
    setState(() {
      Medecin medecin = new Medecin.fromMap(jsonDecode(response.body));
      this.medecin = medecin;
    });
    return "Success";
  }
}
