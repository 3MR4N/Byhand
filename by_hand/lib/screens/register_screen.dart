import 'package:by_hand/screens/login_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:by_hand/components/text_field.dart';
import 'package:by_hand/components/text_button.dart';
import 'package:by_hand/components/elevated_button.dart';
import 'package:by_hand/components/divider.dart';
import 'package:by_hand/components/icon_button.dart';

class RegisterScreen extends StatefulWidget {
  static const String id = 'register_screen';
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
String p =
    r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';

RegExp regExp = new RegExp(p);

class _RegisterScreenState extends State<RegisterScreen> {
  void validation() {
    final FormState _form = _formKey.currentState;
    if (_form.validate()) {
      print('yes');
    } else {
      print('no');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            flex: 2,
            child: Center(
              child: Container(
                child: Image.asset('assets/images/logo.png'),
              ),
            ),
          ),
          Expanded(
            flex: 5,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey,
                    offset: Offset(1.0, 0.0), //(x,y)
                    blurRadius: 6.0,
                  ),
                ],
              ),
              child: Form(
                key: _formKey,
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      textFieldReusable(
                        hint: 'Full user name',
                        isPassword: false,
                        validator: (value) {
                          if (value == "") {
                            return "Please fill User name";
                          } else if (value.length < 6) {
                            return 'user name is short';
                          }
                          return "";
                        },
                      ),
                      textFieldReusable(
                        hint: 'Email Address',
                        isPassword: false,
                        validator: (value) {
                          if (value == "") {
                            return "Please fill Email Address";
                          } else if (!regExp.hasMatch(value)) {
                            return 'Email is invalid';
                          }
                          return "";
                        },
                      ),
                      textFieldReusable(
                        hint: 'password',
                        isPassword: true,
                        validator: (value) {
                          if (value == "") {
                            return "Please fill password";
                          } else if (value.length < 8) {
                            return 'password is short';
                          }
                          return "";
                        },
                      ),
                      textFieldReusable(
                        hint: 'Phone number',
                        isPassword: false,
                        validator: (value) {
                          if (value == "") {
                            return "Please fill phone number";
                          } else if (value.length != 10) {
                            return 'phone number must be 10';
                          }
                          return "";
                        },
                      ),
                      ElevatedButtonReusable(
                          onPressed: () {
                            validation();
                          },
                          text: 'REGISTER',
                          size: 15,
                          color: Colors.blueAccent,
                          textColor: Colors.white),
                      Center(
                          child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text('You have an account?'),
                      )),
                      Center(
                          child: textButtonReusable(
                              onPressed: () {
                                Navigator.pushNamed(context, LoginScreen.id);
                              },
                              text: 'Login')),
                      dividerReusable(
                        text: 'OR Register with',
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          iconButtonReusable(
                            image: Image.asset('assets/images/google_icon.png'),
                          ),
                          iconButtonReusable(
                              image: Image.asset('assets/images/facebook.png')),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
