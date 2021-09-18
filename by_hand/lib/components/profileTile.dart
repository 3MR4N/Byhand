import 'package:flutter/material.dart';

class listTileReusable extends StatelessWidget {
  final Icon icon;
  final String text;
  final Function ontap;
  listTileReusable(
      {@required this.icon, @required this.text, @required this.ontap});
  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: icon,
      title: Text(text),
      trailing: Icon(Icons.arrow_forward_ios),
      onTap: ontap,
    );
  }
}
