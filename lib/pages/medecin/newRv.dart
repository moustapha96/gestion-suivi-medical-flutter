// ignore_for_file: non_constant_identifier_names

import 'dart:convert';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
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

import 'accueil.dart';

class MedecinNewRv extends StatefulWidget{
  late Medecin medecin;
  late Rendezvous rv;
  late Patient patient;
  String emailPatient;
  String emailMedecin;

  String token;
  MedecinNewRv( { Key? key,required this.emailMedecin, required this.emailPatient, required this.token  }) : super(key: key);

  State createState() =>  _MedecinNewRv(emailMedecin: emailMedecin, emailPatient: emailPatient, token: token);
}
class _MedecinNewRv extends State<MedecinNewRv> {
  String emailMedecin; String emailPatient;
  String token;
  _MedecinNewRv({ required this.emailMedecin, required this.emailPatient, required this.token });


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
  TextEditingController dateinput = TextEditingController();

  @override
  void initState() {
    super.initState();
    dateinput.text = "";
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
            new Center(
              child: TextField(
                controller: dateinput,
                decoration: InputDecoration(
                  icon:Icon(Icons.calendar_today),
                  labelText: "date"
                ),
                readOnly: true,
                onTap: () async {
                  DateTime? pickedDate = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(2000),
                      lastDate: DateTime(2030));
                  if(pickedDate != null ){
                    print(pickedDate);
                    String formattedDate = DateFormat('yyyy-MM-dd').format(pickedDate);
                    print(formattedDate);

                    setState(() {
                      dateinput.text = formattedDate;
                    });
                  }else{
                    print("Date is not selected");
                  }
                },
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
                        print(dateinput.text);
                        print( heureController.text);
                        savenewRv(heureController.text, dateinput.text );
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
    String _base_email = "http://localhost:8008/api/patients/user";
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
    String _base_email_me = "http://localhost:8008/api/medecins/user";
    final http.Response response = await http
        .get(Uri.parse(_base_email_me + "/" + email), headers: <String, String>{
      'Accept': 'application/json','Authorization': 'Bearer token $token'
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

   print("heure"+ heure);
   print("date"+ date );

    final http.Response response = await http.post(
        Uri.parse("http://localhost:8008/api/RendezVous"),
        headers: <String, String>{
          "Accept": "application/json",
          'Authorization': 'Bearer token $token',
          'Content-Type': 'application/json; charset=UTF-8',
        }, body: jsonEncode(
              {
                "idRendezVous": 0,
                "date_rv": date,
                "heure": heure,
                "medecin": {
                  "idMedecin": medecinC.getIdMedecin,
                  "specialisation": medecinC.getSpecialisation,
                  "initial": medecinC.getInitial,
                  "prenom": medecinC.getPrenom,
                  "num_licence": medecinC.getNumlicence,
                  "adresse": medecinC.getAdresse,
                  "user": {
                    "iduser": 4,
                    "email": medecinC.user?.getEmail,
                    "password": medecinC.user?.getPassword,
                    "role": medecinC.user?.getRole,
                    "creatAt": ""
                  },
                  "genre": medecinC.getGenre,
                  "nom": medecinC.getNom,
                  "tel": medecinC.getTel,
                  "taille": medecinC.getTaille,
                  "age": medecinC.getAge,
                  "creatAt": "2021-03-03"
                },
                "patient": {
                  "statut_social": patientC,
                  "prenom": patientC.getPrenom,
                  "profession": patientC.getProfession,
                  "adresse": patientC.getAdresse,
                  "genre": patientC.getGenre,
                  "user": {
                    "iduser":patientC.user?.getIduser,
                    "email": patientC.user?.getEmail,
                    "password": patientC.user?.getPassword,
                    "role": patientC.user?.getRole,
                    "creatAt": ""
                  },
                  "nom": patientC.getNom,
                  "tel": patientC.getTel,
                  "taille": patientC.getTaille,
                  "age": patientC.getAge,
                  "creatAt": "",
                  "id": patientC.getIdPatient
                },
              }
          )
    );
    if ( response.statusCode == 200 ){
      Fluttertoast.showToast(
          msg: "RV enregistrer avec succés",
          webPosition: "center",
          backgroundColor: Colors.green,
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 2);
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) =>
                AcceuilMedecin(emailmedecin: emailMedecin,  token: token ),
          ));

    }else{
      Fluttertoast.showToast(
          msg: "RV non enregistrer",
          webPosition: "center",
          backgroundColor: Colors.red,
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 2);
    }
    return "suceess";
  }

}
