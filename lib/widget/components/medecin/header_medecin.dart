import 'package:flutter/material.dart';

AppBar buildAppBarNavgation(BuildContext context , String titre){
  return AppBar(
    elevation: 10,
    title: Text(titre,
    textAlign: TextAlign.center,
    style: TextStyle( fontWeight: FontWeight.bold ),),
    backgroundColor: Colors.amberAccent,
  );
}
