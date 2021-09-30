import 'package:flutter/material.dart';

class Header extends StatelessWidget {
  Header({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Header medecin'),
      ),
      body: Container(),
    );
  }
}
