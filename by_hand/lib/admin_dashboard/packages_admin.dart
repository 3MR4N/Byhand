import 'package:by_hand/models/package.dart';
import 'package:by_hand/providers/package_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';

import 'home_admin.dart';


class PackagesAdmin extends StatefulWidget {
  @override
  _PackagesAdminState createState() => _PackagesAdminState();
}

class _PackagesAdminState extends State<PackagesAdmin> {
  @override
  void initState() {
    super.initState();
    getProductsData();

  }
  String _errorMessage = '';

  TextEditingController name=TextEditingController();
  TextEditingController price=TextEditingController();
  TextEditingController description=TextEditingController();


  List<Package>myModels=[];
  List<String>desc=[];
  getProductsData() {
    EasyLoading.show(status: "Loading".tr);
    PackageProvider().getAllByAccount().then((value) {
      EasyLoading.dismiss();
      setState(() {
        myModels = value;
        name.text=myModels[0].name;
        price.text=myModels[0].price;
        description.text=myModels[0].description;

      });
    }).catchError((ex) {
      EasyLoading.dismiss();
      EasyLoading.showError(ex.toString());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.teal,
          title: Text("Edit Pachage",style: TextStyle(fontWeight: FontWeight.w700,color: Colors.white,fontSize: 20),),
        ),
        body: Container(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: SingleChildScrollView(
            child: SafeArea(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
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
        _entryField("price".tr, price),
        _entryField("description".tr, description),
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


  handelEditAccount() async {
    if (_validation()) {
      setState(() {
        _errorMessage = "";
      });

      PackageProvider()
          .updatePack(name.text,price.text,description.text,myModels[0].id)
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
    if (price.text.isEmpty) {
      setState(() {
        _errorMessage = 'fname_is_required'.tr;
        EasyLoading.showError(_errorMessage);

      });
      return false;
    }if (description.text.isEmpty) {
      setState(() {
        _errorMessage = 'fname_is_required'.tr;
        EasyLoading.showError(_errorMessage);

      });
      return false;
    }



    return true;
  }

}
