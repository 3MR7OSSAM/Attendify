import 'package:flutter/material.dart';
class MyDropdown extends StatefulWidget {
  const MyDropdown({Key? key, required this.onChanged, required this.dropdownValue}) : super(key: key);
  final ValueChanged<String?> onChanged;
  final String dropdownValue;
  @override
  _MyDropdownState createState() => _MyDropdownState();


}

class _MyDropdownState extends State<MyDropdown> {
//  String dropdownValue = "الكود";

  @override
  Widget build(BuildContext context) {

    return DropdownButton<String>(
      underline: Container(),
      dropdownColor:
      Theme.of(context).scaffoldBackgroundColor,
      focusColor:
      Theme.of(context).scaffoldBackgroundColor,
      value: widget.dropdownValue,
      onChanged: widget.onChanged,
      items: <String>[
        "الكود",
        "الاسم",
        "رقم الهاتف",
      ].map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value,style: const TextStyle(fontSize: 16),),
        );
      }).toList(),
    );
  }
}

