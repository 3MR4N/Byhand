import 'package:flutter/material.dart';

class dividerReusable extends StatelessWidget {
  dividerReusable({@required this.text});
  String text;
  @override
  Widget build(BuildContext context) {
    return Row(children: <Widget>[
      Expanded(
          child: Divider(
        thickness: 2.0,
      )),
      Padding(
        padding: const EdgeInsets.only(left: 20, right: 20),
        child: Text(text),
      ),
      Expanded(
          child: Divider(
        thickness: 2.0,
      )),
    ]);
  }
}
