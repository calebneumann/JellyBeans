import 'package:flutter/material.dart';



//list of themes in dropdown menu
List<String> themes = <String>["Light Mode", "Dark Mode", "Colorblind Mode", "Custom", "Secret debugging suprise :)"];


class DropDownWidget extends StatefulWidget{
  @override
  State<DropDownWidget> createState() => _DropDownWidgetState();
}



class _DropDownWidgetState extends State<DropDownWidget> {
  String dropDownValue = themes.first;

  Widget dropdownMenu(){
    return DropdownMenu(
          initialSelection: themes.first, 
          onSelected: (String? value){
            setState(() {
              dropDownValue = value!;
            });
          },
          dropdownMenuEntries: themes.map<DropdownMenuEntry<String>>((String value){
            return DropdownMenuEntry<String>(value: value, label: value);
          }).toList(),
    );
  }

  @override
  Widget build(BuildContext context){
    return dropdownMenu();
  }
}

