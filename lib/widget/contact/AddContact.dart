
import 'package:flutter/material.dart';
import 'package:mygsmp/models/contact.dart';

class AddContact extends StatefulWidget{

  @override
  _AddContact createState() => new _AddContact();
}

class _AddContact  extends State<AddContact>{
  final _formKey = GlobalKey<FormState>();

  String nom='';
  String email= '';
  String subject = '';
  String message = '';

  DateTime date_contact =  new DateTime.now() ;

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
      decoration: InputDecoration(labelText: 'nom', hintText: 'nom'),
      validator: (value) {
        if (value!.isEmpty) {
          return 'votre Nom complet SVP!';
        }
        return null;
      },
      onSaved: (value) {
        setState(() {
          nom = value!;
        });
      },
    ));
    formWidget.add(new TextFormField(
      decoration: InputDecoration(labelText: 'email', hintText: 'email'),
      validator: (value) {
        if (value!.isEmpty) {
          return 'votre Email ';
        }
        return null;
      },
      onSaved: (value) {
        setState(() {
          email = value!;
        });
      },
    ));
    formWidget.add(new TextFormField(
      decoration: InputDecoration(labelText: 'Sujet', hintText: 'sujet'),
      validator: (value) {
        if (value!.isEmpty) {
          return 'le sujet du message';
        }
        return null;
      },
      onSaved: (value) {
        setState(() {
          subject = value!;
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
        print("nom " + nom);
        print("email " + email);
        print("sujet " + subject);
        print("message " + message);

        Contact contact = new Contact(id: 0, nom: nom, email: email, subject: subject, message: message, date_contact: date_contact);
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