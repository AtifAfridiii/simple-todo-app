

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:todo/Phone%20number/phonenum.dart';
import 'package:todo/forgot%20passoward/forgotpassoward.dart';
import 'package:todo/postScreen/postscreen.dart';
import 'package:todo/uiis/singup.dart';
import 'package:todo/utilis/roundbutton.dart';
import 'package:todo/utilis/toastmessage.dart';

class Log_In  extends StatefulWidget {
  const Log_In({super.key});

  @override
  State<Log_In> createState() => _Log_InState();
}
final _formkey =GlobalKey<FormState>();
final emailController = TextEditingController();
final passowardController = TextEditingController();
final auth= FirebaseAuth.instance;
 bool loading=false ;

class _Log_InState extends State<Log_In> {

  @override
  Widget build(BuildContext context) {
final height = MediaQuery.of(context).size.height;

    return Scaffold(
      
    appBar: AppBar(title:const Center(child: Text('Log in ',style: TextStyle(color: Colors.white),)),
    automaticallyImplyLeading: false,
    ),
    
    body: Padding(
      padding:  EdgeInsets.symmetric(vertical: 11, horizontal: 9),
      child: Column(
       
        children: [
        
          Form(
            key: _formkey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                 TextFormField(
                  controller: emailController,
                  keyboardType: TextInputType.emailAddress,
                  
                  decoration: InputDecoration(
                     hintFadeDuration: const Duration(seconds: 3),
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
                  ),validator:(value){
            if(value!.isEmpty){
              return 'Enter your e-mail';
              }
              return null ;}
                  
                 ),
                 SizedBox(height: height*0.03,),
          
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
                  ), validator:(value){
            if(value!.isEmpty){
              return 'Enter your Passoward';
              }
              return null;}
                  
                 ),
                 SizedBox(height: height*0.02,),
               
               Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                   const Text("Don't have an account?"),
                
                  TextButton(onPressed: (){
                 Navigator.push(context, MaterialPageRoute(builder: (context) => Signup(),));
                 }, child: const Text('Sign up', style: TextStyle(color: Colors.deepPurple,fontSize: 15),)),
                ],
               ),
               SizedBox(height: height*0.01,),
               RoundButton(write: 'Login',loading: loading,Pressed: (){
                if(_formkey.currentState!.validate()){
            setState(() {
                    loading=true;
                  });
                auth.signInWithEmailAndPassword(email: emailController.text, password: passowardController.text).then((value){
          
                  Utilis().ToastMessage(value.toString());
                   setState(() {
                    loading=true;
                  });
                   Navigator.push(context, MaterialPageRoute(builder: (context) => Post_Screen(),));
                }).onError((error, stackTrace) {
                   setState(() {
                    loading=true;
                  });
           Utilis().ToastMessage(error.toString());
                });
              
            }
                
                         }),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                             TextButton(
                              onPressed: (){
                               Navigator.push(context, MaterialPageRoute(builder: (context)=>Forgot_Passoward()));
                             }, child: const Text('Forgot passoward?',style: TextStyle(fontWeight: FontWeight.bold,decoration: TextDecoration.underline,decorationThickness: 2,decorationColor: Colors.deepPurple),)),
                          ],
                         ),
            
               SizedBox(height: height*0.02,) ,
          
               InkWell(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context) => Phone_Sign(),));
                },
                 child: Container(
                  height: 50,
                  width: 251,
                  decoration: BoxDecoration(
                    border: Border.all(),
                   borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Center(child: Text('Sign up with phone number'),),
                 ),
               )         
              ],
            ),
          ),
        ],
      ),
    ),
       
    );
  }
}