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

import 'package:fluttertoast/fluttertoast.dart';

import 'inscription.dart';

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
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => CreateAccount()),
    );
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
    circular();
    String _base = "http://localhost:8008/api/User/login";
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
          role: data['role'],
      //    creatAt: data['creatAt']
      );

      if (response.statusCode == 200) {
        if (user.getRole == 'patient') {
          Navigator.push(
              context,
          MaterialPageRoute(
              builder: (context) => AccueilPatient(email: user.getEmail, token: data['token'])));
          
        } else if (user.getRole == 'medecin') {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) =>
                    AcceuilMedecin(emailmedecin: user.getEmail,  token: data['token'] ),
              ));
        }
        showToast("connexion réussi : " + user.getEmail);
      } else {
        showToast(" erreur :  "+response.statusCode.toString()  );
      }
    });
    return ("success");
  }

  void showToast(String m) {
    Fluttertoast.showToast(
        msg: " " + m,
        webPosition: "center",
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 3);
  }

  SizedBox circular() {
    return SizedBox(
      width: 200,
      height: 200,
      child: CircularProgressIndicator(
        strokeWidth: 10,
        backgroundColor: Colors.cyanAccent,
        valueColor: new AlwaysStoppedAnimation<Color>(Colors.red),
      ),
    );
  }

}
