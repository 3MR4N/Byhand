import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class heartButtonReusable extends StatelessWidget {
  heartButtonReusable({@required this.onPressed});
  final Function onPressed;
  @override
  Widget build(BuildContext context) {
    return IconButton(
      iconSize: 40,
      onPressed: onPressed,
      icon: Icon(CupertinoIcons.heart),
    );
  }
}
