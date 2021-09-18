import 'dart:io';

import 'package:by_hand/models/message.dart';
import 'package:by_hand/providers/user_provider.dart';
import 'package:by_hand/utilities/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:get/get.dart';

class EditAccount extends StatefulWidget {
  @override
  _EditAccountState createState() => _EditAccountState();
}

class _EditAccountState extends State<EditAccount> {
  void initState() {
    super.initState();
    getAccountInfoData();
  }

  getAccountInfoData() async {
    EasyLoading.show(status: "Loading".tr);
    SharedPreferences a = await SharedPreferences.getInstance();
    UserProvider().getById(a.getInt('id')).then((value) {
      EasyLoading.dismiss();
      setState(() {
        _email.text = value.email;
        _password.text = value.password;
        _fname.text = value.fname;
        _lname.text = value.lname;
        _address.text = value.address;
        _phone.text = value.phone;
      });
    }).catchError((ex) {
      EasyLoading.dismiss();
      EasyLoading.showError(ex.toString().tr);
    });
  }

  File _image2;

  TextEditingController _email = TextEditingController();
  TextEditingController _password = TextEditingController();
  TextEditingController _fname = TextEditingController();
  TextEditingController _lname = TextEditingController();
  TextEditingController _address = TextEditingController();
  TextEditingController _phone = TextEditingController();
  String _errorMessage = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: AppColors.primColor,
          title: Text('Edit Account'.tr),
          centerTitle: true,
          flexibleSpace: Container(),
        ),
        body: Container(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: _addPhotos(),
              ),
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
              Text(
                _errorMessage,
                style: TextStyle(color: Colors.red, fontSize: 16),
              ),
              SizedBox(
                height: 40,
              ),
            ],
          ),
        ),
      ),
    ));
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

  Widget _submitButton() {
    return Container(
      width: 350,
      height: 54,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: AppColors.primColor),
      child: TextButton(
        onPressed: () {
          handelEditAccount();
        },
        child: Text(
          'Submit'.tr,
          style: TextStyle(color: Colors.white, fontSize: 22),
        ),
      ),
    );
  }

  Widget _addPhotos() => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          GestureDetector(
            onTap: () {
              _showPicker2(context);
            },
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                height: 100,
                width: 100,
                decoration: BoxDecoration(
                  border: Border.all(width: 1, color: Colors.grey),
                  borderRadius: BorderRadius.circular(15),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                        color: Colors.indigo[100],
                        blurRadius: 6,
                        offset: Offset(0, 5))
                  ],
                ),
                child: _image2 != null
                    ? ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: Image.file(
                          _image2,
                          width: 100,
                          height: 100,
                          fit: BoxFit.fitWidth,
                        ),
                      )
                    : Container(
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(50)),
                        width: 100,
                        height: 100,
                        child: Icon(
                          Icons.camera_alt,
                          color: AppColors.primColor,
                        ),
                      ),
              ),
            ),
          )
        ],
      );

  handelEditAccount() async {
    if (_validation()) {
      setState(() {
        _errorMessage = "";
      });
      SharedPreferences preferences=await SharedPreferences.getInstance();
      
      UserProvider()
          .asyncFileUpload(_email.text, _password.text, _fname.text, _lname.text,
              _address.text, _phone.text,_image2,preferences.getInt('id'))
          .then((var res) async {

          Navigator.of(context).pushNamedAndRemoveUntil(
              '/home', (Route<dynamic> route) => false);


      }).catchError((ex) {
        setState(() {
          print(ex);
          _errorMessage = '2';
        });
      });
    }
  }

  Widget snackMessage(String message) => SnackBar(
        content: Text(
          '$message',
          textAlign: TextAlign.center,
        ),
      );

  _validation() {
    if (_fname.text.isEmpty) {
      setState(() {
        _errorMessage = 'fname_is_required'.tr;
      });
      return false;
    }
    if (_lname.text.isEmpty) {
      setState(() {
        _errorMessage = 'lname_is_required'.tr;
      });
      return false;
    }
    if (_email.text.isEmpty) {
      setState(() {
        _errorMessage = 'email_is_required'.tr;
      });
      return false;

    }

    if (_address.text.isEmpty) {
      setState(() {
        _errorMessage = 'address_is_required'.tr;
      });
      return false;
    }
    if (_phone.text.isEmpty) {
      setState(() {
        _errorMessage = 'phone_is_required'.tr;
      });
      return false;
    }

    return true;
  }

  _imgFromCamera2() async {
    // ignore: deprecated_member_use
    File image = (await ImagePicker.pickImage(
        source: ImageSource.camera, imageQuality: 50));

    setState(() {
      _image2 = image;
    });
  }

  _imgFromGallery2() async {
    // ignore: deprecated_member_use
    File image = (await ImagePicker.pickImage(
        source: ImageSource.gallery, imageQuality: 50));

    setState(() {
      _image2 = image;
    });
  }

  void _showPicker2(context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return SafeArea(
            child: Container(
              child: new Wrap(
                children: <Widget>[
                  new ListTile(
                      leading: new Icon(
                        Icons.photo_library,
                        color: AppColors.primColor,
                      ),
                      title: new Text('Photo Library'.tr),
                      onTap: () {
                        _imgFromGallery2();
                        Navigator.of(context).pop();
                      }),
                  new ListTile(
                    leading: new Icon(
                      Icons.photo_camera,
                      color: AppColors.primColor,
                    ),
                    title: new Text('Camera'.tr),
                    onTap: () {
                      _imgFromCamera2();
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
            ),
          );
        });
  }
}
