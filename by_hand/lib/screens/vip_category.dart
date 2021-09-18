import 'package:by_hand/models/category.dart';
import 'package:by_hand/models/product.dart';
import 'package:by_hand/models/user.dart';
import 'package:by_hand/providers/api_helper.dart';
import 'package:by_hand/providers/category_provider.dart';
import 'package:by_hand/providers/user_provider.dart';
import 'package:by_hand/screens/add_item_vip.dart';
import 'package:by_hand/screens/product_detail_screen.dart';
import 'package:by_hand/screens/settings.dart';
import 'package:by_hand/utilities/app_colors.dart';
import 'package:by_hand/utilities/search_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ItemsVip extends StatefulWidget {
  final int id;
  final String _title;

  ItemsVip(this.id, this._title);

  @override
  _ItemsVipState createState() => _ItemsVipState();
}

class _ItemsVipState extends State<ItemsVip> {
  CategoriesProvisers api = CategoriesProvisers();
  CategoryModel model = CategoryModel();
  List<Products> pro = [];
  List<Products> _debit = List<Products>();
  List<Products> _debitDisplay = List<Products>();
  TextEditingController search = TextEditingController();
  Users user = Users('');

  void initState() {
    super.initState();
    getProductsData();
  }

  getProductsData() async {
    EasyLoading.show(status: "Loading".tr);
    CategoriesProvisers().getByIdCate(widget.id).then((value) {
      EasyLoading.dismiss();
      setState(() {
        model = value;
        pro = model.product;
        _debit.addAll(model.product);
        _debitDisplay = _debit;
      });
    }).catchError((ex) {
      EasyLoading.dismiss();
      EasyLoading.showError(ex.toString().tr);
    });

    SharedPreferences a = await SharedPreferences.getInstance();

    UserProvider().getById(a.getInt('id')).then((value) {
      EasyLoading.dismiss();
      setState(() {
        user = value;
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
        backgroundColor: Colors.white,
        title: Padding(
          padding: const EdgeInsets.only(top: 8.0),
          child: Text(
            widget._title.tr,
            style: TextStyle(
                color: Colors.orange,
                fontWeight: FontWeight.bold,
                fontSize: 28),
          ),
        ),
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back_ios, color: Colors.orange),
        ),
      ),
      body: pro != null && pro.isNotEmpty
          ? SingleChildScrollView(
              child: Column(
                children: [
                  SearchWidget(
                      (text) {
                        text = text.toLowerCase();
                        setState(() {
                          model.product = _debit.where((post) {
                            var postTitle = post.name.toLowerCase();
                            return postTitle.contains(text);
                          }).toList();
                        });
                      },
                      search,
                      () {
                        search.clear();
                        setState(() {
                          model.product = _debit;
                        });
                      }),
                  GridView.builder(
                      gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                          maxCrossAxisExtent: 200,
                          childAspectRatio: 3 / 2,
                          crossAxisSpacing: 3,
                          mainAxisExtent: 240,
                          mainAxisSpacing: 10),
                      itemCount: model.product.length,
                      shrinkWrap: true,
                      physics: ScrollPhysics(),
                      itemBuilder: (BuildContext ctx, index) {
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        DetailsPage(model.product[index]),
                                  ));
                            },
                            child: Stack(
                              children: [
                                Container(
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
                                            child: Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: model.product[index]
                                                            .image1 ==
                                                        null
                                                    ? Image.asset(
                                                        'assets/images/google_icon.png')
                                                    : Image.network(
                                                        _helper.imageServer +
                                                            model.product[index]
                                                                .image1,
                                                      )),
                                          )),
                                      Expanded(
                                          child: Container(
                                        width: double.infinity,
                                        decoration: BoxDecoration(
                                            color: Colors.grey.shade100,
                                            borderRadius: BorderRadius.only(
                                                bottomLeft: Radius.circular(16),
                                                bottomRight:
                                                    Radius.circular(16))),
                                        child: Padding(
                                          padding: const EdgeInsets.only(
                                              left: 8.0, right: 8.0),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                '${model.product[index].name}',
                                                style: TextStyle(
                                                    fontSize: 16,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              Text(
                                                '${model.product[index].subName}',
                                                style: TextStyle(
                                                    color: Colors.grey,
                                                    fontSize: 14),
                                              ),
                                              Text(
                                                "Price".tr +
                                                    ' : ${model.product[index].price}',
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 15),
                                              )
                                            ],
                                          ),
                                        ),
                                      ))
                                    ],
                                  ),
                                ),
                                Opacity(
                                  opacity: 0.5,
                                  child: Container(
                                    height: 40,
                                    width: 40,
                                    decoration: BoxDecoration(
                                      color: Colors.grey.shade100,
                                      borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(16),
                                          bottomRight: Radius.circular(16)),
                                    ),
                                    child: IconButton(
                                      icon: Icon(
                                        Icons.favorite_outline_outlined,
                                        color: Colors.black26,
                                      ),
                                      onPressed: () {},
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        );
                      }),
                ],
              ),
            )
          : Container(
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                        width: 75,
                        height: 75,
                        child:
                            Image(image: AssetImage('assets/images/box.png'))),
                    Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Text(
                        "Empty products".tr,
                        style: TextStyle(fontSize: 18),
                      ),
                    ),
                  ],
                ),
              ),
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (user.type == "super_user") {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => AddItemVip(),
                ));
          } else {
            _showDoneDia();
          }
        },
        backgroundColor: Colors.orange,
        child: Icon(Icons.add_box),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  Future<void> _showDoneDia() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('Upgrade account to use VIP category'.tr),
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
                color: AppColors.primColor,
                borderRadius: BorderRadius.circular(16),
              ),
              child: TextButton(
                style: ButtonStyle(
                    textStyle: MaterialStateProperty.all(TextStyle(color: Colors.white))
                ),
                child: Text('Upgrade'.tr,style: TextStyle(color: Colors.white),),
                onPressed: () async {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => SettingsPage(),
                      ));

                },
              ),
            ),
          ],
        );
      },
    );
  }
}
