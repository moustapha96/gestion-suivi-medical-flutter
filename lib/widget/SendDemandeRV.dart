import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mygsmp/models/DemandeRv.dart';
import 'package:mygsmp/models/medecin.dart';

class SendDemandeRv extends StatefulWidget{

  @override
  _SendDemandeRv createState() => new _SendDemandeRv();
}

class _SendDemandeRv  extends State<SendDemandeRv>{
  final _formKey = GlobalKey<FormState>();
  late Demanderv demanderv;
  late List<Medecin> listeMedecin;

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


    void onPressedSubmit() {
      if (_formKey.currentState!.validate() ) {
        _formKey.currentState!.save();
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