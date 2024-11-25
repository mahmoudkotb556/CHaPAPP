import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';

class register extends StatefulWidget {
  const register({super.key});

  @override
  State<register> createState() => _registerState();
}

class _registerState extends State<register> {
  final emailcontroller = TextEditingController();
  final namecon = TextEditingController();
  final phonecon = TextEditingController();
  final passwordcon = TextEditingController();
  final auth = FirebaseAuth.instance;
  final firebase = FirebaseFirestore.instance;
  final storage = FirebaseStorage.instance;
  File? imagefile;

  String imageUrl =
      "https://images.unsplash.com/photo-1503023345310-bd7c1de61c7d?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8Mnx8aHVtYW58ZW58MHx8MHx8fDA%3D&w=1000&q=80";

  String name = "";
  String phone = "";
  String email = "";

  @override
  void dispose() {
    super.dispose();
    emailcontroller.dispose();
    namecon.dispose();
    phonecon.dispose();
    passwordcon.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Quiz profile'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            InkWell(
              onTap: () => selectimage(),
              child: imagefile == null
                  ? CircleAvatar(
                      backgroundImage: NetworkImage(imageUrl),
                      radius: 40,
                    )
                  : ClipRRect(
                      borderRadius: BorderRadius.circular(50),
                      child: Image.file(
                        imagefile!,
                        width: 50,
                        height: 50,
                        fit: BoxFit.fill,
                      )),
            ),
            Container(
              margin:
                  const EdgeInsets.only(top: 5, right: 20, left: 20, bottom: 5),
              child: TextFormField(
                controller: namecon,
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.name,
                keyboardAppearance: Brightness.dark,
                decoration: const InputDecoration(
                  labelText: 'Name',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(
                    Icons.person,
                  ),
                ),
              ),
            ),
            Container(
              margin:
                  const EdgeInsets.only(top: 5, right: 20, left: 20, bottom: 5),
              child: TextFormField(
                controller: phonecon,
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.phone,
                keyboardAppearance: Brightness.dark,
                decoration: const InputDecoration(
                  labelText: 'Phone',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(
                    Icons.phone,
                  ),
                ),
              ),
            ),
            Container(
              margin:
                  const EdgeInsets.only(top: 5, right: 20, left: 20, bottom: 5),
              child: TextFormField(
                controller: emailcontroller,
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.emailAddress,
                keyboardAppearance: Brightness.dark,
                decoration: const InputDecoration(
                  labelText: 'Email',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(
                    Icons.email,
                  ),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 5, right: 20, left: 20, bottom: 5),
              child: TextFormField(
                controller: passwordcon,
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.emailAddress,
                keyboardAppearance: Brightness.dark,
                decoration: const InputDecoration(
                  labelText: 'Password',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(
                    Icons.password,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 5,
            ),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  registertt();
                },
                child: Text("Register"),
                style: ButtonStyle(
                    backgroundColor: MaterialStatePropertyAll(Colors.cyan)),
              ),
            )
          ],
        ),
      ),
    );
  }

  Future<void> selectimage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);
    if (image == null) {
      Fluttertoast.showToast(msg: "error");

      return;
    }
    imagefile = File(image.path);
    Fluttertoast.showToast(msg: "here");
    setState(() {});
  }

  Future<void> upload(File imagurl) async {
    final uid = auth.currentUser!.uid;
    await storage
        .ref("images/${uid}")
        .putFile(imagurl)
        .then((p0) => geturt())
        .catchError((error) {
      Fluttertoast.showToast(msg: imageUrl);
    });
  }

  Future<void> geturt() async {
    //Fluttertoast.showToast(msg: "geturl ");
    final uid = auth.currentUser!.uid;
    Fluttertoast.showToast(msg: uid.toString());
    await storage.ref("images/${uid}").getDownloadURL().then((value) {
      // value == imageUrl;
      imageUrl = value;

      Fluttertoast.showToast(msg: imageUrl);
      print(imageUrl);
      print(value);
      saveinformation(name, phone, email);
    }).catchError((error) {
      print(error.toString());
      Fluttertoast.showToast(msg: error.toString());
    });
    Fluttertoast.showToast(msg: "image uploade");
  }

  registertt() async {
     email = emailcontroller.text;
    String passwordd = passwordcon.text;
     name = namecon.text;
     phone = phonecon.text;
    try {
      await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
        email: email,
        password: passwordd,
      )
          .then((value) {
        // auth.signInWithEmailAndPassword(email: email, password: passwordd).then((value) {
        //
        // });
        upload(imagefile!);
        // saveinformation(name, phone, email);
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
            fontSize: 16.0);
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
            fontSize: 16.0);
      }
    } catch (e) {
      print(e);
    }
  }

  Future<void> saveinformation(String name, String phone, String email) async {

    print(imageUrl);
    Map<String, dynamic> data = {
      "userId": auth.currentUser!.uid.toString(),
      "name": name,
      "phone": phone,
      "email": email,
      "image": imageUrl
    };
    firebase
        .collection("alhofradata")
        .doc(auth.currentUser!.uid)
        .set(data)
        .then((value) {
      Fluttertoast.showToast(msg: "accounted created");
      Navigator.pop(context);
    }).catchError((error) {
      print(error.toString());
      Fluttertoast.showToast(msg: error.toString());
    });
  }
}
