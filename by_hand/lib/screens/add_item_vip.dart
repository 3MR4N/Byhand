import 'dart:io';
import 'package:by_hand/components/text_feild_item_design.dart';
import 'package:by_hand/models/category.dart';
import 'package:by_hand/models/product.dart';
import 'package:by_hand/providers/category_provider.dart';
import 'package:by_hand/providers/product_provider.dart';
import 'package:by_hand/utilities/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:get/get.dart';

class AddItemVip extends StatefulWidget {
  @override
  _AddItemVipState createState() => _AddItemVipState();
}

class _AddItemVipState extends State<AddItemVip> {
  File _image1;
  File _image2;

  TextEditingController name = TextEditingController();
  TextEditingController subname = TextEditingController();
  TextEditingController price = TextEditingController();
  TextEditingController description = TextEditingController();
  String _errorMessage = '';
  String countProduct = '';

  List<CategoryModel> myModels = [];
  int _selectedIndex = 0;

  void initState() {
    super.initState();
    getProductsData();
  }

  getProductsData() async {
    EasyLoading.show(status: "Loading".tr);
    CategoriesProvisers().getAll().then((value) {
      EasyLoading.dismiss();
      setState(() {
        myModels = value;
      });
    }).catchError((ex) {
      EasyLoading.dismiss();
      EasyLoading.showError(ex.toString().tr);
    });


    SharedPreferences a = await SharedPreferences.getInstance();
    ProductProvider().getAllCount(a.getInt('id')).then((value) {
      EasyLoading.dismiss();
      setState(() {
        countProduct = value.toString();
      });
    }).catchError((ex) {
      EasyLoading.dismiss();
      EasyLoading.showError(ex.toString().tr);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(

        backgroundColor: Colors.white,
        title: Padding(
          padding: const EdgeInsets.only(top:8.0),
          child: Text("VIP Product",style: TextStyle(color: Colors.orange,fontWeight: FontWeight.bold,fontSize: 28),),
        ),
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back_ios, color: Colors.orange),
        ),
      ),

      backgroundColor: AppColors.backgroundColor,
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            children: [
              _addPhotos(),
              Padding(
                padding: const EdgeInsets.only(left: 16.0, right: 16.0),
                child: TextItem("Name Item".tr, name),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 16.0, right: 16.0),
                child: Row(
                  children: [
                    Expanded(
                      child: TextItem("Sub title".tr, subname),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: TextItem("Price".tr, price),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 16.0, right: 16.0),
                child: TextItem("Description".tr, description, lineCount: 5),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20, top: 20),
                child: Container(
                  width: double.infinity,
                  child: Text(
                    'Choose category'.tr,
                    textAlign: TextAlign.start,
                    overflow: TextOverflow.clip,
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            myModels.isNotEmpty?  Container(
                margin: EdgeInsets.only(left: 4, right: 2),
                width: 100,
                height: 100,
                decoration: BoxDecoration(

                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8.0),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.grey[300],
                        blurRadius: 6,
                        offset: Offset(0, 5))
                  ],
                ),
                child: ListTile(
                  title: Center(
                      child: Text(
                        '${myModels[0].name.tr}',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,),
                      )),
                  selected: 0 == _selectedIndex,
                  onTap: () {
                    setState(() {
                      _selectedIndex = 0;
                    });
                  },
                ),
              ):Container(),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: SizedBox(
                    width: 100,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: () {
                        handleRegisterAction();
                      },
                      child: Text('Submit'.tr),
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(
                            AppColors.primColor),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _addPhotos() => Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      GestureDetector(
        onTap: () {
          _showPicker(context);
        },
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            height: 100,
            width: 100,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                    color: Colors.grey[300],
                    blurRadius: 6,
                    offset: Offset(0, 5))
              ],
            ),
            child: _image1 != null
                ? ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.file(
                _image1,
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
      ),
      // GestureDetector(
      //   onTap: () {
      //     _showPicker2(context);
      //   },
      //   child: Padding(
      //     padding: const EdgeInsets.all(8.0),
      //     child: Container(
      //       height: 100,
      //       width: 100,
      //       decoration: BoxDecoration(
      //         borderRadius: BorderRadius.circular(15),
      //         color: Colors.white,
      //         boxShadow: [
      //           BoxShadow(
      //               color: Colors.grey[300],
      //               blurRadius: 6,
      //               offset: Offset(0, 5))
      //         ],
      //       ),
      //       child: _image2 != null
      //           ? ClipRRect(
      //               borderRadius: BorderRadius.circular(12),
      //               child: Image.file(
      //                 _image2,
      //                 width: 100,
      //                 height: 100,
      //                 fit: BoxFit.fitWidth,
      //               ),
      //             )
      //           : Container(
      //               decoration: BoxDecoration(
      //                   color: Colors.white,
      //                   borderRadius: BorderRadius.circular(50)),
      //               width: 100,
      //               height: 100,
      //               child: Icon(
      //                 Icons.camera_alt,
      //                 color: AppColors.primColor,
      //               ),
      //             ),
      //     ),
      //   ),
      // )
    ],
  );

  handleRegisterAction() async {
    try {
      if (_validation()) {
        setState(() {
          _errorMessage = '';
        });
        SharedPreferences a = await SharedPreferences.getInstance();
        String textMessage;
        Products product = new Products();
        product.name = name.text;
        product.subName = subname.text;
        product.price = price.text;
        product.description = description.text;
        product.categoryId = _selectedIndex + 1;
        product.userId = a.getInt('id');
        await ProductProvider().asyncFileUpload(product,_image1).then((value) {
          setState(() {
            textMessage ="Added Successfully".tr;
          });
        }).catchError((ex) {
          setState(() {
            textMessage ="Not found".tr;
          });
          print(ex);
        });
        Navigator.of(context)
            .pushNamedAndRemoveUntil('/home', (Route<dynamic> route) => false);
        ScaffoldMessenger.of(context).showSnackBar(ss(textMessage.tr));
      }
    } catch (ex) {
      print(ex);
    }
  }

  _validation() {
    if (_image1 == null && _image2 == null) {
      setState(() {
        _errorMessage = 'images_is_required'.tr;
        EasyLoading.showError(_errorMessage);

      });
      return false;
    }
    if (name.text.isEmpty) {
      setState(() {
        _errorMessage = 'name_is_required'.tr;
        EasyLoading.showError(_errorMessage);

      });
      return false;
    }
    if (subname.text.isEmpty) {
      setState(() {
        _errorMessage = 'subname_is_required'.tr;
        EasyLoading.showError(_errorMessage);


      });
      return false;
    }
    if (price.text.isEmpty) {
      setState(() {
        _errorMessage = 'price_is_required'.tr;
        EasyLoading.showError(_errorMessage);

      });
      return false;
    }
    if (description.text.isEmpty) {
      setState(() {
        _errorMessage = 'description_is_required'.tr;
        EasyLoading.showError(_errorMessage);

      });
      return false;
    }
    if (_image1 == null && _image2 == null) {
      setState(() {
        _errorMessage = 'images_is_required'.tr;
        EasyLoading.showError(_errorMessage);

      });
      return false;
    }

    return true;
  }

  Widget ss(String message) => SnackBar(
    content: Text(
      '$message',
      textAlign: TextAlign.center,
    ),
  );

  _imgFromCamera() async {
    // ignore: deprecated_member_use
    File image = (await ImagePicker.pickImage(
        source: ImageSource.camera, imageQuality: 50));

    setState(() {
      _image1 = image;
    });
  }

  _imgFromGallery() async {
    // ignore: deprecated_member_use
    File image = (await ImagePicker.pickImage(
        source: ImageSource.gallery, imageQuality: 50));

    setState(() {
      _image1 = image;
    });
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

  void _showPicker(context) {
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
                        _imgFromGallery();
                        Navigator.of(context).pop();
                      }),
                  new ListTile(
                    leading: new Icon(
                      Icons.photo_camera,
                      color: AppColors.primColor,
                    ),
                    title: new Text('Camera'.tr),
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
