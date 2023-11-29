//when you call TextWidget and don't want all text to be the same size,
//add or subtract the passed value from userSettings.getFontSize
//to increase or decrease the size and it will still be scaled as needed

//The TextWidget also uses FittedBox() to prevent the text from
//clipping outside the boundries of the screen in the event the
//text is too big to fit the screen; it simply won't increase in size
// to stay in the boundries

//to call TextWidget: import 'textWidget.dart' and call
//TextWidget(text: "The string of text", fontSize: userSettings.getFontSize)

import 'package:flutter/material.dart';
import '../../models/UserSettings.dart';

UserSettings userSettings = UserSettings(1);

class TextWidget extends StatelessWidget {
  const TextWidget({
    Key? key,
    required this.text,
    required this.multiplier,
  }) : super(key: key);

  final String text;
  final double multiplier;

  Widget outputText() {
    return Text(
        text,
        style: TextStyle(fontSize: UserSettings.getFontSize() * multiplier),
        overflow: TextOverflow.ellipsis,
        softWrap: true,
    );
  }

  @override
  Widget build(BuildContext context) {
    return outputText();
  }
}
