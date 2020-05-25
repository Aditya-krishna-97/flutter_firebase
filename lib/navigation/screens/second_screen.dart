import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class SecondScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Second Screen'),
        ),
        body: new Center(
          child: SpinKitWave(
            color: Colors.blueAccent,
            size: 30.0,
          ),
        )
    );
  }

}