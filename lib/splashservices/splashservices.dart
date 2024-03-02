import 'dart:async';
// import 'package:dumy/uii/posts/post_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
//import 'package:todo/firestore/add_firestore_data.dart';
import 'package:todo/postScreen/postscreen.dart';
import 'package:todo/uiis/login.dart';

class SplashServices {

void islogin(BuildContext context){

final _auth =FirebaseAuth.instance;
final User= _auth.currentUser;

if(User!=null){
Timer(const Duration(seconds: 3), () =>Navigator.push(context, MaterialPageRoute(builder: (context) => const Post_Screen()),)) ;

}else{
Timer(const Duration(seconds: 3), () =>Navigator.push(context, MaterialPageRoute(builder: (context) => const Log_In(),)) );

}

}



}