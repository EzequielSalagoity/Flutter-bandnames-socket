

import 'dart:io';

import 'package:band_names/models/band.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class HomePage extends StatefulWidget {

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  List<Band> bands = [
    Band(id:'1', name: 'Metallica', votes: 5),
    Band(id:'2', name: 'QUeen', votes: 1),
    Band(id:'3', name: 'Heroes del Silencio', votes: 2),
    Band(id:'4', name: 'Bon Jovi', votes: 5),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('BandNames',style: TextStyle(color: Colors.black87),),
        backgroundColor: Colors.white,
        elevation: 1,
      ),
      body: ListView.builder(
        itemCount: bands.length,
        itemBuilder: (BuildContext context, int index) => _bandTile(bands[index])        
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: addNewBand,
        child: Icon(Icons.add),
        elevation: 1,
      ),
   );
  }

  Widget _bandTile(Band band) {
  return Dismissible(
    key: Key(band.id),
    direction: DismissDirection.startToEnd,
    background: Container(
      padding: EdgeInsets.only(left: 8.0),
      color: Colors.red,
      child: Align(
        alignment: Alignment.centerLeft,
        child: Text('Delete Band',style: TextStyle(color: Colors.white))
      )      
    ),
      child: ListTile(
          leading: CircleAvatar(
            child: Text(band.name.substring(0,2)),
            backgroundColor: Colors.blue[100],
          ),
          title: Text(band.name),
          trailing: Text('${band.votes}',style: TextStyle(fontSize: 20 )),
          onTap: (){
            print(band.name);
          },
        ),
  );
  }

  addNewBand(){

    final textController = new TextEditingController();

    if(Platform.isAndroid){
      showDialog(
        context: context,
        builder: (context){
          return AlertDialog(
            title: Text('New band name:'),
            content: TextField(
              controller: textController,
            ),
            actions: [
              MaterialButton(
                child: Text('Add'),
                elevation: 5,
                textColor: Colors.blue,
                onPressed: () => addBandToList(textController.text)
              )
            ],
          );
        }
      );
    }else{
      showCupertinoDialog(
        context: context, 
        builder: (_){
          return CupertinoAlertDialog(
            title: Text('New band name: '),
            content: CupertinoTextField(
              controller: textController,
            ),
            actions: [
              CupertinoDialogAction(
                child: Text('Add'),
                isDefaultAction: true,
                onPressed: () => addBandToList(textController.text)
              ),
              CupertinoDialogAction(
                child: Text('Dismiss'),
                isDestructiveAction: true,
                onPressed: () => Navigator.pop(context)
              )
            ],
          );
        }
      );
    }

  }

  void addBandToList(String name){
    print(name);

    if(name.length > 1){
      this.bands.add(new Band(id:DateTime.now().toString(),name:name, votes: 0));
      setState(() {
        
      });
    }
    Navigator.pop(context);
  }



}