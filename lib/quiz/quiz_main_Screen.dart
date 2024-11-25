import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:notes/quiz/quiz_ROFILE.dart';
import 'package:notes/quiz/quiz_SCREEN.dart';

class QuizMainScreen extends StatefulWidget {
  const QuizMainScreen({super.key});

  @override
  State<QuizMainScreen> createState() => _QuizMainScreenState();
}

class _QuizMainScreenState extends State<QuizMainScreen> {
  final auth=FirebaseAuth.instance;
  final firbase =FirebaseFirestore.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBar(
        title: Text("dataa"),
        actions: [IconButton(onPressed: (){
          auth.signOut();
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>LoginQuiz()));

        }, icon: Icon(Icons.exit_to_app))],
      ),
body: Center(child: Column(
  mainAxisSize: MainAxisSize.min,
  children: [
        ElevatedButton(onPressed: (){




    }, child: Text("START QUIZ")),
    ElevatedButton(onPressed: (){

      Navigator.push(context, MaterialPageRoute(builder: (context)=>Profile()));

    }, child: Text("PROFILE"))
  ],
)),
    );
  }
}
