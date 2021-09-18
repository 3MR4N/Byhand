import 'package:by_hand/models/favorites.dart';
import 'package:by_hand/models/notifications_model.dart';
import 'package:by_hand/models/product.dart';
import 'package:by_hand/providers/api_helper.dart';
import 'package:by_hand/providers/favorites_provider.dart';
import 'package:by_hand/providers/notifications_provider.dart';
import 'package:by_hand/providers/product_provider.dart';
import 'package:by_hand/screens/product_detail_screen.dart';
import 'package:by_hand/utilities/search_widgets.dart';
import 'package:favorite_button/favorite_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:get/get.dart';

class HomeBody extends StatefulWidget {
  @override
  _HomeBodyState createState() => _HomeBodyState();
}

class _HomeBodyState extends State<HomeBody> {
  final _sigInFormKey = GlobalKey<FormState>();

  List<Products> myModels = [];
  List<Products> _debit = List<Products>();
  List<Products> _debitDisplay = List<Products>();
  TextEditingController search = TextEditingController();

  void initState() {
    getProductsData();
    ProductProvider().getAll().then((value) {
      setState(() {
        _debit.addAll(value);
        _debitDisplay = _debit;
      });
    });

    //Remove this method to stop OneSignal Debugging
    OneSignal.shared.setLogLevel(OSLogLevel.verbose, OSLogLevel.none);

    OneSignal.shared.init(
      "948f263b-04e0-47e0-84e9-5b52d4ca2e36",
      iOSSettings: {
        OSiOSSettings.autoPrompt: false,
        OSiOSSettings.inAppLaunchUrl: false
      },
    );

    OneSignal.shared
        .setInFocusDisplayType(OSNotificationDisplayType.notification);

    OneSignal.shared
        .setNotificationReceivedHandler((OSNotification notification) async {
      NotificationsModel notificationsModel = new NotificationsModel();
      notificationsModel.title = notification.payload.title;
      notificationsModel.body = notification.payload.body;
      await NotificationsProviders()
          .create(notificationsModel)
          .then((value) {})
          .catchError((ex) {
        print(ex);
      });
    });

    super.initState();
  }

  handleFavoriteAction(int index) async {
    try {
      SharedPreferences a = await SharedPreferences.getInstance();

      int asa = a.getInt('id');

      String textMessage;
      Favorites favorites = new Favorites();
      favorites.productId = myModels[index].id;
      favorites.userId = asa;

      await FavoritesProvider().createNew(favorites).then((value) {
        setState(() {
          textMessage = value['message'];
        });
      }).catchError((ex) {
        EasyLoading.showError(ex.toString().tr);
        throw (ex);
      });
      EasyLoading.showSuccess(textMessage.tr);
    } catch (ex) {
      print(ex);
    }
  }

  getProductsData() async {
    EasyLoading.show(status: "Loading".tr);
    ProductProvider().getAll().then((value) {
      EasyLoading.dismiss();
      setState(() {
        myModels = value;
      });
    }).catchError((ex) {
      EasyLoading.dismiss();
      EasyLoading.showError(ex.toString().tr);
    });
  }

  ApiBaseHelper _helper = ApiBaseHelper();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
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
            GridView.builder(
                gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                    maxCrossAxisExtent: 200,
                    childAspectRatio: 3 / 2,
                    crossAxisSpacing: 3,
                    mainAxisExtent: 250,
                    mainAxisSpacing: 10),
                itemCount: myModels.length,
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
                                  DetailsPage(myModels[index]),
                            ));
                      },
                      child: Stack(
                        children: [
                          cardItem(index),
                          favoriteButton(index),
                        ],
                      ),
                    ),
                  );
                }),
          ],
        ),
      ),
    );
  }

  Widget cardItem(int index) => Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                  color: Colors.grey[300], blurRadius: 6, offset: Offset(0, 5))
            ],
            borderRadius: BorderRadius.circular(15)),
        child: Column(
          children: [
            Expanded(
                flex: 2,
                child: Container(
                  child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: myModels[index].image1 == null
                          ? Image.asset('assets/images/google_icon.png')
                          : Image.network(
                              _helper.imageServer + myModels[index].image1,
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
                    Text(
                      '${myModels[index].name}',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      '${myModels[index].subName}',
                      style: TextStyle(color: Colors.grey, fontSize: 14),
                    ),
                    Text(
                      "Price".tr + ' : ${myModels[index].price}'+"JD".tr,
                      style: TextStyle(color: Colors.black, fontSize: 14),
                    )
                  ],
                ),
              ),
            ))
          ],
        ),
      );

  Widget favoriteButton(int index) => Opacity(
        opacity: 0.7,
        child: Container(
          height: 40,
          width: 40,
          decoration: BoxDecoration(
            color: Colors.grey.shade100,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(16), bottomRight: Radius.circular(16)),
          ),
          child: FavoriteButton(
            iconSize: 30,
            isFavorite: false,
            valueChanged: (_isFavorite) {
              handleFavoriteAction(index);
            },
            iconColor: Colors.redAccent.shade700,
          ),
        ),
      );
}
