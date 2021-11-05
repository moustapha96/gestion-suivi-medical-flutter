import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Drawer buildDrawerNavgation(BuildContext context){
  return Drawer(
    elevation: 10,
    child:  ListView(
      padding: EdgeInsets.zero,
      children: <Widget>[
        DrawerHeader(
          margin: EdgeInsets. zero ,
          padding: EdgeInsets. zero ,
          decoration: BoxDecoration(
              image: DecorationImage(
                  fit: BoxFit.fill,
                  image: AssetImage('images/md.jpg')))  ,
          child: Text(
            'Dr. Diop',
            style: TextStyle(
              color: Colors.amberAccent,
              fontSize: 24,
            ),
          ),
        ),


        ListTile(
          leading: Icon(Icons.connect_without_contact),
          title: Text('Contact'),
          onTap: () {
            Navigator.pushNamed(context, '/medecin/contact');
          },
        ),

        ListTile(
          leading: Icon(Icons.connect_without_contact),
          title: Text('Rendez-vous'),
          onTap: () {
            Navigator.pushNamed(context, '/medecin/rv');
          },
        ),
        ListTile(
          leading: Icon(Icons.post_add),
          title: Text('Publication'),
          onTap: () {
            Navigator.pushNamed(context, '/medecin/memos');
          },
        ),
        ListTile(
          leading: Icon(Icons.group_add),
          title: Text('demande de RV'),
          onTap: () {
            Navigator.pushNamed(context, '/medecin/demanderv');
          },
        ),
        ListTile(
          leading: Icon(Icons.medical_services),
          title: Text('Dossier Médical'),
          onTap: () {
            Navigator.pushNamed(context, '/medecin/dm');
          },
        ),
        ListTile(
          leading: Icon(Icons.portrait_sharp),
          title: Text('Liste des Patients'),
          onTap: () {
            Navigator.pushNamed(context, '/medecin/patient');
          },
        ),
        ListTile(
          leading: Icon(Icons.account_circle),
          title: Text('Profile'),
          onTap: (){
            Navigator.pushNamed(context, '/profil');
          },
        ),
        ListTile(
          leading: Icon(Icons.logout),
          title: Text('déconnexion'),
          onTap: (){
            Navigator.pushNamed(context, '/');
          },
        ),

      ],
    ),
    semanticLabel: 'espace Medecin',

  );
}