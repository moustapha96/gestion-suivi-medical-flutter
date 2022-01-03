import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mygsmp/widget/components/medecin/drawer.dart';
import 'package:mygsmp/widget/components/medecin/footer_medecin.dart';
import 'package:mygsmp/widget/components/medecin/header_medecin.dart';
import 'package:http/http.dart' as http;
import 'package:mygsmp/widget/screen/DetailPatientScreen.dart';

class MedecinPatient extends StatefulWidget {
  @override
  MedecinPatientState createState() => new MedecinPatientState();
}

class MedecinPatientState extends State<MedecinPatient> {
  List _data = [];

  @override
  void initState() {
    getAllPatient();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBarNavgation(context, "Liste des Patients"),
      drawer: buildDrawerNavgation(context),
      body: Container(
        margin: EdgeInsets.all(2),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(2),
            image: DecorationImage(
                image: AssetImage("images/md.jpg"), fit: BoxFit.cover)),
        child: buildCorpsPage(context),
      ),
      bottomNavigationBar: buildBottomNavigationBar(context),
    );
  }

  buildCorpsPage(BuildContext context) {
    final ScrollController _scrollController = ScrollController();
    return Center(
        child: SizedBox(
      height: MediaQuery.of(context).size.height * 0.5,
      child: ListView.builder(
          itemCount: _data.length,
          itemBuilder: (context, indice) {
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 1, horizontal: 4),
              child: Card(
                color: Colors.blueGrey,
                elevation: 20,
                child: ListTile(
                  title: Text(
                      _data[indice]['prenom'] + ' ' + _data[indice]['nom']),
                  subtitle: Text(_data[indice]['adresse'] +
                      ' => ' +
                      _data[indice]['profession']),
                  onTap: () {
                    print(_data[indice]);
                    BuildDialogAlert(context, indice);
                  },
                ),
              ),
            );
          }),
    ));
  }

  Future<String> getAllPatient() async {
    final http.Response response = await http.get(
      Uri.parse("http://localhost:8008/api/patients"),
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

  void BuildDialogAlert(BuildContext context, int index) {
    showDialog<void>(
      context: context,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          title: Text('Détail du Patient'),
          backgroundColor: Colors.transparent,
          content: SingleChildScrollView(
              child: Card(
                  margin: EdgeInsets.all(2),
                  elevation: 10,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      SizedBox(
                        //height: MediaQuery.of(context).size.height * 0.7,
                        child: Card(
                          elevation: 10,
                          color: Colors.blueGrey,
                          child: Column(
                            children: <Widget>[
                              ListTile(
                                hoverColor: Colors.lightBlueAccent,
                                title: Text(
                                    _data[index]['prenom'] +
                                        ' ' +
                                        _data[index]['nom'],
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 12)),
                                subtitle: Text('prenom && nom'),
                              ),
                              ListTile(
                                hoverColor: Colors.lightBlueAccent,
                                title: Text(_data[index]['adresse'],
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 12)),
                                subtitle: Text('adresse'),
                              ),
                              ListTile(
                                hoverColor: Colors.lightBlueAccent,
                                title: Text(_data[index]['statut_social'],
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 12)),
                                subtitle: Text('Statut Social'),
                              ),
                              ListTile(
                                hoverColor: Colors.lightBlueAccent,
                                title: Text(
                                    _data[index]['taille'].toString() + " cm",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 12)),
                                subtitle: Text('taille'),
                              ),
                              ListTile(
                                hoverColor: Colors.lightBlueAccent,
                                title: Text(_data[index]['genre'],
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 12)),
                                subtitle: Text('genre'),
                              ),
                              ListTile(
                                hoverColor: Colors.lightBlueAccent,
                                title: Text(
                                    _data[index]['age'].toString() + ' ans',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 12)),
                                subtitle: Text('age'),
                              ),
                              ListTile(
                                hoverColor: Colors.lightBlueAccent,
                                title: Text(_data[index]['profession'],
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 12)),
                                subtitle: Text('profession'),
                              ),
                              ListTile(
                                hoverColor: Colors.lightBlueAccent,
                                title: Text(_data[index]['tel'].toString(),
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 12)),
                                subtitle: Text('TEL'),
                              ),
                              ListTile(
                                hoverColor: Colors.lightBlueAccent,
                                title: Text(_data[index]['user']['email'],
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 12)),
                                subtitle: Text('email'),
                              ),
                            ],
                          ),
                        ),
                      )
                    ],
                  ))),
          actions: <Widget>[
            TextButton(
              child: Text('Quittez'),
              onPressed: () {
                Navigator.of(dialogContext).pop(); // Dismiss alert dialog
              },
            ),
          ],
        );
      },
    );
  }
}
