import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key, required this.id});

  final id;

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final messagecontroler = TextEditingController();
  final auth = FirebaseAuth.instance;
  final firestore = FirebaseFirestore.instance;
  String messageid = "";
  List<Map<String, dynamic>> message_of_list = [];
  List<Map<String, dynamic>> datas_of_all_user = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadmessages();

    getAllUser();
  }

  Future<void> getAllUser() async {
    await firestore.collection("alhofradata").get().then((value) {
      datas_of_all_user.clear();
      for (var docum in value.docs) {
        final note = docum.data();
        //if (auth2.currentUser!.uid.toString()==note["uid"]){
        datas_of_all_user.add(note);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Chat'),
        ),
        body: Column(children: [
          Expanded(
            child: ListView.builder(
                itemCount: message_of_list.length,
                itemBuilder: (context, index) {
                  return designOfMessage(index);
                }),
          ),
          Divider(height: 1.0),
          Container(
            decoration: BoxDecoration(color: Theme.of(context).cardColor),
            child: Row(
              children: <Widget>[
                Expanded(
                  child: TextField(
                    controller: messagecontroler,
                    decoration: InputDecoration(hintText: 'Enter message'),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.send),
                  onPressed: () {
                    addmessage();
                  },
                ),
              ],
            ),
          ),
        ]));
  }

  void addmessage() {
    messageid = DateTime.now().microsecondsSinceEpoch.toString();
    Map<String, dynamic> data = {
      "messageid": messageid,
      "sent": auth.currentUser!.uid,
      "reciver": widget.id,
      "messagecontent": messagecontroler.text
    };

    firestore
        .collection("chat")
        .doc(auth.currentUser!.uid)
        .collection(widget.id)
        .doc(messageid)
        .set(data)
        .then((value) {
      firestore
          .collection("chat")
          .doc(widget.id)
          .collection(auth.currentUser!.uid)
          .doc(messageid)
          .set(data);
      messagecontroler.clear();
message_of_list.add(data);
setState(() {

});
      Fluttertoast.showToast(msg: "SENT MESSAGE");
    });
  }

  Future<void> loadmessages() async {
    firestore
        .collection("chat")
        .doc(auth.currentUser!.uid)
        .collection(widget.id)
        .get()
        .then((value) {
      print(value.docs.length);

      for (var docum in value.docs) {
        final messa = docum.data();
        //if (auth2.currentUser!.uid.toString()==note["uid"]){
        message_of_list.add(messa);
      }
      print(message_of_list);
    //  listenMessage();
      setState(() {});
    });
  }

  Future<void> listenMessage() async {
    firestore
        .collection("chat")
        .doc(auth.currentUser!.uid)
        .collection(widget.id)
        .snapshots()
        .listen((value) {
      print(value.docs.length);
      print(value.docs.length);
      message_of_list.add(value.docs.first.data());

      setState(() {});
    });
  }

  Widget designOfMessage(int index2) {
    List<Map<String, dynamic>> data = [];
    data = datas_of_all_user
        .where((map) => map.containsValue(message_of_list[index2]["sent"]))
        .toList();

    return message_of_list[index2]["sent"] == auth.currentUser!.uid
        ? Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Container(
                margin: const EdgeInsets.all(20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(data[0]['name'].toString()),
                            const SizedBox(
                              width: 10,
                            ),
                            const Text("20:30")
                          ],
                        ),
                        Text(
                            message_of_list[index2]["messagecontent"]
                                .toString(),
                            style: TextStyle(
                                fontSize: 15, fontWeight: FontWeight.bold))
                      ],
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    CircleAvatar(
                      radius: 15,
                      backgroundImage: NetworkImage(data[0]['image']),
                    ),
                  ],
                ),
              ),
            ],
          )
        : Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                margin: const EdgeInsets.all(20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    CircleAvatar(
                      radius: 10,
                      backgroundImage: NetworkImage(data[0]['image']),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(data[0]['name'].toString()),
                            const SizedBox(
                              width: 10,
                            ),
                            const Text("20:30")
                          ],
                        ),
                        Text(
                          message_of_list[index2]["messagecontent"].toString(),
                          style: TextStyle(
                              fontSize: 15, fontWeight: FontWeight.bold),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ],
          );
  }
}
