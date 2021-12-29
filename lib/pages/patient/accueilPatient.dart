import 'dart:async';
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:mygsmp/connexion/connexion.dart';
import 'package:mygsmp/models/DemandeRv.dart';
import 'package:mygsmp/models/dossier_medical.dart';
import 'package:mygsmp/models/medecin.dart';
import 'package:mygsmp/models/patient.dart';
import 'package:mygsmp/models/userModel.dart';
import 'package:mygsmp/widget/PatientDemandeRv.dart';
import 'package:mygsmp/widget/components/patient/drawerPatient.dart';
import 'package:mygsmp/widget/components/patient/footer_patient.dart';
import 'package:mygsmp/widget/components/patient/header_patient.dart';
import 'package:mygsmp/widget/screen/buildCardSidebox.dart';
import 'package:http/http.dart' as http;

class AccueilPatient extends StatefulWidget {
  String email;
  String token;

  AccueilPatient({required this.email, required this.token});

  @override
  _AccueilPatientState createState() =>
      _AccueilPatientState(email: email, token: token);
}

class _AccueilPatientState extends State<AccueilPatient> {
  String email;
  String token;

  _AccueilPatientState({required this.email, required this.token});

  List _dataMemos = [];
  List cons = [];
  DossierMedical? dm;
  var dmm;
  List _dataDemandeRv = [];

  List _dataListeMedecins = [];

  List _dataRV = [];
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

  String selectedValue = "";

  @override
  void initState() {
    super.initState();

    getPatientById(email, token);
    Timer(Duration(seconds: 1), () {
      Fluttertoast.showToast(
          msg: "Bienvenue  " + this.patientC.user!.getEmail,
          webPosition: "center",
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 2);
    });
    getDmPatient();
    getAllDemandeRv();
    getAllRv();
    getALLMedecins();
    getAllMemos();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: DefaultTabController(
        length: 4,
        child: Scaffold(
          appBar: AppBar(
              elevation: 10,
              title: Text("Patient : " + this.patientC.user!.getEmail),
              backgroundColor: Colors.cyan,
              actions: [
                new IconButton(
                  tooltip: 'logout',
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Login(),
                        ));
                    ScaffoldMessenger.of(context)
                        .showSnackBar(const SnackBar(content: Text('LogOut')));
                  },
                  icon: Icon(Icons.logout),
                )
              ],
              bottom: const TabBar(tabs: [
                Tab(text: 'RV', icon: Icon(Icons.connect_without_contact)),
                Tab(text: 'demande', icon: Icon(Icons.portrait_sharp)),
                Tab(text: 'Dm', icon: Icon(Icons.medical_services)),
                Tab(text: 'Pub', icon: Icon(Icons.post_add)),
              ])),
          drawer: buildDrawerNavgationPatient(context, email, token),
          body: TabBarView(
            children: <Widget>[
              CenterRv(context),
              //CenterDemandeRv(context),
              Container(
                  child: DefaultTabController(
                length: 2,
                child: Scaffold(
                  appBar: AppBar(
                    backgroundColor: Colors.cyan,
                    bottom: TabBar(
                      tabs: [
                        Tab(text: 'Liste', icon: Icon(Icons.list)),
                        Tab(text: 'Nouveau', icon: Icon(Icons.add)),
                      ],
                    ),
                    title: Text('Demande de RV'),
                  ),
                  body: TabBarView(
                    children: [
                      CenterDemandeRv(context),
                      new Container(
                          margin: EdgeInsets.all(20),
                          child: CenterSendDemandeRv(context))
                    ],
                  ),
                ),
              )),
              CenterDossierMedical(context),
              CenterMemos(context),
            ],
          ),
        ),
      ),
    );
  }

// recuperer l'utilisateur connecté
  Future<String> getPatientById(String email, String token) async {
    String _base_email = "http://localhost:8888/api/patients/user";
    final http.Response response = await http
        .get(Uri.parse(_base_email + "/" + email), headers: {
      'Accept': 'application/json',
      'Authorization': 'Bearer token $token'
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
    return "Success";
  }

  //parti memos
  void displayDialog(BuildContext context, int index) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return SimpleDialog(
            elevation: 5,
            backgroundColor: Colors.blueGrey,
            title: Text(
              _dataMemos[index]['titre'],
              textAlign: TextAlign.center,
              style:
                  TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
            ),
            children: [
              Card(
                margin: EdgeInsets.all(5),
                child: Text(_dataMemos[index]["message"],
                    textAlign: TextAlign.center,
                    style: TextStyle(fontWeight: FontWeight.bold)),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(
                    "médecin : " + _dataMemos[index]["medecin"]["initial"],
                    style: TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.white),
                  ),
                  Text(
                    "date Pub: " + _dataMemos[index]["date_creer"],
                    style: TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.white),
                  )
                ],
              )
            ],
          );
        });
  }

  Future<String> getAllMemos() async {
    final http.Response response = await http.get(
      Uri.parse("http://localhost:8888/api/Memos"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );
    setState(() {
      _dataMemos = json.decode(response.body);
    });
    return "succes";
  }

  Center CenterMemos(BuildContext context) {
    return Center(
        child: ListView.separated(
      itemCount: _dataMemos == null ? 0 : _dataMemos.length,
      itemBuilder: (BuildContext context, int index) {
        return ListTile(
          trailing: IconButton(
            color: Colors.lightBlue,
            icon: Icon(Icons.remove_red_eye),
            onPressed: () {
              setState(() {
                displayDialog(context, index);
              });
            },
          ),
          onTap: () {
            displayDialog(context, index);
          },
          leading: CircleAvatar(
            backgroundColor: Colors.amber,
            radius: 30,
            child: Text((_dataMemos[index]['titre'][0]).toUpperCase()),
          ),
          title: Text(_dataMemos[index]['titre']),
          subtitle: Text(
            _dataMemos[index]['message'],
            maxLines: 2,
          ),
        );
      },
      separatorBuilder: (BuildContext context, int index) => (const Divider(
        thickness: 10,
      )),
    ));
  }

// parti dossier medical

  Future<String> getDmPatient() async {
    final http.Response response = await http.get(
      Uri.parse("http://localhost:8888/api/dms/patient/" + this.email),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );
    setState(() {
      print(jsonDecode(response.body));
      var data = jsonDecode(response.body);
      dmm = data;
      cons = dmm['consultations'];
      print(dmm);
    });
    return "Success";
  }

  Center CenterDossierMedical(BuildContext context) {
    if (dmm != null) {
      return Center(
          child: Card(
              margin: EdgeInsets.fromLTRB(15, 15, 15, 15),
              elevation: 10,
              shadowColor: Colors.lightBlueAccent,
              color: Colors.black12,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Text(
                    dmm['patient']['prenom'] + ' ' + dmm['patient']['nom'],
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                  Text(
                    'adresse :' + dmm['patient']['adresse'],
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                  ),
                  Text(
                    'taille :' + dmm['patient']['taille'].toString(),
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                  ),
                  Text(
                    'genre :' + dmm['patient']['genre'],
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                  ),
                  Text(
                    'Age :' + dmm['patient']['age'].toString(),
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                  ),
                  Text(
                    'Consultations  : ',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.5,
                    child: ListView.builder(
                        itemCount: cons.length,
                        itemBuilder: (context, indice) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 1, horizontal: 4),
                            child: Card(
                                child: Column(
                              children: [
                                Text(cons[indice]['traitement']),
                                Text(cons[indice]['diagnostic']),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    new Text(cons[indice]['date_consultation']),
                                  ],
                                )
                              ],
                            )),
                          );
                        }),
                  )
                ],
              )));
    } else {
      return Center(
        child: Text('Dossier médical vide'),
      );
    }
  }

  // parti demande de rv

  Center CenterDemandeRv(BuildContext context) {
    if (_dataDemandeRv != null) {
      return Center(
          child: ListView.separated(
        itemCount: _dataDemandeRv == null ? 0 : _dataDemandeRv.length,
        itemBuilder: (BuildContext context, int index) {
          if (_dataDemandeRv[index]['patient']['user']['email'] == this.email) {
            return Card(
              margin: EdgeInsets.all(10),
              elevation: 12,
              child: ListTile(
                onTap: () {
                  displayDialogMedecin(context, index);
                },
                leading: CircleAvatar(
                  backgroundColor: Colors.amber,
                  radius: 30,
                  child:
                      Text("N°: " + (_dataDemandeRv[index]['id']).toString()),
                ),
                title: Text(convertDate(_dataDemandeRv[index]['date_demande'])),
                subtitle: Text(
                  _dataDemandeRv[index]['medecin']['initial'] +
                      ' ' +
                      _dataDemandeRv[index]['medecin']['specialisation'],
                  maxLines: 2,
                ),
              ),
              color: Colors.blueGrey,
            );
          } else {
            return Center();
          }
        },
        separatorBuilder: (BuildContext context, int index) => (const Divider(
          thickness: 10,
        )),
      ));
    } else {
      return Center(
        child: Text('pas de demande de RV '),
      );
    }
  }

  Future<String> getAllDemandeRv() async {
    final http.Response response = await http.get(
      Uri.parse("http://localhost:8888/api/demandeRVs"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );
    setState(() {
      _dataDemandeRv = json.decode(response.body);
    });
    return "succes";
  }

  void displayDialogMedecin(BuildContext context, int index) {
    showDialog<void>(
      context: context,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          title: Text('Détail Médecin'),
          backgroundColor: Colors.blueGrey,
          content: SingleChildScrollView(
              child: Column(
            children: [
              ListTile(
                hoverColor: Colors.lightBlueAccent,
                title: Text(
                    _dataDemandeRv[index]['medecin']['prenom'] +
                        ' ' +
                        _dataDemandeRv[index]['patient']['nom'],
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
                subtitle: Text('prenom && nom'),
              ),
              ListTile(
                hoverColor: Colors.lightBlueAccent,
                title: Text(_dataDemandeRv[index]['medecin']['initial'],
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
                subtitle: Text('Initial'),
              ),
              ListTile(
                hoverColor: Colors.lightBlueAccent,
                title: Text(_dataDemandeRv[index]['medecin']['specialisation'],
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
                subtitle: Text('Spécialité'),
              ),
            ],
          )),
          actions: <Widget>[
            TextButton(
              child: Text('quittez'),
              onPressed: () {
                Navigator.of(dialogContext).pop(); // Dismiss alert dialog
              },
            ),
          ],
        );
      },
    );
  }

  Center CenterSendDemandeRv(BuildContext context) {
    return Center(
        child: SizedBox(
      height: MediaQuery.of(context).size.height * 0.5,
      child: ListView.builder(
          itemCount: _dataListeMedecins == null ? 0 : _dataListeMedecins.length,
          itemBuilder: (context, indice) {
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 1, horizontal: 4),
              child: Card(
                color: Colors.blueGrey,
                elevation: 20,
                child: ListTile(
                  leading: CircleAvatar(
                    child: Text(_dataListeMedecins[indice]["initial"][0]),
                    backgroundColor: Colors.purple,
                  ),
                  title: Text(_dataListeMedecins[indice]["prenom"] +
                      " " +
                      _dataListeMedecins[indice]["nom"]),
                  subtitle: Text(_dataListeMedecins[indice]["specialisation"]),
                  trailing: new TextButton(
                      onPressed: () {
                        SendDemandeToMedecin(
                            _dataListeMedecins[indice]["user"]['email']);
                      },
                      child: RichText(
                        text: TextSpan(children: [
                          TextSpan(text: 'envoyer'),
                          WidgetSpan(
                              child: Icon(
                            Icons.send,
                            size: 14,
                          ))
                        ]),
                      )),
                ),
              ),
            );
          }),
    ));
  }

  //partie les RV
  Center CenterRv(BuildContext context) {
    return Center(
        child: ListView.separated(
      itemCount: _dataRV == null ? 0 : _dataRV.length,
      itemBuilder: (BuildContext context, int index) {
        if (_dataRV[index]['patient']['user']['email'] == this.email) {
          return Card(
            margin: EdgeInsets.all(10),
            elevation: 12,
            child: ListTile(
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                      onPressed: () {
                        displayDialogMedecin(context, index);
                      },
                      icon: Icon(Icons.remove_red_eye_outlined)),
                ],
              ),
              leading: CircleAvatar(
                backgroundColor: Colors.amber,
                radius: 30,
                child:
                    Text("N°: " + (_dataRV[index]['idRendezVous']).toString()),
              ),
              title: Text(
                  _dataRV[index]['date_rv'] + " at " + _dataRV[index]['heure']),
              subtitle: Text(
                _dataRV[index]['medecin']['prenom'] +
                    ' ' +
                    _dataRV[index]['medecin']['nom'],
                maxLines: 2,
              ),
            ),
            color: Colors.blueGrey,
          );
        } else {
          return Center();
        }
      },
      separatorBuilder: (BuildContext context, int index) => (const Divider(
        thickness: 10,
      )),
    ));
  }

  Future<String> getAllRv() async {
    final http.Response response = await http.get(
      Uri.parse("http://localhost:8888/api/RendezVous"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer token $token'
      },
    );
    setState(() {
      _dataRV = json.decode(response.body);
    });
    print(_dataRV);
    return "succes";
  }

  String convertDate(String date) {
    String datef =
        new DateFormat("dd-MM-yyyy -- HH:mm").format(DateTime.parse(date));
    return datef;
  }

  Future<String> SendDemandeToMedecin(String email) async {
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

    String _base_email_me = "http://localhost:8888/api/medecins/user";
    final http.Response response = await http
        .get(Uri.parse(_base_email_me + "/" + email), headers: <String, String>{
      'Accept': 'application/json',
    });
    setState(() {
      var data = jsonDecode(response.body);
      medecinC = new Medecin(
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
      );
    });
    Demanderv dmrv = new Demanderv(id: 0, patient: patientC, medecin: medecinC, date_demnande: DateTime.now());
    print(dmrv);

    final http.Response responseR2 =
        await http.post(Uri.parse("http://localhost:8888/api/demandeRVs"),
            headers: <String, String>{
              "Accept": "application/json",
              'Content-Type': 'application/json; charset=UTF-8',
            },
            body:
            // jsonEncode(<String, dynamic>{
            //   'patient': patientC.toDatabaseJson(),
            //   'medecin': medecinC.toDatabaseJson(),
            //   'date_demande': DateTime.now().toString()
            // }));
               dmrv.toDatabaseJson()   );

    if (responseR2.statusCode == 200) {
      Fluttertoast.showToast(
          msg: "message posté avec succés",
          webPosition: "center",
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 2);
    } else {
      print( responseR2.body );
      Fluttertoast.showToast(
          msg: "message non posté",
          webPosition: "center",
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 2);
    }
    return "suceess";
  }

  //************** get all medecins***************//////////:
  Future<String> getALLMedecins() async {
    final http.Response response = await http.get(
      Uri.parse("http://localhost:8888/api/medecins"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );
    setState(() {
      _dataListeMedecins = json.decode(response.body);
    });
    return "succes";
  }
}
