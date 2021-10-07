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
      body: Container(
        margin: EdgeInsets.all(2),
        alignment: Alignment.center,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(2),
            image: DecorationImage(
                image: AssetImage("images/md.jpg"), fit: BoxFit.cover)),
        child: buildCorpsPage(context),
      ) ,
      bottomNavigationBar: buildBottomNavigationBar(context),
    );
  }

  Container buildCorpsPage(BuildContext context) {
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


            ],
          ),
        ),
      ),
    );
  }


}
