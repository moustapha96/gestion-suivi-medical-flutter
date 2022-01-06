import 'dart:async';
import 'dart:convert';
import 'dart:html';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mygsmp/connexion/connexion.dart';
import 'package:mygsmp/models/medecin.dart';
import 'package:mygsmp/models/memos.dart';
import 'package:mygsmp/models/userModel.dart';
import 'package:mygsmp/pages/medecin/newRv.dart';
import 'package:mygsmp/widget/components/medecin/drawer.dart';
import 'package:mygsmp/widget/components/medecin/footer_medecin.dart';
import 'package:mygsmp/widget/components/medecin/header_medecin.dart';
import 'package:mygsmp/widget/screen/DetailDmScreen.dart';
import 'package:mygsmp/widget/screen/buildCardSidebox.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

import 'MedecinAddConsultation.dart';

class AcceuilMedecin extends StatefulWidget {
  String emailmedecin;
  String token;

  AcceuilMedecin({required this.emailmedecin, required this.token});

  @override
  _AcceuilMedecinState createState() =>
      _AcceuilMedecinState(emailmedecin: emailmedecin, token: token);
}

class _AcceuilMedecinState extends State<AcceuilMedecin> {
  String emailmedecin;
  String token;

  _AcceuilMedecinState({required this.emailmedecin, required this.token});

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
  List _dataMemos = [];
  List _dataDemandeRv = [];
  List _dataRV = [];
  List _dataPatients = [];
  List _dataDm = [];

  //données memos

  TextEditingController titrecontroller = TextEditingController();
  TextEditingController messagecontroller = TextEditingController();

  String date_creer = new DateTime.now().toString();
  final _formKeyMemos = GlobalKey<FormState>();

  @override
  void initState() {
    print("email" + emailmedecin);
    super.initState();
    getMedecinById(emailmedecin, token);
    Timer(Duration(seconds: 2), () {
      print(this.medecinC);
      Fluttertoast.showToast(
          msg: "Bienvenue  " + this.medecinC.getInitial,
          webPosition: "center",
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 2);

      getAllMemos();
      getAllDemandeRv();
      getAllRv();
      getAllPatients();
      getAllDms();
    });


  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: DefaultTabController(
        length: 5,
        child: Scaffold(
          appBar: AppBar(
              elevation: 10,
              title: Text("Médecin : " + this.medecinC.getInitial),
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
                Tab(text: 'Patients', icon: Icon(Icons.supervised_user_circle)),
                Tab(text: 'DM', icon: Icon(Icons.medical_services)),
                Tab(text: 'Pub', icon: Icon(Icons.post_add)),
              ])),
          body: TabBarView(
            children: <Widget>[
              CenterListeRV(context),
              CenterDemandeRv(context),
              CenterListePatient(context),
              CenterDossierMedical(context),
              Container(
                  child: DefaultTabController(
                    length: 2,
                    child: Scaffold(
                      appBar: AppBar(
                        backgroundColor: Colors.cyan,
                        bottom: TabBar(
                          tabs: [
                            Tab(icon: Icon(Icons.list)),
                            Tab(icon: Icon(Icons.add)),
                          ],
                        ),
                        title: Text('Publications'),
                      ),
                      body: TabBarView(
                        children: [
                          CenterMemos(context),
                          new Container(
                              margin: EdgeInsets.all(20),
                              child: CenterAddMemos(context))
                        ],
                      ),
                    ),
                  )
              )
            ],
          ),
        ),
      ),
    );
  }


  Future<String> getMedecinById(String email, String token) async {
    String _base_email_me = "http://localhost:8008/api/medecins/user";
    final http.Response response = await http
        .get(Uri.parse(_base_email_me + "/" + email), headers: <String, String>{
      'Accept': 'application/json',
      'Authorization': 'Bearer token $token'
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
    return "Success";
  }

  //********************** parti Publication***********************//
  Center CenterMemos(BuildContext context) {
    return Center(
        child: ListView.separated(
          itemCount: _dataMemos == null ? 0 : _dataMemos.length,
          itemBuilder: (BuildContext context, int index) {
            String key = _dataMemos[index]['titre'][0];
            return Dismissible(
                key: new Key(key),
                background: new Container(
                  padding: EdgeInsets.only(right: 20.0),
                  color: Colors.red,
                  child: new Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      new Text(
                        "supprimer", style: TextStyle(color: Colors.white),),
                      new Icon(Icons.delete, color: Colors.white,)
                    ],
                  ),
                ),
                onDismissed: (direction) {
                  setState(() {
                    print(_dataMemos[index]['titre']);
                    int id = _dataMemos[index]['idMemos'];
                    print(id);
                    DeleteMemosDB(id);
                  });
                },
                child: ListTile(
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
                )
            );
          },
          separatorBuilder: (BuildContext context, int index) =>
          (const Divider(
            thickness: 10,
          )),
        ));
  }

  Future<String> getAllMemos() async {
    final http.Response response = await http.get(
      Uri.parse("http://localhost:8008/api/Memos"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );
    setState(() {
      _dataMemos = json.decode(response.body);
    });
    return "succes";
  }

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
              TextStyle(fontWeight: FontWeight.bold, color: Colors.cyan),
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
                    "Spécialisation : " +
                        _dataMemos[index]["medecin"]["specialisation"],
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

  Form CenterAddMemos(BuildContext context) {
    return Form(
      key: _formKeyMemos,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          TextFormField(
            controller: titrecontroller,
            decoration: const InputDecoration(
              icon: const Icon(Icons.text_fields_outlined),
              hintText: 'titre...',
              labelText: 'titre',
            ),
          ),
          TextFormField(
            maxLines: 8,
            controller: messagecontroller,
            keyboardType: TextInputType.multiline,
            decoration: const InputDecoration(
              icon: const Icon(Icons.local_post_office),
              hintText: 'Message...',
              labelText: 'message',
            ),
          ),

          new Container(
            margin: EdgeInsets.only(top: 15),
            child: Center(
                child: TextButton(
                  style: ButtonStyle(
                    foregroundColor: MaterialStateProperty.all<Color>(
                        Colors.blue),
                  ),
                  onPressed: () {
                    getMedecinById(emailmedecin, token);
                    setState(() {
                      saveMemosDB(titrecontroller.text, messagecontroller.text,
                          medecinC);
                    });
                  },
                  child: Text('enregistrer', style: TextStyle(
                      fontSize: 20, fontWeight: FontWeight.bold),),
                )
            ),
          ),

        ],
      ),
    );
  }

  //************************* parti demande de rV *********************** //

  Center CenterDemandeRv(BuildContext context) {
    if (_dataDemandeRv != null) {
      return Center(
          child: ListView.separated(
            itemCount: _dataDemandeRv == null ? 0 : _dataDemandeRv.length,
            itemBuilder: (BuildContext context, int index) {

                return Card(
                  margin: EdgeInsets.all(10),
                  elevation: 12,
                  child: ListTile(
                    onTap: () {
                      displayDialogPatient(context, index);
                    },
                    leading: CircleAvatar(
                      backgroundColor: Colors.amber,
                      radius: 30,
                      child: Text(
                          "N°: " + (_dataDemandeRv[index]['id']).toString()),
                    ),
                    trailing: new TextButton(onPressed: () {
                      print(_dataDemandeRv[index]["patient"]['user']['email']);
                      print(_dataDemandeRv[index]["medecin"]['user']['email']);
                      Navigator.push(
                        context,
                        new MaterialPageRoute(builder: (context) =>
                        new MedecinNewRv(
                          token: token,
                            emailPatient: _dataDemandeRv[index]["patient"]['user']['email'],
                            emailMedecin: _dataDemandeRv[index]['medecin']['user']['email'])),
                      );
                    }, child: new Icon(Icons.lock_clock)),

                    title: Text(
                        convertDate(_dataDemandeRv[index]['date_demande'])),
                    subtitle: Text(
                      _dataDemandeRv[index]['patient']['prenom'] +
                          ' ' +
                          _dataDemandeRv[index]['patient']['nom'],
                      maxLines: 2,
                    ),
                  ),
                  color: Colors.blueGrey,
                );

            },
            separatorBuilder: (BuildContext context, int index) =>
            (const Divider(
              thickness: 10,
            )),
          ));
    } else {
      return Center(child: Text('pas de demande de RV '),);
    }
  }

  void displayDialogPatient(BuildContext context, int index) {
    showDialog<void>(
      context: context,
      // false = user must tap button, true = tap outside dialog
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          title: Text('Détail Patient'),
          backgroundColor: Colors.blueGrey,
          content: SingleChildScrollView(
              child: Column(
                children: [
                  ListTile(
                    hoverColor: Colors.lightBlueAccent,
                    title: Text(
                        _dataDemandeRv[index]['patient']['prenom'] +
                            ' ' +
                            _dataDemandeRv[index]['patient']['nom'],
                        style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
                    subtitle: Text('prenom && nom'),
                  ),
                  ListTile(
                    hoverColor: Colors.lightBlueAccent,
                    title: Text(_dataDemandeRv[index]['patient']['adresse'],
                        style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
                    subtitle: Text('Initial'),
                  ),
                  ListTile(
                    hoverColor: Colors.lightBlueAccent,
                    title: Text(
                        _dataDemandeRv[index]['patient']['age'].toString() +
                            "ans",
                        style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
                    subtitle: Text('age'),
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

  Future<String> getAllDemandeRv() async {
    final http.Response response = await http.get(
      Uri.parse("http://localhost:8008/api/demandeRVs/medecin/${medecinC.getIdMedecin}"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8','Authorization': 'Bearer token $token'
      },
    );
    setState(() {
      _dataDemandeRv = json.decode(response.body);
    });
    return "succes";
  }


  //******************* liste des Rv***************************/////

  Center CenterListeRV(BuildContext context) {
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
                            displayDialogPatientRV(context, index);
                          },
                          icon: Icon(Icons.remove_red_eye_outlined)),
                    ],
                  ),
                  leading: CircleAvatar(
                    backgroundColor: Colors.amber,
                    radius: 30,
                    child: Text(
                        "N°: " + (_dataRV[index]['idRendezVous']).toString()),
                  ),
                  title:
                  Text(_dataRV[index]['date_rv'] + " at " +
                      _dataRV[index]['heure']),
                  subtitle: Text(
                    _dataRV[index]['patient']['prenom'] +
                        ' ' +
                        _dataRV[index]['patient']['nom'],
                    maxLines: 2,
                  ),
                ),
                color: Colors.blueGrey,
              );
          },
          separatorBuilder: (BuildContext context, int index) =>
          (const Divider(
            thickness: 10,
          )),
        )
    );
  }

  Future<String> getAllRv() async {
    final http.Response response = await http.get(
      Uri.parse("http://localhost:8008/api/RendezVous/medecin/${medecinC.getIdMedecin}"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer token $token'
      },
    );
    setState(() {
      _dataRV = json.decode(response.body);
    });
    print("rv medecin");
    print(_dataRV);
    return "succes";
  }

  void displayDialogPatientRV(BuildContext context, int index) {
    showDialog<void>(
      context: context,
      // false = user must tap button, true = tap outside dialog
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          title: Text('Détail Patient'),
          backgroundColor: Colors.blueGrey,
          content: SingleChildScrollView(
              child: Column(
                children: [
                  ListTile(
                    hoverColor: Colors.lightBlueAccent,
                    title: Text(
                        _dataRV[index]['patient']['prenom'] +
                            ' ' +
                            _dataRV[index]['patient']['nom'],
                        style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
                    subtitle: Text('prenom && nom'),
                  ),
                  ListTile(
                    hoverColor: Colors.lightBlueAccent,
                    title: Text(_dataRV[index]['patient']['adresse'],
                        style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
                    subtitle: Text('Initial'),
                  ),
                  ListTile(
                    hoverColor: Colors.lightBlueAccent,
                    title: Text(
                        _dataRV[index]['patient']['age'].toString() + "ans",
                        style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
                    subtitle: Text('age'),
                  ),
                  ListTile(
                    hoverColor: Colors.lightBlueAccent,
                    title: Text(_dataRV[index]['patient']['adresse'],
                        style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
                    subtitle: Text('adresse'),
                  ),
                  ListTile(
                    hoverColor: Colors.lightBlueAccent,
                    title: Text(_dataRV[index]['patient']['tel'],
                        style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
                    subtitle: Text('tel'),
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

  // fonction formatter une date
  String convertDate(String date) {
    String datef = new DateFormat("dd-MM-yyyy -- HH:mm").format(
        DateTime.parse(date));
    return datef;
  }

  //************** liste des patients***********************///

  Center CenterListePatient(BuildContext context) {
    return Center(
        child: SizedBox(
          height: MediaQuery
              .of(context)
              .size
              .height * 0.5,
          child: ListView.builder(
              itemCount: _dataPatients.length,
              itemBuilder: (context, indice) {
                return Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 1, horizontal: 4),
                  child: Card(
                    color: Colors.blueGrey,
                    elevation: 20,
                    child: ListTile(
                      leading: CircleAvatar(
                        child: Text(_dataPatients[indice]["prenom"][0]),
                        backgroundColor: Colors.purple,
                      ),
                      title: Text(_dataPatients[indice]["prenom"] + " " +
                          _dataPatients[indice]["nom"]),
                      subtitle: Text(_dataPatients[indice]["profession"]),
                      trailing:
                            new TextButton(
                                onPressed: () {
                                  print("pressé ajout consultation");
                                }
                                , child: new Icon (Icons.medical_services)
                            ),
                    ),
                  ),
                );
              }),
        ));
  }

  Future<String> getAllPatients() async {
    final http.Response response = await http.get(
      Uri.parse("http://localhost:8008/api/patients"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer token $token'
      },
    );
    setState(() {
      _dataPatients = json.decode(response.body);
    });
    return "succes";
  }

  void BuildDialogAlertPatient(BuildContext context, int index) {
    showDialog<void>(
      context: context,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          title: Text('Détail du Patient'),
          backgroundColor: Colors.transparent,
          content: SingleChildScrollView(
              child: Card(
                  margin: EdgeInsets.all(2),
                  elevation: 10,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      SizedBox(
                        //height: MediaQuery.of(context).size.height * 0.7,
                        child: Card(
                          elevation: 10,
                          color: Colors.blueGrey,
                          child: Column(
                            children: <Widget>[
                              ListTile(
                                hoverColor: Colors.lightBlueAccent,
                                title: Text(
                                    _dataPatients[index]['prenom'] +
                                        ' ' +
                                        _dataPatients[index]['nom'],
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 12)),
                                subtitle: Text('prenom && nom'),
                              ),
                              ListTile(
                                hoverColor: Colors.lightBlueAccent,
                                title: Text(_dataPatients[index]['adresse'],
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 12)),
                                subtitle: Text('adresse'),
                              ),
                              ListTile(
                                hoverColor: Colors.lightBlueAccent,
                                title: Text(
                                    _dataPatients[index]['statut_social'],
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 12)),
                                subtitle: Text('Statut Social'),
                              ),
                              ListTile(
                                hoverColor: Colors.lightBlueAccent,
                                title: Text(
                                    _dataPatients[index]['taille'].toString() +
                                        " cm",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 12)),
                                subtitle: Text('taille'),
                              ),
                              ListTile(
                                hoverColor: Colors.lightBlueAccent,
                                title: Text(_dataPatients[index]['genre'],
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 12)),
                                subtitle: Text('genre'),
                              ),
                              ListTile(
                                hoverColor: Colors.lightBlueAccent,
                                title: Text(
                                    _dataPatients[index]['age'].toString() +
                                        ' ans',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 12)),
                                subtitle: Text('age'),
                              ),
                              ListTile(
                                hoverColor: Colors.lightBlueAccent,
                                title: Text(_dataPatients[index]['profession'],
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 12)),
                                subtitle: Text('profession'),
                              ),
                              ListTile(
                                hoverColor: Colors.lightBlueAccent,
                                title: Text(
                                    _dataPatients[index]['tel'].toString(),
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 12)),
                                subtitle: Text('TEL'),
                              ),
                              ListTile(
                                hoverColor: Colors.lightBlueAccent,
                                title: Text(
                                    _dataPatients[index]['user']['email'],
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 12)),
                                subtitle: Text('email'),
                              ),
                            ],
                          ),
                        ),
                      )
                    ],
                  ))),
          actions: <Widget>[
            TextButton(
              child: Text('Quittez'),
              onPressed: () {
                Navigator.of(dialogContext).pop(); // Dismiss alert dialog
              },
            ),
          ],
        );
      },
    );
  }

  // save memos in database
  Future<String> saveMemosDB(String titre, String message, Medecin medecin) async {
    print(medecin);
    Memos memos = new Memos(
        idMemos: 0, titre: titre, message: message, medecin: medecin);

    final http.Response response = await http.post(
        Uri.parse("http://localhost:8008/api/Memos"),
        headers: <String, String>{
          "Accept": "application/json",
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer token $token',
        }, body: memos.toJson());

    if (response.statusCode == 200) {
      Fluttertoast.showToast(
          msg: "message posté avec succés",
          webPosition: "center",
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 2);
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) =>
                AcceuilMedecin(emailmedecin: emailmedecin,  token: token ),
          ));
    } else {
      Fluttertoast.showToast(
          msg: "message non posté",
          webPosition: "center",
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 2);
    }

    return "suceess";
  }

  Future<String> DeleteMemosDB(int idMemos) async {
    final http.Response response = await http.delete(
        Uri.parse("http://localhost:8008/api/Memos/${idMemos}"),
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
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) =>
                AcceuilMedecin(emailmedecin: emailmedecin,  token: token ),
          ));
    } else {
      Fluttertoast.showToast(
          msg: "message non supprimé",
          webPosition: "center",
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 2);
    }

    return "suceess";
  }

  //************** dossier médical*********************//////////////

  CenterDossierMedical(BuildContext context) {
    return ListView.separated(
      itemCount: _dataDm == null ? 0 : _dataDm.length,
      itemBuilder: (BuildContext context, int index) {
        return BuildCardDossierMedical(context, index);
      },
      separatorBuilder: (BuildContext context, int index) =>
      (const Divider(
        thickness: 10,
      )),
    );
  }

  Card BuildCardDossierMedical(BuildContext context, int index) {
    return Card(
      child: Card(
        color: Colors.blueGrey,
        elevation: 10,
        child: ListTile(
          leading: CircleAvatar(
            child: Text(_dataDm[index]["patient"]["prenom"][0]),
            backgroundColor: Colors.cyan,
          ),
          title: Text(_dataDm[index]["patient"]["prenom"] + " " +
              _dataDm[index]["patient"]["nom"]),
          subtitle: Text(_dataDm[index]["patient"]["profession"]),

          trailing: Wrap(
            spacing: 6,
            children: <Widget>[
            new TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              MedecinAddConsultation( emailPatient : _dataDm[index]["patient"]['user']['email'],
                                  emailMedecin:  this.medecinC.user?.getEmail  , token: token,),
                        ),
                      );
                    }
                    , child: new Icon (Icons.add)),
              new TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            DetailDmScreen(data: _dataDm, index: index),
                      ),
                    );
                  }
                  , child: new Icon (Icons.medical_services)),
            ],
          ),
        ),
      ),
      elevation: 8,
      margin: EdgeInsets.all(10),
    );
  }

  Future<String> getAllDms() async {
    final http.Response response = await http.get(
      Uri.parse("http://localhost:8008/api/dms"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8','Authorization': 'Bearer token $token'
      },
    );
    setState(() {
      _dataDm = json.decode(response.body);
    });
    print(_dataDm);
    return "succes";
  }
}
