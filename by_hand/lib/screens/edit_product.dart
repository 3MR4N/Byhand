import 'package:by_hand/components/text_feild_item_design.dart';
import 'package:by_hand/models/category.dart';
import 'package:by_hand/models/product.dart';
import 'package:by_hand/providers/category_provider.dart';
import 'package:by_hand/providers/product_provider.dart';
import 'package:by_hand/utilities/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:get/get.dart';

class EditProduct extends StatefulWidget {
  final Products product;

  EditProduct(this.product);

  @override
  _EditProductState createState() => _EditProductState();
}

class _EditProductState extends State<EditProduct> {
  TextEditingController name = TextEditingController();
  TextEditingController subname = TextEditingController();
  TextEditingController price = TextEditingController();
  TextEditingController description = TextEditingController();
  String _errorMessage = '';

  List<CategoryModel> myModels = [];
  int _selectedIndex ;

  void initState() {
    super.initState();
    getProductsData();
  }

  getProductsData() {
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

    setState(() {
      name.text =widget.product.name;
      subname.text = widget.product.subName;
      price.text = widget.product.price;
      description.text =widget.product.description;
      _selectedIndex=widget.product.categoryId-1;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: AppColors.primColor,
        leading: IconButton(onPressed: () {
          Navigator.pop(context);
        }, icon: Icon(Icons.arrow_back_ios,color: AppColors.primColor),),
        backgroundColor: Colors.white,
        title: Text('${name.text}',style: TextStyle(color: AppColors.primColor),),
        centerTitle: true,
      ),
      backgroundColor: AppColors.backgroundColor,
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            children: [
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
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Container(
                  height: 100,
                  child: ListView.builder(
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    itemCount: myModels.length,
                    itemBuilder: (BuildContext context, int index) {
                      return index != 0
                          ? Container(
                              margin: EdgeInsets.only(left: 4, right: 2),
                              width: 100,
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
                                  '${myModels[index].name.tr}',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18,
                                  ),
                                )),
                                selected: index == _selectedIndex,
                                onTap: () {
                                  setState(() {
                                    _selectedIndex = index;
                                  });
                                  print(_selectedIndex);
                                },
                              ),
                            )
                          : Container();
                    },
                  ),
                ),
              ),
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
              Text(
                '$_errorMessage',
                style: TextStyle(color: Colors.red),
              )
            ],
          ),
        ),
      ),
    );
  }

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
        await ProductProvider().updatePro(product,widget.product.id).then((value) {
          setState(() {
            textMessage = value['message'];
          });
        }).catchError((ex) {
          print(ex);
        });
        Navigator.of(context)
            .pushNamedAndRemoveUntil('/home', (Route<dynamic> route) => false);
        ScaffoldMessenger.of(context).showSnackBar(ss(textMessage));
      }
    } catch (ex) {
      print(ex);
    }
  }

  _validation() {
    if (name.text.isEmpty) {
      setState(() {
        _errorMessage = 'name_is_required'.tr;
      });
      return false;
    }
    if (subname.text.isEmpty) {
      setState(() {
        _errorMessage = 'subname_is_required'.tr;
      });
      return false;
    }
    if (price.text.isEmpty) {
      setState(() {
        _errorMessage = 'price_is_required'.tr;
      });
      return false;
    }
    if (description.text.isEmpty) {
      setState(() {
        _errorMessage = 'description_is_required'.tr;
      });
      return false;
    }

    return true;
  }

  Widget ss(String message) => SnackBar(
        content: Text(
          '$message'.tr,
          textAlign: TextAlign.center,
        ),
      );
}
