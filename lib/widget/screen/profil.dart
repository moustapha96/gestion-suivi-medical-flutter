import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Profil extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profil'),
        backgroundColor: Colors.lightBlueAccent,
      ),
      body: Container(
        margin: EdgeInsets.all(5),
        padding: EdgeInsets.fromLTRB(5, 3, 5, 2),
        child: Center(
          child: Text('Profil de l\'utilisateur'),
        ),
      ),
    );
  }
  
}