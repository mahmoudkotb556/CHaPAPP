import 'package:flutter/material.dart';

import 'Bmiclass.dart';
import 'VIEWBMI.dart';
import 'colors.dart';

class BmiScreen extends StatefulWidget {
  const BmiScreen({super.key});

  @override
  State<BmiScreen> createState() => _BmiScreenState();
}

class _BmiScreenState extends State<BmiScreen> {
   double number=150;
   double weight=50;
   double age=1;
   bool press1= false;
   bool press2=false;
   String type="";
   Color swap = Color(0xFF55556D);

  @override
  Widget build(BuildContext context) {
    return  Scaffold(backgroundColor: mainColor,
      appBar: AppBar(
        title: Text("BMI Calculator"),
      ),
      body: Column(children: [
       firstpart(),
  halfpart(),
        thirdpart(),
        
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Container(width:double.infinity,color: pinkColor,child: ElevatedButton(style: ButtonStyle(backgroundColor:MaterialStateProperty.all<Color>(Colors.pink)),onPressed:
              (){

            if (press2==true){
                type="Femele";
              }
            else{
              type="Male";
            }

            final bmivariable bmi = bmivariable(type: type, height: number.toInt(), weight: weight.toInt(), age: age.toInt());
            Navigator.push(context, MaterialPageRoute(builder: (context)=>ViewBmi(bmis: bmi)));
              }, child: Text("Calculater"),)),
        )
        
      ],) ,




    );

  }
 Widget firstpart(){
    return  Expanded(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Row(children: [
          Expanded(

            child: InkWell(
              onTap: (){
                press1=true;
                press2=false;
                setState(() {

                });

              },
              child: Container(color:press1==true? selectedColor:secondColor,
                child: Column(mainAxisAlignment: MainAxisAlignment.center,children: [
                  IconButton(onPressed: (){}, icon: Icon(Icons.male,color: Colors.white,size: 60,))
                  ,SizedBox(height: 20,),
                  Text("Male",style: TextStyle(fontSize: 30),)],),
              ),
            ),
          ),
           SizedBox(width: 20,),
           Expanded(
             child: InkWell(onTap: (){
               press2=true;
               press1=false;
               setState(() {

               });


             },
               child: Container(color: press2==true? selectedColor:secondColor,
                 child: Column(mainAxisAlignment: MainAxisAlignment.center,children: [
                  IconButton(onPressed: (){}, icon: Icon(Icons.female,color: Colors.white,size: 70,))
                  ,
                  SizedBox(height: 20,),
                  Text("Famle",style: TextStyle(fontSize: 30),)]),
               ),
             ),
           )],),
      ),
    );


 }
 Widget halfpart(){
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Container(color: secondColor,
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(children: [
            Text("Height"),
            Row(mainAxisAlignment: MainAxisAlignment.center,children: [Text(number.toInt().toString(),style: TextStyle(fontSize:50 )),Text("CM")],),
           Slider(value: number,max: 200,min: 130, onChanged: (value) {
             number=value;

             setState(() {

             });

           },)



          ],),
        ),),
      ),
    );
 }
  Widget thirdpart(){
    return  Expanded(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Row(mainAxisAlignment: MainAxisAlignment.center,children: [
          Expanded(

            child: Container(color: secondColor,
              child: Column(mainAxisAlignment: MainAxisAlignment.center,children: [ Text("Weight",style: TextStyle(fontSize: 20),),
                Text(weight.toInt().toString(),style: TextStyle(fontSize: 20),),
                Row(mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(decoration:  BoxDecoration(color:mainColor,borderRadius: BorderRadius.circular(50)),
                      child: IconButton(onPressed: (){
                        weight=weight+1;
                        setState(() {

                        });
                      }, icon: Icon(Icons.add,color: Colors.white,)),
                    ),
                    SizedBox(width: 10,),
                    Container(decoration:  BoxDecoration(color:mainColor,borderRadius: BorderRadius.circular(50)),
                      child: IconButton(onPressed: (){
                        weight=weight-1;
                        setState(() {

                        });
                      }, icon: Icon(Icons.remove,color: Colors.white,)),
                    ),
                  ],
                )

               ],),
            ),
          ),
          SizedBox(width: 20,),
          Expanded(
            child: Container(color: secondColor,
              child: Column(mainAxisAlignment: MainAxisAlignment.center,children: [ Text("Age",style: TextStyle(fontSize: 20),),
                Text(age.toInt().toString(),style: TextStyle(fontSize: 20),),
                Row(mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(decoration:
                      BoxDecoration(color:mainColor,borderRadius: BorderRadius.circular(50)),
                      child: IconButton(onPressed: (){
                        age=age+1;


                        setState(() {

                        });
                      }, icon: Icon(Icons.add,color: Colors.white,)),
                    ),
                    SizedBox(width: 10,),
                    Container(decoration: BoxDecoration(color: mainColor,
                    borderRadius: BorderRadius.circular(50)),
                      child: IconButton(onPressed: (){
                        age=age-1;
                        if (age<0){
                          age=0;
                        }
                        setState(() {

                        });
                      }, icon: Icon(Icons.remove,color: Colors.white,)),
                    ),
                  ],
                )

              ],),
            ),
          )],),
      ),
    );


  }
}
