import 'package:flutter/cupertino.dart';
import 'package:mygsmp/models/patient.dart';

class CardDetailPatient extends StatelessWidget{

  final Patient? patient;
  CardDetailPatient({Key? key,required this.patient  }): super(key: key);

  @override
  Widget build(BuildContext context) {
   
    return Padding(padding: EdgeInsets.all(0.0),
      child: Column(
        children: <Widget>[
          
        ],
      ),
    );
  }

}