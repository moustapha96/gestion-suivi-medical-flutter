// ignore_for_file: non_constant_identifier_names

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mygsmp/models/medecin.dart';
import 'package:mygsmp/models/patient.dart';
import 'package:mygsmp/models/rendezVous.dart';
import 'package:mygsmp/widget/DatePickerScreen.dart';
import 'package:mygsmp/widget/FixerRendezVous.dart';
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
  void initState() {
    super.initState();
  }

  @override
  Future<void> afterFirstLayout(BuildContext context) async {

  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: buildAppBarNavgation(context,'Nouveau Rendez-Vous'),
      drawer: buildDrawerNavgation(context),
      body: Container(
        margin: EdgeInsets.all(3),
        alignment: Alignment.center,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(2),
            image: DecorationImage(
                image: AssetImage("images/md.jpg"), fit: BoxFit.cover)),
        child: Container(
          margin: EdgeInsets.all(15),
          child: new FixerRendezVous(),
        )
      ) ,
     // bottomNavigationBar: buildBottomNavigationBar(context),
    );
  }

}
