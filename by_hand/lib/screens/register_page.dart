import 'package:by_hand/components/bezier_contaniner.dart';
import 'package:by_hand/models/message.dart';
import 'package:by_hand/providers/user_provider.dart';
import 'package:by_hand/utilities/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';

class SignUpPage extends StatefulWidget {
  SignUpPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  TextEditingController _email = TextEditingController();
  TextEditingController _password = TextEditingController();
  TextEditingController _fname = TextEditingController();
  TextEditingController _lname = TextEditingController();
  TextEditingController _address = TextEditingController();
  TextEditingController _phone = TextEditingController();
  String _errorMessage = '';

  Widget _backButton() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: InkWell(
        onTap: () {
          Navigator.pop(context);
        },
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 10),
          decoration: BoxDecoration(
            color: AppColors.primColor,
            borderRadius: BorderRadius.circular(16.0)
          ),

          child: Row(
            children: <Widget>[
              Container(
                padding: EdgeInsets.only(left: 0, top: 10, bottom: 10),
                child: Icon(Icons.keyboard_arrow_left, color: Colors.white),
              ),
              Text('Back'.tr,
                  style: TextStyle(fontSize: 12, fontWeight: FontWeight.w900,color: Colors.white))
            ],
          ),
        ),
      ),
    );
  }

  Widget _entryField(String title, TextEditingController controller,
      {bool isPassword = false}) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: [
              Text(
                title,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
              ),
              Text(
                '*',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                    color: Colors.red),
              ),
            ],
          ),
          SizedBox(
            height: 10,
          ),
          TextField(
              controller: controller,
              obscureText: isPassword,
              decoration: InputDecoration(
                  border: InputBorder.none,
                  fillColor: Color(0xfff3f3f4),
                  filled: true))
        ],
      ),
    );
  }

  Widget _submitButton() {
    return Container(
      width: 350,
      height: 54,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: AppColors.primColor),
      child: TextButton(
        onPressed: () {
          handelSignIn();
        },
        child: Text(
          'Register'.tr,
          style: TextStyle(color: Colors.white, fontSize: 22),
        ),
      ),
    );
  }

  Widget _title() {
    return RichText(
      textAlign: TextAlign.center,
      text: TextSpan(
          text: 'By',
          style: TextStyle(
            fontSize: 30,
            fontFamily: 'GrandHotel',
            fontWeight: FontWeight.w700,
            color: AppColors.primColor,
          ),
          children: [
            TextSpan(
              text: 'hand',
              style: TextStyle(
                  color: Colors.black, fontSize: 30, fontFamily: 'GrandHotel'),
            ),
          ]),
    );
  }

  Widget _emailPasswordWidget() {
    return Column(
      children: <Widget>[
        _entryField("First name".tr, _fname),
        _entryField("Last name".tr, _lname),
        _entryField("Email".tr, _email),
        _entryField("Password".tr, _password, isPassword: true),
        _entryField("Address".tr, _address),
        _entryField("Phone".tr, _phone),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Container(
        height: height,
        child: Stack(
          children: <Widget>[
            Positioned(
              top: -MediaQuery.of(context).size.height * .15,
              right: -MediaQuery.of(context).size.width * .4,
              child: BezierContainer(),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(height: height * .2),
                    _title(),
                    SizedBox(
                      height: 50,
                    ),
                    _emailPasswordWidget(),
                    SizedBox(
                      height: 20,
                    ),
                    _submitButton(),
                    SizedBox(
                      height: 40,
                    ),

                  ],
                ),
              ),
            ),
            Positioned(top: 40, left: 0, child: _backButton()),
          ],
        ),
      ),
    );
  }

  handelSignIn() {
    if (_validation()) {
      setState(() {
        _errorMessage = "";
      });
      UserProvider()
          .signIn(_email.text, _password.text, _fname.text, _lname.text,
              _address.text, _phone.text)
          .then((var res) async {
        if (res != null) {
          Message message = Message.fromJson(res);

          Navigator.of(context).pushNamedAndRemoveUntil(
              '/login', (Route<dynamic> route) => false);
          ScaffoldMessenger.of(context)
              .showSnackBar(snackMessage(message.message));
        } else {
          setState(() {
            _errorMessage = 'try_again'.tr;
            EasyLoading.showError(_errorMessage);

          });
        }
      }).catchError((ex) {
        setState(() {
          print(ex);
          _errorMessage = ex.toString();
          EasyLoading.showError("Please enter a valid email address");

        });
      });
    }
  }

  _validation() {
    if (_fname.text.isEmpty) {
      setState(() {
        _errorMessage = 'fname_is_required'.tr;
        EasyLoading.showError(_errorMessage);

      });
      return false;
    }
    if (_lname.text.isEmpty) {
      setState(() {
        _errorMessage = 'lname_is_required'.tr;
        EasyLoading.showError(_errorMessage);

      });
      return false;
    }
    if (_email.text.isEmpty) {
      setState(() {
        _errorMessage = 'email_is_required'.tr;
        EasyLoading.showError(_errorMessage);

      });
      return false;
    }
    if (_password.text.isEmpty) {
      setState(() {
        _errorMessage = 'password_is_required'.tr;
        EasyLoading.showError(_errorMessage);

      });
      return false;
    }

    if (_address.text.isEmpty) {
      setState(() {
        _errorMessage = 'address_is_required'.tr;
        EasyLoading.showError(_errorMessage);

      });
      return false;
    }
    if (_phone.text.isEmpty) {
      setState(() {
        _errorMessage = 'phone_is_required'.tr;
        EasyLoading.showError(_errorMessage);

      });
      return false;
    }

    return true;
  }

  Widget snackMessage(String message) => SnackBar(
        content: Text(
          '$message'.tr,
          textAlign: TextAlign.center,
        ),
      );
}
