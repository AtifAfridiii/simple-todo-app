import 'package:flutter/material.dart';
import 'package:todo/postScreen/postscreen.dart';
import 'package:todo/uiis/login.dart';
import 'package:todo/utilis/roundbutton.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:todo/utilis/toastmessage.dart';



class Signup extends StatefulWidget {

  @override
  State<Signup> createState() => _SignupState();
}

final emailController = TextEditingController();
final passowardController = TextEditingController();
final auth = FirebaseAuth.instance;
bool loading = false;
class _SignupState extends State<Signup> {

@override
  Widget build(BuildContext context) {
final height = MediaQuery.of(context).size.height;

    return Scaffold(
    appBar: AppBar(title:const Center(child: Text('Sign up',style: TextStyle(color: Colors.white),)),
    automaticallyImplyLeading: true,
    ),

    body: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 11),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
           TextFormField(
            controller: emailController,
            keyboardType: TextInputType.emailAddress,
            
            decoration: InputDecoration(
              hintText: 'Email',
              focusColor: Colors.pink.shade500,
              enabled: true,
              labelText: 'Email',
              prefixIconColor: Colors.black,
              prefixIcon: const Icon(Icons.attach_email_rounded),
              enabledBorder: const OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(50)),
              ),
              focusedBorder:const OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(50))
              )
            ),
            
           ),
           SizedBox(height: height*0.05,),

           TextFormField(
            controller: passowardController,
            keyboardType: TextInputType.visiblePassword,
            obscureText: true,
            decoration: InputDecoration(
              hintFadeDuration: const Duration(seconds: 3),
              hintText: 'Passoward',
              focusColor: Colors.pink.shade500,
              enabled: true,
             labelText: 'Passoward',
              prefixIconColor: Colors.black,
              prefixIcon:const Icon(Icons.password_rounded),
              suffixIcon: const Icon(Icons.visibility_off_outlined),
              enabledBorder: const OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(50)),
              ),
              focusedBorder:const OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(50))
              )
            ),
            
           ),
           SizedBox(height: height*0.03,),
         
         Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
             const Text("Already have an account?"),
             TextButton(onPressed: (){
 Navigator.push(context, MaterialPageRoute(builder: (context) =>const Log_In(),));
          }, child: const Text('Log in', style: TextStyle(color: Colors.deepPurple,fontSize: 15),)),
          ],
         ),
         SizedBox(height: height*0.01,),
         RoundButton(write: 'Signup',loading: loading ,Pressed: (){
          setState(() {
            loading=true;
          });
          auth.createUserWithEmailAndPassword(email: emailController.text, password: passowardController.text).then((value) {
               const Text('user Created');
          Navigator.push(context, MaterialPageRoute(builder: (context) => const Post_Screen(),));
                setState(() {
            loading=false;
         Utilis().ToastMessage(value.user!.email.toString())  ; 
          });
          }).onError((error, stackTrace) {
            Utilis().ToastMessage(error.toString());
             setState(() {
            loading=false;
          });
           Text(error.toString());
          });
         
         }),
        ],
      ),
    )
    );
  }

 }