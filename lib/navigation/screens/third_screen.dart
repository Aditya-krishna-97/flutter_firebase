import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

void main() => runApp(ThirdScreen());

class ThirdScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
          appBar: AppBar(
            title: Text('Feedback'),
          ),
            body: Feedback()
        )
    );
  }
}

class Feedback extends StatefulWidget {
  @override
  _FeedbackState createState() => _FeedbackState();
}

class _FeedbackState extends State<Feedback> {
  var feedbackfirestore = Firestore.instance;
  final _feedbackformkey = GlobalKey<FormState>();
  final name = TextEditingController();
  final feedback = TextEditingController();
  String result = "";
  String n,f;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(10.0),
        child: Form(
          key: _feedbackformkey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Enter your name',
                ),
                controller: name,
                validator: (value){
                  if(value.isEmpty)
                  {
                    return 'Please enter your name';
                  }
                  return null;
                },
                onSaved: (String str){
                  setState(() {
                    result = str;
                  });
                },
              ),
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Provide your feedback here',
                ),
                controller: feedback,
                validator: (value){
                  if(value.isEmpty)
                  {
                    return 'Please enter your feedback';
                  }
                  return null;
                },
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                child: Container(
                  child: Column(
                    children: <Widget>[
                      RaisedButton(
                        onPressed: (){
                          n = name.text.toString();
                          f = feedback.text.toString();
                          if(_feedbackformkey.currentState.validate())
                            {
                              print("user is $n and feedback is $f");
                              feedbackfirestore.collection("feedback").document("users").collection(n).add(
                                {
                                  'name': n,
                                  'feedback' : f,
                                  'time' : new DateTime.now()
                                }
                              ).then((response){
                                Scaffold.of(context).showSnackBar(SnackBar(content: Text("Thanks for your feedback"),));
                              })
                              .catchError((onerror){
                                Scaffold.of(context).showSnackBar(SnackBar(content: Text("Please check your internet connection"),));
                              });
                            }
                        },
                        child: Text('Submit'),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

