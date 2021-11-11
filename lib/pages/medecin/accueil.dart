import 'dart:convert';
import 'dart:html';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mygsmp/models/medecin.dart';
import 'package:mygsmp/models/userModel.dart';
import 'package:mygsmp/widget/components/medecin/drawer.dart';
import 'package:mygsmp/widget/components/medecin/footer_medecin.dart';
import 'package:mygsmp/widget/components/medecin/header_medecin.dart';
import 'package:mygsmp/widget/screen/buildCardSidebox.dart';
import'package:http/http.dart' as http;


class AcceuilMedecin extends StatefulWidget {
  String emailmedecin;
  String token;

  AcceuilMedecin({required this.emailmedecin, required this.token});

  @override
  _AcceuilMedecinState createState() =>
      _AcceuilMedecinState(emailmedecin: emailmedecin, token: token);
}

class _AcceuilMedecinState extends State<AcceuilMedecin> {
  String emailmedecin;
  String token;

  _AcceuilMedecinState({required this.emailmedecin, required this.token});

  Medecin? medecinC;
  @override
  void initState() {
    print("email" + emailmedecin);
    super.initState();
    getMedecinById(emailmedecin, token);
    //print(this.medecinC!.toJson());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBarNavgation(context, 'Menu Medecin'),
      drawer: buildDrawerNavgation(context),
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

  FloatingActionButton buildFloatingActionButton(BuildContext context) {
    return FloatingActionButton(
      onPressed: () {
        Navigator.pushNamed(context, '/medecin/newRv');
      },
      backgroundColor: Colors.green,
      child: Icon(
        Icons.add,
        color: Colors.amber,
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
                  buildCard(context, 'Rv', 'Rendez-vous', '/medecin/rv',
                      Icons.connect_without_contact , this.emailmedecin, this.token),
                  buildCard(context, 'memos', 'publication', '/medecin/memos',
                      Icons.post_add,  this.emailmedecin, this.token),
                ],
              )),
            ]),
            TableRow(children: [
              TableCell(
                  child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  buildCard(context, 'Demande', 'Demande-rv',
                      '/medecin/demanderv', Icons.group_add,  this.emailmedecin, this.token),
                  buildCard(context, 'patient', 'liste Patient',
                      '/medecin/patient', Icons.portrait_sharp,  this.emailmedecin, this.token),
                ],
              )),
            ]),
            TableRow(children: [
              TableCell(
                  child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  buildCard(context, 'Dm', 'dossier médical', '/medecin/dm',
                      Icons.medical_services ,  this.emailmedecin, this.token),
                  buildCard(context, 'Dm', 'dossier médical', '/medecin/dm',
                      Icons.medical_services ,  this.emailmedecin, this.token),
                ],
              )),
            ]),
          ],
        ));
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
      this.medecinC = medecin;
      print(medecin.toJson());
    });
    return "Success";
  }

}
