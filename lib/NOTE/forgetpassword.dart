import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'NOTES_SCREEN.dart';

class forgetScreen extends StatefulWidget {
  const forgetScreen ({super.key});

  @override
  State<forgetScreen> createState() => _forgetScreenState();
}

class _forgetScreenState extends State<forgetScreen> {
  final notecontroller=TextEditingController();
  @override
  void dispose() {
    notecontroller.dispose();
    // TODO: implement dispose
    super.dispose();
  }
  Future passwordreset()async{
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(
          email: notecontroller.text.trim());
      showDialog(context: context, builder: (context){
        return AlertDialog(content: Text("send password to your email"),);
      });
    }on FirebaseAuthException catch(e){
      print(e);
      showDialog(context: context, builder: (context){
        return AlertDialog(content: Text(e.message.toString()),);
      });
    }
  }
  final time=DateTime.now().microsecondsSinceEpoch.toString();
  final auth=FirebaseAuth.instance;
  final  firestore=FirebaseFirestore.instance;



  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        title: Text("ResTore password"),),
      body:  Padding(
        padding: const EdgeInsets.all(20.0),
        child:   Column(children: [

          Container(width: double.infinity,child: TextFormField(

            controller: notecontroller,decoration: InputDecoration(
            labelText: "EMAIL",
            border: OutlineInputBorder(),
          ),

          )),
          SizedBox(height: 10,),
          Container(width: double.infinity,
            child: ElevatedButton(onPressed: (){
              passwordreset();



            }, child: Text("RESTORE")),
          )









        ],),
      ),

    );
  }

  void addnotee() {



  }
}
