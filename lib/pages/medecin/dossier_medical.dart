import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mygsmp/models/consultation.dart';
import 'package:mygsmp/models/dossier_medical.dart';
import 'package:mygsmp/models/patient.dart';
import 'package:mygsmp/models/userModel.dart';
import 'package:mygsmp/services/DossierMedicalService.dart';
import 'package:mygsmp/widget/components/medecin/drawer.dart';
import 'package:mygsmp/widget/components/medecin/footer_medecin.dart';
import 'package:mygsmp/widget/components/medecin/header_medecin.dart';

import 'package:http/http.dart' as http;
import 'package:mygsmp/widget/screen/DetailDmScreen.dart';

class MedecinDms extends StatefulWidget {
  @override
  MedecinDmState createState() => new MedecinDmState();
}

class MedecinDmState extends State<MedecinDms> {
  List _data = [];

  @override
  void initState() {
    getAllDms();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBarNavgation(context),
      drawer: buildDrawerNavgation(context),
      body: Container(
          margin: EdgeInsets.all(2),
          alignment: Alignment.center,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(2),
              image: DecorationImage(
                  image: AssetImage("images/md.jpg"), fit: BoxFit.cover)),
          child: Container(
            margin: EdgeInsets.all(7),
            child: buildCorpsPage(context),
          )),
      //body : buildCorpsPage(context),
      bottomNavigationBar: buildBottomNavigationBar(context),
    );
  }

  buildCorpsPage(BuildContext context) {
    return ListView.separated(
      itemCount: _data == null ? 0 : _data.length,
      itemBuilder: (BuildContext context, int index) {
        return BuildCardDossierMedical(context, index);
      },
      separatorBuilder: (BuildContext context, int index) => (const Divider(
        thickness: 10,
      )),
    );
  }

  Future<String> getAllDms() async {
    final http.Response response = await client.get(
      Uri.parse("http://localhost:8888/api/dms"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );
    setState(() {
      _data = json.decode(response.body);
    });
    print(_data);
    return "succes";
  }

  Card BuildCardDossierMedical(BuildContext context, int index) {
    return Card(
      child: Container(
        height: 100,
        color: Colors.white,
        child: Row(
          children: [
            Expanded(
              child: Container(
                alignment: Alignment.topLeft,
                child: Column(
                  children: [
                    Expanded(
                      flex: 5,
                      child: ListTile(
                        title: Text(_data[index]['patient']['prenom'] +
                            " " +
                            _data[index]['patient']['nom']),
                        subtitle:
                            Text(_data[index]['patient']['statut_social']),
                      ),
                    ),
                    Expanded(
                      flex: 5,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          TextButton(
                            child: Text("Consultations"),
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => DetailDmScreen(data: _data,index: index),
                                ),
                              );

                            },
                          ),
                          SizedBox(
                            width: 8,
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
              flex: 8,
            ),
          ],
        ),
      ),
      elevation: 8,
      margin: EdgeInsets.all(10),

    );
  }

  void displayDialog(BuildContext context, int index) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return SimpleDialog(
            elevation: 5,
            // backgroundColor: Colors.amberAccent,
            title: Text(
              'Dossier Médical',
              textAlign: TextAlign.center,
            ),
            children: [
              SingleChildScrollView(
                child: Column(
                  children: [
                    ListView.builder(
                        padding: const EdgeInsets.all(8),
                        itemCount: _data[index]['consultations'].length,
                        shrinkWrap: true,
                        itemBuilder: (BuildContext context, int indexx) {
                          return Container(
                            height: 50,
                            child: Center(
                                child: Text('N°: ' +
                                    _data[index]['consultations'][indexx]
                                        ['idConsultation'])),
                          );
                        })
                  ],
                ),
              )
            ],
          );
        });
  }
}
