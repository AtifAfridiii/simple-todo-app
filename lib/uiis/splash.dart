// ignore_for_file: camel_case_types
import 'package:flutter/material.dart';
import 'package:todo/splashservices/splashservices.dart';

//import 'package:animations/animations.dart';

class Splash_Screen extends StatefulWidget {
  const Splash_Screen({super.key});


  @override
  State<Splash_Screen> createState() => _Splash_ScreenState();


}



class _Splash_ScreenState extends State<Splash_Screen> {

 @override
  void initState() {
    super.initState();
    SplashServices().islogin(context);
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
    body: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children:<Widget> [
        Center(child: Image.network('https://static.vecteezy.com/system/resources/previews/010/925/944/original/colorful-welcome-design-template-free-vector.jpg'),),
    
     
      ],
    )
    );
  }
}