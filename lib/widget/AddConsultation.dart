import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mygsmp/models/patient.dart';

class AddConsultation extends StatefulWidget{

  final Patient? patient;
  AddConsultation({Key? key, required this.patient}): super (key: key);

  @override
  _AddConsultation createState() => new _AddConsultation();
}
class _AddConsultation extends State<AddConsultation> {
  final _formKey = GlobalKey<FormState>();
  String diagnostic = '';
  String traitement = '';


  @override
  Widget build(BuildContext context) {
    return Form(
        key: _formKey,
        child: new ListView(
          children: getFormWidget(),
        ));
  }

  List<Widget> getFormWidget() {
    List<Widget> formWidget = [];

    formWidget.add(new TextFormField(
      decoration: InputDecoration(labelText: 'diagtostic', hintText: 'Diagnostic'),
      validator: (value) {
        if (value!.isEmpty) {
          return 'Please enter you diagnostic';
        }
        return null;
      },
      onSaved: (value) {
        setState(() {
          diagnostic = value!;
        });
      },
    ));
    formWidget.add(new TextFormField(
      decoration: InputDecoration(labelText: 'traitement', hintText: 'traitement'),
      validator: (value) {
        if (value!.isEmpty) {
          return 'Please enter you traitement';
        }
        return null;
      },
      onSaved: (value) {
        setState(() {
          diagnostic = value!;
        });
      },
    ));
    void onPressedSubmit() {
      if (_formKey.currentState!.validate() ) {
        _formKey.currentState!.save();

        print("diagnostic " + diagnostic);
        print("traitement " + traitement);
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

}