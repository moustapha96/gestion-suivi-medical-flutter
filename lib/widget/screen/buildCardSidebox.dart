import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

SizedBox buildCard(BuildContext context, String text, String desc , String route, IconData icon){
  return SizedBox(
    width: MediaQuery.of(context).size.width * 0.4 ,
    height: MediaQuery.of(context).size.height * 0.2 ,
    child: Card(
      margin: EdgeInsets.all(10),
      //color: Colors.amber,
      shadowColor: Colors.blueGrey,
      elevation: 10,
      child: Column(
        //mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(
            title: Text( text , style: TextStyle(fontSize: 20),
            ),
            subtitle: Text(desc),
            onTap: (){
              Navigator.pushNamed( context, route );
            },
          ),
          Icon( icon )
        ],
      ),
    ),
  );
}