import 'dart:js';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mygsmp/models/simple_user.dart';
import 'package:mygsmp/widget/components/medecin/drawer.dart';

class AcceuilMedecin extends StatelessWidget{
  final SimpleUser user;

  AcceuilMedecin({ Key? key , required this.user }) : super(key: key);
  @override
  Widget build(BuildContext context) {

    return Scaffold(
        appBar: AppBar(
          title: Text('Home Medecin'),
          backgroundColor: Colors.amberAccent,
        ),
      drawer: buildDrawerNavgation(context),
      backgroundColor: Colors.amberAccent,
      body : buildCorpsPage(context),
      floatingActionButton: buildFloatingActionButton(context),
      bottomNavigationBar: buildBottomNavigationBar(context),
      //drawer: buildDrawerNavgation(context),

    );
  }

  FloatingActionButton buildFloatingActionButton(BuildContext context) {
    return FloatingActionButton(
      onPressed: (){
        Navigator.pushNamed(context, '/medecin/newRv');
      },
      backgroundColor: Colors.green,
      child: Icon(
        Icons.add,
        color: Colors.amber,
      ),
    );
  }


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

  Container buildCorpsPage(BuildContext context) {
    return Container(
      child: Center(
        child: Container(
          color: Colors.amber,
          width: MediaQuery.of(context).size.width * 0.7,
          height: MediaQuery.of(context).size.height * 0.7,
          child: ListView(
            children: [
              Container(
                padding: EdgeInsets.all(10),
                margin: EdgeInsets.all(50),
                width: 300,
                height: 300,
                child : Text('email : '+user.email,
                textAlign: TextAlign.center,
                style: TextStyle( fontSize: 30 ),),
              ),
              Container(
                 child:  Text("role : "+ user.role)
              )
            ],
          ),
        ),
      ),
    );
  }

  buildDrawerNavgation(BuildContext context) {
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
           leading: Icon(Icons.message),
           title: Text('Rendez-vous'),
           onTap: () {
             Navigator.pushNamed(context, '/medecin/rv');
           },
           subtitle: Text('nouveau'),
         ),
         ListTile(
           leading: Icon(Icons.message),
           title: Text('Publication'),
           onTap: () {
             Navigator.pushNamed(context, '/medecin/memos');
           },
         ),
         ListTile(
           leading: Icon(Icons.account_circle),
           title: Text('Profile'),
         ),

       ],)
   );
  }
}