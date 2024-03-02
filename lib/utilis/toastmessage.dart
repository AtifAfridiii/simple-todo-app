
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Utilis {

void ToastMessage(String Message){

Fluttertoast.showToast(
    msg: Message,
    toastLength: Toast.LENGTH_SHORT,
    gravity: ToastGravity.BOTTOM_RIGHT,
    timeInSecForIosWeb: 1,
    backgroundColor: Colors.deepPurple,
    textColor: Colors.white,
    fontSize: 16.0
    );
}

}