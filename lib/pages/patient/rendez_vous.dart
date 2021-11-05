import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mygsmp/widget/components/patient/drawerPatient.dart';
import 'package:mygsmp/widget/components/patient/footer_patient.dart';
import 'package:mygsmp/widget/components/patient/header_patient.dart';
import 'package:http/http.dart' as http;

class PatientRv extends StatefulWidget {
  @override
  _PatientRvState createState() => new _PatientRvState();
}

class _PatientRvState extends State<PatientRv> {
  List _data = [];

  @override
  void iniState() {
    getAllRv();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBarNavgationPatient(context),
      drawer: buildDrawerNavgationPatient(context),
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
      bottomNavigationBar: buildBottomNavigationBarPatient(context),
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
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                    onPressed: () {
                      displayDialogMedecin(context, index);
                    },
                    icon: Icon(Icons.remove_red_eye_outlined)),
                IconButton(
                    onPressed: () {
                      setState(() {
                        _data.removeAt(index);
                      });
                    },
                    icon: Icon(Icons.delete),
                    color: Colors.red),
              ],
            ),
            leading: CircleAvatar(
              backgroundColor: Colors.amber,
              radius: 30,
              child: Text("N°: " + (_data[index]['idRendezVous']).toString()),
            ),
            title:
                Text(_data[index]['date_rv'] + " at " + _data[index]['heure']),
            subtitle: Text(
              _data[index]['medecin']['prenom'] +
                  ' ' +
                  _data[index]['medecin']['nom'],
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

  void displayDialogMedecin(BuildContext context, int index) {
    showDialog<void>(
      context: context,
      // false = user must tap button, true = tap outside dialog
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          title: Text('Détail Medecin'),
          backgroundColor: Colors.transparent,
          content: SingleChildScrollView(
              child: Card(
                  elevation: 10,
                  color: Colors.blueGrey,
                  child: Column(
                    children: [
                      ListTile(
                        hoverColor: Colors.lightBlueAccent,
                        title: Text(
                            _data[index]['medecin']['prenom'] +
                                ' ' +
                                _data[index]['medecin']['nom'],
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 15)),
                        subtitle: Text('prenom && nom'),
                      ),
                      ListTile(
                        hoverColor: Colors.lightBlueAccent,
                        title: Text(_data[index]['medecin']['specialisation'],
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 15)),
                        subtitle: Text('spécialité'),
                      ),
                      ListTile(
                        hoverColor: Colors.lightBlueAccent,
                        title: Text(_data[index]['medecin']['initial'],
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 15)),
                        subtitle: Text('Statut Social'),
                      ),
                    ],
                  ))),
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

  Future<String> getAllRv() async {

    final http.Response response = await http.get(
      Uri.parse("http://localhost:8888/api/RendezVous/patient/1"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );
    setState(() {
      _data = json.decode(response.body);
    });
    print("data");
    print(_data);
    return "succes";
  }
}
