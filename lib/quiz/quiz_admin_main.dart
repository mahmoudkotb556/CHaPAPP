import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:notes/quiz/quiz_SCREEN.dart';
import 'package:notes/quiz/quiz_question_admin_main.dart';

class QuizAdmin extends StatefulWidget {
  const QuizAdmin({super.key});

  @override
  State<QuizAdmin> createState() => _QuizAdminState();
}

class _QuizAdminState extends State<QuizAdmin> {
  final auth=FirebaseAuth.instance;
  final  firestore=FirebaseFirestore.instance;
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar:AppBar(
        title: Text("ADMIN"),
        actions:   [
          IconButton(onPressed:(){
            FirebaseAuth.instance.signOut();
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (context)=>LoginQuiz()));


          }, icon: Icon(Icons.exit_to_app))
        ],
      ),
        floatingActionButton: FloatingActionButton(onPressed:(){
          Navigator.push(context, MaterialPageRoute(builder: (context)=>AddquestionScreen()));
        },child: Icon(Icons.add),),
        body: Column(children: [],)
    );
  }
}
