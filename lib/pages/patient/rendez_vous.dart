import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mygsmp/widget/components/patient/drawerPatient.dart';
import 'package:mygsmp/widget/components/patient/footer_patient.dart';
import 'package:mygsmp/widget/components/patient/header_patient.dart';

class PatientRv extends StatelessWidget{
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
        child: Column(
          children: [
            Center(
                child : Container(
                  margin: EdgeInsets.fromLTRB(0, 20 , 0, 0),
                  child: Text('Liste des Rendez-Vous', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, fontFamily: 'Arial Rounded MT Bold' ),
                  ),
                )
            ),
            buildCorpsPage(context),
          ],
        ),
      ) ,
      bottomNavigationBar: buildBottomNavigationBarPatient(context),


    );
  }

  buildCorpsPage(BuildContext context) {
    return Center(
      child: Text('rendez-vous'),
    );
  }
  
}