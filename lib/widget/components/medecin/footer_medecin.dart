import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

BottomNavigationBar buildBottomNavigationBar(BuildContext context) {
  return BottomNavigationBar(
      fixedColor: Colors.amber,
      backgroundColor: Colors.black54,
      items: [
        BottomNavigationBarItem(
          label: "Acceuil",
          icon: IconButton(
              color: Colors.amber,
              onPressed: () {
                Navigator.pushNamed(context, "/medecin/home");
              },
              icon: Icon(Icons.home)),
        ),
        BottomNavigationBarItem(
          label: "RV",
          icon: IconButton(
              color: Colors.amber,
              onPressed: () {
                Navigator.pushNamed(context, "/medecin/rv");
              },
              icon: Icon(Icons.connect_without_contact)),
        ),
        BottomNavigationBarItem(
          label: "Pub",
          icon: IconButton(
              color: Colors.amber,
              onPressed: () {
                Navigator.pushNamed(context, "/medecin/memos");
              },
              icon: Icon(Icons.message)),
        ),
        BottomNavigationBarItem(
          label: "Demande RV",
          icon: IconButton(
              color: Colors.amber,
              onPressed: () {
                Navigator.pushNamed(context, "/medecin/demandeRv");
              },
              icon: Icon(Icons.group_add)),
        ),
      ]);
}
