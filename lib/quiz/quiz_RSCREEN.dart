import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class REGISTERQUIZ extends StatefulWidget {
  const REGISTERQUIZ({super.key});

  @override
  State<REGISTERQUIZ> createState() => _REGISTERQUIZState();
}

class _REGISTERQUIZState extends State<REGISTERQUIZ> {
  final emailcontroller=TextEditingController();
  final password=TextEditingController();
  final namecon=TextEditingController();
  final phonecon=TextEditingController();
final auth= FirebaseAuth.instance;
final firebase=FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return  Scaffold(

      appBar: AppBar(
        title: Text('Quiz Register'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(children: [
        Container(
        margin: EdgeInsets.only(top: 10,right: 20,left: 20) ,
        child: TextFormField(
          controller:namecon,
          textInputAction: TextInputAction.next,
          keyboardType: TextInputType.name,
          keyboardAppearance:Brightness.dark ,


          decoration:const InputDecoration(
            labelText: 'Name',

            border: OutlineInputBorder(),
            prefixIcon: Icon(
              Icons.person,
            ),
          ),
        ),
      ),
          Container(
            margin: EdgeInsets.only(top: 10,right: 20,left: 20) ,
            child: TextFormField(
              controller:phonecon,
              textInputAction: TextInputAction.next,
              keyboardType: TextInputType.phone,
              keyboardAppearance:Brightness.dark ,


              decoration:const InputDecoration(
                labelText: 'Phone',

                border: OutlineInputBorder(),
                prefixIcon: Icon(
                  Icons.phone,
                ),
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 20,right: 20,left: 20) ,
            child: TextFormField(
              controller: emailcontroller,
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
          ),

          Container(
            margin: EdgeInsets.only(top: 10,right: 20,left: 20) ,
            child: TextFormField(
              controller:password,
              textInputAction: TextInputAction.next,
              keyboardType: TextInputType.emailAddress,
              keyboardAppearance:Brightness.dark ,
              obscureText: true,

              decoration:const InputDecoration(
                labelText: 'password',

                border: OutlineInputBorder(),
                prefixIcon: Icon(
                  Icons.lock,
                ),
              ),
            ),
          ),


          SizedBox(height: 20,),
          SizedBox(width: double.infinity,
            child: ElevatedButton(onPressed: ()=> register(), child: Text("Register"),style: ButtonStyle(
                backgroundColor: MaterialStatePropertyAll(Colors.cyan)
            ),),
          ),SizedBox(width: 10,),


        ],


        ),
      ),
    );
  }

  register() async {
    String email=emailcontroller.text;
    String passwordd=password.text;
    String name=namecon.text;
    String phone=phonecon.text;
    try {
       await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: passwordd,
      ).then((value) {
        saveinformation(name,phone,email);
        Navigator.pop(context);
      });
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        Fluttertoast.showToast(
            msg: "weak-password",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0
        );
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
        Fluttertoast.showToast(
            msg: "The account already exists for that email",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0
        );
      }
    } catch (e) {
      print(e);
    }
  }

  void saveinformation(String name, String phone, String email) {
    Map<String,dynamic> data= {
      "userId":auth.currentUser!.uid.toString(),
      "name":name,
      "phone":phone,
      "email":email,
      "admin":false

    };
    firebase.collection("personaldata").doc(auth.currentUser!.uid).set(data).then((value) {

      auth.signOut();
      Navigator.pop(context);
      Fluttertoast.showToast(msg: "accounted created");

    }).catchError((error){
      print(error);
      Fluttertoast.showToast(msg: error.toString());
    });


  }
}