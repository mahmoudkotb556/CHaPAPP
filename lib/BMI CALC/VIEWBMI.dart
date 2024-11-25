import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:notes/BMI%20CALC/Bmiclass.dart';
import 'package:notes/BMI%20CALC/colors.dart';
import 'dart:math';
class ViewBmi extends StatefulWidget {


  const ViewBmi({super.key,required this.bmis});
 final bmivariable bmis;


  @override
  State<ViewBmi> createState() => _ViewBmiState();

}

class _ViewBmiState extends State<ViewBmi> {
  String type="";
  int age=0;
  int weight=0;
  int height=0;
  double bmii=0;
  double m=0;
  String nn="";
  @override
  void setState(VoidCallback fn) {
    // TODO: implement setState
    super.setState(fn);
     type=widget.bmis.type;
     age=widget.bmis.age;
     weight= widget.bmis.weight;
     height=widget.bmis.height;
       m=height.toDouble()/100;
     bmii=weight.toDouble()/(m*m);
     if(bmii<18.5){
       nn="UNDER WEIGHT";
     }else if((bmii>=18.5) && (bmii<=24.9)){
       nn="NORMAL";
     }else if((bmii>=25) && (bmii<=29.9)){
       nn="OVER WEIGHT";
     }else{
       nn="obse";
     }

  }
  @override
  Widget build(BuildContext context) {
    return  Scaffold(backgroundColor: mainColor,
      appBar:AppBar(
        title: Text("View Result"),
      ),
      body: Column(mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(30.0),
              child: Row(children: [
                Text("Gender:${widget.bmis.type}",style: TextStyle(fontSize: 15,color: Colors.white),),
                SizedBox(width: 10,),
                Text("Height:${widget.bmis.height}",style: TextStyle(fontSize: 15,color: Colors.white)),
                SizedBox(width: 10,),
                Text("weight:${widget.bmis.weight}",style: TextStyle(fontSize: 15,color: Colors.white)),
                SizedBox(width: 10,),
                Text("Age:${widget.bmis.age}",style: const TextStyle(fontSize: 15,color: Colors.white)),
              ],),
            ),
          ),

          Expanded(child: Container(child: Text(status(widget.bmis.weight.toDouble(),widget.bmis.height.toDouble(),widget.bmis.age),style:TextStyle(fontSize: 30,color: Colors.green)))),


        Expanded(child: Container(child: Text(calculateBMI(widget.bmis.weight.toDouble(),widget.bmis.height.toDouble(),widget.bmis.age).toInt().toString(),style:TextStyle(fontSize: 100,color: Colors.white)))),
          Expanded(child: Container(child: Text("you are good weight",style:TextStyle(fontSize: 30,color: Colors.white)))),

          Container(child: Text("Good job",style:TextStyle(fontSize: 30,color: Colors.white))),
        ],
      ),


    );
  }


  double calculateBMI(double weight, double height, int age) {
    double bmi = weight / pow(height / 100, 2);
    if (age < 18) {
      if (bmi < 18.5) {
        return bmi;
      } else if (bmi < 25) {
        return bmi;
      } else if (bmi < 30) {
        return bmi + (age / 10);
      } else {
        return bmi + (age / 5);
      }
    } else if (age < 65) {
      if (bmi < 18.5) {
        return bmi;
      } else if (bmi < 25) {
        return bmi;
      } else if (bmi < 30) {
        return bmi + 1;
      } else {
        return bmi + 2;
      }
    } else {
      if (bmi < 22) {
        return bmi;
      } else if (bmi < 27) {
        return bmi + 1;
      } else {
        return bmi + 2;
      }
    }
  }
 String status(double weight, double height, int age){
  double bmi= calculateBMI(weight,height,age);
  if(bmi<18.5){
    return "UNDER WEIGHT";
  }else if((bmi>=18.5) && (bmi<=24.9)){
    return "NORMAL";
  }else if((bmi>=25) && (bmi<=29.9)){
    return "OVER WEIGHT";
  }else{
     return "obse";
  }
 }
}
