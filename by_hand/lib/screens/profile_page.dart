import 'package:by_hand/components/avatar.dart';
import 'package:by_hand/models/product.dart';
import 'package:by_hand/models/user.dart';
import 'package:by_hand/providers/api_helper.dart';
import 'package:by_hand/providers/product_provider.dart';
import 'package:by_hand/providers/rate_provider.dart';
import 'package:by_hand/providers/user_provider.dart';
import 'package:by_hand/screens/edit_product.dart';
import 'package:by_hand/utilities/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:get/get.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  _ProfilePageState();

  List<Products> myModels = [];
  Users user = Users('');
  String fullName = '';
  String countProduct = '';
  double rate = 0;
  bool vip=false;
  List values = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getProductsData();
  }

  getProductsData() async {
    EasyLoading.show(status: "Loading".tr);
    SharedPreferences a = await SharedPreferences.getInstance();

    UserProvider().getById(a.getInt('id')).then((value) {
      EasyLoading.dismiss();
      setState(() {
        user = value;
        vip=user.vip;
        fullName = user.fname+" "+user.lname;
      });
    }).catchError((ex) {
      EasyLoading.dismiss();
      EasyLoading.showError(ex.toString().tr);
    });

    ProductProvider().getAllByuser(a.getInt('id')).then((value) {
      EasyLoading.dismiss();
      setState(() {
        myModels = value;
      });
    }).catchError((ex) {
      EasyLoading.dismiss();
      EasyLoading.showError(ex.toString().tr);
    });

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

  ApiBaseHelper _helper = ApiBaseHelper();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: user.imageUrl != null &&user.imageUrl!=''
                      ? CircleAvatar(
                          backgroundImage:
                              NetworkImage("${_helper.imageServer+user.imageUrl}"),
                          radius: 55,
                        )
                      : CircleAvatar(
                          backgroundImage:
                              AssetImage("assets/images/account.png"),
                          radius: 55,
                        ),
                ),
                Text(
                  '$fullName'.toUpperCase(),
                  style: TextStyle(color: vip?Colors.orange:Colors.grey, fontSize: 22),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Expanded(
                      child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      height: 100,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(32.0),
                        boxShadow: [
                          BoxShadow(
                              color: Colors.grey[300],
                              blurRadius: 6,
                              offset: Offset(0, 5))
                        ],
                        gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment(0.8, 0.0),
                          // 10% of the width, so there are ten blinds.
                          colors: [
                            const Color(0xff9d00ff),
                            const Color(0xffd352dc)
                          ],
                          // red to yellow
                          // repeats the gradient over the canvas
                        ),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Products".tr,
                            style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ),
                          Text(
                            "$countProduct",
                            style: TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          )
                        ],
                      ),
                    ),
                  )),
                  Expanded(
                      child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      height: 100,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(32.0),
                        boxShadow: [
                          BoxShadow(
                              color: Colors.grey[300],
                              blurRadius: 6,
                              offset: Offset(0, 5))
                        ],
                        gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment(0.8, 0.0),
                          // 10% of the width, so there are ten blinds.
                          colors: [
                            const Color(0xff5900ff),
                            const Color(0xff9c52dc)
                          ],
                          // red to yellow
                          // repeats the gradient over the canvas
                        ),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Likes".tr,
                            style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ),
                          Text(
                            "${sumRates()}",
                            style: TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          )
                        ],
                      ),
                    ),
                  )),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: GridView.builder(
                  shrinkWrap: true,
                  physics: ScrollPhysics(),
                  gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                      maxCrossAxisExtent: 200,
                      childAspectRatio: 3 / 2,
                      crossAxisSpacing: 3,
                      mainAxisExtent: 250,
                      mainAxisSpacing: 10),
                  itemCount: myModels.length,
                  itemBuilder: (BuildContext ctx, index) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.grey[300],
                                  blurRadius: 6,
                                  offset: Offset(0, 5))
                            ],
                            borderRadius: BorderRadius.circular(15)),
                        child: Column(
                          children: [
                            Expanded(
                                flex: 2,
                                child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: myModels[index].image1 == null
                                        ? Image.asset(
                                            'assets/images/google_icon.png')
                                        : Image.network(
                                            _helper.imageServer +
                                                myModels[index].image1,
                                          ))),
                            Expanded(
                                child: Container(
                              width: double.infinity,
                              decoration: BoxDecoration(
                                  color: Colors.grey.shade100,
                                  borderRadius: BorderRadius.only(
                                      bottomLeft: Radius.circular(16),
                                      bottomRight: Radius.circular(16))),
                              child: Column(
                                children: [
                                  SizedBox(
                                    height: 6,
                                  ),
                                  Text(
                                    '${myModels[index].name}',
                                    style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Row(
                                    children: [
                                      Expanded(
                                        child: TextButton.icon(
                                            onPressed: () {
                                              _showDoneDia(index);
                                            },
                                            icon: Icon(
                                              Icons.delete,
                                              color: Colors.redAccent,
                                              size: 15,
                                            ),
                                            label: Text(
                                              'Delete'.tr,
                                              style: TextStyle(
                                                  color: Colors.red,
                                                  fontSize: 12),
                                            )),
                                      ),
                                      Expanded(
                                        child: TextButton.icon(
                                            onPressed: () {
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (context) =>
                                                        EditProduct(
                                                            myModels[index]),
                                                  ));
                                            },
                                            icon: Icon(
                                              Icons.edit,
                                              color: Colors.black,
                                              size: 15,
                                            ),
                                            label: Text(
                                              'Edit'.tr,
                                              style: TextStyle(
                                                  color: Colors.black54,
                                                  fontSize: 12),
                                            )),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ))
                          ],
                        ),
                      ),
                    );
                  }),
            )
          ],
        ),
      ),
    );
  }

  sumRates() {
    double rate = 0;
    for (Products item in myModels) {
      if (item.rates != null) rate += double.parse(item.rates);
    }

    return rate;
  }

  handleDeleteAction(int index) async {
    try {
      String textMessage;

      await ProductProvider().deleteFav(myModels[index].id).then((value) {
        setState(() {
          textMessage = value['message'];
        });
      }).catchError((ex) {
        throw (ex);
      });

      ss(textMessage);
    } catch (ex) {
      print(ex);
    }

    getProductsData();
  }

  Widget ss(String message) => SnackBar(
        content: Text(
          '$message'.tr,
          textAlign: TextAlign.center,
        ),
      );

  Future<void> _showDoneDia(int index) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('delete item'.tr),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('cancel'.tr),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            Container(
              decoration:BoxDecoration(
                color: Colors.redAccent,
                borderRadius: BorderRadius.circular(16),
              ),
              child: TextButton(
                style: ButtonStyle(
                    textStyle: MaterialStateProperty.all(TextStyle(color: Colors.white))
                ),
                child: Text('Delete'.tr,style: TextStyle(color: Colors.white),),
                onPressed: () async {
                  handleDeleteAction(index);
                  Navigator.of(context).pop();

                },
              ),
            ),

          ],
        );
      },
    );
  }
}
