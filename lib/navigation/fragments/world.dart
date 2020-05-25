import 'dart:async';

import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';


class CovidWorld extends StatefulWidget {
  @override
  _CovidWorldState createState() => _CovidWorldState();
}

class _CovidWorldState extends State<CovidWorld> {
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
  Widget build(BuildContext context) {
    return Scaffold(

        body: IndexedStack(
            index: position,
            children: <Widget>[

              WebView(
                initialUrl: 'https://www.worldometers.info/coronavirus/',
                javascriptMode: JavascriptMode.unrestricted,
                key: key ,
                onPageFinished: doneLoading,
                onPageStarted: startLoading,
              ),

              Container(
                color: Colors.white,
                child: Center(
                    child: CircularProgressIndicator()),
              ),

            ])
    );
  }
}
