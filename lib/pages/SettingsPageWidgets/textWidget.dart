import 'package:flutter/material.dart';


class TextWidget extends StatelessWidget{
  const TextWidget({
    Key? key,
    required this.text,
    required this.fontSize,
  }) : super(key: key);

  final String text;
  final double fontSize;


  Widget outputText(){
    return Text(
      text,
      style: TextStyle(fontSize: fontSize),
    );
  }

  @override
  Widget build(BuildContext context){
    return outputText();
  }

}