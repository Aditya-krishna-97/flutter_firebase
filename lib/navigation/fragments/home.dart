import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterfirebase/datasource.dart';
import 'package:flutterfirebase/getting_data_from_firestore.dart';
import 'package:flutterfirebase/panels/indiadatapanel.dart';

import 'package:flutterfirebase/panels/worlddatapanel.dart';


class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MyHomePage();
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {




  String worldwide = "Worldwide";
  var firestoreDb = Firestore.instance.collection('district').snapshots();
  @override
  Widget build(BuildContext context) {

   // getData.gettingData();
    return Scaffold(
    body: SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            height: 100,
            alignment: Alignment.center,
            padding: EdgeInsets.all(10),
            color: Colors.orange.shade100,
            child: Text(
              DataSource.quote,
              style: TextStyle(
                color: Colors.orange.shade800,
                fontWeight: FontWeight.bold,
                  fontSize: 16
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10.0,horizontal: 10.0),
            child: Text(
              worldwide,
              style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold),
            ),
          ),
          WorldDataPanel(),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10.0,horizontal: 10.0),
            child: Text(
              'INDIA',
              style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold),
            ),
          ),
          IndiaDataPanel(),
        ],
      ),
    ),
    );
  }

  @override
  void initState() {
    GetData getData = new GetData();
    getData.getData();
  }
}




//below code is used to get data from firestore and also update it in realtime.
/*class _MyHomePageState extends State<MyHomePage> {

  var firestoreDb = Firestore.instance.collection('district').snapshots();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildBody(context),
    );
  }

  Widget _buildBody(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: firestoreDb,
      builder: (context, snapshot) {
        if (!snapshot.hasData) return LinearProgressIndicator();
        return _buildList(context, snapshot.data.documents);
      },
    );
  }

  Widget _buildList(BuildContext context, List<DocumentSnapshot> snapshot) {
    return ListView(
      padding: const EdgeInsets.only(top: 20.0),
      children: snapshot.map((data) => _buildListItem(context, data)).toList(),
    );
  }

  Widget _buildListItem(BuildContext context, DocumentSnapshot data) {
    final record = Record.fromSnapshot(data);

    return Padding(

      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.red),
          borderRadius: BorderRadius.circular(5.0),
        ),
        child: ListTile(
          title: Text(record.name),
          trailing: Text(record.votes.toString()),
// Disabled on tap          onTap: () => record.reference.updateData({'cases': FieldValue.increment(1)}),
        ),
      ),
    );
  }



}

class Record {
  final String name;
  final int votes;
  final DocumentReference reference;

  Record.fromMap(Map<String, dynamic> map, {this.reference})
      : assert(map['name'] != null),
        assert(map['cases'] != null),
        name = map['name'],
        votes = map['cases'];

  Record.fromSnapshot(DocumentSnapshot snapshot)
      : this.fromMap(snapshot.data, reference: snapshot.reference);

  @override
  String toString() => "Record<$name:$votes>";
}
*/