import 'package:flutter/material.dart';
import 'package:mygsmp/widget/components/patient/drawerPatient.dart';
import 'package:mygsmp/widget/components/patient/footer_patient.dart';
import 'package:mygsmp/widget/components/patient/header_patient.dart';

class PatientDemandeRv extends StatelessWidget{
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
      floatingActionButton: buildFloatingActionButton(context),

    );
  }

  buildCorpsPage(BuildContext context) {
    return Center(
      child: Text('demande Rv'),
    );
  }

  buildFloatingActionButton(BuildContext context) {
    return FloatingActionButton(
      tooltip: 'nouvelle demande',
      onPressed: (){
        Navigator.pushNamed(context, '/patient/nouveauDemande');
      },
      backgroundColor: Colors.green,
      child: Icon(
        Icons.add,
        color: Colors.amber,
      ),
    );
  }
}