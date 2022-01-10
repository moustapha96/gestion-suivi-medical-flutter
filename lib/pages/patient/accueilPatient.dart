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
    print(email);
    super.initState();

    getPatientById();
    Timer(Duration(seconds: 2), () {
      Fluttertoast.showToast(
          msg: "Bienvenue  " + this.patientC.user!.getEmail,
          webPosition: "center",
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 2);

      getDmPatient();
      getAllDemandeRv();
      getAllRv();
      getALLMedecins();
      getAllMemos();
    });
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
                          .showSnackBar(
                          const SnackBar(content: Text('déconnecte...')));
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
            body: Container(
              padding: EdgeInsets.all(10),
              margin: EdgeInsets.all(2),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(2),
                  image: DecorationImage(
                      image: AssetImage("images/md.jpg"), fit: BoxFit.cover)),
              child: TabBarView(
                children: <Widget>[
                  CenterRv(context),
                  //CenterDemandeRv(context),
                  Container(
                    color: Colors.transparent,
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
            )


        ),
      ),
    );
  }

// recuperer l'utilisateur connecté
  Future<String> getPatientById() async {
    final http.Response response = await http.get(
      Uri.parse("http://localhost:8008/api/patients/user/${email}"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer token $token'
      },
    );
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
            backgroundColor: Colors.white70,
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
      Uri.parse("http://localhost:8008/api/Memos"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer token $token'
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
          separatorBuilder: (BuildContext context, int index) =>
          (const Divider(
            thickness: 10,
          )),
        ));
  }

// parti dossier medical

  Future<String> getDmPatient() async {
    final http.Response response = await http.get(
      Uri.parse("http://localhost:8008/api/dms/patient/" + this.email),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer token $token'
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
            shadowColor: Colors.white70,
            color: Colors.white70,
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
              height: MediaQuery
                  .of(context)
                  .size
                  .height * 0.5,
              child: ListView.separated(
                  itemBuilder: (BuildContext context, int index) {
                    return ListTile(

                      trailing: Text(
                          convertDate(cons[index]["date_consultation"])
                      ),
                      leading: CircleAvatar(
                        backgroundColor: Colors.cyan,
                        radius: 30,
                        child: Text((cons[index]["idConsultation"].toString() )
                            .toUpperCase()),
                      ),
                      title: Text(cons[index]['traitement']),
                      subtitle: Text(
                        cons[index]['diagnostic'],
                        maxLines: 3,
                      ),
                    );
                  },
                  separatorBuilder: (BuildContext context, int index) =>
              (const Divider(
              thickness: 10,
            )),
        itemCount: cons == null ? 0 : cons.length,)


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
              String i = _dataDemandeRv[index]["id"].toString();
              final item = i;
              return Dismissible(key: Key(item),
                background: new Container(
                  padding: EdgeInsets.only(right: 20.0),
                  color: Colors.red,
                  child: new Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      new Text(
                        "supprimer",
                        style: TextStyle(color: Colors.white),
                      ),
                      new Icon(
                        Icons.delete,
                        color: Colors.white,
                      )
                    ],
                  ),
                ),
                child: Card(
                  color: Colors.transparent,
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
                    title: Text(
                        convertDate(_dataDemandeRv[index]['date_demande'])),
                    subtitle: Text(
                      _dataDemandeRv[index]['medecin']['initial'] +
                          ' ' +
                          _dataDemandeRv[index]['medecin']['specialisation'],
                      maxLines: 2,
                    ),
                  ),

                ),
                onDismissed: (direction) {
                  setState(() {
                    print(_dataDemandeRv[index]["id"]);
                    int id = _dataMemos[index]['id'];
                    DeleteDemandeRv(id);
                  });
                },
              );
            },
            separatorBuilder: (BuildContext context, int index) =>
            (const Divider(
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

      Uri.parse("http://localhost:8008/api/demandeRVs/patient/${patientC
          .getIdPatient}"),
      // Uri.parse("http://localhost:8008/api/demandeRVs"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer token $token'
      },
    );
    setState(() {
      _dataDemandeRv = json.decode(response.body);
    });
    print("all demandes rvs patient");
    print(_dataDemandeRv);
    return "succes";
  }

  void displayDialogMedecin(BuildContext context, int index) {
    showDialog<void>(
      context: context,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          title: Text('Détail Médecin'),
          backgroundColor: Colors.white70,
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
                    title: Text(
                        _dataDemandeRv[index]['medecin']['specialisation'],
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
          height: MediaQuery
              .of(context)
              .size
              .height * 0.5,
          child: ListView.builder(
              itemCount: _dataListeMedecins == null ? 0 : _dataListeMedecins
                  .length,
              itemBuilder: (context, indice) {
                return Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 1, horizontal: 4),
                  child: Card(
                    color: Colors.white70,
                    elevation: 20,
                    child: ListTile(
                      leading: CircleAvatar(
                        child: Text(_dataListeMedecins[indice]["initial"][0]),
                        backgroundColor: Colors.purple,
                      ),
                      title: Text(_dataListeMedecins[indice]["prenom"] +
                          " _ " +
                          _dataListeMedecins[indice]["nom"]),
                      subtitle: Text(
                          _dataListeMedecins[indice]["specialisation"]),
                      trailing: new TextButton(
                          onPressed: () {
                            SendDemandeToMedecin(
                                _dataListeMedecins[indice]["user"]['email']);
                          },
                          child: RichText(
                            text: TextSpan(children: [
                              TextSpan(text: 'envoyer '),
                              WidgetSpan(
                                  child: Icon(
                                    Icons.send,
                                    size: 16,
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
                    IconButton(
                        onPressed: () {
                          setState(() {
                              int id = _dataRV[index]['idRendezVous'];
                              Deleterv(id);
                          });
                        },
                        icon: Icon(Icons.delete_forever , color: Colors.red,)),
                  ],
                ),
                leading: CircleAvatar(
                  backgroundColor: Colors.amber,
                  radius: 30,
                  child:
                  Text("N°: " + (_dataRV[index]['idRendezVous']).toString()),
                ),
                title: Text(
                    _dataRV[index]['date_rv'] + " at " +
                        _dataRV[index]['heure']),
                subtitle: Text(
                  _dataRV[index]['medecin']['prenom'] +
                      ' ' +
                      _dataRV[index]['medecin']['nom'],
                  maxLines: 2,
                ),
              ),
              color: Colors.white70,
            );
          },
          separatorBuilder: (BuildContext context, int index) =>
          (const Divider(
            thickness: 10,
          )),
        ));
  }

  Future<String> getAllRv() async {
    final http.Response response = await http.get(
      Uri.parse("http://localhost:8008/api/RendezVous/patient/${patientC
          .getIdPatient}"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer token $token'
      },
    );
    setState(() {
      _dataRV = json.decode(response.body);
    });

    return "succes";
  }

  String convertDate(String date) {
    String datef =
    new DateFormat("dd-MM-yyyy - HH:mm").format(DateTime.parse(date));
    return datef;
  }

  Future<String> SendDemandeToMedecin(String emailMedecin) async {
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

    String _base_email_me = "http://localhost:8008/api/medecins/user";
    final http.Response response = await http
        .get(Uri.parse(_base_email_me + "/" + emailMedecin),
        headers: <String, String>{
          'Accept': 'application/json', 'Authorization': 'Bearer token $token'
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

    final http.Response responseR2 =
    await http.post(Uri.parse("http://localhost:8008/api/demandeRVs"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer token $token'
        },
        body: jsonEncode(
            {
              "id": 0,
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
                  "iduser": patientC.user?.getIduser,
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

    if (responseR2.statusCode == 200) {
      Fluttertoast.showToast(
          msg: "demande envoye avec succés",
          webPosition: "center",
          backgroundColor: Colors.green,
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 2);
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) =>
                  AccueilPatient(email: email, token: token)));
    } else {
      print(responseR2.body);
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) =>
                  AccueilPatient(email: email, token: token)));
      Fluttertoast.showToast(
          msg: "demande non envoye",
          webPosition: "center",
          backgroundColor: Colors.red,
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 2);
    }
    return "suceess";
  }

  //************** get all medecins***************//////////:
  Future<String> getALLMedecins() async {
    final http.Response response = await http.get(
      Uri.parse("http://localhost:8008/api/medecins"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer token $token'
      },
    );
    setState(() {
      _dataListeMedecins = json.decode(response.body);
    });
    return "succes";
  }


  // delete demande rendez-vous

  Future<String> DeleteDemandeRv(int index) async {
    final http.Response response = await http.delete(
        Uri.parse("http://localhost:8008/api/demandeRVs/${index}"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer token $token',
        });
    if (response.statusCode == 200) {
      Fluttertoast.showToast(
          msg: "message supprimé avec succés",
          webPosition: "center",
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 2);
    } else {
      Fluttertoast.showToast(
          msg: "message non supprimé",
          webPosition: "center",
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 2);
    }
    return "success";
  }



//  delete rv
  Future<String> Deleterv(int id) async {

    final http.Response response = await http.delete(
      Uri.parse("http://localhost:8008/api/RendezVous/${id}"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer token $token'
      },
    );
    var rps = response.body;
    if (response.statusCode == 200) {
      Fluttertoast.showToast(
          msg: "rv supprimé avec succés",
          webPosition: "center",
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 2);
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) =>
                  AccueilPatient(email: email, token: token)));
    } else {
      Fluttertoast.showToast(
          msg: "rv non supprimé",
          webPosition: "center",
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 2);
    }
    return "success";
  }
}
