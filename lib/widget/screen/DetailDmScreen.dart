import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mygsmp/widget/components/medecin/drawer.dart';
import 'package:mygsmp/widget/components/medecin/footer_medecin.dart';
import 'package:mygsmp/widget/components/medecin/header_medecin.dart';

class DetailDmScreen extends StatelessWidget {
  List data = [];
  final int index;

  DetailDmScreen({required this.data, required this.index});

  @override
  Widget build(BuildContext context) {
    List cons = data[index]['consultations'];

    return Scaffold(
      appBar: buildAppBarNavgation(context),
      drawer: buildDrawerNavgation(context),
      body: Container(
          margin: EdgeInsets.all(2),
          alignment: Alignment.center,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(2),
              image: DecorationImage(
                  image: AssetImage("images/md.jpg"), fit: BoxFit.cover)),
          child: Center(
              child: Card(
                  margin: EdgeInsets.fromLTRB(15, 15, 15, 15),
                  elevation: 10,
                  shadowColor: Colors.lightBlueAccent,
                  color: Colors.black12,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                       Text(
                        'Prenom & Nom : ' +
                            this.data[index]['patient']['prenom'] +
                            ' ' +
                            this.data[index]['patient']['nom'],
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20),
                      ),
                      Text(
                        'adresse :' + this.data[index]['patient']['adresse'],
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 15),
                      ),
                      Text(
                        'taille :' +
                            this.data[index]['patient']['taille'].toString(),
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 15),
                      ),
                      Text(
                        'genre :' + this.data[index]['patient']['genre'],
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 15),
                      ),
                      Text(
                        'Age :' + this.data[index]['patient']['age'].toString(),
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 15),
                      ),
                      Text(
                        'Consultations  : ',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 15),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.5 ,
                        child: ListView.builder(
                            itemCount: cons.length,
                            itemBuilder: (context, indice) {
                              return Padding(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 1, horizontal: 4),
                                child: Card(
                                  child: ListTile(
                                    title: Text(cons[indice]['diagnostic']),
                                    subtitle: Text(cons[indice]['traitement']),
                                  ),
                                ),
                              );
                            }),
                      )
                    ],
                  )))),
      //body : buildCorpsPage(context),
      bottomNavigationBar: buildBottomNavigationBar(context),
    );
  }
}
