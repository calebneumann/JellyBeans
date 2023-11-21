//To call FnafWidget, do
//FnafWidget()

import 'package:flutter/material.dart';

class FnafWidget extends StatelessWidget {
  const FnafWidget({Key? key, required this.rand}) : super(key: key);

  final String rand;

  Widget playFNAF() {
    return Image.asset(
      rand,
      height: 650.0,
      width: 500.0,
      fit: BoxFit.cover,
      alignment: Alignment.center,
    );
  }

  @override
  Widget build(BuildContext context) {
    return playFNAF();
  }
}
