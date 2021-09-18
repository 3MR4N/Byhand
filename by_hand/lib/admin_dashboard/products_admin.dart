import 'package:by_hand/models/product.dart';
import 'package:by_hand/models/user.dart';
import 'package:by_hand/providers/api_helper.dart';
import 'package:by_hand/providers/product_provider.dart';
import 'package:by_hand/providers/user_provider.dart';
import 'package:by_hand/screens/edit_product.dart';
import 'package:by_hand/utilities/search_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:get/get.dart';

class ProductsAdmin extends StatefulWidget {
  @override
  _ProductsAdminState createState() => _ProductsAdminState();
}

class _ProductsAdminState extends State<ProductsAdmin> {
  List<Products> myModels = [];
  List<Products> _debit = List<Products>();
  List<Products> _debitDisplay = List<Products>();
  TextEditingController search = TextEditingController();


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getProductsData();
  }

  getProductsData() async {
    EasyLoading.show(status: "Loading".tr);
    ProductProvider().getAll().then((value) {
      EasyLoading.dismiss();
      setState(() {
        myModels=value;
        _debit.addAll(value);
        _debitDisplay = _debit;
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
      appBar: AppBar(
        backgroundColor: Colors.teal,
        title: Text("Product",style: TextStyle(fontWeight: FontWeight.w700,color: Colors.white,fontSize: 20),),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SearchWidget(
                    (text) {
                  text = text.toLowerCase();
                  setState(() {
                    myModels = _debit.where((post) {
                      var postTitle = post.name.toLowerCase();
                      return postTitle.contains(text);
                    }).toList();
                  });
                },
                search,
                    () {
                  search.clear();
                  setState(() {
                    myModels = _debit;
                  });
                }),
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
            ),
          ],
        )
      ),
    );
  }

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
            TextButton(
              child: Text('yes'.tr),
              onPressed: () {
                handleDeleteAction(index);
                Navigator.of(context).pop();

              },
            ),
          ],
        );
      },
    );
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


}
