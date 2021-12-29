import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mygsmp/models/dossier_medical.dart';
import 'package:mygsmp/models/patient.dart';
import 'package:mygsmp/models/simple_user.dart';
import 'package:mygsmp/models/userModel.dart';
import 'package:http/http.dart' as http;

class SignUpForm extends StatefulWidget {
  @override
  _SignUpFormState createState() => new _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  final _formKey = GlobalKey<FormState>();
  var _passKey = GlobalKey<FormFieldState>();
  String email = '';
  String _password = '';

  String statutSocial = 'Célibataire';
  String prenom = '';
  String nom = '';
  String profession = '';
  String adresse = '';
  String genre = 'Masculin';
  double tel = 0;
  int taille = 0;
  int age = 0;
  String password = '';
  String selectedValue = "USA";

  @override
  Widget build(BuildContext context) {
    return Form(
        key: _formKey,
        child: new ListView(
          children: getFormWidget(),
        ));
  }

  List<DropdownMenuItem<String>> get dropdownItemsGender {
    List<DropdownMenuItem<String>> menuItems = [
      DropdownMenuItem(child: Text("Masculin"), value: "Masculin"),
      DropdownMenuItem(child: Text("Féminin"), value: "Féminin"),
    ];
    return menuItems;
  }

  List<DropdownMenuItem<String>> get dropdownItemsStatutSocial {
    List<DropdownMenuItem<String>> menuItems = [
      DropdownMenuItem(child: Text('Célibataire'), value: 'Célibataire'),
      DropdownMenuItem(
        child: Text('Marié(e)'),
        value: 'Marié(e)',
      ),
      DropdownMenuItem(
        child: Text('Divorcé(e)'),
        value: 'Divorcé(e)',
      ),
      DropdownMenuItem(
        child: Text('Veuf(ve)'),
        value: 'Veuf(ve)',
      ),
      DropdownMenuItem(
        child: Text('Maribataire'),
        value: 'maribataire',
      ),
    ];
    return menuItems;
  }

  List<Widget> getFormWidget() {
    List<Widget> formWidget = [];

    formWidget.add(new TextFormField(
      decoration: InputDecoration(
          labelText: 'prénom',
          hintText: 'prenom',
          prefixIcon: Icon(Icons.accessibility_sharp)),
      validator: (value) {
        if (value!.isEmpty) {
          return 'Please enter you firstname';
        }
        return null;
      },
      onSaved: (value) {
        setState(() {
          prenom = value!;
        });
      },
    ));
    formWidget.add(new TextFormField(
      decoration: InputDecoration(
          labelText: 'nom',
          prefixIcon: Icon(Icons.text_fields),
          hintText: 'nom'),
      validator: (value) {
        if (value!.isEmpty) {
          return 'Please enter you lastname';
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
      decoration: InputDecoration(
          labelText: 'adresse',
          prefixIcon: Icon(Icons.add_reaction_sharp),
          hintText: 'adresse'),
      validator: (value) {
        if (value!.isEmpty) {
          return 'Please enter you address';
        }
        return null;
      },
      onSaved: (value) {
        setState(() {
          adresse = value!;
        });
      },
    ));
    formWidget.add(new TextFormField(
      decoration: InputDecoration(
          labelText: 'profeession',
          prefixIcon: Icon(Icons.text_fields),
          hintText: 'profession'),
      validator: (value) {
        if (value!.isEmpty) {
          return 'votre profession';
        }
        return null;
      },
      onSaved: (value) {
        setState(() {
          profession = value!;
        });
      },
    ));
    formWidget.add(new TextFormField(
      decoration: InputDecoration(
          labelText: 'tel', prefixIcon: Icon(Icons.phone), hintText: 'tel'),
      validator: (value) {
        if (value!.isEmpty) {
          return 'Please enter you phone';
        }
        return null;
      },
      onSaved: (value) {
        setState(() {
          tel = double.tryParse(value!)!;
        });
      },
    ));
    formWidget.add(new TextFormField(
      decoration: InputDecoration(
          labelText: 'taille',
          prefixIcon: Icon(Icons.text_fields),
          hintText: 'taille'),
      validator: (value) {
        if (value!.isEmpty) {
          return 'Please enter you tail';
        }
        return null;
      },
      onSaved: (value) {
        setState(() {
          taille = int.tryParse(value!)!;
        });
      },
    ));
    formWidget.add(new TextFormField(
      decoration: InputDecoration(
          labelText: 'Enter Email',
          prefixIcon: Icon(Icons.alternate_email),
          hintText: 'Email'),
      keyboardType: TextInputType.emailAddress,
      onSaved: (value) {
        setState(() {
          email = value!;
        });
      },
    ));

    formWidget.add(new TextFormField(
      decoration: InputDecoration(
          hintText: 'Age',
          prefixIcon: Icon(Icons.emoji_people_sharp),
          labelText: 'Age'),
      keyboardType: TextInputType.number,
      validator: (value) {
        if (value!.isEmpty)
          return 'Enter age';
        else
          return null;
      },
      onSaved: (value) {
        setState(() {
          age = int.tryParse(value!)!;
        });
      },
    ));

    formWidget.add(new DropdownButton(
      value: genre,
      onChanged: (String? newValue) {
        setState(() {
          genre = newValue!;
          print(genre);
        });
      },
      items: dropdownItemsGender,
      isExpanded: true,
    ));
    formWidget.add(new DropdownButton(
      value: statutSocial,
      onChanged: (String? newValue) {
        setState(() {
          statutSocial = newValue!;
          print(statutSocial);
        });
      },
      items: dropdownItemsStatutSocial,
      isExpanded: true,
    ));

    formWidget.add(
      new TextFormField(
          key: _passKey,
          obscureText: true,
          decoration: InputDecoration(
              hintText: 'Password',
              prefixIcon: Icon(Icons.password),
              labelText: 'Enter Password'),
          validator: (value) {
            if (value!.isEmpty)
              return 'Please Enter password';
            else if (value.length < 6)
              return 'Password should be more than 8 characters';
            else
              return null;
          }),
    );

    formWidget.add(
      new TextFormField(
          obscureText: true,
          decoration: InputDecoration(
              hintText: 'Confirm Password',
              prefixIcon: Icon(Icons.password_outlined),
              labelText: 'Enter Confirm Password'),
          validator: (confirmPassword) {
            if (confirmPassword!.isEmpty) return 'Enter confirm password';
            var password = _passKey.currentState!.value;
            if (confirmPassword.compareTo(password) != 0)
              return 'Password mismatch';
            else
              return null;
          },
          onSaved: (value) {
            setState(() {
              _password = value!;
            });
          }),
    );

    void onPressedSubmit() {
      if (_formKey.currentState!.validate()) {
        _formKey.currentState!.save();
        //
        // print("email : " + email);
        // print("age " + age.toString());
        // print("profession " + profession);
        // print('N° '+ statutSocial + ' statut social : ');
        // print("prenom"+ prenom);
        // print("npm" + nom);
        // print( "adresse" + adresse);
        // print('genre' + genre );
        // print("tel "+ tel.toString() );
        // print("tille" + taille.toString() );
        //
        // print("Password " + _password);
        Usermodel user = new Usermodel(
            email: email,
            password: _password,
            role: "patient",
            iduser: 0,
           // creatAt: DateTime.now().toString()
        );
        print(user.toMap());

        Patient patient = new Patient(
          idPatient: 0,
            statut_social: statutSocial,
            prenom: prenom,
            profession: profession,
            adresse: adresse,
            genre: genre,
            user: user,
            nom: nom,
            tel: tel.toString(),
            taille: taille,
            age: age);

        saveUser(user, patient);

        print(patient.toJson());

        Scaffold.of(context)
            .showSnackBar(SnackBar(content: Text('inscription en cours...!')));
      }
    }

    formWidget.add(new RaisedButton(
        color: Colors.blue,
        textColor: Colors.white,
        child: new Text('s\'inscrire'),
        onPressed: onPressedSubmit));

    return formWidget;
  }

  Future<String> savePatient(Patient patient) async {
    String _base = "http://localhost:8888/api/patients";
    final http.Response response = await http.post(
      Uri.parse(_base),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(patient.toDatabaseJson()),
    );
    return ("success");
  }

  Future<String> saveUser(Usermodel user, Patient patient) async {
    String _base = "http://localhost:8888/api/User";
    final http.Response response = await http.post(
      Uri.parse(_base),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(user.toDatabaseJson()),
    );
    var data = json.decode(response.body);

    Usermodel usr = new Usermodel(
        iduser: data['iduser'],
        email: data['email'],
        password: data['password'],
        role: data['role'],
       // creatAt: data['creatAt']
    );

    print(usr.toJson());
    Patient patient = new Patient(
        idPatient: 0,
        statut_social: statutSocial,
        prenom: prenom,
        profession: profession,
        adresse: adresse,
        genre: genre,
        user : user,
        nom: nom,
        tel: tel.toString(),
        taille: taille,
        age: age,
       );

    print(patient.toJson());
    savePatient(patient);

    return "Success";
  }
}
