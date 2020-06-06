import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutterfirebase/getting_data_from_firestore.dart';


class SecondScreen extends StatefulWidget {
  @override
  _SecondScreenState createState() => _SecondScreenState();
}

class _SecondScreenState extends State<SecondScreen> {

  var firestoreDb = Firestore.instance.collection("users").snapshots();
  String ph;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Getting data from firestore"),
      ),
      body: StreamBuilder(
        stream : firestoreDb,
        builder: (context, snapshot){
          if(!snapshot.hasData) return CircularProgressIndicator();
          return ListView.builder(
            itemCount: snapshot.data.documents.length,
              itemBuilder: (context,int index){
              ph = snapshot.data.documents[index]['phone-number'];
              for(int i=0; i<snapshot.data.documents.length;i++)
                {
                  if(snapshot.data.documents[index]['phone-number'] == '9701815888')
                    {
                      print(snapshot.data.documents[index]['name']);
                    }
                  print("printing all names");

                  //print(snapshot.data.documents[index]['phone-number']);
                }
              print(snapshot.data.documents[index]['phone-number']);
              return Text(
                ph,
              );
              }
              );
        }),

    );
  }
}