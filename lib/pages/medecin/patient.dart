import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mygsmp/widget/components/medecin/drawer.dart';
import 'package:mygsmp/widget/components/medecin/footer_medecin.dart';
import 'package:mygsmp/widget/components/medecin/header_medecin.dart';
import 'package:http/http.dart' as http;
import 'package:mygsmp/widget/screen/DetailPatientScreen.dart';


class MedecinPatient extends StatefulWidget {
  @override
  MedecinPatientState createState() => new MedecinPatientState();
}

class MedecinPatientState extends State<MedecinPatient> {
  List _data = [];

  @override
  void initState() {
    getAllPatient();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBarNavgation(context),
      drawer: buildDrawerNavgation(context),
      body: Container(
        margin: EdgeInsets.all(2),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(2),
            image: DecorationImage(
                image: AssetImage("images/md.jpg"), fit: BoxFit.cover)),
        child: buildCorpsPage(context),
      ),
      bottomNavigationBar: buildBottomNavigationBar(context),
    );
  }

  buildCorpsPage(BuildContext context) {
    final ScrollController _scrollController = ScrollController();
    return Center(
       child: SizedBox(
          height: MediaQuery.of(context).size.height * 0.5 ,
          child: ListView.builder(
              itemCount: _data.length,
              itemBuilder: (context, indice) {
                return Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 1, horizontal: 4),
                  child: Card(
                    child: ListTile(
                      title: Text(_data[indice]['nom']),
                      subtitle: Text(_data[indice]['prenom']),
                      onTap: (){
                        print(_data[indice]);
                        Navigator.push(
                          context,

                          MaterialPageRoute(
                            builder: (context) => DetailPatientScreen(data: _data,index: indice),
                          ),
                        );
                      },
                    ),
                  ),
                );
              }),
        )
    );
  }

  Future<String> getAllPatient() async {
    final http.Response response = await http.get(
      Uri.parse("http://localhost:8888/api/patients"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );
    setState(() {
      _data = json.decode(response.body);
    });
    print(_data);
    return "succes";
  }
}
