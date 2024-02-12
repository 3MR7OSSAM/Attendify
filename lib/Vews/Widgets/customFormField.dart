import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomFormField extends StatelessWidget {
  const CustomFormField({Key? key, required this.controller, required this.onChanged, required this.hintText, this.validator, required this.obscureText, this.isCenterHint, required this.isNumber})
      : super(key: key);
  final bool obscureText;
  final bool isNumber;
  final FormFieldValidator<String>? validator;
  final TextEditingController controller;
  final Function(String)? onChanged;
  final String hintText;
  final bool? isCenterHint;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black12.withOpacity(0.03),
      child: TextFormField(
        autofocus: false,
        keyboardType: isNumber ?TextInputType.number : TextInputType.text,
        inputFormatters:  isNumber ? <TextInputFormatter>[
          FilteringTextInputFormatter.digitsOnly,
        ]:null,
        validator: validator,
        obscureText: obscureText,
      //  cursorColor: Colors.black87.withOpacity(0.4),
        style: const TextStyle(
          color: Colors.black54,
          //fontWeight: FontWeight.bold,
        ),
        controller: controller,
        onChanged: onChanged,
        textAlign: TextAlign.right,
        decoration: InputDecoration(
          hintText: hintText,
          hintTextDirection:TextDirection.ltr ,
          hintStyle: const TextStyle(
            fontSize: 18,
            color: Colors.black54,
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(
              width: 3,
              color: Colors.white,
            ),
            borderRadius: BorderRadius.circular(10.0),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(
              width: 3,
              color: Colors.white, // Change the color to what you want on focus.
            ),
            borderRadius: BorderRadius.circular(10.0),
          ),
          // Add focusColor to change the cursor color when focused.
          // You can change it to any color you like.
          focusColor: Colors.white,
        ),
      ),
    );
  }
}
