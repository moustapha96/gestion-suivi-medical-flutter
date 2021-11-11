import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mygsmp/models/patient.dart';
import 'package:mygsmp/models/userModel.dart';
import 'package:mygsmp/widget/components/patient/drawerPatient.dart';
import 'package:mygsmp/widget/components/patient/footer_patient.dart';
import 'package:mygsmp/widget/components/patient/header_patient.dart';
import 'package:http/http.dart' as http;

class PatientRv extends StatefulWidget {
  String email;
  String token;
  PatientRv({required this.email, required this.token});

  @override
  _PatientRvState createState() => new _PatientRvState(token: '', email: '');
}

class _PatientRvState extends State<PatientRv> {
  String email;
  String token;
  _PatientRvState({required this.email, required this.token});

  Patient patientConnecte = new Patient(
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
  List _data = [];

  @override
  void iniState() {
    super.initState();
    getAllRv();
    print(this.patientConnecte);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBarNavgationPatient(context, 'Vos RVs'),
      drawer: buildDrawerNavgationPatient(context, email, token ),
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
      bottomNavigationBar: buildBottomNavigationBarPatient(context,email, token),
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

  void displayDialogMedecin(BuildContext context, int index, ) {
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
    String _base_email = "http://localhost:8888/api/patients/user";
    final http.Response resp = await http
        .get(Uri.parse(_base_email + "/" + email), headers: {
      'Accept': 'application/json',
      'Authorization': 'Bearer token $token'
    });
    setState(() async {
      var data = jsonDecode(resp.body);
      print("prneom "+ data["creatAt"] );
      this.patientConnecte = new Patient(
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

      print("patient apres" );
      print(this.patientConnecte);

      getAllRvPatient(this.patientConnecte.getIdPatient);
    });
    return "succes";
  }
  Future<String> getAllRvPatient(int id) async{
    final http.Response response = await http.get(
      Uri.parse(
          "http://localhost:8888/api/RendezVous/patient/" + id.toString()  ),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );
    setState(() async {
      _data = json.decode(response.body);
      print("data");
      print(_data);
    });
    return 'success';
  }
}
