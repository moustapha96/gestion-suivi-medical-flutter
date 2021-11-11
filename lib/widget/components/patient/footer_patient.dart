import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

BottomNavigationBar buildBottomNavigationBarPatient(BuildContext context, String email, String token) {
  return BottomNavigationBar(

      items: [
    BottomNavigationBarItem(
      label: "Acceuil",
      icon: IconButton(
          color: Colors.amber,
          onPressed: () {
            Navigator.pushNamed(context, "/patient/home",
            arguments: { email: email, token: token  } );
          },
          icon: Icon(Icons.home)),
    ),
    BottomNavigationBarItem(
      label: "RV",
      icon: IconButton(
          color: Colors.amber,
          onPressed: () {
            Navigator.pushNamed(context, "/patient/rv",
                arguments: { email: email, token: token  });
          },
          icon: Icon(Icons.people_alt)),
    ),
    BottomNavigationBarItem(
      label: "Pub",
      icon: IconButton(
          color: Colors.amber,
          onPressed: () {
            Navigator.pushNamed(context, "/patient/memos",
                arguments: { email: email, token: token  }
                );
          },
          icon: Icon(Icons.admin_panel_settings)),
    ),
    BottomNavigationBarItem(
      label: "Demande RV",
      icon: IconButton(
          color: Colors.amber,
          onPressed: () {
            Navigator.pushNamed(context, "/patient/demandeRv",
                arguments: { email: email, token: token  } );
          },
          icon: Icon(Icons.admin_panel_settings)),
    ),
  ]);
}
