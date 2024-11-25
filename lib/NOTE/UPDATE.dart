import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'NOTES_SCREEN.dart';

class UPDATENOTE extends StatefulWidget {
  const UPDATENOTE ({super.key, required this.notee});

 final  notee;

  @override
  State<UPDATENOTE> createState() => _UPDATENOTEState();
}

class _UPDATENOTEState extends State<UPDATENOTE> {
  final notecontroller=TextEditingController();
  final auth=FirebaseAuth.instance;
  final  firestore=FirebaseFirestore.instance;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    notecontroller.text=widget.notee['note'];
  }
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
appBar: AppBar(
  title: Text("UPDATE"),),
body:  Padding(
  padding: const EdgeInsets.all(20.0),
  child:   Column(children: [

    Container(width: double.infinity,child: TextFormField(

    controller: notecontroller,decoration: InputDecoration(
        labelText: "note",
        border: OutlineInputBorder(),
      ),

    )),
SizedBox(height: 10,),
    Container(width: double.infinity,
      child: ElevatedButton(onPressed: (){
        addnotee();



      }, child: Text("UPDATE")),
    )









  ],),
),

    );
  }

  void addnotee() {
    String noteee=notecontroller.text;
    Map<String,dynamic> data={
      "uid":widget.notee['uid'],
      "noteid":widget.notee["noteid"],
      "note":noteee,
    };
    firestore.collection("notes").doc(widget.notee["noteid"]).update(data).then((value){

      Navigator.pop(context);
    }).catchError((error){
      print(error);
    });

  }
}
