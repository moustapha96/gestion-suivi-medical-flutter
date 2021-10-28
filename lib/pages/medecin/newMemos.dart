import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:mygsmp/models/medecin.dart';
import 'package:mygsmp/models/memos.dart';
import 'package:mygsmp/services/MedecinService.dart';
import 'package:mygsmp/widget/AddMemos.dart';
import 'package:mygsmp/widget/components/medecin/drawer.dart';
import 'package:mygsmp/widget/components/medecin/footer_medecin.dart';
import 'package:mygsmp/widget/components/medecin/header_medecin.dart';
import 'package:http/http.dart' as http;

class MedecinNewMemos extends StatefulWidget {
  @override
  MedecinNewMemosState createState() => MedecinNewMemosState();
}

class MedecinNewMemosState extends State<MedecinNewMemos> {

  final _formKey = GlobalKey<FormState>();
  String titre = '';
  String message = '';
  DateTime date_creer = new DateTime.now();
  String data = '';
  Map<String, dynamic>? mess ;
  @override
  void initState() {
    getOneMedecin();
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
        child: buildCorpsPage(context),
      ),
      bottomNavigationBar: buildBottomNavigationBar(context),
    );
  }

  buildCorpsPage(BuildContext context) {
    return Form(
        key: _formKey,
        child: new ListView(
          padding: EdgeInsets.all(20),
          children: getFormWidget(),
        ));
  }

  List<Widget> getFormWidget() {
    List<Widget> formWidget = [];
    getOneMedecin();

    formWidget.add(new Container(
        margin: EdgeInsets.fromLTRB(0, 10, 0, 0),
        alignment: Alignment.center,
        child: Text('Nouveau mémos', style: TextStyle( fontSize: 25, fontWeight: FontWeight.bold ),  )));
    formWidget.add(new TextFormField(
      decoration: InputDecoration(labelText: 'titre', hintText: 'titre'),
      validator: (value) {
        if (value!.isEmpty) {
          return 'le titre du message';
        }
        return null;
      },
      onSaved: (value) {
        setState(() {
          titre = value!;
        });
      },
    ));
    formWidget.add(new TextFormField(
      decoration: InputDecoration(labelText: 'message', hintText: 'message'),
      validator: (value) {
        if (value!.isEmpty) {
          return 'le message';
        }
        return null;
      },
      onSaved: (value) {
        setState(() {
          message = value!;
        });
      },
    ));
    void onPressedSubmit() {
      if (_formKey.currentState!.validate()) {
        _formKey.currentState!.save();
        print("titre " + titre);
        print("message " + message);
        print( data );
        print(mess!["specialisation"]  );
        Medecin medecin = new Medecin(idMedecin: mess!["idMedecin"], specialisation: mess!["specialisation"], initial: mess!["initial"],
            prenom: mess!["prenom"], num_licence: mess!["num_licence"], adresse: mess!["adresse"], user: mess!["user"],
            genre: mess!["genre"], nom: mess!["nom"], tel: mess!["tel"], taille: mess!["taille"], age: mess!["age"], creatAt: mess!["creatAt"]
            ,serviceMedical: null, );
        Memos memos = new Memos(idMemos: 0, titre: titre, message: message, medecin: medecin, date_creer: date_creer);
        Future<String> resp = saveMemos(memos);
        print(resp);
        Scaffold.of(context)
            .showSnackBar(SnackBar(content: Text('Form Submitted')));
      }
    }

    formWidget.add(new RaisedButton(
        color: Colors.blue,
        textColor: Colors.white,
        child: new Text('enregistrer'),
        onPressed: onPressedSubmit));
    return formWidget;
  }

  String _base = "http://localhost:8888/api/medecins/1";
  var client = new http.Client();
  Future<String> getOneMedecin() async {
    final http.Response response = await client.get(
      Uri.parse(_base),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );
    setState(() {
      data = json.decode(response.body).toString() ;
      mess = jsonDecode(response.body);
    });
    return "suceess";
  }

  Future<String> saveMemos(Memos memos) async{
    final http.Response response = await client.post(
      Uri.parse(_base),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(memos.toDatabaseJson()),
    );
    return "suceess";
  }
}


