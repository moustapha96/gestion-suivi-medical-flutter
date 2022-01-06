// ignore_for_file: non_constant_identifier_names

import 'dart:convert';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mygsmp/models/consultation.dart';
import 'package:mygsmp/models/dossier_medical.dart';
import 'package:mygsmp/models/medecin.dart';
import 'package:mygsmp/models/patient.dart';
import 'package:mygsmp/models/rendezVous.dart';
import 'package:mygsmp/models/userModel.dart';
import 'package:http/http.dart' as http;

import 'accueil.dart';

class MedecinAddConsultation extends StatefulWidget{


  String token;
  String emailPatient;
  String emailMedecin;

  MedecinAddConsultation( { Key? key,required this.emailMedecin, required this.emailPatient , required this.token }) : super(key: key);

  State createState() =>  _MedecinAddConsultationState(token: token, emailMedecin: emailMedecin, emailPatient: emailPatient);
}
class _MedecinAddConsultationState extends State<MedecinAddConsultation> {

  String emailMedecin; String emailPatient;String token;
  _MedecinAddConsultationState({ required this.emailMedecin, required this.emailPatient, required this.token });


  DossierMedical dm = new DossierMedical(idDossierMedical: 0, medecin: null, patient: null, consultations: null);

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

  final _formKeyConsultation = GlobalKey<FormState>();

  TextEditingController traitement = TextEditingController();
  TextEditingController diagnostic = TextEditingController();


  @override
  void initState() {
    super.initState();

    print('patient'+ emailPatient);
    print('medecin'+ emailMedecin);

    getMedecinById(emailMedecin);
    getPatientById(emailPatient);
    getDmPatient(emailPatient);

  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text('Consultation pour '+ this.patientC.getPrenom ),
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
        key: _formKeyConsultation,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            TextFormField(
              controller: diagnostic,
              keyboardType: TextInputType.datetime,
              decoration: const InputDecoration(
                icon: const Icon(Icons.text_fields_outlined),
                hintText: 'diagnostic...',
                labelText: 'diagnostic',
              ),
            ),
            TextFormField(
              controller: traitement,
              maxLines: 6,
              keyboardType: TextInputType.multiline,
              decoration: const InputDecoration(
                icon: const Icon(Icons.local_post_office),
                hintText: 'traitement...',
                labelText: 'traitement',
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
                        print( diagnostic.text+ "- "+ traitement.text  );
                        saveConsultation(traitement.text, diagnostic.text );
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

  Future<String> getDmPatient(String email) async { 
    String _base_email = "http://localhost:8008/api/dms/patient";
    final http.Response response = await http
        .get(Uri.parse(_base_email + "/" + email), headers: {
      'Accept': 'application/json',
    });
    setState(() {
      var data = jsonDecode(response.body);

      List<Consultation> liste_consultation = convertiListConsultation(data['consultations']);

      this.dm = new DossierMedical(
          idDossierMedical: data['idDossierMedical'],
          medecin: this.medecinC,
          patient: this.patientC,
          consultations: liste_consultation
      );
    });
    print(this.dm);
    return "Success";
  }

  Future<String> getMedecinById(String email) async {
    String _base_email_me = "http://localhost:8008/api/medecins/user";
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

  Future<String> saveConsultation(String traitement, String diagnostic) async{
    int? nbr = dm.consultations?.last.getIdConsultation;
    Consultation consultation = new Consultation(idConsultation: nbr!+1 , diagnostic: diagnostic, traitement: traitement);
    print(consultation);
    this.dm.consultations?.add(consultation);
    int id = this.dm.getIdDossierMedical;
    print(dm);

    final http.Response responseC = await http.post(
        Uri.parse("http://localhost:8008/api/dms/consultation/${id}"),
        headers: <String, String>{
          "Accept": "application/json", 'Authorization': 'Bearer token $token',
          'Content-Type': 'application/json; charset=UTF-8',
        }, body:
                    jsonEncode({
                              "diagnostic": diagnostic,
                              "traitement": traitement,
                        })
    );
    if ( responseC.statusCode == 200 ){
      Fluttertoast.showToast(
          msg: "consultation ajouté avec succés",
          webPosition: "center",
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
          msg: "consultation non enregistrer",
          webPosition: "center",
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 2);
    }
    return "suceess";
  }

  List<Consultation> convertiListConsultation(List data ){
    List<Consultation> liste = [];
    for( int i=0; i<data.length; i++ ){
      var js = jsonEncode({
        "idConsultation": data[i]['idConsultation'],
        "diagnostic": data[i]['diagnostic'],
        "traitement": data[i]['traitement'],
      }
      );
      Consultation cons = new Consultation(
                idConsultation: data[i]['idConsultation'],
                diagnostic: data[i]['diagnostic'],
                traitement: data[i]['traitement'],
      );

      liste.add(cons);
    }
    print(liste);
    return liste;
  }
}
