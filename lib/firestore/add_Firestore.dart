// ignore_for_file: camel_case_types
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:todo/utilis/roundbutton.dart';
import 'package:todo/utilis/toastmessage.dart';


class Add_Firestore extends StatefulWidget {
  const Add_Firestore({super.key});


  @override
  State<Add_Firestore> createState() => _Add_FirestoreState();
}
final controller = TextEditingController();

final firestore = FirebaseFirestore.instance.collection('Data');

bool loading = false;

class _Add_FirestoreState extends State<Add_Firestore> {
  @override
  Widget build(BuildContext context) {

    return Scaffold(
    appBar: AppBar(title: const Text('Add Firestore ',style: TextStyle(color: Colors.white),)),

    body: Column(
      children: [
       const SizedBox(height: 11,),
       
                 Padding(
                   padding: const EdgeInsets.symmetric(horizontal: 11,vertical: 11),
                   child: TextFormField(
                   
                    maxLines: 3,
                    controller: controller,
                   
                    decoration: InputDecoration(
                      hintFadeDuration: const Duration(seconds: 3),
                      hintText: 'Whats in your mind',
                      focusColor: Colors.pink.shade500,
                     
                     
                      prefixIconColor: Colors.black,
                      enabledBorder: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(9)),
                      ),
                      focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(9),
                    borderSide:const  BorderSide(
                      color: Colors.pink,
                     style: BorderStyle.solid,
                     
                    ),
                   
                   ),
                    ), 
                    
                   ),
                 ),
                 
                const  SizedBox(height: 51,),
                 
                 RoundButton(write: 'Post',loading: loading, Pressed: (){
  setState(() {
  loading=true;
});
 String id = DateTime.now().toIso8601String(); // Using ISO 8601 format for a timestamp
id = id.replaceAll(RegExp(r'[:.]+'), '_'); // Replace ':' and '.' with underscores

firestore.doc(id).set({
  'Title': controller.text.toString(),
  'id': id,
}).then((value) {
  Utilis().ToastMessage('Posted');
  setState(() {
    loading = false;
  });
}).onError((error, stackTrace) {
  Utilis().ToastMessage(error.toString());
  setState(() {
    loading = false;
  });
});


                 })
      ],
    )
    );
  }
}