import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mygsmp/widget/PatientDemandeRv.dart';
import 'package:mygsmp/widget/components/patient/drawerPatient.dart';
import 'package:mygsmp/widget/components/patient/footer_patient.dart';
import 'package:mygsmp/widget/components/patient/header_patient.dart';

class PatientNewDemandeRv extends StatefulWidget{

  String email;  String token;
  PatientNewDemandeRv({ required this.email , required this.token });
  @override
  _PatientNewDemandeRv  createState() => new _PatientNewDemandeRv(email: email, token: token);
}

class _PatientNewDemandeRv extends State<PatientNewDemandeRv> {
  String email;  String token;
  _PatientNewDemandeRv({ required this.email , required this.token });

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBarNavgationPatient(context,'Demande RV'),
      drawer: buildDrawerNavgationPatient(context,email, token ),
      body: Container(
        margin: EdgeInsets.all(2),
        alignment: Alignment.center,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(2),
            image: DecorationImage(
                image: AssetImage("images/md.jpg"), fit: BoxFit.cover)),
      /*  child: Column(
          children: [
            Center(
                child : Container(
                  margin: EdgeInsets.fromLTRB(0, 20 , 0, 0),
                  child: Text('Nouvelle demande de RV', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, fontFamily: 'Arial Rounded MT Bold' ),
                  ),
                )
            ),
            new DemandeRVForm()
          ],
        ),*/
        child: buildCorpsPage(context)
      ) ,
      bottomNavigationBar: buildBottomNavigationBarPatient(context,email, token),
    );
  }

  buildCorpsPage(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(20, 10, 20, 0),
      child: new DemandeRVForm()
    );
  }

}