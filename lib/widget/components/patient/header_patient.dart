import 'package:flutter/material.dart';
import 'package:mygsmp/connexion/connexion.dart';

AppBar buildAppBarNavgationPatient(BuildContext context, String titre){
  return AppBar(
    elevation: 10,
    title: Text(titre),
    backgroundColor: Colors.cyan,
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
  );
}
