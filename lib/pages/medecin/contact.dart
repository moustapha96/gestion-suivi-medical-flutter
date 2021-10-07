import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mygsmp/widget/components/medecin/drawer.dart';
import 'package:mygsmp/widget/components/medecin/footer_medecin.dart';
import 'package:mygsmp/widget/components/medecin/header_medecin.dart';
import 'package:mygsmp/widget/contact/AllContact.dart';

class MedecinContat extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
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
        child: buildCorpsPage(context),
      ) ,
      //body : buildCorpsPage(context),
      bottomNavigationBar: buildBottomNavigationBar(context),
    );
  }


  buildCorpsPage(BuildContext context) {
    final ScrollController _scrollController = ScrollController();
    return MaterialApp(
        home: Scaffold(
          body: Center(
            child: new Scrollbar(
                isAlwaysShown: true,
                controller: _scrollController,
                child: ListView.builder(
                    controller: _scrollController,
                    itemCount: 50,
                    itemBuilder: (context, index){
                      return Card(
                        child: ListTile(
                          title: Text('contact: ${index + 1} '),
                        ),
                      );
                    }
                )),
          ),
        )
    );
  }
}