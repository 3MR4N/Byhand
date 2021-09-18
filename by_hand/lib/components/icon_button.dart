import 'package:flutter/material.dart';

class iconButtonReusable extends StatelessWidget {
  iconButtonReusable({@required this.image});
  Image image;
  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: image,
      iconSize: 50,
      onPressed: () {},
    );
  }
}
