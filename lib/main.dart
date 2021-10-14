import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mygsmp/connexion/connexion.dart';
import 'package:mygsmp/connexion/inscription.dart';
import 'package:mygsmp/pages/medecin/MedecindemandeRV.dart';
import 'package:mygsmp/pages/medecin/accueil.dart';
import 'package:mygsmp/pages/medecin/contact.dart';
import 'package:mygsmp/pages/medecin/dossier_medical.dart';
import 'package:mygsmp/pages/medecin/memos.dart';
import 'package:mygsmp/pages/medecin/newRv.dart';
import 'package:mygsmp/pages/medecin/patient.dart';
import 'package:mygsmp/pages/medecin/rv.dart';
import 'package:mygsmp/pages/patient/accueilPatient.dart';
import 'package:mygsmp/pages/patient/demandeRv.dart';
import 'package:mygsmp/pages/patient/new_demande_rv.dart';
import 'package:mygsmp/widget/screen/profil.dart';

import 'pages/medecin/newMemos.dart';
import 'pages/patient/dossier_medical.dart';
import 'pages/patient/memos.dart';
import 'pages/patient/rendez_vous.dart';

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
          '/': (context) => Login(),
          '/inscription': (context) => CreateAccount(),
          '/medecin/home': (context) => AcceuilMedecin( ),
          '/medecin/rv': (context) => MedecinRv(),
          '/medecin/memos': (context) => MedecinMemos(),
          '/medecin/newMemos': (context) => MedecinNewMemos(),
          '/medecin/newRv': (context) => MedecinNewRv(),
          '/medecin/demandeRv': (context) => MedecinDemandeRv(),
          '/medecin/dm': (context) => MedecinDms(),
          '/medecin/contact': (context) => MedecinContact(),
          '/medecin/patient': (context) => MedecinPatient(),
          '/medecin/fixerRv': (context) => MedecinNewRv(),
          '/patient/home': (context) => PatientAccueil(),
          '/patient/dm': (context) => PatientDms(),
          '/patient/rv': (context) => PatientRv(),
          '/patient/demandeRv': (context) => PatientDemandeRv(),
          '/patient/memos': (context) => PatientMemos(),
          '/patient/nouveauDemande': (context) => PatientNewDemandeRv(),
          '/profil': (context) => Profil(),
        },
        initialRoute: '/');
  }
}
