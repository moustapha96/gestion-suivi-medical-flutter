import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mygsmp/models/dossier_medical.dart';
import 'package:mygsmp/models/patient.dart';
import 'package:mygsmp/models/simple_user.dart';
import 'package:mygsmp/models/userModel.dart';

class SignUpForm extends StatefulWidget {
  @override
  _SignUpFormState createState() => new _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  final _formKey = GlobalKey<FormState>();
  var _passKey = GlobalKey<FormFieldState>();
  String email = '';
  int _selectedGender = 0;
  String _password = '';

  int selectSttsocial = 0;
  String statutSocial = '';
  String prenom = '';
  String nom = '';
  String profession = '';
  String adresse = '';
  String genre = '';
  double tel = 0;
  int taille = 0;
  int age = 0;
  String password = '';

  List<DropdownMenuItem<int>> genderList = [];
  List<DropdownMenuItem<int>> sttsocial = [];

  void loadGenderList() {
    genderList = [];
    genderList.add(new DropdownMenuItem(
      child: new Text('Masculin'),
      value: 0,
    ));
    genderList.add(new DropdownMenuItem(
      child: new Text('Féminin'),
      value: 1,
    ));
  }

  void loadStatuSocial() {
    sttsocial = [];
    sttsocial.add(new DropdownMenuItem(
      child: new Text('Célibataire'),
      value: 0,
    ));
    sttsocial.add(new DropdownMenuItem(
      child: new Text('Marié(e)'),
      value: 1,
    ));
    sttsocial.add(new DropdownMenuItem(
      child: new Text('Divorcé(e)'),
      value: 2,
    ));
    sttsocial.add(new DropdownMenuItem(
      child: new Text('Veuf(ve)'),
      value: 3,
    ));
  }

  @override
  Widget build(BuildContext context) {
    loadGenderList();
    loadStatuSocial();
    return Form(
        key: _formKey,
        child: new ListView(
          children: getFormWidget(),
        ));
  }

  List<Widget> getFormWidget() {
    List<Widget> formWidget = [];

    formWidget.add(new TextFormField(
      decoration: InputDecoration(labelText: 'prénom', hintText: 'prenom'),
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
      decoration: InputDecoration(labelText: 'nom', hintText: 'nom'),
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
      decoration: InputDecoration(labelText: 'adresse', hintText: 'adresse'),
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
      decoration: InputDecoration(labelText: 'tel', hintText: 'tel'),
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
      decoration: InputDecoration(labelText: 'taille', hintText: 'taille'),
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
      decoration: InputDecoration(labelText: 'Enter Email', hintText: 'Email'),
      keyboardType: TextInputType.emailAddress,
      onSaved: (value) {
        setState(() {
          email = value!;
        });
      },
    ));

    formWidget.add(new TextFormField(
      decoration: InputDecoration(hintText: 'Age', labelText: 'Age'),
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
      hint: new Text('Genre'),
      items: genderList,
      value: _selectedGender,
      onChanged: (value) {
        setState(() {
          _selectedGender = (value) as int;
        });
      },
      isExpanded: true,
    ));
    formWidget.add(new DropdownButton(
      hint: new Text('Statut social'),
      items: sttsocial,
      value: selectSttsocial,
      onChanged: (value) {
        setState(() {
          selectSttsocial = (value) as int;
        });
      },
      isExpanded: true,
    ));

    formWidget.add(
      new TextFormField(
          key: _passKey,
          obscureText: true,
          decoration: InputDecoration(
              hintText: 'Password', labelText: 'Enter Password'),
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

        DossierMedical dm = new DossierMedical(
            idDossierMedical: 0,
            medecin: null,
            patient: null,
            consultations: []);
        print("Password " + _password);
        Usermodel user = new Usermodel(
            email: email, password: password, role: "patient", iduser: 0);
        Patient patient = new Patient(
            id: 0,
            statut_social: statutSocial,
            prenom: prenom,
            profession: profession,
            adresse: adresse,
            genre: genre,
            user: user,
            nom: nom,
            tel: tel.toString(),
            taille: taille,
            age: age,
            creatAt: DateTime.now().toString());

        print(patient.prenom);
        print(patient.nom);
        print(patient.adresse);

        Scaffold.of(context)
            .showSnackBar(SnackBar(content: Text('Form Submitted')));
      }
    }

    formWidget.add(new RaisedButton(
        color: Colors.blue,
        textColor: Colors.white,
        child: new Text('inscrire'),
        onPressed: onPressedSubmit));

    return formWidget;
  }
}
