import 'package:flutter/material.dart';
import 'package:mygsmp/widget/components/medecin/drawer.dart';
import 'package:mygsmp/widget/components/medecin/footer_medecin.dart';
import 'package:mygsmp/widget/components/medecin/header_medecin.dart';

class CounterScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBarNavgation(context,'Dosssier Médical'),
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
      //body : buildCorpsPage(context),
      bottomNavigationBar: buildBottomNavigationBar(context),
    );
  }

  buildCorpsPage(BuildContext context) {
    return Center(
      child: Text('dossier médical')
    );
  }
}
