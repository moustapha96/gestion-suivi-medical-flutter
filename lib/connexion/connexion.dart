import 'package:flutter/material.dart';
import 'package:mygsmp/models/simple_user.dart';
import 'package:mygsmp/pages/medecin/accueil.dart';
import 'package:mygsmp/pages/medecin/rv.dart';

import '../main.dart';

class Login extends StatefulWidget {
  @override
  _Login createState() => _Login();
}

class _Login extends State<Login> {


  TextEditingController emailController = TextEditingController();

  TextEditingController passwordController = TextEditingController();

  TextEditingController roleController = TextEditingController();

  void creerCompte() {
    print("button creer un compte");
    Navigator.pushNamed(context, '/inscription');
  }

  void login(){
    SimpleUser users = new SimpleUser(emailController.text, passwordController.text, "role");
    Navigator.push(context,
        MaterialPageRoute(
      builder: (context) => AcceuilMedecin( user : users),
    ));
  //  Navigator.pushNamed(context, '/medecin/home', arguments: { users } );
    print(emailController.text);
    print(passwordController.text);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
            appBar: AppBar(
              title: Text("GSMP"),
              backgroundColor: Colors.amber,
              elevation: 10.0,
              automaticallyImplyLeading: true,
            ),
            body: Center(
              child: Container(
                padding: EdgeInsets.all(10),
                margin: EdgeInsets.all(2),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(2),
                    image: DecorationImage(
                        image: AssetImage("images/md.jpg"), fit: BoxFit.cover)),
                child: Column(
                  children: <Widget>[
                    Container(
                        margin: EdgeInsets.fromLTRB(0, 50, 0, 0),
                        alignment: Alignment.center,
                        child: Text(
                          'Connexion',
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 25),
                        )),
                    Container(
                      padding: EdgeInsets.all(10),
                      margin: EdgeInsets.fromLTRB(0, 20, 0, 0),
                      child: TextField(
                        controller: emailController,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Email',
                        ),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
                      child: TextField(
                        obscureText: true,
                        controller: passwordController,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Password',
                        ),
                      ),
                    ),
                    Container(
                        height: 50,
                        width: 200,
                        child: TextButton(
                          child: Text(
                            'Se Connecter',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                                color: Colors.black),
                          ),
                          onPressed: login,
                        )),
                    Container(
                        margin: EdgeInsets.fromLTRB(0, 0, 10, 0),
                        alignment: Alignment.bottomRight,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: <Widget>[
                            TextButton(
                              onPressed: () {
                                print("bouton forget password");
                              },
                              child: Text(
                                'Forgot Password',
                                style: TextStyle(fontStyle: FontStyle.italic),
                              ),
                            ),
                            TextButton(
                                onPressed: creerCompte,
                                child: Text(
                                  'creer un compte',
                                  style: TextStyle(fontSize: 20),
                                ))
                          ],
                        ))
                  ],
                ),
              ),
            )));
  }
}
