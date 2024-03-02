import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:todo/uiis/splash.dart';

void main()async{

  WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp(
      options: const FirebaseOptions(
        apiKey: "AIzaSyC8AV7qNM4M12MhhN9xCzEvr-KMQsv__fc",
         appId:'1:141053174852:android:5e2b4752004c8dbab10811',
         messagingSenderId:"141053174852", 
         projectId: "todo-58293",
         authDomain: 'todo-58293.todo.com',
         databaseURL: 'https://todo-58293-default-rtdb.firebaseio.com',
         storageBucket: 'todo-58293.appspot.com',
         )
    );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
   

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        appBarTheme: const AppBarTheme(
          color: Colors.deepPurple
        ),
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home:const Splash_Screen(),
    );
  }
}

