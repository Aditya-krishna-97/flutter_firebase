import 'dart:async';

import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';



class CovidIND extends StatefulWidget {
  @override
  _CovidINDState createState() => _CovidINDState();
}

class _CovidINDState extends State<CovidIND> {
  num position = 1 ;

  final key = UniqueKey();

  doneLoading(String A) {
    setState(() {
      position = 0;
    });
  }

  startLoading(String A){
    setState(() {
      position = 1;
    });
  }

  @override
  void initState() {

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

        body: IndexedStack(
            index: position,
            children: <Widget>[

              WebView(
                initialUrl: 'https://www.covid19india.org/',
                javascriptMode: JavascriptMode.unrestricted,
                key: key ,
                onPageFinished: doneLoading,
                onPageStarted: startLoading,
              ),

              Container(
                color: Colors.white,
                child: Center(
                    child: CircularProgressIndicator(
                      backgroundColor: Colors.orange,
                    )),
              ),

            ])
    );
  }




}