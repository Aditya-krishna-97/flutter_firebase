import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterfirebase/saving_to_localdb.dart';
class FifthScreen extends StatefulWidget {
  @override
  _FifthScreenState createState() => _FifthScreenState();
}

class _FifthScreenState extends State<FifthScreen> {
  localDb dbmanager = new localDb();
  Users users = new Users();
  List<Users> userslist;
  String wc;
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
appBar: AppBar(
  title: Text('sqlite'),
),
body: ListView(
  children: <Widget>[
    FutureBuilder(
future: dbmanager.getData(),
      builder: (context,snapshot){
                if(snapshot.hasData){
                  userslist =snapshot.data;
                  return ListView.builder(
                    shrinkWrap: true,
                    itemCount: userslist == null ?0 :userslist.length,
                    itemBuilder: (BuildContext context,int index){
                      Users ud = userslist[index];
                      wc = ud.wc;
                      return Card(
                        child: Row(
                          children: <Widget>[
                            Container(
                              width: width*0.6,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text('WorldTotalcases: ${ud.wc}',style: TextStyle(fontSize: 15),),
                                  Text('WorldActivecases: ${ud.wa}',style: TextStyle(fontSize: 15),),
                                  Text('WorldRecovered: ${ud.wr}',style: TextStyle(fontSize: 15),),
                                  Text('WorldDeaths: ${ud.wd}',style: TextStyle(fontSize: 15), ),
                                  Text('IndiaTotalcases: ${ud.ci}',style: TextStyle(fontSize: 15),),
                                  Text('IndiaActivecases: ${ud.ai}',style: TextStyle(fontSize: 15),),
                                  Text('IndiaRecovered: ${ud.ri}',style: TextStyle(fontSize: 15),),
                                  Text('IndiaDeaths: ${ud.di}',style: TextStyle(fontSize: 15), ),
                                ],
                              ),
                            ),
                            IconButton(onPressed: (){
                              print(ud.id);
                              dbmanager.deleteData(ud.id);
                              setState(() {
                                userslist.removeAt(index);
                                print("deleted data at $index");
                              });
                            }, icon: Icon(Icons.delete, color: Colors.red,),
                            )
                          ],
                        ),
                      );
                    },
                  );
                }
      },
    )
  ],
),
    );
  }
}
