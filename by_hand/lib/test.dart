import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';

int main(){
  runApp(MaterialApp(home: InfoTemp1(),));
}

class InfoTemp1 extends StatefulWidget {
  @override
  _InfoTemp1State createState() => _InfoTemp1State();
}

class _InfoTemp1State extends State<InfoTemp1> {
  final _formKey = GlobalKey<FormState>();
  List<double> rating =List<double>(3);
  File _image;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          // ignore: deprecated_member_use
          autovalidate: false,
          child: Container(
            margin: EdgeInsets.fromLTRB(16.0, 0, 16.0, 16.0),
            child: Column(
              children: <Widget>[
                SizedBox(
                  height: 70,
                ),

                //This Widget to add photo
                Center(
                    child: GestureDetector(
                      onTap: () {
                        _showPicker(context);
                      },
                      child: CircleAvatar(
                        radius: 55,
                        backgroundColor:Color(0xffB76E79),
                        child: _image != null
                            ? ClipRRect(
                          borderRadius: BorderRadius.circular(50),
                          child: Image.file(
                            _image,
                            width: 100,
                            height: 100,
                            fit: BoxFit.fitWidth,
                          ),
                        )
                            : Container(
                          decoration: BoxDecoration(
                              color:Colors.white,
                              borderRadius: BorderRadius.circular(50)),
                          width: 100,
                          height: 100,
                          child: Icon(
                            Icons.camera_alt,
                            color: Color(0xffB76E79),
                          ),
                        ),
                      ),
                    )),

                SmoothStarRating(
                  color: Color(0xffB76E79),
                  borderColor: Color(0xffB76E79),
                  rating: 0,
                  isReadOnly: false,
                  size: 20,
                  filledIconData: Icons.star,
                  halfFilledIconData: Icons.star_half,
                  defaultIconData: Icons.star_border,
                  starCount: 5,
                  allowHalfRating: true,
                  spacing:0,
                  onRated: (value) {
                    rating[2]=value;

                    // print("rating value dd -> ${value.truncate()}");
                  },
                ),



              ],
            ),
          ),
        ),
      ),
    );
  }


  //Methods add photo from gallery
  _imgFromCamera() async {
    // ignore: deprecated_member_use
    File image = (await ImagePicker.pickImage(
        source: ImageSource.camera, imageQuality: 50));

    setState(() {
      _image = image;
    });
  }

  _imgFromGallery() async {
    // ignore: deprecated_member_use
    File image = (await ImagePicker.pickImage(
        source: ImageSource.gallery, imageQuality: 50));

    setState(() {
      _image = image;
    });
  }

  void _showPicker(context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return SafeArea(
            child: Container(
              child: new Wrap(
                children: <Widget>[
                  new ListTile(
                      leading: new Icon(Icons.photo_library,color: Color(0xffB76E79),),
                      title: new Text('Photo Library'),
                      onTap: () {
                        _imgFromGallery();
                        Navigator.of(context).pop();
                      }),
                  new ListTile(
                    leading: new Icon(Icons.photo_camera,color: Color(0xffB76E79),),
                    title: new Text('Camera'),
                    onTap: () {
                      _imgFromCamera();
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
            ),
          );
        });
  }

  //Method Widget to Custom Text
}
// ignore: non_constant_identifier_names
Widget _ContainerCustom(Color color)=>Container(
  height: 32,
  width: 32,
  decoration: BoxDecoration(
      color: color,
      borderRadius: BorderRadius.circular(5),
      border: Border.all(
        color: Colors.white,
        width: 1,
      )),
);

