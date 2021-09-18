import 'dart:io';
import 'package:by_hand/admin_dashboard/category_admin.dart';
import 'package:by_hand/admin_dashboard/home_admin.dart';
import 'package:by_hand/providers/category_provider.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';

class AddCategory extends StatefulWidget {
  @override
  _AddCategoryState createState() => _AddCategoryState();
}

class _AddCategoryState extends State<AddCategory> {
  void initState() {
    super.initState();
  }

  File _image2;

  TextEditingController name = TextEditingController();

  String _errorMessage = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.teal,
          title: Text("Add Category",style: TextStyle(fontWeight: FontWeight.w700,color: Colors.white,fontSize: 20),),
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
        _entryField("name".tr, name),

      ],
    );
  }

  Widget _submitButton() {
    return Container(
      width: 350,
      height: 54,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: Colors.teal),
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
                color: Colors.teal,
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

      CategoriesProvisers()
          .asyncFileUpload(name.text,_image2)
          .then((var res) async {


      }).catchError((ex) {
        setState(() {
          print(ex);
          _errorMessage = '2';
        });
      });
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomeAdmin(),));
    }
  }

  Widget snackMessage(String message) => SnackBar(
    content: Text(
      '$message',
      textAlign: TextAlign.center,
    ),
  );

  _validation() {
    if (name.text.isEmpty) {
      setState(() {
        _errorMessage = 'fname_is_required'.tr;
        EasyLoading.showError(_errorMessage);

      });
      return false;
    }
    if (_image2==null) {
      setState(() {
        _errorMessage = 'image_is_required'.tr;
        EasyLoading.showError(_errorMessage);
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
                        color: Colors.teal,
                      ),
                      title: new Text('Photo Library'.tr),
                      onTap: () {
                        _imgFromGallery2();
                        Navigator.of(context).pop();
                      }),
                  new ListTile(
                    leading: new Icon(
                      Icons.photo_camera,
                      color: Colors.teal,
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
