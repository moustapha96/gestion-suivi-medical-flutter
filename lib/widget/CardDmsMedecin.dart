import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Card BuildCardDossierMedical(
    BuildContext context, String name, String statut, List data) {
  return Card(
    child: Container(
      height: 100,
      color: Colors.white,
      child: Row(
        children: [
          Expanded(
            child: Container(
              alignment: Alignment.topLeft,
              child: Column(
                children: [
                  Expanded(
                    flex: 5,
                    child: ListTile(
                      title: Text(name),
                      subtitle: Text(statut),
                    ),
                  ),
                  Expanded(
                    flex: 5,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        TextButton(
                          child: Text("Ajouter"),
                          onPressed: () {},
                        ),
                        SizedBox(
                          width: 8,
                        ),
                        TextButton(
                          child: Text("Consultations"),
                          onPressed: () {
                            displayDialog(context, name, data);
                          },
                        ),
                        SizedBox(
                          width: 8,
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
            flex: 8,
          ),
        ],
      ),
    ),
    elevation: 8,
    margin: EdgeInsets.all(10),
  );
}

void displayDialog(BuildContext context, String name, List data) {
  showDialog(
      context: context,
      builder: (BuildContext context) {
        return SimpleDialog(
          elevation: 5,
          // backgroundColor: Colors.amberAccent,
          title: Text(
            'Consultation ' + name,
            textAlign: TextAlign.center,
          ),
          children: [
            ListView.separated(
              itemCount: data == null ? 0 : data.length,
              itemBuilder: (BuildContext context, int index) {
                return Column(
                  children: [
                    Text('Id :' + data[index]['idConsultation']),
                    Text('diagnostic :' + data[index]['diagnostic']),
                  ],
                );
              },
              separatorBuilder: (BuildContext context, int index) =>
                  (const Divider(
                thickness: 5,
              )),
            )
          ],
        );
      });
}
