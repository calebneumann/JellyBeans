//To call DropDownWidget, do
//DropDownWidget(fontSize: userSettings.getFontSize);

import 'package:flutter/material.dart';


//list of themes in dropdown menu
List<String> themes = <String>["Light Mode", "Dark Mode", "Colorblind Mode", "Custom"];
String dropDownValue = themes.first;

bool h = false;


class DropDownWidget extends StatefulWidget{

  final double fontSize;
  DropDownWidget({Key? key, required this.fontSize}) : super(key: key);
  
  @override
  State<DropDownWidget> createState() => _DropDownWidgetState();
}



class _DropDownWidgetState extends State<DropDownWidget> {


  Widget dropdownMenu(){
    
    return Padding(
      padding: EdgeInsets.all(20),
      child: DropdownMenu(
        initialSelection: dropDownValue, 
        enableSearch: false,
        width: 200,
        onSelected: (String? value){
          setState(() {
            dropDownValue = value!;
          });
        },
        textStyle: TextStyle(fontSize: widget.fontSize - 5.0),
        dropdownMenuEntries: themes.map<DropdownMenuEntry<String>>((String value){
          return DropdownMenuEntry<String>(value: value, label: value);
        }).toList(),
      )
    );
  }

  @override
  Widget build(BuildContext context){
    return dropdownMenu();
  }
}

