import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';


class AddquestionScreen extends StatefulWidget {
  const AddquestionScreen ({super.key});

  @override
  State<AddquestionScreen> createState() => _AddquestionScreenState();
}

class _AddquestionScreenState extends State<AddquestionScreen> {
  final questioncontroller=TextEditingController();
  final answer1controller=TextEditingController();
  final answer2controller=TextEditingController();
  final answer3controller=TextEditingController();
  final rightanswercontroller=TextEditingController();
  final time=DateTime.now().microsecondsSinceEpoch.toString();
  final auth=FirebaseAuth.instance;
  final  firestore=FirebaseFirestore.instance;



  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        title: Text("adddata"),),
      body:  Padding(
        padding: const EdgeInsets.all(20.0),
        child:   Column(children: [

          Container(width: double.infinity,child: TextFormField(

            controller: questioncontroller,decoration: InputDecoration(
            labelText: "note",
            border: OutlineInputBorder(),
          ),

          )),
          SizedBox(height: 10,),
          Container(width: double.infinity,
            child: ElevatedButton(onPressed: (){
              addnotee();



            }, child: Text("ADD")),
          )









        ],),
      ),

    );
  }

  void addnotee() {


    String note=questioncontroller.text;
    String userid= auth.currentUser!.uid;
    Map<String,dynamic> data={
      "uid":userid,
      "noteid":time,
      "note":note,
    };
    firestore.collection( "notes").doc(time).set(data);
    Navigator.pop(context);
  }
}
