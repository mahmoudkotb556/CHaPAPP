import 'package:flutter/material.dart';
import 'package:notes/Blogapp/blog.dart';

class aUPDATEblogScreen extends StatefulWidget {
  const aUPDATEblogScreen ({super.key, required this.blogcc});
   final blogg blogcc;


  @override
  State<aUPDATEblogScreen> createState() => _aUPDATEblogScreenState();
}

class _aUPDATEblogScreenState extends State<aUPDATEblogScreen> {
  final contr1=TextEditingController();
  final contr2=TextEditingController();
  final contr3=TextEditingController();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    contr1.text=widget.blogcc.title;
    contr2.text=widget.blogcc.content;
    contr3.text=widget.blogcc.Img;
  }
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        title: Text("add blog"),),
      body:  Padding(
        padding: const EdgeInsets.all(20.0),
        child:   Column(children: [

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



            }, child: Text("UPDATE")),
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
