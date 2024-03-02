import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:todo/utilis/roundbutton.dart';
import 'package:todo/utilis/toastmessage.dart';


class Forgot_Passoward extends StatefulWidget {

  @override
  State<Forgot_Passoward> createState() => _Forgot_PassowardState();
}
final controller = TextEditingController();
final auth = FirebaseAuth.instance;

class _Forgot_PassowardState extends State<Forgot_Passoward> {
  @override
  Widget build(BuildContext context) {

    return Scaffold(
    appBar: AppBar(title: const Text('Forgot passoward'),centerTitle: true,),

    body:Column(
      children: [
        const Gap(35),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 11),
          child: TextFormField(
            controller: controller,
            decoration: InputDecoration(
              hintText: 'Email',
              focusColor: Colors.pink,
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(51),
               borderSide: BorderSide(
                color: Colors.pink,

               ),
              ),
              prefixIcon: Icon(Icons.email),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(51),
                 borderSide: BorderSide(
                color: Colors.deepPurple,
                
               ),
              ),
              hintFadeDuration: const Duration(seconds: 3),
              
            ),
          ),
          
        ),
       const Gap(21),
       RoundButton(write: 'Forgot', Pressed: (){
        auth.sendPasswordResetEmail(email: controller.text.toString()).then((value) {
             Utilis().ToastMessage('We sent Email to ${controller.text.toString()}');
        }).onError((error, stackTrace){
              Utilis().ToastMessage(error.toString());
        });
       })
      ],
    )
    );
  }
}