import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mygsmp/pages/profil.dart';

Drawer buildDrawerNavgationPatient(BuildContext context, String email,String token){
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
            'Ibou Khouma',
            style: TextStyle(
              color: Colors.amberAccent,
              fontSize: 24,
            ),
          ),
        ),


        ListTile(
          leading: Icon(Icons.connect_without_contact),
          title: Text('Rendez-vous'),
          onTap: () {
            // Navigator.pushNamed(context, '/patient/rv',
            //     arguments: { email: email, token: token  } );
          },

        ),
        ListTile(
          leading: Icon(Icons.post_add),
          title: Text('Publication'),
          onTap: () {
            // Navigator.pushNamed(context, '/patient/memos',
            //     arguments: { email: email, token: token  });
          },
        ),
        ListTile(
          leading: Icon(Icons.group_add),
          title: Text('demande de RV'),
          onTap: () {
            // Navigator.pushNamed(context, '/patient/demandeRv',
            //     arguments: { email: email, token: token  });
          },
        ),
        ListTile(
          leading: Icon(Icons.medical_services),
          title: Text('Dossier Médical'),
          onTap: () {
            // Navigator.pushNamed(context, '/patient/dm',
            //     arguments: { email: email, token: token  });
          },
        ),
        ListTile(
          leading: Icon(Icons.account_circle),
          title: Text('Profile'),
          onTap: (){
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => Profil(email: email, token: token)));
          },
        ),
        ListTile(
          leading: Icon(Icons.logout),
          title: Text('Déonnexion'),
          onTap: (){
              Navigator.pushNamed(context, '/');
          },
        ),
      ],),
    semanticLabel: 'espace Patient',
  );
}