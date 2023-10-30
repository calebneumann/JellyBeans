//To call FnafWidget, do
//FnafWidget()


import 'package:flutter/material.dart';


class FnafWidget extends StatelessWidget{

  Widget playFNAF(){
    return Image.asset(
      "assets/images/BONNIE.gif",
      height: 650.0,
      width: 500.0,
      fit: BoxFit.cover,
      alignment: Alignment.center,   
    );
  }

  @override
  Widget build(BuildContext context){
    return playFNAF();
  }

}
