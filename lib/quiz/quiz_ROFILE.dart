import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  final emailcontroller=TextEditingController();
  final namecon=TextEditingController();
  final phonecon=TextEditingController();
final auth= FirebaseAuth.instance;
final firebase=FirebaseFirestore.instance;
final storage=FirebaseStorage.instance;
   File? imagefile;
   String imageUrl =
      "https://images.unsplash.com/photo-1503023345310-bd7c1de61c7d?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8Mnx8aHVtYW58ZW58MHx8MHx8fDA%3D&w=1000&q=80";
  @override
  Widget build(BuildContext context) {
    return  Scaffold(

      appBar: AppBar(
        title: Text('Quiz profile'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(children: [
          InkWell(onTap: ()=>selectimage(),
            child:imagefile ==null? CircleAvatar(backgroundImage: NetworkImage(imageUrl),
              radius: 40,
            ):ClipRRect(borderRadius: BorderRadius.circular(50),child: Image.file(imagefile !,width: 100,height: 100,fit: BoxFit.fill,)),
          ),
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




          SizedBox(height: 20,),
          SizedBox(width: double.infinity,
            child: ElevatedButton(onPressed: (){}, child: Text("Register"),style: ButtonStyle(
                backgroundColor: MaterialStatePropertyAll(Colors.cyan)
            ),),
          ),SizedBox(width: 10,),


        ],


        ),
      ),
    );
  }

 Future<void> selectimage() async {
   final ImagePicker picker = ImagePicker();
   final XFile? image = await picker.pickImage(source: ImageSource.gallery);
   if (image == null)
 {return;}
   imagefile=File(image.path);
   upload(imagefile !);
   setState(() {
     
   });

  }

void upload(File imagurl ){
    final uid=auth.currentUser!.uid;
    storage.ref("images/${uid}").putFile(imagurl).then((p0) => geturt(imagurl.toString())).catchError((error){
      Fluttertoast.showToast(msg: error.toString());
    });

}

  geturt(String imageurl) {
    Map<String,dynamic> data={
    "imageurl":imageurl
    };
    final USERID=auth.currentUser!.uid;
    firebase.collection("personaldata").doc(USERID).update(data).then((value) => Fluttertoast.showToast(msg: "uplozded image")).catchError((error){
      Fluttertoast.showToast(msg: error.toString());
    });

  }

 @override
  void initState() {
    // TODO: implement initState
    super.initState();
    firebase.collection("personaldata").doc(auth.currentUser!.uid).get().then((value) {
      updateui(value.data() !);


    });
  }

  void updateui(Map<String, dynamic> map) {
    namecon.text=map["name"];
    phonecon.text=map["phone"];
    emailcontroller.text=map['email'];
    if (map.containsKey("imageurl")){
      imagefile=map["imageurl"];



    }
    setState(() {

    });


  }
}