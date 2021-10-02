import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

BottomNavigationBar buildBottomNavigationBar(BuildContext context) {
  return BottomNavigationBar(currentIndex: 1,backgroundColor: Colors.cyan ,items: [

    BottomNavigationBarItem(
      label: "Acceuil",
      icon: IconButton(
          onPressed: () {
            Navigator.pushNamed(context, "/medecin/home");
          },
          icon: Icon(Icons.home)),
    ),
    BottomNavigationBarItem(
      label: "RV",
      icon: IconButton(
          onPressed: () {
            Navigator.pushNamed(context, "/medecin/rv");
          },
          icon: Icon(Icons.connect_without_contact)),
    ),
    BottomNavigationBarItem(
      label: "Pub",
      icon: IconButton(
          onPressed: () {
            Navigator.pushNamed(context, "/medecin/memos");
          },
          icon: Icon(Icons.message)),
    ),
    BottomNavigationBarItem(
      label: "Demande RV",
      icon: IconButton(
          onPressed: () {
            Navigator.pushNamed(context, "/medecin/demandeRv");
          },
          icon: Icon(Icons.group_add)),
    ),
  ]);
}
