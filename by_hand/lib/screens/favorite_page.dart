import 'package:by_hand/models/favorites.dart';
import 'package:by_hand/providers/api_helper.dart';
import 'package:by_hand/providers/favorites_provider.dart';
import 'package:by_hand/screens/product_detail_screen.dart';
import 'package:by_hand/utilities/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:get/get.dart';

class FavoritePage extends StatefulWidget {
  static const routeName = '/favorite_page';
  @override
  _FavoritePageState createState() => _FavoritePageState();
}

class _FavoritePageState extends State<FavoritePage> {
  List<Favorites> myModels=[];
  ApiBaseHelper _helper = ApiBaseHelper();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getProductsData();
  }


  getProductsData() async {
    EasyLoading.show(status: "Loading".tr);
    SharedPreferences a = await SharedPreferences.getInstance();

    FavoritesProvider().getAllByUser(a.getInt('id')).then((value) {
      EasyLoading.dismiss();
      setState(() {
        myModels = value;
      });
    }).catchError((ex) {
      EasyLoading.dismiss();
      EasyLoading.showError(ex.toString().tr);
    });
  }



  @override
  Widget build(BuildContext context) {
    return
        myModels.isNotEmpty?
        GridView.builder(
            gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: 200,
                childAspectRatio: 3 / 2,
                crossAxisSpacing: 3,
                mainAxisExtent: 240,
                mainAxisSpacing: 10),
            itemCount: myModels.length,
            itemBuilder: (BuildContext ctx, index) {

              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: InkWell(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context) => DetailsPage(myModels[index].products) ,));
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
                                  child: myModels[index].products.image1 == null
                                      ? Image.asset('assets/images/google_icon.png')
                                      : Image.network(
                                    _helper.imageServer+myModels[index].products.image1,
                                  )),
                                ),
                            Expanded(
                                child: Container(
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                      color: Colors.grey.shade100,
                                      borderRadius: BorderRadius.only(
                                          bottomLeft: Radius.circular(16),
                                          bottomRight: Radius.circular(16))),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text('${myModels[index].products.name}',style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold),),
                                        Text(
                                          '${myModels[index].products.subName}',
                                          style: TextStyle(
                                              color: Colors.grey, fontSize: 14),
                                        ),
                                        Text("Price".tr+
                                            ' : ${myModels[index].products.price}',
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
                        opacity: 0.7,
                        child: Container(
                          height: 40,
                          width: 40,
                          decoration: BoxDecoration(
                            color: Colors.grey.shade100,
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(16),
                                bottomRight: Radius.circular(16)),
                          ),
                          child: IconButton(icon:Icon(Icons.favorite,color: Colors.redAccent.shade700,), onPressed: () {
                            handleDeleteAction(index);

                          },),
                        ),
                      )
                    ],
                  ),
                ),
              );
            }):Container(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                    width: 75,
                    height: 75,
                    child: Image(image: AssetImage('assets/images/Afa.png'))),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Container(
                    height: 54,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: AppColors.primColor),
                    child: TextButton(
                      onPressed: () {
                        Navigator.pushReplacementNamed(context, '/home');
                      },
                      child: Text(
                        'Add Favorites'.tr,
                        style: TextStyle(color: Colors.white, fontSize: 16),
                      ),
                    ),
                  ),
                ),


              ],
            ),
          ),
      );
  }


  handleDeleteAction(int index) async {
    try {

      String textMessage;

      await FavoritesProvider().deleteFav(myModels[index].id).then((value) {
        setState(() {
          textMessage = value['message'];
          EasyLoading.showSuccess(textMessage.tr);

        });
      }).catchError((ex) {
        EasyLoading.showError(ex.toString().tr);
      });

      ss(textMessage);
    } catch (ex) {
      EasyLoading.showError(ex.toString().tr);
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
