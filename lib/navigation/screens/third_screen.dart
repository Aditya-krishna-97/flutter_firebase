import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

void main() => runApp(ThirdScreen());

class ThirdScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
            body: WebViewClass()
        )
    );
  }
}

class WebViewClass extends StatefulWidget {

  WebViewState createState() => WebViewState();

}

class WebViewState extends State<WebViewClass>{

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
        appBar: AppBar(
            title: Text('Show ProgressBar While Loading Webview')),
        body: IndexedStack(
            index: position,
            children: <Widget>[

              WebView(
                initialUrl: 'https://Google.com',
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