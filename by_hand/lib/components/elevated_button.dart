import 'package:flutter/material.dart';

class ElevatedButtonReusable extends StatelessWidget {
  final String text;
  final Function onPressed;
  final double size;
  final Color color;
  final Color textColor;
  ElevatedButtonReusable({
    @required this.onPressed,
    @required this.text,
    @required this.size,
    @required this.color,
    @required this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        height: 60.0,
        width: 120,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: ElevatedButton(
            onPressed: onPressed,
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all<Color>(color),
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18.0),
                ),
              ),
            ),
            child: Text(
              text,
              style: TextStyle(fontSize: size, color: textColor),
            ),
          ),
        ),
      ),
    );
  }
}
