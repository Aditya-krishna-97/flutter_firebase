
import 'package:flutter/material.dart';

import 'package:flutter/material.dart';
import 'package:flutterfirebase/getting_data_from_firestore.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutterfirebase/saving_to_localdb.dart';


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
  final data = Firestore.instance;
  final FirebaseDatabase rdb = FirebaseDatabase.instance;

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
                        labelText: 'Enter your district'
                    ),
                    controller: city,
                    validator: (value){
                      if(value.isEmpty)
                      {
                        return 'Please enter your district';
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
                    child: Container(
                      child: Column(
                        children: <Widget>[
                          RaisedButton(
                            onPressed: (){
                              n = name.text.toString();
                              c = city.text.toString();
                              ph = phone.text.toString();
                              if(_formKey.currentState.validate() && (rdb.reference().child(ph) != null))
                                //checks if form is valid and if phone number does not exist then user gets created
                                  {


                                print("name is $n");
                                print("city is $c");
                                print("phone number is $ph");
                                Scaffold.of(context).showSnackBar(SnackBar(content: Text("Storing data to flutter-firebase"),));
                                Scaffold.of(context).showSnackBar(SnackBar(content: Text("Name is $n" + " City is $c" + " phone number is $ph"),));
                                // db.collection("refeference").document("users").collection(ph).add({'name': n,'doc-ref':'a'});

                                data.collection("users").add(
                                    {
                                      'name' : n,
                                      'district' : c,
                                      'phone-number' : ph,
                                      "timestamp" : new DateTime.now()
                                    }
                                ).then((response)
                                {
                                  documentref = response.documentID.toString();
                                  print("Document reference number is $documentref");
                                  rdb.reference().child(ph).set(<String,String>{'documentref':documentref,'name':n});
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
                              else{
                                print("user already exists");
                                Scaffold.of(context).showSnackBar(SnackBar(content: Text("User already exists"),));
                              }

                              //db.collection(ph).add({'name':n,'doc_ref':documentref});
                              //db.document(ph).add({'name':n,'doc_ref':documentref});
                            },
                            child: Text('Submit'),
                          ),
                        ],
                      ),

                    ),
                    
                  )
                ],
              ),
            )
        )
    );
  }




}