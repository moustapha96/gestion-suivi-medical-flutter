import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mygsmp/widget/components/medecin/drawer.dart';
import 'package:mygsmp/widget/components/medecin/footer_medecin.dart';
import 'package:mygsmp/widget/components/medecin/header_medecin.dart';
import 'package:mygsmp/widget/contact/AllContact.dart';
import 'package:http/http.dart' as http;
class MedecinContact extends StatefulWidget{
  @override
  MedecinContactState createState() => MedecinContactState();


}
 class MedecinContactState extends State<MedecinContact> {
  List _data = [];
  String _base = "http://localhost:8888/api/memos";
  var client = new http.Client();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBarNavgation(context,'Liste des Contacts'),
      drawer: buildDrawerNavgation(context),

      body: Container(
        margin: EdgeInsets.all(2),
        alignment: Alignment.center,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(2),
            image: DecorationImage(
                image: AssetImage("images/md.jpg"), fit: BoxFit.cover)),
        child: buildCorpsPage(context),
      ) ,
      //body : buildCorpsPage(context),
      bottomNavigationBar: buildBottomNavigationBar(context),
    );
  }

  buildCorpsPage(BuildContext context) {
    return ListView.separated(
      itemCount: _data == null ? 0 : _data.length,
      itemBuilder: (BuildContext context, int index) {
        return ListTile(
          trailing: IconButton(color: Colors.red,icon: Icon(Icons.delete_sweep),
            onPressed: (){
              setState((){
                _data.removeAt(index);
              });
            },
          ),
          onTap: (){
            displayDialog(context, index );
          },
          leading: CircleAvatar(
            backgroundColor: Colors.amber,
            radius: 30,
            child: Text((_data[index]['titre'][0]).toUpperCase()),
          ),

          title: Text(_data[index]['titre']),
          subtitle: Text(_data[index]['message'], maxLines: 2,),
        );
      },
      separatorBuilder: (BuildContext context, int index) =>
      (
          const Divider(
            thickness: 10,
          )
      ),
    );
  }

  Future<String> getAllMemos() async {
    final http.Response response = await client.get(
      Uri.parse("http://localhost:8888/api/Memos"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );

    setState(() {
      _data = json.decode(response.body);
    });
    print(response.body);
    return "succes";
  }

  void displayDialog(BuildContext context, int index){
    showDialog(context: context,
        builder: (BuildContext context){
          return SimpleDialog(
            elevation: 5,
            backgroundColor: Colors.amberAccent,
            title: Text( _data[index]['titre'], textAlign: TextAlign.center, ) ,
            children: [
              Text( _data[index]["message"] , textAlign: TextAlign.center, ),
              Text( "medecin :"+ _data[index]["medecin"]["initial"] ),
              Text("date_Pub: "+ _data[index]["date_creer"]  )
            ],
          );
        });
  }

}