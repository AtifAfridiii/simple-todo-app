// ignore_for_file: camel_case_types

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:todo/utilis/roundbutton.dart';
import 'package:todo/utilis/toastmessage.dart';


class Add_post extends StatefulWidget {
  const Add_post({Key? key}) : super(key: key);


  @override
  State<Add_post> createState() => _Add_postState();
}
final controller = TextEditingController();
final Ref = FirebaseDatabase.instance.ref('Data');
bool loading = false;

class _Add_postState extends State<Add_post> {
  @override
  Widget build(BuildContext context) {

    return Scaffold(
    appBar: AppBar(title: const Text('Add post ',style: TextStyle(color: Colors.white),)),

    body: Column(
      children: [
       const SizedBox(height: 11,),
       
                 Padding(
                   padding: const EdgeInsets.symmetric(horizontal: 11,vertical: 11),
                   child: TextFormField(
                    
                    maxLines: 3,
                    controller: controller,
                   
                    decoration: InputDecoration(
                      hintText: 'Whats in your mind',
                      focusColor: Colors.pink.shade500,
                      focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(9),
                    borderSide:const  BorderSide(
                      color: Colors.pink,
                     style: BorderStyle.solid,
                     
              
                     
                    ),
                   
                   ),
                     
                      prefixIconColor: Colors.black,
                      enabledBorder: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(9)),
                      ),
                      hintFadeDuration: const Duration(seconds: 3),
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

Ref.child(id).set({
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