import 'package:by_hand/admin_dashboard/dashboard.dart';
import 'package:by_hand/components/bezier_contaniner.dart';
import 'package:by_hand/models/user.dart';
import 'package:by_hand/providers/user_provider.dart';
import 'package:by_hand/utilities/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:get/get.dart';

class LoginPage extends StatefulWidget {


  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController _email=TextEditingController();
  TextEditingController _password=TextEditingController();
  String _errorMessage='';

  Widget _entryField(String title,TextEditingController controller, {bool isPassword = false}) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            title,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
          ),
          SizedBox(
            height: 10,
          ),
          TextField(
              keyboardType: TextInputType.visiblePassword,
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
         handelLogin();
        },
        child: Text(
          'Login'.tr,
          style: TextStyle(color: Colors.white, fontSize: 22),
        ),
      ),
    );
  }



  Widget _createAccountLabel() {
    return InkWell(
      onTap: () {
        Navigator.pushNamed(context, '/register');
      },
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 20),
        padding: EdgeInsets.all(15),
        alignment: Alignment.bottomCenter,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Don\'t have an account ?'.tr,
              style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
            ),
            SizedBox(
              width: 10,
            ),
            Text(
              'Register'.tr,
              style: TextStyle(
                  color: AppColors.primColor,
                  fontSize: 13,
                  fontWeight: FontWeight.w600),
            ),
          ],
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
            fontFamily: 'GrandHotel',
            fontSize: 30,
            fontWeight: FontWeight.w700,
            color: AppColors.primColor,
          ),
          children: [
            TextSpan(
              text: 'hand',
              style: TextStyle(color: Colors.black, fontSize: 30,
                  fontFamily: 'GrandHotel'),
            ),
          ]),
    );
  }

  Widget _emailPasswordWidget() {
    return Column(
      children: <Widget>[
        _entryField("Email".tr,_email),
        _entryField("Password".tr,_password, isPassword: true),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
        body: SingleChildScrollView(
          child: Container(
            height: height,
            child: Stack(
              children: <Widget>[
                Positioned(
                    top: -height * .15,
                    right: -MediaQuery.of(context).size.width * .4,
                    child: BezierContainer()),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        SizedBox(height: height * .2),
                        _title(),
                        SizedBox(height: 50),
                        _emailPasswordWidget(),
                        SizedBox(height: 20),
                        _submitButton(),
                        SizedBox(height: height * .055),
                        _createAccountLabel(),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      IconButton(icon: Icon(Icons.admin_panel_settings,color: Colors.teal,size: 40,), onPressed: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context) => MyDashBoard(),));

                      }),
                    ],
                  ),
                )
              ],
            ),
          ),
        ));
  }

  handelLogin(){
    if (_validation()) {
      setState(() {
        _errorMessage = "";
      });
       UserProvider()
          .login(_email.text, _password.text)
          .then((Users users) async {
        if (users != null) {

         await setData(users.id, users.email,
              _password.text, true);

          Navigator.popAndPushNamed(context, '/home');
        } else {
          setState(() {
            _errorMessage = 'try_again'.tr;
            EasyLoading.showError(_errorMessage);
          });
        }
      }).catchError((ex) {
        setState(() {
          print(ex);
          _errorMessage = ex;
          EasyLoading.showError(_errorMessage.tr);
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


}