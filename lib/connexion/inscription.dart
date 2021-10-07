import 'package:flutter/material.dart';
import 'package:mygsmp/styles/theme.dart';
import 'package:mygsmp/widget/screen/data_patient.dart';

import 'SignUpForm.dart';

class CreateAccount extends StatefulWidget {
  @override
  _CreateAccountState createState() => _CreateAccountState();
}

class _CreateAccountState extends State<CreateAccount> {

  void seconnecter() {
    Navigator.pop(context);
  }

  void inscription() {}

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text("GSMP", ),
          leading: IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.pop(context);
              }),
          backgroundColor: Colors.amber,
          elevation: 5.0,
        ),
        body: new Container(
            padding: new EdgeInsets.fromLTRB(20, 0, 20, 0),
          child: new SignUpForm(),
        ),
      )
    );
  }
}
