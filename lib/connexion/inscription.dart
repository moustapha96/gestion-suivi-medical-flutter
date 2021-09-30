import 'package:flutter/material.dart';
import 'package:mygsmp/models/simple_user.dart';

import '../main.dart';

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
    SimpleUser user = SimpleUser(
        emailController.text, passwordController.text, roleController.text);
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
      leading: IconButton(icon: Icon(Icons.menu), onPressed: () {}),
      actions: <Widget>[
        IconButton(onPressed: () {}, icon: Icon(Icons.more_vert))
      ],
    ),
          backgroundColor: Colors.cyan,
      body: Center(

        child: Container(
          color: Colors.amber,
          width: 400,
          height: 400,
          padding: EdgeInsets.all(2),
          margin: EdgeInsets.all(20),
         /* decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(2),
              image: DecorationImage(
                  image: AssetImage("images/md.jpg"), fit: BoxFit.cover)),*/

          child: Column(
            children: <Widget>[
              Container(
                  margin: EdgeInsets.fromLTRB(0, 10, 0, 0),
                  alignment: Alignment.center,
                  child: Text(
                    'Inscription',
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
                  controller: roleController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Role',
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
                      'S\'inscrire',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                          color: Colors.black),
                    ),
                    onPressed: inscription,
                  )),
              Container(
                  margin: EdgeInsets.fromLTRB(0, 0, 10, 0),
                  alignment: Alignment.bottomRight,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: <Widget>[
                      TextButton(
                          onPressed: seconnecter,
                          child: Text(
                            'Se connecter',
                            style: TextStyle(fontSize: 20),
                          ))
                    ],
                  ))
            ],
          ),
        ),
      ),
    ),

    );
  }
}
