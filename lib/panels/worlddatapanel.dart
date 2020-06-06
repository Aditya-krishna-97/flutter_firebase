  import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
  import 'package:flutter/material.dart';
  import 'package:flutterfirebase/getting_data_from_firestore.dart';
import 'package:flutterfirebase/navigation/screens/fifth_screen.dart';

import '../saving_to_localdb.dart';


class WorldDataPanel extends StatefulWidget {
  @override
  _WorldDataPanelState createState() => _WorldDataPanelState();
}

class _WorldDataPanelState extends State<WorldDataPanel> {
  String cw,aw,rw,dw,ci,ai,ri,di;
  List<Users> ulist;
  FifthScreen fifthScreen = new FifthScreen();


  @override
  Widget build(BuildContext context) {

    Users users = new Users();

    cw = GetData.wconfirmed;
    aw = GetData.wactive;
    rw = GetData.wrecovered;
    dw = GetData.wdeaths;

    return Container(
        child: GridView(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 2,
          ),
          children: <Widget>[
            StatusPanel(
              title: 'CONFIRMED',
              panelColor: Colors.red.shade100,
              textColor: Colors.red,
              count: cw,
            ),
            StatusPanel(title: 'ACTIVE',
              panelColor: Colors.blue.shade100,
              textColor: Colors.blue.shade900,
              count: aw,
            ),
            StatusPanel(title: 'RECOVERED',
              panelColor: Colors.green.shade100,
              textColor: Colors.green,
              count: rw,
            ),
            StatusPanel(title: 'DEATHS',
              panelColor: Colors.grey.shade400,
              textColor: Colors.grey.shade900,
              count: dw,
            ),

          ],
        ),
      );
  }
}

class StatusPanel extends StatelessWidget {

  final Color panelColor,textColor;
  final String title,count;

  const StatusPanel({Key key, this.panelColor, this.textColor, this.title, this.count}) : super(key: key);



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