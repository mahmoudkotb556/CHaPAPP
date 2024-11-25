import 'package:flutter/material.dart';
import 'package:notes/Blogapp/blog.dart';

class AddblogScreen extends StatefulWidget {
  const AddblogScreen ({super.key});

  @override
  State<AddblogScreen> createState() => _AddblogScreenState();
}

class _AddblogScreenState extends State<AddblogScreen> {
  final contr1=TextEditingController();
  final contr2=TextEditingController();
  final contr3=TextEditingController();
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
appBar: AppBar(
  title: Text("add blog"),),
body:  Padding(
  padding: const EdgeInsets.all(20.0),
  child:   Column(children: [
Image.asset('assets/th.jpg'),
    Container(width: double.infinity,child: TextFormField(

    controller: contr1,decoration: InputDecoration(
        labelText: "title",
        border: OutlineInputBorder(),
      ),

    )),SizedBox(height: 10,),

    Container(width: double.infinity,child: TextFormField(

      controller: contr2,decoration: const InputDecoration(
      labelText: "content",
      border: OutlineInputBorder(),
    ),

    )),
    SizedBox(height: 10,),

    Container(width: double.infinity,child: TextFormField(

      controller: contr3,decoration: const InputDecoration(
      labelText: "image url",
      border: OutlineInputBorder(),
    ),

    )),
SizedBox(height: 10,),
    Container(width: double.infinity,
      child: ElevatedButton(onPressed: (){
        addnotee();



      }, child: Text("ADD")),
    )









  ],),
),

    );
  }

  void addnotee() {
    String title=contr1.text;
    String content=contr2.text;
    String image=contr3.text;
    blogg b= blogg(title: title, content: content, Img: image);
    Navigator.pop(context,b);
  }
}
