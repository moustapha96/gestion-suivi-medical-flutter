import 'package:flutter/material.dart';
import 'package:mygsmp/styles/theme.dart';
import 'package:mygsmp/widget/screen/data_patient.dart';

class CreateAccount extends StatefulWidget {
  @override
  _CreateAccountState createState() => _CreateAccountState();
}

class _CreateAccountState extends State<CreateAccount> {


  TextEditingController emailController = TextEditingController();

  TextEditingController passwordController = TextEditingController();

  TextEditingController roleController = TextEditingController();

  void seconnecter() {
    Navigator.pop(context);
  }

  void inscription() {

  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,

        home: Scaffold(

    appBar: AppBar(
      title: Text("GSMP",
      textAlign: TextAlign.center,

      ),
      leading: IconButton(icon: Icon(Icons.arrow_back), onPressed: () {
        Navigator.pop(context);
      }),
      actions: <Widget>[
        IconButton(onPressed: () {}, icon: Icon(Icons.login))
      ],
      backgroundColor: Colors.amber,
      elevation: 10.0,
    ),
          backgroundColor: Colors.cyan,
      body: Center(

        child: Container(
          padding: EdgeInsets.all(1),
          margin: EdgeInsets.all(2),
         width: MediaQuery.of(context).size.width * 0.95,
         height: MediaQuery.of(context).size.height * 0.95,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(2),
              image: DecorationImage(
                  image: AssetImage("images/md.jpg"), fit: BoxFit.cover)),


          child: builContainerPatientDetail(context),
        ),
      ),
    ),

    );
  }
}
