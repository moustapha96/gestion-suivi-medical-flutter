import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mygsmp/models/rendezVous.dart';
import 'package:mygsmp/services/RendezVous.dart';
import 'package:mygsmp/widget/components/medecin/drawer.dart';
import 'package:mygsmp/widget/components/medecin/footer_medecin.dart';
import 'package:mygsmp/widget/components/medecin/header_medecin.dart';

import 'package:http/http.dart' as http;

class MedecinRv extends StatefulWidget {
  @override
  _MedecinRvState createState() => new _MedecinRvState();
}

class _MedecinRvState extends State<MedecinRv> {
  List _data = [];

  @override
  void initState() {
    getAllRv();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBarNavgation(context),
      drawer: buildDrawerNavgation(context),
      body: Container(
        margin: EdgeInsets.all(2),
        alignment: Alignment.center,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(2),
            image: DecorationImage(
                image: AssetImage("images/md.jpg"), fit: BoxFit.cover)),
        child: Container(
          margin: EdgeInsets.all(7),
          child: buildCorpsPage(context),
        )
      ),
      floatingActionButton: buildFloatingActionButton(context),
      bottomNavigationBar: buildBottomNavigationBar(context),
    );
  }

  buildCorpsPage(BuildContext context) {
    return ListView.separated(
      itemCount: _data == null ? 0 : _data.length,
      itemBuilder: (BuildContext context, int index) {

       return  Card(
         margin: EdgeInsets.all(10),
          elevation: 12,
          child: ListTile(
            trailing: IconButton(
              color: Colors.red,
              icon: Icon(Icons.delete_sweep),
              onPressed: () {
                setState(() {
                  _data.removeAt(index);
                });
              },
            ),
            onTap: () {
              displayDialog(context, index);
            },
            leading: CircleAvatar(
              backgroundColor: Colors.amber,
              radius: 30,
              child: Text("N°: "+ (_data[index]['idRendezVous']).toString()),
            ),
            title: Text(_data[index]['date_rv']+ " at "+_data[index]['heure'] ),
            subtitle: Text(
              _data[index]['patient']['prenom'] +
                  ' ' +
                  _data[index]['patient']['nom'],
              maxLines: 2,
            ),
          ),
          color: Colors.blueAccent,
        );
      },
      separatorBuilder: (BuildContext context, int index) => (const Divider(
        thickness: 10,
      )),
    );
  }

  buildFloatingActionButton(BuildContext context) {
    return FloatingActionButton(
      onPressed: () {
        Navigator.pushNamed(context, '/medecin/fixerRv');
      },
      backgroundColor: Colors.green,
      child: Icon(
        Icons.add,
        color: Colors.amber,
      ),
    );
  }

  Future<String> getAllRv() async {
    final http.Response response = await client.get(
      Uri.parse("http://localhost:8888/api/RendezVous/medecin/1"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );
    setState(() {
      _data = json.decode(response.body);
    });
    print(_data);
    return "succes";
  }

  void displayDialog(BuildContext context, int index) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return SimpleDialog(
            elevation: 5,
           // backgroundColor: Colors.amberAccent,
            title: Text(
              'Rendez-Vous', textAlign: TextAlign.center,
            ),
            children: [
              Container(
                margin: EdgeInsets.all(3),
               child: Card(
                 child: Column(
                    children: [
                      Text(
                        _data[index]["medecin"]['initial'],
                      ),
                      Text( 'Spécialité : '+
                          _data[index]["medecin"]['specialisation'],
                      ),
                      Text("Patient : " +
                          _data[index]["patient"]["prenom"] +
                          ' ' +
                          _data[index]["patient"]["nom"]),
                      Text("date & heure : " + _data[index]["date_rv"]+ ''+_data[index]["heure"] )
                    ],
                 ),
                )
              )
            ],
          );
        });
  }
}
