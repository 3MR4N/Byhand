import 'package:flutter/material.dart';

class textFieldReusable extends StatelessWidget {
  textFieldReusable(
      {@required this.hint, @required this.isPassword, this.validator});
  final String hint;
  final bool isPassword;
  final Function validator;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Material(
        borderRadius: BorderRadius.circular(20),
        elevation: 5,
        child: TextFormField(
          validator: validator,
          decoration: InputDecoration(
            hintText: hint,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(20.0),
              ),
            ),
          ),
          keyboardType: isPassword == true
              ? TextInputType.text
              : TextInputType.emailAddress,
          obscureText: isPassword,
        ),
      ),
    );
  }
}
