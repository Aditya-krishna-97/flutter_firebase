
import 'package:flutter/material.dart';

import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


class FirstScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
      ),
      body: A(),
    );

  }
}



class A extends StatefulWidget {
  @override
  _FirstScreenState createState() => _FirstScreenState();
}

class _FirstScreenState extends State<A> {
  final db = Firestore.instance.collection("reference").document("users");
  final data = Firestore.instance;

  final _formKey = GlobalKey<FormState>();
  final name = TextEditingController();
  final city = TextEditingController();
  final phone = TextEditingController();
  String result = "";
  static String n,c,ph;
  String documentref;

  @override
  void dispose() {
    name.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
            padding: EdgeInsets.all(10.0),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  TextFormField(
                    decoration: const InputDecoration(
                      labelText: 'Enter your name',
                    ),
                    controller: name,
                    validator: (value){
                      if(value.isEmpty)
                      {
                        return 'Please enter your name';
                      }
                      return null;
                    },
                    onSaved: (String str){
                      setState(() {
                        result = str;
                      });
                    },
                  ),
                  TextFormField(
                    decoration: const InputDecoration(
                        labelText: 'Enter your city'
                    ),
                    controller: city,
                    validator: (value){
                      if(value.isEmpty)
                      {
                        return 'Please enter your city';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    decoration: const InputDecoration(
                        labelText: 'Enter your number'
                    ),
                    controller: phone,
                    validator: (value){
                      if(value.isEmpty)
                      {
                        return 'Please enter your number';
                      }
                      return null;
                    },
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16.0),
                    child: RaisedButton(
                      onPressed: (){
                        if(_formKey.currentState.validate())
                        {
                          n = name.text.toString();
                          c = city.text.toString();
                          ph = phone.text.toString();
                          print("name is $n");
                          print("city is $c");
                          print("phone number is $ph");
                          Scaffold.of(context).showSnackBar(SnackBar(content: Text("Storing data to flutter-firebase"),));
                          Scaffold.of(context).showSnackBar(SnackBar(content: Text("Name is $n" + " City is $c" + " phone number is $ph"),));
                        // db.collection("refeference").document("users").collection(ph).add({'name': n,'doc-ref':'a'});

                          data.collection("users").add(
                              {
                            'name' : n,
                            'city' : c,
                                'phone-number' : ph,
                                "timestamp" : new DateTime.now()
                          }
                          ).then((response)
                          {
                            documentref = response.documentID.toString();
                            print(documentref);
                          }    );



                          //    if(name.text.isNotEmpty && city.text.isNotEmpty )
                          //    {
                      //    Firestore.instance.collection("board").add({
                      //      "name" : n,
                      //      "city" : c,
                      //      "timestamp" : new DateTime.now()
                      //    }).then((response){
                      //      print(response.documentID);
                     //       Navigator.pop(context);
                    //      }).catchError((error) => print(error));
                          //  }
                        }

                        //db.collection(ph).add({'name':n,'doc_ref':documentref});
                        //db.document(ph).add({'name':n,'doc_ref':documentref});
                      },
                      child: Text('Submit'),
                    ),
                  )
                ],
              ),
            )
        )
    );
  }
}