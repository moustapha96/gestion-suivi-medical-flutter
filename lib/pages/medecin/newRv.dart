// ignore_for_file: non_constant_identifier_names

import 'dart:convert';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mygsmp/models/medecin.dart';
import 'package:mygsmp/models/patient.dart';
import 'package:mygsmp/models/rendezVous.dart';
import 'package:mygsmp/models/userModel.dart';
import 'package:mygsmp/widget/DatePickerScreen.dart';
import 'package:mygsmp/widget/FixerRendezVous.dart';
import 'package:mygsmp/widget/components/medecin/drawer.dart';
import 'package:mygsmp/widget/components/medecin/footer_medecin.dart';
import 'package:mygsmp/widget/components/medecin/header_medecin.dart';
import 'package:http/http.dart' as http;

class MedecinNewRv extends StatefulWidget{
  late Medecin medecin;
  late Rendezvous rv;
  late Patient patient;
  String emailPatient;
  String emailMedecin;

  MedecinNewRv( { Key? key,required this.emailMedecin, required this.emailPatient  }) : super(key: key);

  State createState() =>  _MedecinNewRv(emailMedecin: emailMedecin, emailPatient: emailPatient);
}
class _MedecinNewRv extends State<MedecinNewRv> {
  String emailMedecin; String emailPatient;
  _MedecinNewRv({ required this.emailMedecin, required this.emailPatient });


  Medecin medecinC = new Medecin(
      idMedecin: 0,
      specialisation: "",
      initial: "",
      prenom: "",
      num_licence: "",
      adresse: "",
      user: null,
      genre: "",
      nom: "",
      tel: "",
      taille: 0,
      age: 0);
  Patient patientC = new Patient(
    idPatient: 0,
    statut_social: "",
    prenom: "",
    profession: "",
    adresse: "",
    genre: "",
    user: null,
    nom: "",
    tel: "",
    taille: 0,
    age: 0,
    // creatAt: DateTime.now()
  );

  final _formKeyMemos = GlobalKey<FormState>();
  TextEditingController dateController = TextEditingController();
  TextEditingController heureController = TextEditingController();


  @override
  void initState() {
    super.initState();
    print('patient'+ emailPatient);
    print('medecin'+ emailMedecin);
    getMedecinById(emailMedecin);
    getPatientById(emailPatient);


  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text('Nouveau RV'),
      ),
      body: Container(
        margin: EdgeInsets.all(3),
        alignment: Alignment.center,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(2),
            image: DecorationImage(
                image: AssetImage("images/md.jpg"), fit: BoxFit.cover)),
        child: Container(
          margin: EdgeInsets.all(15),
          child: formnewRV(context),
        )
      ) ,
     // bottomNavigationBar: buildBottomNavigationBar(context),
    );
  }

  Center formnewRV(BuildContext context){
    return Center(
      child: Form(
        key: _formKeyMemos,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            TextFormField(
              controller: heureController,
              keyboardType: TextInputType.datetime,
              decoration: const InputDecoration(
                icon: const Icon(Icons.text_fields_outlined),
                hintText: 'heure...',
                labelText: 'heure',
              ),
            ),
            TextFormField(
              controller: dateController,
              keyboardType: TextInputType.datetime,
              decoration: const InputDecoration(
                icon: const Icon(Icons.local_post_office),
                hintText: 'date...',
                labelText: 'date',
              ),
            ),

            new Container(
              margin: EdgeInsets.only(top: 15),
              child : Center(
                  child: TextButton(
                    style: ButtonStyle(
                      foregroundColor: MaterialStateProperty.all<Color>(Colors.blue),
                    ),
                    onPressed: (){

                      setState(() {
                        print( heureController.text+ "- "+dateController.text  );
                        savenewRv(heureController.text, dateController.text );
                      });
                    },
                    child: Text('enregistrer', style: TextStyle( fontSize: 20 , fontWeight:  FontWeight.bold),   ),
                  )
              ),
            ),

          ],
        ),
      ),
    ) ;
  }


  Future<String> getPatientById(String email) async {
    String _base_email = "http://localhost:8888/api/patients/user";
    final http.Response response = await http
        .get(Uri.parse(_base_email + "/" + email), headers: {
      'Accept': 'application/json',
    });
    setState(() {
      var data = jsonDecode(response.body);
      this.patientC = new Patient(
        idPatient: data["id"],
        statut_social: data["statut_social"],
        prenom: data["prenom"],
        profession: data["profession"],
        adresse: data["adresse"],
        genre: data["genre"],
        user: new Usermodel.fromMap(data["user"]),
        nom: data["nom"],
        tel: data["tel"],
        taille: data["taille"],
        age: data["age"],
        //creatAt: DateTime.parse( data["creatAt"] )
      );
    });
    print(this.patientC);
    return "Success";
  }

  Future<String> getMedecinById(String email) async {
    String _base_email_me = "http://localhost:8888/api/medecins/user";
    final http.Response response = await http
        .get(Uri.parse(_base_email_me + "/" + email), headers: <String, String>{
      'Accept': 'application/json',
    });
    setState(() {
      var data = jsonDecode(response.body);
      this.medecinC = new Medecin(
        idMedecin: data['idMedecin'],
        specialisation: data["specialisation"],
        initial: data['initial'],
        prenom: data['prenom'],
        num_licence: data['num_licence'],
        adresse: data['adresse'],
        user: new Usermodel.fromMap(data["user"]),
        genre: data['genre'],
        nom: data['nom'],
        tel: data['tel'],
        taille: data['taille'],
        age: data['age'],
        //created_at: DateTime.parse(data["created_at"])
      );
    });
    print(this.medecinC);
    return "Success";
  }

  Future<String> savenewRv(String heure, String date) async{

    DateTime datee = DateTime.now();
    Rendezvous rv= new Rendezvous(idRendezVous: 0, date_rv: datee, heure: heure, medecin: medecinC, patient: patientC);

    final http.Response response = await http.post(
        Uri.parse("http://localhost:8888/api/RendezVous"),
        headers: <String, String>{
          "Accept": "application/json",
          'Content-Type': 'application/json; charset=UTF-8',
        }, body: rv.toJson());

    if ( response.statusCode == 200 ){
      Fluttertoast.showToast(
          msg: "RV enregistrer avec succés",
          webPosition: "center",
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 2);
    }else{
      Fluttertoast.showToast(
          msg: "RV non enregistrer",
          webPosition: "center",
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 2);
    }
    return "suceess";
  }

}
