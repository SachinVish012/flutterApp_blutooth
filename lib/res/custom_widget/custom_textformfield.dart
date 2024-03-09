import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  final TextEditingController controller;
  final String lebelText;

  const CustomTextFormField({
    Key? key,
    required this.controller,
    required this.lebelText
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 60,
      child: TextField(
        maxLines: null,
        expands: true,
        controller: controller,
        readOnly: true,
        decoration: InputDecoration(
          labelText: lebelText,
          contentPadding: EdgeInsets.only(left: 15,bottom: 5),
          border: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.blue), // Border color
            borderRadius: BorderRadius.circular(10.0),
          ),
          filled: true,
          fillColor: Colors.grey[200],
        ),
      ),
    );
  }
}