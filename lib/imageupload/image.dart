


// ignore_for_file: camel_case_types

import 'dart:io';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:todo/utilis/roundbutton.dart';
import 'package:todo/utilis/toastmessage.dart';

class Image_upload extends StatefulWidget {
  const Image_upload({super.key});


  @override
  State<Image_upload> createState() => _Image_uploadState();
}

class _Image_uploadState extends State<Image_upload> {
  bool loading = false ;
  File? _image;
  final picker = ImagePicker();

final storage = firebase_storage.FirebaseStorage.instance ;
DatabaseReference databaseref = FirebaseDatabase.instance.ref('Table');

Future getImageGallery()async{
final pickedFile= await picker.pickImage(source: ImageSource.gallery,imageQuality: 80);
setState(() {
  if(pickedFile!=null){
    _image=File(pickedFile.path);
  }else{
    print('No image picked');
  }
});
}
  
  @override
  Widget build(BuildContext context) {

    return Scaffold(
    appBar: AppBar(title:const  Text('Upload',style: TextStyle(color: Colors.white),)),

    body:Column(
      children: [
        const SizedBox(height: 21,),
     Center(
       child: InkWell(
        onTap: (){
           getImageGallery();
        },
         child: Container(
          height: 150,
          width: 150,
          decoration: BoxDecoration(
            border: Border.all(),
          ),child:_image!=null ? Image.file(_image!.absolute): const  Center(child: Icon(Icons.photo),),
         ),
       ),
       
     ),
     const SizedBox(height: 31,),
     
     RoundButton(write: 'Upload',loading: loading, Pressed: ()async{
      setState(() {
        loading=true;
      });
          firebase_storage.Reference ref =firebase_storage.FirebaseStorage.instance.ref('/foldername/'+DateTime.now().microsecondsSinceEpoch.toString());
          firebase_storage.UploadTask uploadTask= ref.putFile(_image!.absolute);
          String id = DateTime.now().millisecondsSinceEpoch.toString();
          await Future.value(uploadTask);
          var newurl= await ref.getDownloadURL();
           databaseref.child(id).set({
           'id' : id,
           'Name' :newurl.toString()
           }).then((value) {
         
           Utilis().ToastMessage('Uploaded');
              setState(() {
              loading=false;
            });
           }).onError((error, stackTrace) {
            setState(() {
              loading=false;
            });
           // print('Error: ${error.toString()}');
            Utilis().ToastMessage(error.toString());
           });
          

     })
    ],)
    );
  }
}