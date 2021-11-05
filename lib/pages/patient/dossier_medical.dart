import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mygsmp/models/dossier_medical.dart';
import 'package:mygsmp/widget/components/patient/drawerPatient.dart';
import 'package:mygsmp/widget/components/patient/footer_patient.dart';
import 'package:mygsmp/widget/components/patient/header_patient.dart';
import 'package:http/http.dart' as http;

class PatientDms extends StatefulWidget {
  @override
  _PatientDmsState createState() => _PatientDmsState();
}

class _PatientDmsState extends State<PatientDms> {
  List cons = [];
  DossierMedical? dm;
  var dmm;

  @override
  void initState() {
    getDmPatient();
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
          child: Center(
              child: Card(
                  margin: EdgeInsets.fromLTRB(15, 15, 15, 15),
                  elevation: 10,
                  shadowColor: Colors.lightBlueAccent,
                  color: Colors.black12,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        dmm['patient']['prenom'] + ' ' + dmm['patient']['nom'],
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20),
                      ),
                      Text(
                        'adresse :' + dmm['patient']['adresse'],
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 15),
                      ),
                      Text(
                        'taille :' + dmm['patient']['taille'].toString(),
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 15),
                      ),
                      Text(
                        'genre :' + dmm['patient']['genre'],
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 15),
                      ),
                      Text(
                        'Age :' + dmm['patient']['age'].toString(),
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 15),
                      ),
                      Text(
                        'Consultations  : ',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 15),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.5,
                        child: ListView.builder(
                            itemCount: cons.length,
                            itemBuilder: (context, indice) {
                              return Padding(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 1, horizontal: 4),
                                child: Card(
                                  child: ListTile(
                                    trailing: new Text(
                                        cons[indice]['date_consultation']),
                                    title: Text(cons[indice]['diagnostic']),
                                    subtitle: Text(cons[indice]['traitement']),
                                  ),
                                ),
                              );
                            }),
                      )
                    ],
                  )))),
    );
  }

  Future<String> getDmPatient() async {
    final http.Response response = await http.get(
      Uri.parse("http://localhost:8888/api/dms/patient/test@test.com"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );
    setState(() {
      print(jsonDecode(response.body));
      var data = jsonDecode(response.body);
      dmm = data;
      cons = dmm['consultations'];
      print(dmm);
    });
    return "Success";
  }
}
