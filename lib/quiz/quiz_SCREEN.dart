import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:notes/quiz/quiz_admin_main.dart';


import 'quiz_RSCREEN.dart';
import 'quiz_main_Screen.dart';


class LoginQuiz extends StatefulWidget {
  const LoginQuiz({super.key});

  @override
  State<LoginQuiz> createState() => _LoginQuizState();
}

class _LoginQuizState extends State<LoginQuiz> {
  final email=TextEditingController();
  final PASSWOED=TextEditingController();
  final auth=FirebaseAuth.instance;
  final firbase =FirebaseFirestore.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Icon(Icons.menu),
        title: Text('Quiz LOGIN'),
        actions: [
          Icon(Icons.favorite),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Icon(Icons.search),
          ),
          Icon(Icons.more_vert),
        ],
        backgroundColor: Colors.cyan,
      ),
      body:

      Container(

        child: SizedBox(width: double.infinity,child:
        Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(children: [
            const SizedBox(height:20 ,),
            TextFormField(
              controller: email,
              textInputAction: TextInputAction.next,
              keyboardType: TextInputType.emailAddress,
              keyboardAppearance:Brightness.dark ,

              decoration:const InputDecoration(
                labelText: 'Email',

                border: OutlineInputBorder(),
                prefixIcon: Icon(
                  Icons.email,
                ),
              ),
            ),
            const SizedBox(height:20 ,),
            TextFormField(controller: PASSWOED,
              obscureText: true,


              decoration: InputDecoration(
                labelText: 'password',

                border: OutlineInputBorder(),
                prefixIcon: Icon(
                  Icons.lock,
                ),
              ),
            ),
            SizedBox(height: 20,),
            Container(width: double.infinity,child: ElevatedButton(onPressed: ()=>LOGIN(), child:const Text("LOGIN"),style: ButtonStyle(
              backgroundColor: MaterialStatePropertyAll(Colors.cyan),
            ), )),
            const SizedBox(height: 15,),
            Container(width: double.infinity,child: ElevatedButton(onPressed: (){
              Navigator.push(context, MaterialPageRoute(builder: (context)=>REGISTERQUIZ()));
            }, child:const Text("REGISTER"),
              style: ButtonStyle(
                  backgroundColor: MaterialStatePropertyAll(Colors.cyan)
              ),),),
            InkWell(onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (context)=>REGISTERQUIZ()));
            },
              child: Text("Forget Passwoed",style: TextStyle(
                decoration: TextDecoration.underline,
                color: Colors.blue,
                fontSize: 20,
                
              ),),
            )





          ],
          ),
        )),
      ),
    );
  }

  LOGIN() {
    String emaiLL=email.text;
    String pass=PASSWOED.text;

    auth.signInWithEmailAndPassword(email: emaiLL, password: pass).then((value){
     checktype();
    }).catchError((error){print(error);});
  }


  void checktype() {
    String USER=auth.currentUser!.uid;
    firbase.collection("personaldata").doc(USER).get().then((value) {
      if(value.data()!["admin"]){
        Navigator.push(context, MaterialPageRoute(builder: (context)=>QuizMainScreen(),)
        );
      }
      else{
        Navigator.push(context, MaterialPageRoute(builder: (context)=>QuizAdmin(),)
        );
      }

    });

  }
}