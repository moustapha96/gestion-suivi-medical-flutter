import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

BottomNavigationBar buildBottomNavigationBar(BuildContext context) {
  return BottomNavigationBar(currentIndex: 1, items: [
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
          icon: Icon(Icons.people_alt)),
    ),
    BottomNavigationBarItem(
      label: "Pub",
      icon: IconButton(
          onPressed: () {
            Navigator.pushNamed(context, "/medecin/memos");
          },
          icon: Icon(Icons.admin_panel_settings)),
    )
  ]);
}
