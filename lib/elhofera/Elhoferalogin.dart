import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:notes/elhofera/home.dart';
import 'package:notes/quiz/quiz_admin_main.dart';

import '../NOTE/forgetpassword.dart';
import 'elhofera__rr.dart';
import 'elhofra_register.dart';





class elhoferalogin extends StatefulWidget {
  const elhoferalogin({super.key});

  @override
  State<elhoferalogin> createState() => _elhoferaloginState();
}

class _elhoferaloginState extends State<elhoferalogin> {
  final String logo="https://i.ytimg.com/vi/-xijbXYSvNs/maxresdefault.jpg";
  final email=TextEditingController();
  final PASSWOED=TextEditingController();
  final auth=FirebaseAuth.instance;
  final firbase =FirebaseFirestore.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(

        title: Text("ALhofrah"),
        centerTitle: true,
        backgroundColor: Colors.black,
      ),
      body:

      Container(

        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Center(

            child: ListView(children: [
              SizedBox(height: 10,),
              CircleAvatar(backgroundImage: NetworkImage(logo,),radius: 70,),
          const SizedBox(height:20 ,),
          Center(child: Text("Al7FRH_الحفرة",style: TextStyle(fontWeight:FontWeight.w600,fontSize: 40),)),
              const SizedBox(height:10 ,),
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
              const SizedBox(height:10 ,),
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
              SizedBox(height: 10,),
              Row(mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(margin: EdgeInsets.all(20),width: 150,
                    child: ElevatedButton(onPressed: (){


                      LOGIN();}, child:const Text("LOGIN"),style: ButtonStyle(
                      backgroundColor: MaterialStatePropertyAll(Colors.black54),
                    ), ),
                  ),
                  const SizedBox(width: 10,),
                  Container(width: 150,child: ElevatedButton(onPressed: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>register()));
                  }, child:const Text("REGISTER"),
                    style: ButtonStyle(
                        backgroundColor: MaterialStatePropertyAll(Colors.black54)
                    ),),),
                ],
              ),

              Row(mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  InkWell(onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>forgetScreen()));
                  },
                    child: Text("Forget Passwoed",style: TextStyle(
                      decoration: TextDecoration.underline,
                      color: Colors.blue,
                      fontSize: 20,

                    ),),
                  ),
                ],
              )





            ],
            ),
          ),
        ),
      ),
    );
  }

  LOGIN() {
    String emaiLL=email.text;
    String pass=PASSWOED.text;

    auth.signInWithEmailAndPassword(email: emaiLL, password: pass).then((value) {

      Navigator.push(
          context, MaterialPageRoute(builder: (context) => homepagetab()
      )).catchError((error) {
        Fluttertoast.showToast(msg: error.toString());
      });
    });

}}