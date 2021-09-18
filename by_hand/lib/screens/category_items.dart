import 'package:by_hand/models/category.dart';
import 'package:by_hand/models/product.dart';
import 'package:by_hand/providers/api_helper.dart';
import 'package:by_hand/providers/category_provider.dart';
import 'package:by_hand/providers/product_provider.dart';
import 'package:by_hand/screens/product_detail_screen.dart';
import 'package:by_hand/utilities/app_colors.dart';
import 'package:by_hand/utilities/search_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';

class ItemsCate extends StatefulWidget {
  final int id;
  final String _title;

  ItemsCate(this.id, this._title);

  @override
  _ItemsCateState createState() => _ItemsCateState();
}

class _ItemsCateState extends State<ItemsCate> {
  CategoriesProvisers api = CategoriesProvisers();
  CategoryModel model=CategoryModel();
  List<Products> pro = [];
  List<Products> _debit = List<Products>();
  List<Products> _debitDisplay = List<Products>();
  TextEditingController search = TextEditingController();

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
        pro=model.product;
        _debit.addAll(model.product);
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
        backgroundColor: AppColors.primColor,
        title: Text(widget._title.tr),
        centerTitle: true,
      ),
      body:
          pro!=null&&pro.isNotEmpty? SingleChildScrollView(
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
                                    borderRadius:
                                    BorderRadius.circular(15)),
                                child: Column(
                                  children: [
                                    Expanded(
                                        flex: 2,
                                        child: Padding(
                                          padding:
                                          const EdgeInsets.all(8.0),
                                          child: Padding(
                                              padding: const EdgeInsets.all(8.0),
                                              child: model.product[index].image1 == null
                                                  ? Image.asset('assets/images/google_icon.png')
                                                  : Image.network(
                                                _helper.imageServer+model.product[index].image1,
                                              )),
                                        )),
                                    Expanded(
                                        child: Container(
                                          width: double.infinity,
                                          decoration: BoxDecoration(
                                              color: Colors.grey.shade100,
                                              borderRadius: BorderRadius.only(
                                                  bottomLeft: Radius.circular(16),
                                                  bottomRight: Radius.circular(16))),
                                          child: Padding(
                                            padding: const EdgeInsets.only(left:8.0,right: 8.0),
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Text('${model.product[index].name}',style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold),),
                                                Text(
                                                  '${model.product[index].subName}',
                                                  style: TextStyle(
                                                      color: Colors.grey, fontSize: 14),
                                                ),
                                                Text("Price".tr+
                                                    ' : ${model.product[index].price}',
                                                  style: TextStyle(
                                                      color: Colors.black, fontSize: 15),
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
          ) : Container(
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                          width: 75,
                          height: 75,
                          child: Image(image: AssetImage('assets/images/box.png'))),
                      Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Text("Empty products".tr,style: TextStyle(fontSize: 18),),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Container(
                          height: 54,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              color: AppColors.primColor),
                          child: TextButton(
                            onPressed: () {
                              Navigator.pushReplacementNamed(context, 'add_item');
                            },
                            child: Text(
                              'Add Product'.tr,
                              style: TextStyle(color: Colors.white, fontSize: 16),
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
}
