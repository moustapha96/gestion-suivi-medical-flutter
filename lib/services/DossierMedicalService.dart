import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:mygsmp/models/dossier_medical.dart';
import 'package:mygsmp/models/rendezVous.dart';

String _base = "http://localhost:8888/api/dms";
String dmpatient = "http://localhost:8888/api/dms/patient/{email}";

var client = new http.Client();
List<DossierMedical> data = [];

Future<List<DossierMedical>> getAllDms() async {
  final http.Response response = await client.get(
    Uri.parse(_base),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
  );
  data = json.decode(response.body);
  print(data);
  return data;
}
