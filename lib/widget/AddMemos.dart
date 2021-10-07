import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mygsmp/models/DemandeRv.dart';
import 'package:mygsmp/models/medecin.dart';
import 'package:mygsmp/models/memos.dart';

class AddMemos extends StatefulWidget{

  @override
  _AddMemos createState() => new _AddMemos();
}

class _AddMemos  extends State<AddMemos>{
  final _formKey = GlobalKey<FormState>();
  String titre = '';
  String message = '';
  DateTime date_creer =  new DateTime.now() ;
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
      decoration: InputDecoration(labelText: 'titre', hintText: 'titre'),
      validator: (value) {
        if (value!.isEmpty) {
          return 'le titre du mrssage';
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
      if (_formKey.currentState!.validate() ) {
        _formKey.currentState!.save();
        print("titre " + titre);
        print("message " + message);


        //Memos memos = new Memos(idMemos: 0, titre: titre, message: message, medecin: null, date_creer: date_creer);
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