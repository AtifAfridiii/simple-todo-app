import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:todo/Phone%20number/verify.dart';
import 'package:todo/utilis/roundbutton.dart';
import 'package:todo/utilis/toastmessage.dart';

class Phone_Sign extends StatefulWidget {


  @override
  State<Phone_Sign> createState() => _Phone_SignState();
}
final auth = FirebaseAuth.instance;
bool loading =false;
final controller = TextEditingController();

class _Phone_SignState extends State<Phone_Sign> {
  @override
  Widget build(BuildContext context) {

    return Scaffold(
    appBar: AppBar(title: const Text('Sign up with phone number',style: TextStyle(color: Colors.white),)),

    body: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 11),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
        const SizedBox(height: 11,),
         TextFormField(
          
          
          controller: controller,
          decoration: InputDecoration(
             hintFadeDuration: const Duration(seconds: 3),
            hintText: '+923370399050',
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            border : OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
            ),

          ),
          
         ),
         const SizedBox(height: 31,) ,
         RoundButton(write: 'Verify', loading: loading,Pressed: (){
          setState(() {
            loading=true;
          });
          auth.verifyPhoneNumber(
            verificationCompleted: (_){
                        setState(() {
            loading=false;
          });

            },
            phoneNumber: controller.text.toString() ,
           verificationFailed: (e){
            setState() {
            loading=false;
          }
            
            Utilis().ToastMessage(e.toString());
            
           }, 
           codeSent:(String verificationId , int? token){
            Navigator.push(context, MaterialPageRoute(builder: (context) => Verify(verificationId: verificationId),));
             setState() {
            loading=false;
          }
           } , 
           codeAutoRetrievalTimeout: (e){
                    
            Utilis().ToastMessage(e.toString());
             setState() {
            loading=false;
          }
           }, );
         }),
      ],),
    )
    );
  }
}