import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PhoneCall extends StatelessWidget {
  const PhoneCall({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
       appBar: AppBar(
         title: Text("phone Call"),

       ),
      body: ListView(children: [
        Container(margin: EdgeInsets.all(20),decoration:BoxDecoration(
          borderRadius: BorderRadius.circular(0)
              ,color: Colors.grey
        ),child: TextFormField())
     ,Row(mainAxisAlignment: MainAxisAlignment.center,children: [
       
       Container(margin: EdgeInsets.all(5),
         child: Expanded(
           child: FloatingActionButton(onPressed: (){},child: Text("1"),
              ),
         ),
       ),
         
          Container(margin: EdgeInsets.all(15),child: Expanded(child: FloatingActionButton(onPressed: (){},child: Text("2"),)))
,       Container(margin: EdgeInsets.all(15),child: Expanded(child: FloatingActionButton(onPressed: (){},child: Text("3"),)))


        ],),
        Row(mainAxisAlignment: MainAxisAlignment.center,children: [

          Container(margin: EdgeInsets.all(5),
            child: Expanded(
              child: FloatingActionButton(onPressed: (){},child: Text("4"),
              ),
            ),
          ),

          Container(margin: EdgeInsets.all(15),child: Expanded(child: FloatingActionButton(onPressed: (){},child: Text("5"),)))
          ,       Container(margin: EdgeInsets.all(15),child: Expanded(child: FloatingActionButton(onPressed: (){},child: Text("6"),)))


        ],),
        Row(mainAxisAlignment: MainAxisAlignment.center,children: [

          Container(margin: EdgeInsets.all(5),
            child: Expanded(
              child: FloatingActionButton(onPressed: (){},child: Text("1"),
              ),
            ),
          ),

          Container(margin: EdgeInsets.all(15),child: Expanded(child: FloatingActionButton(onPressed: (){},child: Text("2"),)))
          ,       Container(margin: EdgeInsets.all(15),child: Expanded(child: FloatingActionButton(onPressed: (){},child: Text("3"),)))


        ],),
        Row(mainAxisAlignment: MainAxisAlignment.center,children: [



          Container(child: FloatingActionButton(onPressed: (){},child: Text("0"),))


        ],)
      ,Container(margin: EdgeInsets.all(20),

        child: Row(mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(child: ElevatedButton(onPressed: (){}, child: Text("CALL"))),
              SizedBox(width: 20,),
              Expanded(child: ElevatedButton(onPressed: (){}, child: Text("CLEAR")))
            ],


          ),
      )],),


    );
  }
}
