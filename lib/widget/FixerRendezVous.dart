import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:mygsmp/models/medecin.dart';
import 'package:mygsmp/models/patient.dart';
import 'package:mygsmp/models/rendezVous.dart';
import 'package:mygsmp/services/MedecinService.dart';
import 'package:mygsmp/services/PatientService.dart';
import 'DatePickerScreen.dart';

class FixerRendezVous extends StatefulWidget {
  @override
  _FixerRendezVousState createState() => new _FixerRendezVousState();
}

class _FixerRendezVousState extends State<FixerRendezVous> {
  final _formKey = GlobalKey<FormState>();
  String date = '';
  String heure = '';

  DateTime dateselected = DateTime.now();
  int _selectedPatient = 0;
  List<DropdownMenuItem<int>> listePatient = [];

  void loadPatient() {

    listePatient = [];
    listePatient.add(new DropdownMenuItem(
      child: new Text('patient 1'),
      value: 0,
    ));
    listePatient.add(new DropdownMenuItem(
      child: new Text('patient 2'),
      value: 1,
    ));
    listePatient.add(new DropdownMenuItem(
      child: new Text('patient 3'),
      value: 2,
    ));
    listePatient.add(new DropdownMenuItem(
      child: new Text('patient 4'),
      value: 3,
    ));
  }

  @override
  Widget build(BuildContext context) {
    loadPatient();
    return Form(
        key: _formKey,
        child: new ListView(
          children: getFormWidget(),
        ));
  }

  List<Widget> getFormWidget() {
    List<Widget> formWidget = [];

    formWidget.add(
      new Container(
          margin: EdgeInsets.fromLTRB(0, 50, 0, 0),
          alignment: Alignment.center,
          child: Text(
            'Nouveau Rendez-Vous',
            style: TextStyle(
                color: Colors.black, fontWeight: FontWeight.bold, fontSize: 25),
          )),
    );

//    formWidget.add(new DatePickerScreen());

    formWidget.add(new TextFormField(
      decoration: InputDecoration(labelText: 'date', hintText: 'Date'),
      validator: (value) {
        if (value!.isEmpty) {
          return 'date du rendez-vous';
        }
        return null;
      },
      onSaved: (value) {
        setState(() {
          date = value!;
        });
      },
    ));
    formWidget.add(new TextFormField(
      decoration: InputDecoration(labelText: 'heure', hintText: 'heure'),
      validator: (value) {
        if (value!.isEmpty) {
          return 'heure du rendez-vous';
        }
        return null;
      },
      onSaved: (value) {
        setState(() {
          heure = value!;
        });
      },
    ));

    formWidget.add(new DropdownButton(
      hint: new Text('Patient'),
      items: listePatient,
      value: _selectedPatient,
      onChanged: (value) {
        setState(() {
          _selectedPatient = (value) as int;
        });
      },
      isExpanded: true,
    ));

    void onPressedSubmit() {
      addRv();
      if (_formKey.currentState!.validate()) {
        _formKey.currentState!.save();
        print('date : ' + date);
        print('heure :' + heure);
        print('id patient : ');
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

  Future<String> addRv() async {
    Medecin medecin = getOneMedecin() as Medecin;
    Patient patient = getOnePatient()  as Patient;

    final url = Uri.parse("http://localhost:8888/api/RendezVous");
    final response = await http.post(url, headers: {
      'Content-type': 'application/json; charset=UTF-8',
    },
        body: jsonEncode({
          "date_rv": "2021-10-06",
          "heure": "12:00",
           "medecin" : medecin,
           "patient" : patient
        })

    );
    if (response.statusCode == 201) {
      print(Rendezvous.fromJson(jsonDecode(response.body)));
      return 'success';
    } else {
      print("erreur");
      throw Exception('Failed to create post');
    }
  }
}
