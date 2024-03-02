

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:todo/postScreen/postscreen.dart';
import 'package:todo/utilis/roundbutton.dart';
import 'package:todo/utilis/toastmessage.dart';


class Verify extends StatefulWidget {

  final String verificationId;
  const Verify({super.key,required this.verificationId});

  @override
  State<Verify> createState() => _VerifyState();
}

class _VerifyState extends State<Verify> {
final contro = TextEditingController();
bool loading=false;
final auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {

    return Scaffold(
    appBar: AppBar(title: const Text('Verify')),

    body:Column(
      children: [
       const  SizedBox(height: 11,),
        TextFormField(
          keyboardType: TextInputType.number,
          controller:contro ,
          decoration: InputDecoration(
             hintFadeDuration: const Duration(seconds: 3),
            hintText: 'Enter 6 digits code',
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            border : OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
            ),

          ),
          
         ),
         const SizedBox(height: 31,),
         RoundButton(write: 'Signup',loading: loading ,Pressed: ()async{
          setState(() {
            loading=true;
          });
          final Credential=PhoneAuthProvider.credential(
            verificationId: widget.verificationId, 
          smsCode: contro.text.toString());
          setState(() {
            loading=false;
          });
           try{
            
      await  auth.signInWithCredential(Credential);
        Navigator.push(context, MaterialPageRoute(builder: (context) => Post_Screen(),));
         setState(() {
            loading=false;
          });
       }catch(e){
         setState(() {
            loading=false;
          });
       Utilis().ToastMessage(e.toString());
     }
         }),

      ],
    )
    );
  }
}