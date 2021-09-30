import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mygsmp/connexion/connexion.dart';
import 'package:mygsmp/connexion/inscription.dart';
import 'package:mygsmp/models/simple_user.dart';
import 'package:mygsmp/pages/medecin/accueil.dart';
import 'package:mygsmp/pages/medecin/memos.dart';
import 'package:mygsmp/pages/medecin/newRv.dart';
import 'package:mygsmp/pages/medecin/rv.dart';

void main() {
  runApp(new HomePage());
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'connexion',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        routes: {
          '/': (context) => Login(),
          '/inscription': (context) => CreateAccount(),
          '/medecin/home': (context) => AcceuilMedecin(user: new SimpleUser("","",""),),
          '/medecin/rv' :(context) => MedecinRv(),
          '/medecin/memos': (context) => MedecinMemos(),
          '/medecin/newRv': (context) => MedecinNewRv(),
        },
        initialRoute: '/');
  }
}
