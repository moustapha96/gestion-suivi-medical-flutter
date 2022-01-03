import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mygsmp/services/MemosService.dart';
import 'package:mygsmp/widget/components/medecin/header_medecin.dart';
import 'package:http/http.dart' as http;
import 'package:mygsmp/widget/components/patient/drawerPatient.dart';
import 'package:mygsmp/widget/components/patient/footer_patient.dart';
import 'package:mygsmp/widget/components/patient/header_patient.dart';

class PatientMemos extends StatefulWidget {
  String email; String token;
  PatientMemos({required this.email,required this.token });
  @override
  PatientMemosState createState() => PatientMemosState(email:'', token: ''  );
}

class PatientMemosState extends State<PatientMemos> {
  String email;String token;
  PatientMemosState({ required this.email, required this .token });
  List _data = [];


  @override
  void initState() {
    getAllMemos();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBarNavgationPatient(context, 'Publications'),
      drawer: buildDrawerNavgationPatient(context,email, token ),
      body: Container(
        margin: EdgeInsets.all(2),
        alignment: Alignment.center,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(2),
            image: DecorationImage(
                image: AssetImage("images/md.jpg"), fit: BoxFit.cover)),
        child: buildCorpsPage(context),
      ),
      bottomNavigationBar: buildBottomNavigationBarPatient(context,email, token),
    );
  }

  buildCorpsPage(BuildContext context) {
    return ListView.separated(
      itemCount: _data == null ? 0 : _data.length,
      itemBuilder: (BuildContext context, int index) {
        return ListTile(
          trailing: IconButton(
            color: Colors.lightBlue,
            icon: Icon(Icons.remove_red_eye),
            onPressed: () {
              setState(() {
                displayDialog(context, index);
              });
            },
          ),
          onTap: () {
            displayDialog(context, index);
          },
          leading: CircleAvatar(
            backgroundColor: Colors.amber,
            radius: 30,
            child: Text((_data[index]['titre'][0]).toUpperCase()),
          ),
          title: Text(_data[index]['titre']),
          subtitle: Text(
            _data[index]['message'],
            maxLines: 2,
          ),
        );
      },
      separatorBuilder: (BuildContext context, int index) => (const Divider(
        thickness: 10,
      )),
    );
  }

  Future<String> getAllMemos() async {
    final http.Response response = await client.get(
      Uri.parse("http://localhost:8008/api/Memos"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );
    setState(() {
      _data = json.decode(response.body);
    });
    return "succes";
  }

  void displayDialog(BuildContext context, int index) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return SimpleDialog(
            elevation: 5,
            backgroundColor: Colors.blueGrey,
            title: Text(
              _data[index]['titre'],
              textAlign: TextAlign.center,
              style:
                  TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
            ),
            children: [
              Card(
                margin: EdgeInsets.all(5),
                child: Text(_data[index]["message"],
                    textAlign: TextAlign.center,
                    style: TextStyle(fontWeight: FontWeight.bold)),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(
                    "médecin : " + _data[index]["medecin"]["initial"],
                    style: TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.white),
                  ),
                  Text(
                    "date Pub: " + _data[index]["date_creer"],
                    style: TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.white),
                  )
                ],
              )
            ],
          );
        });
  }
}
