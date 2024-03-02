
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:todo/firestore/add_Firestore.dart';
import 'package:todo/imageupload/image.dart';


class Firestore_Screen extends StatefulWidget {
  const Firestore_Screen({super.key});

  @override
  State<Firestore_Screen> createState() => _Firestore_ScreenState();
}
final auth =FirebaseAuth.instance;
final text_field_Controller = TextEditingController();
final firestore = FirebaseFirestore.instance.collection('Data').snapshots();
final fs = FirebaseFirestore.instance.collection('Data');
class _Firestore_ScreenState extends State<Firestore_Screen> {
  @override
  Widget build(BuildContext context) {

    return Scaffold(
    appBar: AppBar(title: const Text('Firestore screen',style: TextStyle(color: Colors.white),),
    centerTitle: true,
    actions: [
      const Gap(31),
    IconButton(onPressed: (){
      Navigator.push(context, MaterialPageRoute(builder: (context)=> const Image_upload()));
    }, icon: const Icon(Icons.photo,color: Colors.white,))
    ],
    ),

    body:Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Gap(31),
        // Expanded(
        //   child: FirebaseAnimatedList(
        //     query: ref, 
        //      itemBuilder: (BuildContext context, snapshot, animation,index){
        //       return ListTile(
        //           title: Text(snapshot.child('Title').value.toString()),
        //           subtitle: Text(snapshot.child('id').value.toString()),
        //       );
        //      },),
        // ),
        StreamBuilder<QuerySnapshot>(
          stream: firestore, 
          builder:(BuildContext context ,AsyncSnapshot<QuerySnapshot>snapshot ){
                        if(snapshot.connectionState==ConnectionState)
            return CircularProgressIndicator(color: Colors.white,);

              if(snapshot.hasError)
              return  Text('Some error occured');

               if (snapshot.data == null || snapshot.data!.docs.isEmpty) 
               return Text('No data available');
    

           return  Expanded(
        child: ListView.builder(
          itemCount: snapshot.data!.docs.length,
          itemBuilder: (context,index){   
            String Title =snapshot.data!.docs[index]['Title'].toString();
       return Card(
         child: ListTile(
          title: Text(snapshot.data!.docs[index]['Title'].toString()),
          subtitle: Text(snapshot.data!.docs[index].id.toString()),
          trailing: PopupMenuButton(
            itemBuilder: (context)=>[
              PopupMenuItem(
                value: 1,
                child: ListTile(
                title: const Text('Edit'),
                leading: const  Icon(Icons.edit) ,
                onTap: (){
                 Navigator.pop(context);
                 showmydialouge(Title, snapshot.data!.docs[index].id.toString());
                },

              )),
              PopupMenuItem(
                value: 2,
                child: ListTile(
                title:const  Text('Delete'),
                onTap: (){
                  Navigator.pop(context);
                  fs.doc( snapshot.data!.docs[index].id.toString()).delete();
                },
                leading: const Icon(Icons.delete) ,
              ))
            ],
          ),
         ),
       );
        }),
     );

          } ),
         
      ],
    ),
    floatingActionButton: FloatingActionButton(onPressed: (){
 Navigator.push(context, MaterialPageRoute(builder: (context) =>const Add_Firestore(),));
    },
    backgroundColor: Colors.deepPurple,
    focusColor: Colors.pink,
    shape:const OvalBorder(
      eccentricity: BorderSide.strokeAlignCenter
    ),
    elevation:101,
    child: const Icon(Icons.add_box_outlined),),
    );
  }
 Future<void> showmydialouge(String Title,String id)async{
  text_field_Controller.text=Title;

return showDialog(
  context: context, 
builder: (BuildContext context ,){
  return AlertDialog(
    title: const Text('Update'),
    content: TextField(
      controller:text_field_Controller ,
      decoration:const  InputDecoration(
        hintText: "Edit",
      ),
    
    ),
    actions: [
      TextButton(onPressed: (){
          Navigator.pop(context);
      }, child: const Text('Cancle')),

   TextButton(onPressed: (){
     Navigator.pop(context);
    fs.doc(id).update({
   "Title" : text_field_Controller.text.toString()
    });
   }, child:const  Text('Update'))
    ],
  );
});



  }
}