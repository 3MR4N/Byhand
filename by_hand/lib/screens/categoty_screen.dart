import 'package:by_hand/models/category.dart';
import 'package:by_hand/providers/api_helper.dart';
import 'package:by_hand/providers/category_provider.dart';
import 'package:by_hand/screens/category_items.dart';
import 'package:by_hand/screens/vip_category.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';

class CategoryScreen extends StatefulWidget {
  @override
  _CategoryScreenState createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {

  List<CategoryModel> myModels = [];
  ApiBaseHelper _helper = ApiBaseHelper();

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
      EasyLoading.showError(ex.toString());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body:SingleChildScrollView(
          child: Column(
            children: [
              myModels.isNotEmpty?Padding(
                padding: const EdgeInsets.all(8.0),
                child: InkWell(
                  onTap: () {
                    if (myModels.isNotEmpty)
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ItemsVip(
                                myModels[0].id,
                                myModels[0].name),
                          ));
                  },
                  child: Container(
                  height: 120,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image: NetworkImage(
                                  '${myModels[0].image}'),
                              fit: BoxFit.fitHeight),
                          color: Color(0xff000000),
                          boxShadow: [

                            BoxShadow(
                                color: Colors.indigo[100],
                                blurRadius: 6,
                                offset: Offset(0, 5))
                          ],
                          borderRadius: BorderRadius.circular(15)),
                      child: Stack(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                             // color: Colors.black45,
                              borderRadius: BorderRadius.circular(15),
                            ),
                          ),
                          // Center(
                          //   child: Text(
                          //     '${myModels[0].name.tr}',
                          //     style: TextStyle(
                          //         color: Colors.white,
                          //         fontSize: 18,
                          //         fontWeight: FontWeight.bold),
                          //   ),
                          // ),
                        ],
                      )),
                ),
              ):Container(),
              myModels.isNotEmpty? GridView.builder(
                  physics: ScrollPhysics(),
                  shrinkWrap: true,
                  gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                      maxCrossAxisExtent: 200,
                      childAspectRatio: 3 / 2,
                      crossAxisSpacing: 3,
                      mainAxisExtent: 150,
                      mainAxisSpacing: 10),
                  itemCount: myModels.length-1,
                  itemBuilder: (BuildContext ctx, int index) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: InkWell(
                        onTap: () {
                          if (myModels.isNotEmpty)
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ItemsCate(
                                      myModels[index + 1].id,
                                      myModels[index + 1].name),
                                ));
                        },
                        child: Container(
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                                image: DecorationImage(
                                    image:                                 index>8?
                                    NetworkImage(
                                        '${_helper.imageServer+myModels[index + 1].image}'): NetworkImage(
                                        '${myModels[index + 1].image}'),
                                    fit: BoxFit.cover),
                                color: Colors.white,
                                boxShadow: [
                                  BoxShadow(
                                      color: Colors.indigo[100],
                                      blurRadius: 6,
                                      offset: Offset(0, 5))
                                ],
                                borderRadius: BorderRadius.circular(15)),
                            child: Stack(
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                    color: Colors.black26,
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                ),
                                Center(
                                  child: Text(
                                    '${myModels[index + 1].name.tr}',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ],
                            )),
                      ),
                    );
                  }):Container(),
            ],
          ),
        )

    );
  }
}
