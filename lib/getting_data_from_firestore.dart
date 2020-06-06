
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutterfirebase/localdbmanager.dart';
import 'package:flutterfirebase/panels/worlddatapanel.dart';
import 'package:flutterfirebase/saving_to_localdb.dart';

class GetData
{
  var variation;
  dynamic idata,wdata;
  static String iactive,iconfirmed,ideaths,irecovered;
  static String wactive,wconfirmed,wdeaths,wrecovered;
  localDb ldb = new localDb();
  Users users = new Users();
  int _checksifdataisinsertedpreviously = 0;

  Future<dynamic> getData() async {
    final DocumentReference india = await Firestore.instance.collection("data")
        .document("india");
    final DocumentReference world = await Firestore.instance.collection("data")
        .document("world");

    await india.get().then<dynamic>((DocumentSnapshot snapshot) async {
      idata = snapshot.data;
      iactive = idata['ACTIVE'];
      iconfirmed = idata['CONFIRMED'];
      ideaths = idata['DEATHS'];
      irecovered = idata['RECOVERED'];

      print("Active cases in india are $iactive");
      print("Confirmed cases in india are $iconfirmed");
      print("Deaths in india are $ideaths");
      print("Recovered in india are $irecovered");
    });
    await world.get().then<dynamic>((DocumentSnapshot snapshot) async {
      wdata = snapshot.data;
      wactive = wdata['ACTIVE'];
      wconfirmed = wdata['CONFIRMED'];
      wdeaths = wdata['DEATHS'];
      wrecovered = wdata['RECOVERED'];
      print("Active cases in world are $wactive");
      print("Confirmed cases in world are $wconfirmed");
      print("Deaths in world are $wdeaths");
      print("Recovered in world are $wrecovered");
    });
    if (iactive != null && iconfirmed != null && irecovered != null && ideaths != null && wactive != null && wconfirmed != null && wrecovered != null && wdeaths != null)
    {
      Users user;
      print("now calling saving to localdb");
        if(_checksifdataisinsertedpreviously==0) {
          localDb l = new localDb();
         // l.deleteData(2);
          print('deleting first');
          Users users = new Users(wc: wconfirmed,
              wa: wactive,
              wr: wrecovered,
              wd: wdeaths,
              ci: iconfirmed,
              ai: iactive,
              ri: irecovered,
              di: ideaths);
          l.insertData(users).then((id) =>
          {
            print("Data added to db with id as ${id}"),
          });
          _checksifdataisinsertedpreviously = 1;
          print(_checksifdataisinsertedpreviously);
        }
        else if(_checksifdataisinsertedpreviously == 1) {
          localDb l = new localDb();
          Users users = new Users(wc: wconfirmed,wa: wactive,wr: wrecovered,wd: wdeaths,ci: iconfirmed,ai: iactive,ri: irecovered,di: ideaths);
      //    l.deleteData(2);
          l.deleteData(1);
          l.updateData(users).then((id) => {
            print("Data is updated with id as $id and $wconfirmed is total confirmed")
          });
        }


    }
  }


  Future<void> gettingData() async{
    QuerySnapshot snapshot = await Firestore.instance.collection("data").getDocuments();
    snapshot.documents.forEach((f){
    //  print('${f.data}');
    });


    var userdata = FirebaseDatabase.instance.reference();
    userdata.once().then((DataSnapshot dataSnapShot){
    //  print(dataSnapShot.value);
    });
    //print("userdata is $data");
    variation = "1";
  }

}