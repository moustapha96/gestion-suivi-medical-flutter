import 'package:flutter/material.dart';
import 'package:mygsmp/connexion/connexion.dart';

AppBar buildAppBarNavgation(BuildContext context, String titre) {
  return AppBar(
      elevation: 10,
      title: Text(titre,
        textAlign: TextAlign.center,
        style: TextStyle(fontWeight: FontWeight.bold),),
      backgroundColor: Colors.amberAccent,
      actions: [
      new IconButton(
      tooltip: 'logout',
      onPressed: () {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => Login(),
            ));
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('LogOut')));
      }, icon:Icon(Icons.logout), )
  ]
  ,
  );
}
