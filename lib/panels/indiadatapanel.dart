import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterfirebase/getting_data_from_firestore.dart';

class IndiaDataPanel extends StatefulWidget {
  @override
  _IndiaDataPanelState createState() => _IndiaDataPanelState();
}

class _IndiaDataPanelState extends State<IndiaDataPanel> {
  String cw,aw,rw,dw,ci,ai,ri,di;

  @override
  Widget build(BuildContext context) {
    ci = GetData.iconfirmed;
    ai = GetData.iactive;
    ri = GetData.irecovered;
    di = GetData.ideaths;
    return Container(
      child: GridView(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 2,
        ),
        children: <Widget>[
          StatusPane(
            title: 'CONFIRMED',
            panelColor: Colors.red.shade100,
            textColor: Colors.red,
            count: ci,
          ),
          StatusPane(title: 'ACTIVE',
            panelColor: Colors.blue.shade100,
            textColor: Colors.blue.shade900,
            count: ai,
          ),
          StatusPane(title: 'RECOVERED',
            panelColor: Colors.green.shade100,
            textColor: Colors.green,
            count: ri,
          ),
          StatusPane(title: 'DEATHS',
            panelColor: Colors.grey.shade400,
            textColor: Colors.grey.shade900,
            count: di,
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
          FutureBuilder(

          )
        ],
      ),
    );
  }
}
class StatusPane extends StatelessWidget {

  final Color panelColor,textColor;
  final String title,count;

  const StatusPane({Key key, this.panelColor, this.textColor, this.title, this.count}) : super(key: key);


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