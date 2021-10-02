import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mygsmp/widget/components/medecin/drawer.dart';
import 'package:mygsmp/widget/components/medecin/header_medecin.dart';
import 'package:mygsmp/widget/components/patient/drawerPatient.dart';
import 'package:mygsmp/widget/components/patient/footer_patient.dart';
import 'package:mygsmp/widget/components/patient/header_patient.dart';

class PatientNewDemandeRv extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBarNavgationPatient(context),
      drawer: buildDrawerNavgationPatient(context),
      backgroundColor: Colors.amberAccent,
      body: Container(
        margin: EdgeInsets.all(5),
        alignment: Alignment.center,
        decoration: BoxDecoration(
            color: Colors.cyan
        ),
        child: buildCorpsPage(context),
      ) ,
      bottomNavigationBar: buildBottomNavigationBarPatient(context),
    );
  }

  buildCorpsPage(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(0, 10, 0, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Container(
            child: Text('nouvelle demande de Rv')
          ),
          Container(
            child: Text('liste des medecin'),
          ),
        ],
      )
    );
  }

}