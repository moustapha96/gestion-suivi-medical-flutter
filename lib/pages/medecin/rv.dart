import 'package:flutter/material.dart';
import 'package:mygsmp/widget/components/medecin/drawer.dart';
import 'package:mygsmp/widget/components/medecin/footer_medecin.dart';
import 'package:mygsmp/widget/components/medecin/header_medecin.dart';

class MedecinRv extends StatelessWidget{
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
      floatingActionButton: buildFloatingActionButton(context),
      bottomNavigationBar: buildBottomNavigationBar(context),
    );
  }

  buildCorpsPage(BuildContext context) {
    return Container(
      child: Text('rendez-vous')
    );
  }

  buildFloatingActionButton(BuildContext context) {
    return FloatingActionButton(
      onPressed: (){
        Navigator.pushNamed(context, '/medecin/fixerRv');
      },
      backgroundColor: Colors.green,
      child: Icon(
        Icons.add,
        color: Colors.amber,
      ),
    );
  }

}