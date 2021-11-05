import 'dart:html';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mygsmp/models/medecin.dart';
import 'package:mygsmp/models/userModel.dart';
import 'package:mygsmp/widget/components/medecin/drawer.dart';
import 'package:mygsmp/widget/components/medecin/footer_medecin.dart';
import 'package:mygsmp/widget/components/medecin/header_medecin.dart';
import 'package:mygsmp/widget/screen/buildCardSidebox.dart';

// ignore: must_be_immutable
class AcceuilMedecin extends StatelessWidget {
  AcceuilMedecin({Key? key, Medecin? medecin}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBarNavgation(context, 'Menu Medecin'),
      drawer: buildDrawerNavgation(context),
      body: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(2),
            image: DecorationImage(
                image: AssetImage("images/md.jpg"), fit: BoxFit.cover)),
        child: Column(
          children: [
            Center(
                child: Container(
              margin: EdgeInsets.fromLTRB(0, 20, 0, 0),
              child: Text(
                'Menu ',
                style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Arial Rounded MT Bold'),
              ),
            )),
            buildCorpsPage(context),
          ],
        ),
      ),
    );
  }

  FloatingActionButton buildFloatingActionButton(BuildContext context) {
    return FloatingActionButton(
      onPressed: () {
        Navigator.pushNamed(context, '/medecin/newRv');
      },
      backgroundColor: Colors.green,
      child: Icon(
        Icons.add,
        color: Colors.amber,
      ),
    );
  }

  Container buildCorpsPage(BuildContext context) {
    return Container(
        alignment: Alignment.center,
        margin: EdgeInsets.fromLTRB(0, 20, 0, 0),
        child: Table(
          children: [
            TableRow(children: [
              TableCell(
                  child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  buildCard(context, 'Rv', 'Rendez-vous', '/medecin/rv',
                      Icons.connect_without_contact),
                  buildCard(context, 'memos', 'publication', '/medecin/memos',
                      Icons.post_add),
                ],
              )),
            ]),
            TableRow(children: [
              TableCell(
                  child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  buildCard(context, 'Demande', 'Demande-rv',
                      '/medecin/demanderv', Icons.group_add),
                  buildCard(context, 'patient', 'liste Patient',
                      '/medecin/patient', Icons.portrait_sharp),
                ],
              )),
            ]),
            TableRow(children: [
              TableCell(
                  child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  buildCard(context, 'Dm', 'dossier médical', '/medecin/dm',
                      Icons.medical_services),
                  buildCard(context, 'Dm', 'dossier médical', '/medecin/dm',
                      Icons.medical_services),
                ],
              )),
            ]),
          ],
        ));
  }
}
