
import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mygsmp/models/patient.dart';
import 'package:http/http.dart' as http;
import 'package:mygsmp/models/userModel.dart';

class Profil extends StatefulWidget{

  String email;
  String token;

  Profil({required this.email, required this.token});

  @override
  _ProfilState createState() =>
      _ProfilState(email: email, token: token);

  @override
  Widget build(BuildContext context) {
    return Scaffold(

    );
  }
  
}

class _ProfilState extends State<Profil>{
  String email;
  String token;

  _ProfilState({required this.email, required this.token});

  Patient patientC = new Patient(
    idPatient: 0,
    statut_social: "",
    prenom: "",
    profession: "",
    adresse: "",
    genre: "",
    user: null,
    nom: "",
    tel: "",
    taille: 0,
    age: 0,
    // creatAt: DateTime.now()
  );

  final _formKey = GlobalKey<FormState>();
  var _passKey = GlobalKey<FormFieldState>();

  String _password = '';

  String statutSocial = 'Célibataire';
  String prenom = '';
  String nom = '';
  String profession = '';
  String adresse = '';
  String genre = 'Masculin';
  double tel = 0;
  int taille = 0;
  int age = 0;
  String password = '';

  @override
  void initState() {
    print(email);
    super.initState();
    getPatientById();
    Timer(Duration(seconds: 2), () {
      print(this.patientC);
    });

  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profil'+ email),
        backgroundColor: Colors.lightBlueAccent,
      ),
      body: new Container(
        margin: EdgeInsets.all(10),
        padding: new EdgeInsets.fromLTRB(20, 5, 20, 5),
        child: SignUpForm(),
      ),
    );
  }

  Future<String> getPatientById() async {


    final http.Response response = await http.get(
      Uri.parse("http://localhost:8008/api/patients/user/${email}"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8','Authorization': 'Bearer token $token'
      },
    );
    setState(() {
      var data = jsonDecode(response.body);
      this.patientC = new Patient(
        idPatient: data["id"],
        statut_social: data["statut_social"],
        prenom: data["prenom"],
        profession: data["profession"],
        adresse: data["adresse"],
        genre: data["genre"],
        user: new Usermodel.fromMap(data["user"]),
        nom: data["nom"],
        tel: data["tel"],
        taille: data["taille"],
        age: data["age"],
        //creatAt: DateTime.parse( data["creatAt"] )
      );
    });
    return "Success";
  }


  Container SignUpForm(){
    return new Container();
  }
}