import 'package:flutter/material.dart';

class CustomElevatedButton extends StatelessWidget {
  final Function onPress;
  final String text;
  const CustomElevatedButton({
    Key? key,
    required this.onPress,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.all(20),
      child: ElevatedButton.icon(
        onPressed: () => onPress(),
        icon: Icon(
          Icons.forward,
          color: Colors.white,
        ),
        label: Text(
          text,
          style: TextStyle(color: Colors.white),
        ),
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.blue,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
            side: BorderSide(color: Colors.blue),
          ),
        ),
      ),
    );
  }
}