import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class localDb {
  Database _database;

  Future openDb() async {
    if(_database == null)
    {
      _database =await openDatabase(
          join(await getDatabasesPath(),"data.db"),
          version:1,
          onCreate:(Database db,int version) async {
            await db.execute(
              "CREATE TABLE usersd(id INTEGER PRIMARY KEY autoincrement, wc TEXT,wa TEXT,wr TEXT,wd TEXT,ci TEXT,ai TEXT,ri TEXT,di TEXT)",
            );});}}

  Future<int> insertData(Users users) async {
    await openDb();
    await _database.delete('usersd');
    return await _database.insert('usersd', users.toMap());
  }

  Future<int> updateData(Users users) async{
    await openDb();
    return await _database.update('usersd', users.toMap(),where: "id = ?",whereArgs: [users.id]);
  }

  Future<List<Users>> getData() async{
              await openDb();
              print("World cases are $_database.query('users',columns: ['wc'])");
              final List<Map<String,dynamic>> maps = await _database.query('usersd');
              return List.generate(maps.length, (i){
              return Users(
                  id:maps[i]['id'],
                wc: maps[i]['wc'], wa: maps[i]['wa'], wr: maps[i]['wr'], wd: maps[i]['wd'],
                ci: maps[i]['ci'],ai: maps[i]['ai'],ri: maps[i]['ri'],di: maps[i]['di']
              );
                });
  }

Future<void> deleteData(int id) async {
    List a = await getData();
    dynamic h = a[0];
    print("data is $h");
await openDb();
await _database.delete('usersd', where: "id=?",whereArgs: [id]);
}
}


class Users {
  int id;
  String wc,wa,wr,wd,ci,ai,ri,di;
  Users({@required this.wc,@required this.wa,@required this.wr,@required this.wd,@required this.ci,@required this.ai,@required this.ri,@required this.di,this.id});
  Map<String, dynamic> toMap(){
   return {'wc':wc,'wa':wa,'wr':wr,'wd':wd,'ci':ci,'ai':ai,'ri':ri,'di':di};
  }
}