import 'package:flutter/material.dart';
import 'package:notes/Blogapp/story_view.dart';
import 'package:notes/Blogapp/update_blog.dart';
import 'package:notes/utils/networkimage.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import 'add_blog.dart';
import 'blog.dart';

class BlogScreen extends StatefulWidget {
  const BlogScreen({super.key});

  @override
  State<BlogScreen> createState() => _BlogScreenState();
}

class _BlogScreenState extends State<BlogScreen> {
final String name="mahmoud bfgdbd";
final String imageUrl =
    "https://images.unsplash.com/photo-1503023345310-bd7c1de61c7d?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8Mnx8aHVtYW58ZW58MHx8MHx8fDA%3D&w=1000&q=80";
List<blogg> blogc=[blogg(title: "title1", content: "title1",
    Img: "https://images.unsplash.com/photo-1503023345310-bd7c1de61c7d?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8Mnx8aHVtYW58ZW58MHx8MHx8fDA%3D&w=1000&q=80"
),blogg(title: "title2", content: "vewbcuib cqiecyevc efbeb vrevrawv vEVRVwvWVWVvEWC Vwvc  efbeb vrevrawv vEVRVwvWVWVvEWC Vwvc  efbeb vrevrawv vEVRVwvWVWVvEWC Vwvc  efbeb vrevrawv vEVRVwvWVWVvEWC Vwvc  efbeb vrevrawv vEVRVwvWVWVvEWC Vwvc  efbeb vrevrawv vEVRVwvWVWVvEWC Vwvc  euc uqe  cuqe cuq", Img: "https://images.unsplash.com/photo-1503023345310-bd7c1de61c7d?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8Mnx8aHVtYW58ZW58MHx8MHx8fDA%3D&w=1000&q=80"
),blogg(title: "title3", content: " dvvsd s dc sdcvS DCWVg43   4f 4g  3g d  d 33", Img:"https://images.unsplash.com/photo-1503023345310-bd7c1de61c7d?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8Mnx8aHVtYW58ZW58MHx8MHx8fDA%3D&w=1000&q=80"
)];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Blog"),
        centerTitle: true,
      ),
      floatingActionButton: FloatingActionButton(onPressed: (
          ){
        navigatertoaddblogscreen();

      },child: Icon(Icons.add ),),
      body: Column(
        children: [

         SizedBox(height: 15.h,
           child: ListView.builder(itemCount: 8,scrollDirection: Axis.horizontal,itemBuilder: (context,index){
             return InkWell(
               onTap: (){
                 Navigator.push(context, MaterialPageRoute(builder: (context)=>Storyview()));},
               child: Column(
                 children: [
                   Padding(
                     padding:  EdgeInsets.all(15.sp),
                     child: Stack(alignment: Alignment.bottomRight,
                       children: [
                         CircleAvatar(
                           radius: 20.sp,
                           child: image(imageUURL: imageUrl),
                         ),
                       CircleAvatar(radius: 11.sp,
                        backgroundColor: Colors.white,
                      ), CircleAvatar(radius: 10.sp,
                           backgroundColor: Colors.red,
                         ) ],
                     ),
                   ),
                   Text(name.length>8? "${name.substring(0,8)}...":name ,style:TextStyle(fontSize: 12.sp,color: Colors.green),),
                 ],
               ),
             );
           }),
         ),
          Expanded(
            child: ListView.builder(itemCount:blogc.length ,itemBuilder: (context,index){
              return viewitem(index);
            }),
          )

      ]),
    );
  }
Widget viewitem(int index){
    blogg v=blogc[index];
    return Container(margin: EdgeInsets.all(10.sp),decoration: BoxDecoration(
      color: Colors.blueGrey,
      borderRadius: BorderRadius.circular(15.sp)
    ),child: Column(crossAxisAlignment: CrossAxisAlignment.start,children: [
     ClipRRect(borderRadius:  BorderRadius.only(
       topLeft: Radius.circular(25.sp),
       topRight: Radius.circular(25.sp),
     ),child: image(imageUURL: v.Img)),
        Padding(
         padding: EdgeInsets.all(8.sp),
         child: Row(
           children: [
              Expanded(
               child: Text(v.title,style: TextStyle(fontWeight: FontWeight.w600,color: Colors.cyan,fontSize: 20.sp),
               ),
             ),
             IconButton(onPressed: (){
               UPDATE(index);
             }, icon: Icon(Icons.edit,size: 20.sp,),),
             SizedBox(width: 10.sp,),
             IconButton(onPressed: (){
               blogc.removeAt(index);
               setState(() {
                 
               });
             }, icon: Icon(Icons.delete,size: 20.sp,))
           ],
         ),
       ),
       Padding(
        padding: EdgeInsets.all(8.sp),
        child: Text(v.content,maxLines: 2,overflow: TextOverflow.ellipsis,style: TextStyle(fontWeight: FontWeight.w600,color: Colors.cyan,fontSize: 20.sp)),
      ),
    ],),);
}

  void navigatertoaddblogscreen() {
    Navigator.push(context, MaterialPageRoute(builder: (context)=>AddblogScreen(),)).then((value){
      if(value== null) {
        return;
      }
      blogc.add(value);
      setState(() {

      });


    });
  }
  void UPDATE(int index){
    Navigator.push(context, MaterialPageRoute(builder: (context)=>aUPDATEblogScreen(blogcc: blogc[index],)
    )).then((value)
    {
      if (value == null) {
        return;
      }
      blogc[index]=value;
      setState(() {

      });
    });
  }}