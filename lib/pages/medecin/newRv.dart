// ignore_for_file: non_constant_identifier_names

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mygsmp/models/medecin.dart';
import 'package:mygsmp/models/patient.dart';
import 'package:mygsmp/models/rendezVous.dart';
import 'package:mygsmp/widget/components/medecin/drawer.dart';
import 'package:mygsmp/widget/components/medecin/footer_medecin.dart';
import 'package:mygsmp/widget/components/medecin/header_medecin.dart';

class MedecinNewRv extends StatefulWidget{
  late Medecin medecin;
  late Rendezvous rv;
  late Patient patient;
  MedecinNewRv({ Key? key  }) : super(key: key);

  State createState() =>  _MedecinNewRv();
}
class _MedecinNewRv extends State<MedecinNewRv> {

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: buildAppBarNavgation(context),
      drawer: buildDrawerNavgation(context),
      backgroundColor: Colors.amberAccent,
      body: Container(
        margin: EdgeInsets.all(5),
        alignment: Alignment.center,
        decoration: BoxDecoration(
            color: Colors.cyan
        ),
        child: buildCorpsPage(context),
      ) ,
      bottomNavigationBar: buildBottomNavigationBar(context),
    );
  }

  Container buildCorpsPage(BuildContext context) {
    TextSelectionControls idpatient;

    TextEditingController dateController= new TextEditingController();
    TextEditingController heureController = new TextEditingController();
    return Container(
      child: Center(
        child: Container(
          color: Colors.amber,
          width: MediaQuery.of(context).size.width * 0.7,
          height: MediaQuery.of(context).size.height * 0.7,
          child: Column(
            children: <Widget>[
              Container(
                  margin: EdgeInsets.fromLTRB(0, 50, 0, 0),
                  alignment: Alignment.center,
                  child: Text(
                    'Nouveau Rendez-Vous',
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 25),
                  )),
              Container(
                padding: EdgeInsets.all(10),
                margin: EdgeInsets.fromLTRB(0, 20, 0, 0),
                child: Center(
                  child: Text('liste des patients'),
                ),
              ),
              Container(
                padding: EdgeInsets.all(10),
                margin: EdgeInsets.fromLTRB(0, 20, 0, 0),
                child: TextField(
                  controller: dateController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'date',
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
                child: TextField(
                  controller: heureController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'heure',
                  ),
                ),
              ),
              Container(
                  height: 50,
                  width: 200,
                  child: TextButton(
                    child: Text(
                      'enregistrer',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                          color: Colors.black),
                    ),
                    onPressed: (){},
                  )),

            ],
          ),
        ),
      ),
    );
  }


  void fixer_rv(int idpatinent,String date,String heure ){

  }

}
