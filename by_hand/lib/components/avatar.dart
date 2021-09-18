import 'package:flutter/material.dart';

class avatarReusable extends StatelessWidget {
  final String image;
  final double radius;

  const avatarReusable({this.image, this.radius});
  @override
  Widget build(BuildContext context) {
    return Container(
      child: CircleAvatar(
        radius: radius,
        backgroundImage: NetworkImage(image),
      ),
    );
  }
}
