import 'package:by_hand/models/user.dart';
import 'package:by_hand/providers/user_provider.dart';
import 'package:by_hand/utilities/translations/localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:get/get.dart';

import 'home_admin.dart';

class MyDashBoard extends StatefulWidget {
  @override
  _MyDashBoardState createState() => _MyDashBoardState();
}

class _MyDashBoardState extends State<MyDashBoard> {
  TextEditingController _email = TextEditingController();
  TextEditingController _password = TextEditingController();
  String _errorMessage = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(32.0),
                child: Text(
                  "Admin Dashboard",
                  style: TextStyle(
                      fontWeight: FontWeight.w700,
                      color: Colors.teal,
                      fontSize: 20),
                ),
              ),
              SizedBox(
                height: 40.0,
              ),
              textFieldStyle("Username", _email),
              SizedBox(
                height: 16,
              ),
              textFieldStyle("Password", _password),
              SizedBox(
                height: 32,
              ),
              signInButton(),
            ],
          ),
        ),
      ),
    );
  }

  handelLogin() {
    if (_validation()) {
      setState(() {
        _errorMessage = "";
      });
      UserProvider()
          .login(_email.text, _password.text)
          .then((Users users) async {
        if (users != null) {
           setData(users.id, users.email, _password.text, true);
          if (users.type == "admin") {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => HomeAdmin(),
                ));
          } else {
            EasyLoading.showError("You are't admin");
          }
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
          EasyLoading.showError(_errorMessage.tr);
          throw ex;
        });
      });
    }
  }

  _validation() {
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

    return true;
  }

  setData(int id, String email, String password, bool isLogin) async {
    SharedPreferences account = await SharedPreferences.getInstance();
    account.setInt('id', id);
    account.setString('email', email);
    account.setString('password', password);
    account.setBool('isLogin', isLogin);
  }

  Widget textFieldStyle(String title, TextEditingController controller) =>
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 60),
        child: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                title,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
              ),
              TextField(
                  controller: controller,
                  keyboardType: TextInputType.visiblePassword,
                  decoration: InputDecoration(
                      border: InputBorder.none,
                      fillColor: Color(0xffe8e8ea),
                      filled: true))
            ],
          ),
        ),
      );

  Widget signInButton() => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 60),
        child: SizedBox(
          width: double.infinity,
          height: 50,
          child: ElevatedButton(
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(Colors.teal),
            ),
            onPressed: () {
              handelLogin();
            },
            child: Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Text(
                "Sign in",
                style: TextStyle(
                    fontSize: 18,
                    color: Colors.black,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ),
      );
}
