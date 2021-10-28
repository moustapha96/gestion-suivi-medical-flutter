import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mygsmp/widget/components/medecin/drawer.dart';
import 'package:mygsmp/widget/components/medecin/footer_medecin.dart';
import 'package:mygsmp/widget/components/medecin/header_medecin.dart';

class DetailPatientScreen extends StatelessWidget {
  List data = [];
  final int index;

  DetailPatientScreen({required this.data, required this.index});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 10,
        title: Text('Detail du Patient'),
        backgroundColor: Colors.amberAccent,
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
              icon: const Icon(Icons.arrow_back_outlined),
              onPressed: () { Navigator.of(context).pop(); }
            );
          },
        ),
      ),
      drawer: buildDrawerNavgation(context),
      body: Container(
          margin: EdgeInsets.all(2),
          alignment: Alignment.center,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(2),
              image: DecorationImage(
                  image: AssetImage("images/md.jpg"), fit: BoxFit.cover)),
          child: SingleChildScrollView(
              child: Card(
                  margin: EdgeInsets.all(10),
                  elevation: 10,
                  shadowColor: Colors.lightBlueAccent,
                  color: Colors.black12,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      SizedBox(
                        //height: MediaQuery.of(context).size.height * 0.7,
                        child: Card(
                          elevation: 10,
                          color: Colors.blueGrey,
                          child: Column(
                            children: <Widget>[
                              Text(
                                "Detail Patient",
                                style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),
                              ),
                                    ListTile(
                                      hoverColor: Colors.lightBlueAccent,
                                      title: Text(
                                          this.data[index]['prenom'] +
                                              ' ' +
                                              this.data[index]['nom'],
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 15)),
                                      subtitle: Text('prenom&& nom'),
                                    ),
                                    ListTile(
                                      hoverColor: Colors.lightBlueAccent,
                                      title: Text(this.data[index]['adresse'],
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 15)),
                                      subtitle: Text('adresse'),
                                    ),
                                    ListTile(
                                      hoverColor: Colors.lightBlueAccent,
                                      title: Text(
                                          this.data[index]['taille'].toString()+" cm",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 15)),
                                      subtitle: Text('taille'),
                                    ),
                                    ListTile(
                                      hoverColor: Colors.lightBlueAccent,
                                      title: Text(this.data[index]['genre'],
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 15)),
                                      subtitle: Text('genre'),
                                    ),
                                    ListTile(
                                      hoverColor: Colors.lightBlueAccent,
                                      title: Text(this.data[index]['age'].toString(),
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 15)),
                                      subtitle: Text('age'),
                                    ),
                                    ListTile(
                                      hoverColor: Colors.lightBlueAccent,
                                      title: Text(this.data[index]['profession'],
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 15)),
                                      subtitle: Text('profession'),
                                    ),
                                    ListTile(
                                      hoverColor: Colors.lightBlueAccent,
                                      title: Text(this.data[index]['tel'].toString(),
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 15)),
                                      subtitle: Text('TEL'),
                                    ),
                                    ListTile(
                                      hoverColor: Colors.lightBlueAccent,
                                      title: Text(this.data[index]['user']['email'],
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 15)),
                                      subtitle: Text('email'),
                                    ),
                            ],
                          ),
                        ),
                      )
                    ],
                  )))),
    );
  }
}
