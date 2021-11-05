import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mygsmp/models/patient.dart';
import 'package:mygsmp/widget/components/patient/drawerPatient.dart';
import 'package:mygsmp/widget/components/patient/footer_patient.dart';
import 'package:mygsmp/widget/components/patient/header_patient.dart';
import 'package:mygsmp/widget/screen/buildCardSidebox.dart';

class AccueilPatient extends StatelessWidget {
  AccueilPatient({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBarNavgationPatient(context),
      drawer: buildDrawerNavgationPatient(context),
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
                  buildCard(context, 'Rv', 'Rendez-vous', '/patient/rv',
                      Icons.connect_without_contact),
                  buildCard(context, 'memos', 'publication', '/patient/memos',
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
                      '/patient/demanderv', Icons.group_add),
                  buildCard(context, 'Demande', 'nouveau demande',
                      '/patient/nouveauDemande', Icons.portrait_sharp),
                ],
              )),
            ]),
            TableRow(children: [
              TableCell(
                  child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  buildCard(context, 'Dm', 'dossier médical', '/patient/dm',
                      Icons.medical_services),
                ],
              )),
            ]),
          ],
        ));
  }

  buildFloatingActionButton(BuildContext context) {}
}
