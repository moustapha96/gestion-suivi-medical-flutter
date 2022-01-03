import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:mygsmp/widget/components/patient/drawerPatient.dart';
import 'package:mygsmp/widget/components/patient/footer_patient.dart';
import 'package:mygsmp/widget/components/patient/header_patient.dart';

import 'package:http/http.dart' as http;

class PatientDemandeRv extends StatefulWidget {
  String email;
  String token;

  PatientDemandeRv({required this.email, required this.token});

  @override
  _PatientDemandeRvState createState() =>
      _PatientDemandeRvState(email: email, token: token);
}

class _PatientDemandeRvState extends State<PatientDemandeRv> {
  String email;
  String token;

  _PatientDemandeRvState({required this.email, required this.token});

  List _data = [];

  void initState() {
    print("email" + email);
    super.initState();
    getAllDemandeRv();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBarNavgationPatient(context, 'Demande RV'),
      drawer: buildDrawerNavgationPatient(context, email, token),
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
        ),
      ),
      bottomNavigationBar:
          buildBottomNavigationBarPatient(context, email, token),
      floatingActionButton: buildFloatingActionButton(context),
    );
  }

  buildCorpsPage(BuildContext context) {
    return ListView.separated(
      itemCount: _data == null ? 0 : _data.length,
      itemBuilder: (BuildContext context, int index) {
        return Card(
          margin: EdgeInsets.all(10),
          elevation: 12,
          child: ListTile(
            onTap: () {
              displayDialogMedecin(context, index);
            },
            leading: CircleAvatar(
              backgroundColor: Colors.amber,
              radius: 30,
              child: Text("N°: " + (_data[index]['id']).toString()),
            ),
            title: Text(_data[index]['date_demande']),
            subtitle: Text(
              _data[index]['medecin']['initial'] +
                  ' ' +
                  _data[index]['medecin']['specialisation'],
              maxLines: 2,
            ),
          ),
          color: Colors.blueGrey,
        );
      },
      separatorBuilder: (BuildContext context, int index) => (const Divider(
        thickness: 10,
      )),
    );
  }

  buildFloatingActionButton(BuildContext context) {
    return FloatingActionButton(
      tooltip: 'nouvelle demande',
      onPressed: () {
        Navigator.pushNamed(context, '/patient/nouveauDemande');
      },
      backgroundColor: Colors.green,
      child: Icon(
        Icons.add,
        color: Colors.amber,
      ),
    );
  }

  Future<String> getAllDemandeRv() async {
    final http.Response response = await http.get(
      Uri.parse("http://localhost:8008/api/demandeRVs"),
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

  void displayDialogMedecin(BuildContext context, int index) {
    showDialog<void>(
      context: context,
      // false = user must tap button, true = tap outside dialog
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          title: Text('Détail Médecin'),
          backgroundColor: Colors.blueGrey,
          content: SingleChildScrollView(
              child: Column(
            children: [
              ListTile(
                hoverColor: Colors.lightBlueAccent,
                title: Text(
                    _data[index]['medecin']['prenom'] +
                        ' ' +
                        _data[index]['patient']['nom'],
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
                subtitle: Text('prenom && nom'),
              ),
              ListTile(
                hoverColor: Colors.lightBlueAccent,
                title: Text(_data[index]['medecin']['initial'],
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
                subtitle: Text('Initial'),
              ),
              ListTile(
                hoverColor: Colors.lightBlueAccent,
                title: Text(_data[index]['medecin']['specialisation'],
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
                subtitle: Text('Spécialité'),
              ),
            ],
          )),
          actions: <Widget>[
            TextButton(
              child: Text('quittez'),
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
