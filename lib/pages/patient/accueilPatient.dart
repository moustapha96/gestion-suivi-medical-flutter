import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mygsmp/widget/components/patient/drawerPatient.dart';
import 'package:mygsmp/widget/components/patient/footer_patient.dart';
import 'package:mygsmp/widget/components/patient/header_patient.dart';

class PatientAccueil extends StatelessWidget{

  PatientAccueil({ Key? key  }) : super(key: key);

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
        floatingActionButton: buildFloatingActionButton(context),
        bottomNavigationBar: buildBottomNavigationBarPatient(context),


    );
  }

  buildCorpsPage(BuildContext context) {
    return Center(
      child: Text('bienvenue sur la page du patient'),
    );
  }

  buildFloatingActionButton(BuildContext context) {}
  
}