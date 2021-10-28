import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:mygsmp/models/rendezVous.dart';



String _base = "http://localhost:8888/api/memos";
String rvmedecin = "http://localhost:8888/api/RendezVous/medecin/1";

var client = new http.Client();

Future<String> getAllMemos() async {
  final http.Response response = await client.post( Uri.parse(_base) ,
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
  );
  if (response.statusCode == 200) {
    List data = json.decode(response.body);
    return (data[1]['message']);
  } else {
    print(json.decode(response.body).toString());
    throw Exception(json.decode(response.body));
  }
}


Future<Rendezvous> fetchRendezVousMedecin() async {
  final response =
  await http.get( Uri.parse(rvmedecin) );
  final responseJson = json.decode(response.body);
  print(responseJson);
  return new Rendezvous.fromJson(responseJson);
}

Future<List<Rendezvous>> fetchRendezVousMedecinList() async {
  http.Response response =
  await http.get(Uri.parse(rvmedecin));
  List responseJson = json.decode(response.body);
  print(responseJson);
  return responseJson.map((m) => new Rendezvous.fromJson(m)).toList();
}