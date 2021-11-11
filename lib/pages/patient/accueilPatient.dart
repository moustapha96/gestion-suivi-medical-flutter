import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mygsmp/models/patient.dart';
import 'package:mygsmp/models/userModel.dart';
import 'package:mygsmp/widget/components/patient/drawerPatient.dart';
import 'package:mygsmp/widget/components/patient/footer_patient.dart';
import 'package:mygsmp/widget/components/patient/header_patient.dart';
import 'package:mygsmp/widget/screen/buildCardSidebox.dart';
import 'package:http/http.dart' as http;

class AccueilPatient extends StatefulWidget {
  String email;
  String token;

  AccueilPatient({required this.email, required this.token});

  @override
  _AccueilPatientState createState() =>
      _AccueilPatientState(email: email, token: token);
}

class _AccueilPatientState extends State<AccueilPatient> {
  String email;
  String token;

  _AccueilPatientState({required this.email, required this.token});

  Patient patientC = new Patient(
      id: 0,
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
      creatAt: DateTime.now());

  @override
  void initState() {
    print("email" + email);
    super.initState();
    getPatientById(email, token);
    print(this.patientC);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBarNavgationPatient(context, 'Accueil Patient'),
      drawer: buildDrawerNavgationPatient(context, email, token),
      body: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(2),
            image: DecorationImage(
                image: AssetImage("images/md.jpg"), fit: BoxFit.cover)),
        child: Column(
          children: [
            Center(
                child: Container(
              margin: EdgeInsets.fromLTRB(0, 20, 0, 0),
              child: Text(
                'Menu ',
                style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Arial Rounded MT Bold'),
              ),
            )),
            buildCorpsPage(context),
          ],
        ),
      ),
    );
  }

  Container buildCorpsPage(BuildContext context) {
    return Container(
        alignment: Alignment.center,
        margin: EdgeInsets.fromLTRB(0, 20, 0, 0),
        child: Table(
          children: [
            TableRow(children: [
              TableCell(
                  child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  buildCard(
                      context,
                      'Rv',
                      'Rendez-vous',
                      '/patient/rv',
                      Icons.connect_without_contact,
                      this.email,
                      this.token),
                  buildCard(context, 'memos', 'publication', '/patient/memos',
                      Icons.post_add, this.email, this.token),
                ],
              )),
            ]),
            TableRow(children: [
              TableCell(
                  child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  buildCard(
                      context,
                      'Demande',
                      'Demande-rv',
                      '/patient/demandeRv',
                      Icons.group_add,
                      this.email,
                      this.token),
                  buildCard(context, 'Dm', 'dossier médical', '/patient/dm',
                      Icons.medical_services, this.email, this.token),
                ],
              )),
            ]),
            TableRow(children: [
              TableCell(
                  child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  buildCard(
                      context,
                      'Demande',
                      'nouveau demande',
                      '/patient/nouveauDemande',
                      Icons.portrait_sharp,
                      this.email,
                      this.token),
                ],
              )),
            ]),
          ],
        ));
  }

  buildFloatingActionButton(BuildContext context) {}

  Future<String> getPatientById(String email, String token) async {
    String _base_email = "http://localhost:8888/api/patients/user";
    final http.Response response = await http
        .get(Uri.parse(_base_email + "/" + email), headers: {
      'Accept': 'application/json',
      'Authorization': 'Bearer token $token'
    });
    setState(() {
      //Patient patient = new Patient.fromMap(jsonDecode(response.body));
      var data = jsonDecode(response.body);
      this.patientC = new Patient(
          id: data["id"],
          statut_social: data["statut_social"],
          prenom: data["prenom"],
          profession: data["profession"],
          adresse: data["adresse"],
          genre: data["genre"],
          user: new Usermodel.fromMap( data["user"]),
          nom: data["nom"],
          tel: data["tel"],
          taille: data["taille"],
          age: data["age"],
          creatAt: DateTime.parse( data["creatAt"] )) ;
    });
    return "Success";
  }
}
