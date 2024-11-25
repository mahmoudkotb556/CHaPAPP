import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:notes/NOTE/cubit/login_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notes/NOTE/cubit/login_state.dart';

import '../NOTES_SCREEN.dart';
import '../Register/page/REGISTERSCREEN.dart';
import '../forgetpassword.dart';

class loginpage extends StatefulWidget {
  const loginpage({super.key});

  @override
  State<loginpage> createState() => _loginpageState();
}

class _loginpageState extends State<loginpage> {
  final  cubit=logincubit();
  final email=TextEditingController();
  final PASSWOED=TextEditingController();
  final auth=FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {

    return BlocProvider(
         create: (_) => logincubit(),
        child:BlocListener(listener: (context,state){
          if (state is loginsyccessestate) Navigatormethoad();
          if (state is loginfailuretestate) {
            Fluttertoast.showToast(msg: state.messageerror);
          }

        },
        child:
        Scaffold(
      appBar: AppBar(
        leading: Icon(Icons.menu),
        title: Text('Page title'),
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

          child: ListView(children: [
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
              Navigator.push(context, MaterialPageRoute(builder: (context)=>Register()));
            }, child:const Text("REGISTER"),
              style: ButtonStyle(
                  backgroundColor: MaterialStatePropertyAll(Colors.cyan)
              ),),),
            InkWell(onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (context)=>forgetScreen()));
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
    )));
  }

  void Navigatormethoad() {
    Navigator.push(context, MaterialPageRoute(builder: (context)=>NotesScreen()));
  }

  LOGIN() {
    String emaill=email.text;
    String password=PASSWOED.text;
    cubit.LOGIN(emaiLL: emaill, pass: password);
  }





}