import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:notes/utils/networkimage.dart';
import 'package:text_area/text_area.dart';

class homescreen extends StatefulWidget {
  const homescreen({super.key});

  @override
  State<homescreen> createState() => _homescreenState();
}

class _homescreenState extends State<homescreen> {

   String name_of_user="noname";
   Map<String,dynamic> user_data={};
   List<Map<String, dynamic>> List_of_posts = [];
  List<Map<String, dynamic>> comments = [];
   List<Map<String, dynamic>> datas_of_all_user = [];
  final firsstore=FirebaseFirestore.instance;

  final auth=FirebaseAuth.instance;
  final Storage= FirebaseStorage.instance;
  File? imagefile;
  int number_of_likes = 0;
   String post_id="";
  final COMMENTCONTROL=TextEditingController();
   String Select_image = "https://i.ytimg.com/vi/-xijbXYSvNs/maxresdefault.jpg";
   String logo2 = "https://i.ytimg.com/vi/-xijbXYSvNs/maxresdefault.jpg";
   String user_image_profile="";
   String images_of_posts=" ";
  final myTextController = TextEditingController();
  var reasonValidation = true;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

   Future<void> getAllUser() async {
     await firsstore.collection("alhofradata").get().then((value) {
       datas_of_all_user.clear();
       for (var docum in value.docs) {
         final note = docum.data();
         //if (auth2.currentUser!.uid.toString()==note["uid"]){
         datas_of_all_user.add(note);
       }

     });
   }
   Future<void> getAllPosts() async {
   List_of_posts.clear();
    await firsstore.collection("posts").get().then((value){

       for (var docum in value.docs) {
         final note = docum.data();
         //if (auth2.currentUser!.uid.toString()==note["uid"]){
         List_of_posts.add(note);

       }
     });
    print(List_of_posts);
setState(() {

});
    }

  Future<void> loadPersonalData() async {
    await firsstore
        .collection("alhofradata")
        .doc(auth.currentUser!.uid)
        .get()
        .then((value) {
      updateui(value.data()!);
    });
    setState(() {

    });
  }
   Map<String,dynamic> getDataOfSpecificUser(String id)  {
     Map<String,dynamic> h={};
      firsstore
         .collection("alhofradata")
         .doc(id)
         .get()
         .then((value) {
       h= value.data()!;
     });
      return h;
   }
  void updateui(Map<String, dynamic> map) {
    name_of_user = map["name"];
    if (map.containsKey("image")) {
      user_image_profile = map["image"];

    }
setState(() {

});
  }

@override
  void initState() {
    // TODO: implement initState
    super.initState(

    );
    getAllPosts();
    loadPersonalData();
    getAllUser();




  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: const EdgeInsets.all(20),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                CircleAvatar(
                  radius: 20,
                  child: image(imageUURL: user_image_profile),
                ),
                const SizedBox(
                  width: 10,
                ),
                 Row(
                  children: [
                    Text(name_of_user),
                    SizedBox(
                      width: 10,
                    ),
                    Text("20:30")
                  ],
                ),
              ],
            ),
            Form(
              key: formKey,
              child: TextArea(
                borderRadius: 10,
                borderColor: const Color(0xFFCFD6FF),
                textEditingController: myTextController,
                suffixIcon: Icons.attach_file_rounded,
                onSuffixIconPressed: () => {},
                validation: reasonValidation,
                errorText: 'Please type a reason!',
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                IconButton(onPressed: () {
                 post_id=DateTime.now().microsecondsSinceEpoch.toString();
                  setPoST(post_id);
                }, icon: const Icon(Icons.post_add)),
                InkWell(
                  onTap: ()=>selectimage(),
                  child:
                      CircleAvatar(
                    child: image(imageUURL: Select_image),
                    radius: 20,
                  )
                      ,
                ),],
            ),
            const SizedBox(
              height: 5,
            ),
            Expanded(
              child: ListView.builder(
                  itemCount: List_of_posts.length,
                  itemBuilder: (context, index) {
                    return WidgetOFPosts(index);
                  }),
            )
          ],
        ),
      ),
    );
  }

  Widget WidgetOFPosts(int index2) {
    List<Map<String, dynamic>> DATA=[];
    DATA = datas_of_all_user.where((map) => map.containsValue(List_of_posts[index2]["uid"])).toList();
    //aaFluttertoast.showToast(msg: postslist[index2]["uid"]);
  //  Map<String,dynamic> user_data_specfici=getDataOfSpecificUser(List_of_posts[index2]["uid"]);
    return Container(
      margin: const EdgeInsets.all(15),
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
          color: Colors.grey[300], borderRadius: BorderRadius.circular(20)),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              CircleAvatar(
                radius: 20,
                child: image(imageUURL: DATA[0]['image']),
              ),
              const SizedBox(
                width: 10,
              ),
               Row(
                children: [
                  Text(DATA[0]["name"]),
                  SizedBox(
                    width: 10,
                  ),
                  Text("20:30")
                ],
              ),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
           Row(
            children: [
              Expanded(
                  child:List_of_posts[index2]["content"] !=" "?Text(List_of_posts[index2]["content"]):Text(" "))
            ]
            ,
          ),
        Center(
          child: Container(height: 150,
            child: ListView.builder(
                itemCount: 1,
                itemBuilder: (context, index) {
                  return List_of_posts[index2]["image"]!=" "? CircleAvatar(
                      child: image(imageUURL: List_of_posts[index2]["image"]),
                    radius: 150,


                  ):Text(" ");
                } ),
          ),
        ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: Column(
                  children: [
                    IconButton(
                        onPressed: () {
                          number_of_likes = number_of_likes + 1;

                          setState(() {});
                        },
                        icon: const Icon(
                          Icons.front_hand_rounded,
                          color: Colors.green,
                        )),
                    Text("$number_of_likes")
                  ],
                ),
              ),
              Expanded(
                child: IconButton(
                  onPressed: () {

                    showMyDialog(context,index2);
                  },
                  icon: const Icon(
                    Icons.comment,
                    color: Colors.green,
                  ),
                ),
              ),
              Expanded(
                child: IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.share,
                    color: Colors.red,
                  ),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }

// Define a function that shows the dialog
  void showMyDialog(BuildContext context,int index3) {
     firsstore.collection("comments").where("postid",isEqualTo: List_of_posts[index3]["postid"]).get().then((value) {
       comments.clear();
       for (var docum in value.docs) {
         final note = docum.data();
         //if (auth2.currentUser!.uid.toString()==note["uid"]){
         comments.add(note);
         setState(() {

         });
       }
     });
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Comments'),
          content: Container(
            height: 500,
            width: 400,
            child: ListView(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        controller: COMMENTCONTROL,
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
                    IconButton(onPressed:() {
                      addComment(index3);
                      setState(() {

                      });
                    }, icon: Icon(Icons.comment))
                  ],
                ),
                ListView.builder(
                  shrinkWrap: true,
                  itemCount: comments.length,
                  itemBuilder: (context, index) {
                    return postsss(index);
                  },
                ),

                ],
            ),
          ),
          actions: <Widget>[
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Close'),
            ),
          ],
        );
      },
    );
  }

  Widget postsss(int index) {
    return Container(
      margin: const EdgeInsets.all(15),
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
          color: Colors.grey[300], borderRadius: BorderRadius.circular(20)),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              CircleAvatar(
                radius: 20,
                child: image(imageUURL: comments[index]["imagecomment"]),
              ),
              const SizedBox(
                width: 10,
              ),
               Row(
                children: [
                  Text(comments[index]["name"]),
                  SizedBox(
                    width: 10,
                  ),
                  Text("20:30")
                ],
              ),
            ],
          ),
           Text(comments[index]["commentcontent"])
        ],
      ),
    );
  }
  Future<void> selectimage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? imaged = await picker.pickImage(source: ImageSource.gallery);
    if (imaged == null) {
      return;
    }
    imagefile = File(imaged.path);
    upload(imagefile!);
    setState(() {});
  }
  void upload(File imagurl) {

    Storage.ref("images/${post_id}").putFile(imagurl).then((p0) => downloadUrlOfImage()).catchError((error) {
      Fluttertoast.showToast(msg: error.toString());
    });
  }

  downloadUrlOfImage() {
    final uid = auth.currentUser!.uid;
    Storage.ref("images/${post_id}")
        .getDownloadURL()
        .then((value) {
          images_of_posts = value;
          Select_image=value;
          setState(() {

          });
        })

        .catchError((error) {
      Fluttertoast.showToast(msg: error.toString());

    });
  }
  Future<void> setPoST(String post_id) async {

    Map<String,dynamic> data={
      "postid":post_id,
      "content":myTextController.text.isEmpty?" ":myTextController.text,
      "image":images_of_posts.isEmpty?" ":images_of_posts,
      "uid":auth.currentUser!.uid,
      "name":name_of_user,
      "imageuser":user_image_profile


    };
   await firsstore.collection("posts").doc(post_id).set(data).then((value) {
     getAllPosts();
     setState(() {

     });
      Fluttertoast.showToast(msg: "POSTED");
    });

  }

  void addComment(int index3) {
     String postid= List_of_posts[index3]["postid"];
     List<Map<String, dynamic>> DATA=[];
     DATA = datas_of_all_user.where((map) => map.containsValue(auth.currentUser!.uid)).toList();
     String COMMENTID=DateTime.now().microsecondsSinceEpoch.toString();
     Map<String,dynamic> comm={
       "postid":postid,
       "commentid":COMMENTID,
       "commentcontent":COMMENTCONTROL.text,
       "name":DATA[0]["name"],
       "imagecomment":DATA[0]["image"]

     };
     firsstore.collection("comments").doc(COMMENTID).set(comm).then((value){
       Fluttertoast.showToast(msg: "commentadd");

     });
     setState(() {

     });

  }


}
