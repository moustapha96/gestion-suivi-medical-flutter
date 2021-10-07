import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mygsmp/models/contact.dart';
import 'package:mygsmp/services/contactService.dart';

class AllContact extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return getAllContactState();
  }
}

class getAllContactState extends State<AllContact>{
  final ScrollController _scrollController = ScrollController();
  @override
  Widget build(BuildContext context) {
     // List<Contact> contacts =  fetchContact() as List<Contact>;
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
