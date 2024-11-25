import 'package:flutter/material.dart';

class MessageScreen extends StatefulWidget {
  const MessageScreen({super.key});

  @override
  State<MessageScreen> createState() => _MessageScreenState();
}

class _MessageScreenState extends State<MessageScreen> {
  final String img="https://images.unsplash.com/photo-1503023345310-bd7c1de61c7d?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8Mnx8aHVtYW58ZW58MHx8MHx8fDA%3D&w=1000&q=80";
List<String> name=["ahmed mohamed","mahmoud kotb","nader assel"];
List<String> message=["i want to home jvuvutv iyvyvtu","habby barth day","thanks"];
List<String> TIME=["12:4","15:5","5:3"];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Message"),
        centerTitle: true,

      ),
      body:ListView.builder(itemCount: name.length,scrollDirection: Axis.vertical,itemBuilder: (context, index){
        return Container(margin: EdgeInsets.all(20),
          child: Expanded(
            child: Row(
              
              children: [
                 CircleAvatar(
radius: 30,
                  backgroundImage: NetworkImage(img),
                ),
              SizedBox(width: 10,),
               Column(crossAxisAlignment: CrossAxisAlignment.start,children: [Row(children: [Text(name[index]),SizedBox(width: 10,),Text(TIME[index])
              ],)
              ,Text(message[index].length>=15?"${message[index].substring(0,15)}...":message[index])]
                ,),
              Spacer(),
              IconButton(onPressed:(){

              }, icon: const Icon(Icons.edit),)],
            ),
          ),
        );


      },)
      ,
    );
  }
}
