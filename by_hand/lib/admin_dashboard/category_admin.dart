import 'package:by_hand/admin_dashboard/add_category.dart';
import 'package:by_hand/models/category.dart';
import 'package:by_hand/providers/api_helper.dart';
import 'package:by_hand/providers/category_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';

class CategoryAdmin extends StatefulWidget {
  @override
  _CategoryAdminState createState() => _CategoryAdminState();
}

class _CategoryAdminState extends State<CategoryAdmin> {
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
        appBar: AppBar(
          backgroundColor: Colors.teal,
          title: Text("Categories",style: TextStyle(fontWeight: FontWeight.w700,color: Colors.white,fontSize: 20),),
        ),

        body:SingleChildScrollView(
          child: Column(
            children: [
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
                                  color: Colors.black45,
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
                    );
                  }):Container(),
            ],
          ),
        ),
      floatingActionButton: FloatingActionButton(onPressed: () {

Navigator.push(context, MaterialPageRoute(builder: (context) => AddCategory(),));
      },
        backgroundColor: Colors.teal,
        child: Icon(Icons.add_box),


      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,

    );
  }
}
