

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutterfirebase/datasource.dart';
import 'package:flutterfirebase/navigation/fragments/gridview.dart';
import 'package:flutterfirebase/navigation/screens.dart';
import 'package:flutterfirebase/navigation/screens/fifth_screen.dart';
import 'package:flutterfirebase/panels/indiadatapanel.dart';
import 'package:flutterfirebase/panels/worlddatapanel.dart';

import 'getting_data_from_firestore.dart';
import 'navigation/fragments/home.dart';
import 'navigation/fragments/india.dart';
import 'navigation/fragments/streaming.dart';
import 'navigation/fragments/world.dart';


import 'navigation/screens/first_screen.dart';
import 'navigation/screens/second_screen.dart';
import 'navigation/screens/third_screen.dart';

void main() {
  
  runApp(MyApp());
      }



class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primaryColor: primaryBlack,
      ),
      home: MyHomePage(),
    );
  }
}

class DrawerItem {
  String title;
  IconData icon;
  Function body;
  DrawerItem(this.title, this.icon, this.body);

}

class MyHomePage extends StatefulWidget {

  final drawerFragments = [
    new DrawerItem("Home", Icons.home, () => new Home()),
    new DrawerItem("COVID INDIA",Icons.change_history, () => new CovidIND()),
    new DrawerItem("COVID WORLDWIDE", Icons.language, () => new CovidWorld())
  ];

  final drawerScreens = [
    new DrawerItem("Profile", Icons.add_circle, () => new FirstScreen()),
    new DrawerItem("UsersData", Icons.add_circle, () => new SecondScreen()),
    new DrawerItem("Feedback", Icons.all_inclusive, () => new ThirdScreen()),
   // new DrawerItem("Fourth", Icons.all_inclusive, () => new FourthScreen()),
  //  new DrawerItem("Fifth", Icons.ac_unit,() => new FifthScreen()),
    new DrawerItem("Streaming", Icons.accessibility, () => new Hscreen()),
    new DrawerItem("Gview", Icons.accessibility, () => new Gview()),
  ];

  MyHomePage({Key key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Future<void> fetc() async{
    GetData gd = new GetData();
    dynamic iactive = await gd.getData();
  }

  int _selectedDrawerFragmentIndex = 0;
  String name="";
  String mailid="";


  @override
  // ignore: must_call_super
  void initState() {
    name = 'Aditya';
    mailid = 'aditya.krishna.97@gmail.com';
  }

  _getDrawerFragmentWidgetIndex(int pos) {
    if (widget.drawerFragments[pos] != null) {
      return widget.drawerFragments[pos].body();
    } else {
      return new Text("Error");
    }
  }

  _onSelectFragment(int index) {
    setState(() => _selectedDrawerFragmentIndex = index);
    Navigator.of(context).pop();
  }

  _onSelectScreen(int index) {
    if (widget.drawerScreens[index] != null) {
      Navigator.of(context).pop(); // close drawer
      Navigator.push(
          context,
          MaterialPageRoute(builder: (BuildContext context) => widget.drawerScreens[index].body())
      );
    }
  }


  @override
  Widget build(BuildContext context) {
    List<Widget> drawerOptions = [];

    for (var i = 0; i < widget.drawerFragments.length; i++) {
      var d = widget.drawerFragments[i];
      drawerOptions.add(
          new ListTile(
            leading: new Icon(d.icon),
            title: new Text(d.title),
            selected: i == _selectedDrawerFragmentIndex,
            onTap: () => _onSelectFragment(i),
          )
      );
    }

    for (var i = 0; i < widget.drawerScreens.length; i++) {
      var d = widget.drawerScreens[i];
      drawerOptions.add(
          new ListTile(
            leading: new Icon(d.icon),
            title: new Text(d.title),
            onTap: () => _onSelectScreen(i),
          )
      );
    }

    Future<bool> _onBackPressed(){
      return showDialog(
          context: context,
          builder: (context)=> AlertDialog(
            title: Text("Exit?"),
            actions: <Widget>[
              FlatButton(
                child: Text("No"),
                onPressed: () => Navigator.pop(context,false),
              ),
              FlatButton(
                child: Text("Yes"),
                onPressed: () => Navigator.pop(context,true),
              )
            ],
          )
      );
    }

    return WillPopScope(
      onWillPop: _onBackPressed,
      child: new Scaffold(
        appBar: new AppBar(
          title: new Text(widget.drawerFragments[_selectedDrawerFragmentIndex].title),
        ),
        drawer: new SizedBox(
          width: MediaQuery.of(context).size.width * 0.75,
          child: new Drawer(

            child: StreamBuilder<Object>(

              builder: (context, snapshot) {
                return new Column(
                  children: <Widget>[
                    new UserAccountsDrawerHeader(
                      accountName: new Text(name),
                      accountEmail: new Text(mailid),
                    ),
                    new Column(children: drawerOptions)
                  ],
                );
              }
            ),
          ),
        ),
        body: _getDrawerFragmentWidgetIndex(_selectedDrawerFragmentIndex),
      ),
    );
  }
}