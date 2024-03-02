// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:todo/uiis/singup.dart';

class RoundButton extends StatefulWidget {
  final String write;
  final VoidCallback? Pressed;
  bool loading;

  RoundButton({Key? key, required this.write, this.loading=false , required this.Pressed}) : super(key: key);

  @override
  State<RoundButton> createState() => _RoundButtonState();
}

class _RoundButtonState extends State<RoundButton> {
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return InkWell(
      onTap: widget.Pressed, // Use widget.Pressed to invoke the callback
      child: Container(
        height: height * 0.07,
        width: width * 0.7,
        decoration: BoxDecoration(
          color: Colors.deepPurple,
          borderRadius: BorderRadius.circular(15),
        ),
        child: Center(
          child: loading? const CircularProgressIndicator(color: Colors.white,): Text(widget.write, style: const TextStyle(fontSize: 17,color: Colors.white)),
        ),
      ),
    );
  }
}
