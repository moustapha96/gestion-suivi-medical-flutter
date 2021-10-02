
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Container builContainerPatientDetail(BuildContext context){
  TextEditingController statutSocial = TextEditingController();
  TextEditingController prenom = TextEditingController();
  TextEditingController nom = TextEditingController();
  TextEditingController profession = TextEditingController();
  TextEditingController adresse = TextEditingController();
  TextEditingController genre = TextEditingController();
  TextEditingController tel = TextEditingController();
  TextEditingController taille = TextEditingController();
  TextEditingController age = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

  return Container(
    margin: EdgeInsets.all(1),
    child: Center(

      child: ListView.separated (
        itemCount: 3,
        separatorBuilder: (BuildContext conext, int index) => Divider(
          color: Colors.lightBlue
        ) ,
        padding: const EdgeInsets.all(11),
        scrollDirection: Axis.vertical ,

        itemBuilder: (BuildContext context, int index) {
            return Container(
              child: Column(
                children: [
                  Container(
                      margin: EdgeInsets.fromLTRB(0, 2, 0, 0),
                      alignment: Alignment.center,
                      child: Text(
                        'Inscription',
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 25),
                      )),
                  Container(
                    margin: EdgeInsets.fromLTRB(0, 15, 0, 0),
                    child: TextField(
                      controller: prenom,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Prenom',
                          icon: Icon(Icons.text_fields)
                      ),
                    ),
                  ),

                  Container(
                    child: TextField(
                      controller: nom,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'nom',
                          icon: Icon(Icons.text_fields)
                      ),
                    ),
                  ),
                  Container(
                    child: TextField(
                      controller: statutSocial,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Statut Social',
                          icon: Icon(Icons.text_fields)
                      ),
                    ),
                  ),
                  Container(
                    child: TextField(
                      controller: profession,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'profession',
                          icon: Icon(Icons.text_fields)
                      ),
                    ),
                  ),
                  Container(
                    child: TextField(
                      controller: adresse,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'adresse',
                          icon: Icon(Icons.text_fields)
                      ),
                    ),
                  ),
                  Container(
                    child: TextField(
                      controller: genre,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'genre',
                          icon: Icon(Icons.people)
                      ),
                    ),
                  ),
                  Container(
                    child: TextField(
                      controller: tel,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'tel',
                          icon: Icon(Icons.phone)
                      ),
                    ),
                  ),
                  Container(
                    child: TextField(
                      controller: taille,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'taille',
                          icon: Icon(Icons.mode_edit)
                      ),
                    ),
                  ),
                  Container(
                    child: TextField(
                      controller: age,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Age',
                          icon: Icon(Icons.assignment_ind_rounded)
                      ),
                    ),
                  ),
                  Container(
                    child: TextField(
                      controller: email,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Email',
                          icon: Icon(Icons.alternate_email)
                      ),
                    ),
                  ),
                  Container(
                    child: TextField(
                      controller: password,
                      obscureText: true,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Password',
                          icon: Icon(Icons.vpn_key_outlined)
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.fromLTRB(0, 5, 0, 0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(2.0) ),
                    ),
                    child: TextButton(

                      onPressed: () {  },
                      child: Text('s\'inscrire',
                        style: TextStyle(fontSize: 25), ),

                    ),
                  )
                ],
              )

            );
        },

      ),
    ),
  );
}