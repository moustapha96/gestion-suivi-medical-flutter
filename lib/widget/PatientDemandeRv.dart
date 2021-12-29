import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mygsmp/models/DemandeRv.dart';
import 'package:mygsmp/models/dossier_medical.dart';
import 'package:mygsmp/models/medecin.dart';
import 'package:mygsmp/models/patient.dart';
import 'package:mygsmp/models/simple_user.dart';
import 'package:mygsmp/models/userModel.dart';

class DemandeRVForm extends StatefulWidget{
  @override
  _DemandeRVForm  createState() => new _DemandeRVForm();
}

class _DemandeRVForm extends State<DemandeRVForm> {

  final _formKey = GlobalKey<FormState>();
  var _passKey = GlobalKey<FormFieldState>();

  late Patient patient;
  late Medecin medecin;

  int _selectedMedecin = 0;

  List<DropdownMenuItem<int>> listeMedeccin = [];

  void loadMedecinList() {
    listeMedeccin = [];
    listeMedeccin.add(new DropdownMenuItem(child: new Text('Medecin 1'), value: 0,));
    listeMedeccin.add(new DropdownMenuItem(child: new Text('Medecin 2'), value: 1,));
    listeMedeccin.add(new DropdownMenuItem(child: new Text('Medecin 3'), value: 2,));
    listeMedeccin.add(new DropdownMenuItem(child: new Text('Medecin 4'), value: 3,));
  }

  @override
  Widget build(BuildContext context) {
    loadMedecinList();
    return Form(
        key: _formKey,
        child: new ListView(
          children: getFormWidget(),
        ));
  }

  List<Widget> getFormWidget() {
    List<Widget> formWidget = [];

    formWidget.add(new DropdownButton(
      hint: new Text('Medecin'),
      items: listeMedeccin,
      value: _selectedMedecin,
      onChanged: (value) {
        setState(() {
          _selectedMedecin = (value) as int ;
        });
      },
      isExpanded: true,
    ));

    void onPressedSubmit() {
        DateTime date_demande = DateTime.now();
        Demanderv demanderv = new Demanderv(id: 0,
            patient: patient, medecin: medecin, date_demnande: DateTime.now());
        Scaffold.of(context)
            .showSnackBar(SnackBar(content: Text('demande enovoyé !!')));

    }

    formWidget.add(new RaisedButton(
        color: Colors.blue,
        textColor: Colors.white,
        child: new Text('envoyé demande'),
        onPressed: onPressedSubmit));

    return formWidget;
  }
}