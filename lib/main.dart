import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mygsmp/connexion/connexion.dart';
import 'package:mygsmp/connexion/inscription.dart';
import 'package:mygsmp/pages/profil.dart';
import 'package:mygsmp/pages/splashScreen.dart';

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
        title: 'Gestion Suivi Médical',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        routes: {
          '/': (conetext) => SplashScreen(),
          '/login': (context) => Login(),
          '/inscription': (context) => CreateAccount(),
          '/profil': (context) => Profil(email: '', token: '',),
        },
        initialRoute: '/');
  }
}
