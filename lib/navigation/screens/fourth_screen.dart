import 'package:flutter/material.dart';
import 'package:flutterfirebase/saving_to_localdb.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shimmer/shimmer.dart';

class FourthScreen extends StatefulWidget {
  @override
  _FourthScreenState createState() => _FourthScreenState();
}

class _FourthScreenState extends State<FourthScreen> {
  var worlddata = Firestore.instance.collection("data").snapshots();
  localDb l = new localDb();
  List<Users> userslist;
  String wc,wa,wr,wd;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Getting data from local db"),
      ),
      body: StreamBuilder(
        stream: Firestore.instance.collection("users").snapshots(),
        builder: (context,snapshot){
          if(!snapshot.hasData){
            return Center(child: Shimmer.fromColors(child: Text('Loading'), baseColor: Colors.red, highlightColor: Colors.yellow));
          }
  /*        return GridView.builder(
            shrinkWrap: true,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2,childAspectRatio: 2,),
            physics: NeverScrollableScrollPhysics(),
            itemCount: snapshot.data.documents.lenght,
            itemBuilder: (context,int index){
              wc = snapshot.data.documents['world']['CONFIRMED'];
              wa = snapshot.data.documents['world']['ACTIVE'];
              wr = snapshot.data.documents['world']['RECOVERED'];
              return
            };
          );
          */
        },
      )
    );
  }
}

class WStatusPanel extends StatelessWidget {

  final Color panelColor,textColor;
  final String title,count;

  const WStatusPanel({Key key, this.panelColor, this.textColor, this.title, this.count}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double deviceWidth = MediaQuery.of(context).size.width;
    return Container(
      margin: EdgeInsets.all(10),
      color: panelColor,
      height: 80,
      width: deviceWidth/2,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(title,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16,color: textColor),),
          Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(count,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16,color: textColor),),
              ],
            ),
          ),
        ],
      ),
    );
  }
}