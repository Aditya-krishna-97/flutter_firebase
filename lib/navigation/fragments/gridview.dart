import 'package:flutter/material.dart';

class Gview extends StatefulWidget {
  @override
  _GviewState createState() => _GviewState();
}

class _GviewState extends State<Gview> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("GridView"),
      ),
      body: GridView.count(crossAxisCount: 2,
      children: List.generate(8, (index) {
        return Center(
          child: Text('Item $index'),
        );
      }),

      ),
    );
  }
}