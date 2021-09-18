import 'package:flutter/material.dart';

class textButtonReusable extends StatelessWidget {
  textButtonReusable({
    @required this.onPressed,
    @required this.text,
  });
  final Function onPressed;
  final String text;
  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      child: Text(
        text,
        style: TextStyle(color: Colors.orange),
      ),
    );
  }
}
