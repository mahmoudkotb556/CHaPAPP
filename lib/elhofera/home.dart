import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:notes/elhofera/home_Screen.dart';

import 'chat_elhofra.dart';

class homepagetab extends StatefulWidget {
  const homepagetab({super.key});

  @override
  State<homepagetab> createState() => _homepagetabState();
}

class _homepagetabState extends State<homepagetab> {
  final emailcontroller = TextEditingController();
  final namecon = TextEditingController();
  final phonecon = TextEditingController();
  final auth = FirebaseAuth.instance;
  final firebase = FirebaseFirestore.instance;
  final storage = FirebaseStorage.instance;
  File? imagefile;
  List<Map<String, dynamic>> datas = [];
  String imageUrl =
      "https://images.unsplash.com/photo-1503023345310-bd7c1de61c7d?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8Mnx8aHVtYW58ZW58MHx8MHx8fDA%3D&w=1000&q=80";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    alluser();
    loaddata();
  }

  Future<void> loaddata() async {
    await firebase
        .collection("alhofradata")
        .doc(auth.currentUser!.uid)
        .get()
        .then((value) {
      updateui(value.data()!);
    });
  }

  Future<void> alluser() async {
    await firebase.collection("alhofradata").get().then((value) {
      datas.clear();
      for (var docum in value.docs) {
        final note = docum.data();
        //if (auth2.currentUser!.uid.toString()==note["uid"]){
        datas.add(note);
      }
      setState(() {});
    });
  }

  void updateui(Map<String, dynamic> map) {
    namecon.text = map["name"];
    phonecon.text = map["phone"];
    emailcontroller.text = map['email'];
    if (map.containsKey("image")) {
      imageUrl = map["image"];
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          bottom: const TabBar(
            tabs: [
              Tab(icon: Icon(Icons.person_add_alt)),
              Tab(icon: Icon(Icons.person)),
              Tab(icon: Icon(Icons.home)),
            ],
          ),
          title: const Text('EL7HOFRA'),
          actions: [
            IconButton(
                onPressed: () {
                  auth.signOut();
                  Navigator.pop(context);
                },
                icon: const Icon(Icons.exit_to_app))
          ],
        ),
        body: TabBarView(
          children: [
            tab2(),
            tab1(),
            homescreen(),
          ],
        ),
      ),
    ));
  }

  Widget tab1() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          InkWell(
            onTap: () {
              selectimage();
            },
            child: imagefile == null
                ? CircleAvatar(
                    backgroundImage: NetworkImage(imageUrl),
                    radius: 40,
                  )
                : ClipRRect(
                    child: Image.file(
                    imagefile!,
                    width: 100,
                    height: 100,
                  )),
          ),
          Container(
            margin: const EdgeInsets.only(top: 10, right: 20, left: 20),
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
            margin: const EdgeInsets.only(top: 5, right: 20, left: 20),
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
            margin: const EdgeInsets.only(top: 5, right: 20, left: 20),
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
          const SizedBox(
            height: 5,
          ),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                updatedata();
              },
              child: const Text("update data"),
              style: const ButtonStyle(
                  backgroundColor: MaterialStatePropertyAll(Colors.cyan)),
            ),
          ),
        ],
      ),
    );
  }

  Widget tab2() {
    return ListView.builder(
        itemCount: datas.length,
        scrollDirection: Axis.vertical,
        itemBuilder: (context, index) {
          return Container(
            margin: const EdgeInsets.all(20),
            child: Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  CircleAvatar(
                    radius: 30,
                    backgroundImage:
                        NetworkImage(datas[index]['image'].toString()),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(datas[index]['name'].toString()),
                          const SizedBox(
                            width: 10,
                          ),
                          const Text("20:30")
                        ],
                      ),
                      Text(datas[index]['email'].toString())
                    ],
                  ),
                  const Spacer(),
                  IconButton(onPressed: () {
                    String Friendid= datas[index]['userId'].toString();
                    Fluttertoast.showToast(msg: Friendid);
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>ChatScreen( id: Friendid)));
                  }, icon: const Icon(Icons.message))
                ],
              ),
            ),
          );
        });
  }

  Future<void> selectimage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);
    if (image == null) {
      return;
    }
    imagefile = File(image.path);
    upload(imagefile!);
    setState(() {});
  }

  void upload(File imagurl) {
    final uid = auth.currentUser!.uid;
    storage
        .ref("images/${uid}")
        .putFile(imagurl)
        .then((p0) => geturt())
        .catchError((error) {
      Fluttertoast.showToast(msg: error.toString());
    });
  }

  geturt() {
    final uid = auth.currentUser!.uid;
    storage
        .ref("images/${uid}")
        .getDownloadURL()
        .then((value) => imageUrl = value)
        .catchError((error) {
      Fluttertoast.showToast(msg: error.toString());
      setState(() {
        alluser();
      });
    });
  }

  void updatedata() {
    Map<String, dynamic> data = {
      "userId": auth.currentUser!.uid.toString(),
      "email": emailcontroller.text,
      "name": namecon.text,
      "phone": phonecon.text,
      "image": imageUrl,
    };
    firebase
        .collection("alhofradata")
        .doc(auth.currentUser!.uid)
        .update(data)
        .then((value) {
          alluser();
      Fluttertoast.showToast(msg: "UPDATA DATA");
    });
  }
}
