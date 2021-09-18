import 'package:by_hand/components/avatar.dart';
import 'package:by_hand/models/rate.dart';
import 'package:by_hand/models/user.dart';
import 'package:by_hand/providers/api_helper.dart';
import 'package:by_hand/providers/rate_provider.dart';
import 'package:by_hand/providers/user_provider.dart';
import 'package:by_hand/utilities/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:by_hand/models/product.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

import 'image_zoom.dart';

class DetailsPage extends StatefulWidget {
  DetailsPage(this.model);

  final Products model;

  @override
  _DetailsPageState createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  double rating = 0;
  Users user=Users('');
  String rate = '';
  String fullName = '';
  String address = '';
  String phone='';
  ApiBaseHelper _helper = ApiBaseHelper();


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getProductsData();
  }

  getProductsData() async {
    EasyLoading.show(status: "Loading".tr);
    UserProvider().getById(widget.model.userId).then((value) {
      EasyLoading.dismiss();
      setState(() {
        user = value;
        fullName = user.fname + ' ' + user.lname;
        address = user.address;
        phone=user.phone;
      });
    }).catchError((ex) {
      EasyLoading.dismiss();
      EasyLoading.showError(ex.toString().tr);
    });

    RateProvider().getSumRates(widget.model.id).then((value) {
      EasyLoading.dismiss();
      setState(() {
        rate = value;
      });
    }).catchError((ex) {
      EasyLoading.dismiss();
      EasyLoading.showError(ex.toString());
    });
  }
  handleRateAction() async {
    try {
      SharedPreferences a = await SharedPreferences.getInstance();

      int asa = a.getInt('id');

      String textMessage;
      Rates rate = new Rates();
      rate.productId = widget.model.id;
      rate.valueRate = rating;
      rate.userproduct = '$asa${widget.model.id}';

      await RateProvider().createNew(rate).then((value) {
        setState(() {
          textMessage = value['message'];
        });
      }).catchError((ex) {
        print(ex);
        textMessage = ex.toString();
      });
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => DetailsPage(widget.model),
          ));

      ScaffoldMessenger.of(context).showSnackBar(ss(textMessage));
    } catch (ex) {
      print(ex);
    }
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            children: [
              imageProduct(),
              Column(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.only(
                          topRight: Radius.circular(30),
                          topLeft: Radius.circular(30)),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        productInfo(),
                        userInfo(),
                        rateProduct(),


                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget appBar() => AppBar(
    foregroundColor: AppColors.primColor,
    leading: IconButton(
      onPressed: () {
        Navigator.pop(context);
      },
      icon: Icon(Icons.arrow_back_ios, color: AppColors.primColor),
    ),
    backgroundColor: Colors.white,
    title: Text(
      '${widget.model.name}',
      style: TextStyle(
          color: AppColors.primColor, fontWeight: FontWeight.bold),
    ),
    centerTitle: true,
  );

  Widget imageProduct() => Align(
    alignment: Alignment.topCenter,
    child: InkWell(
      onTap: (){
        Navigator.push(context, MaterialPageRoute(builder: (context) => ImageZoom(widget.model.image1),));
      },
      child: Container(
        height: 200,
        child: widget.model.image1 == null
            ? Image.asset('assets/images/google_icon.png')
            : Image.network(
          _helper.imageServer+widget.model.image1,
          fit: BoxFit.fill,
        ),
      ),
    ),
  );

  Widget userInfo() => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Padding(
        padding: const EdgeInsets.all(16.0),
        child: Text(
          'User information'.tr,
          overflow: TextOverflow.clip,
          style: TextStyle(
              color: AppColors.primColor,
              fontSize: 24,
              fontWeight: FontWeight.bold),
        ),
      ),
      Row(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: user.imageUrl != null&&user.imageUrl!=''
                  ? CircleAvatar(
                backgroundImage:
                NetworkImage(_helper.imageServer+user.imageUrl),
                radius: 55,
              )
                  : CircleAvatar(
                backgroundImage:
                AssetImage("assets/images/account.png"),
                radius: 55,
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                 user.type=="user" ?Text(
                    '$fullName',
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 22,
                        fontWeight: FontWeight.bold),
                  ):Text(
                   '$fullName'+" VIP",
                   style: TextStyle(
                       color: Colors.orange,
                       fontSize: 22,
                       fontWeight: FontWeight.bold),
                 ),
                  Text(
                    "Address".tr + ": " + '$address',
                    style: TextStyle(color: Colors.grey, fontSize: 20),
                  ),
                  InkWell(
                    onTap: () async {

                        var url = 'tel:$phone';
                        if (await canLaunch(url)) {
                      await launch(url);
                      } else {
                      throw 'Could not launch $url';
                      }

                    },
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Center(
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(
                                width: 2, color: AppColors.primColor),
                          ),
                          child: SizedBox(
                            height: 50,
                            width: 150,
                            child: Center(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.call,
                                    size: 20,
                                    color: AppColors.primColor,
                                  ),
                                  SizedBox(
                                    width: 4,
                                  ),
                                  Text(
                                    'Call'.tr,
                                    style: TextStyle(
                                        fontSize: 16,
                                        color: AppColors.primColor,
                                        fontWeight: FontWeight.bold),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    ],
  );

  Widget productInfo()=>Row(
    mainAxisAlignment: MainAxisAlignment.center,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Expanded(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Container(
            width: double.infinity,
            child: Column(
              crossAxisAlignment:
              CrossAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment:
                  CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Information'.tr,
                      overflow: TextOverflow.clip,
                      style: TextStyle(
                          color: AppColors.primColor,
                          fontSize: 24,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    Text(
                      '${widget.model.subName}',
                      style: TextStyle(
                          color: Colors.black87,
                          fontSize: 18,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                SizedBox(
                  height: 8,
                ),
                Text(
                  'Price'.tr +
                      ": " +
                      '${widget.model.price}',
                  textAlign: TextAlign.center,
                  overflow: TextOverflow.clip,
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 16,),
              ],
            ),
          ),
        ),
      ),
      Expanded(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Container(
            width: double.infinity,
            child: Column(
              crossAxisAlignment:
              CrossAxisAlignment.start,
              children: [
                Text(
                  'Description'.tr,
                  overflow: TextOverflow.clip,
                  style: TextStyle(
                      color: AppColors.primColor,
                      fontSize: 24,
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 16,
                ),
                Text(
                  "${widget.model.description}",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 14,
                      fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
        ),
      ),
    ],
  );

  Widget rateProduct()=>Padding(
    padding: const EdgeInsets.all(16.0),
    child: Row(
      children: [
        Text(
          "Likes".tr+": "+'$rate',
          style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold,),
        ),
        SizedBox(width: 8,),
        SmoothStarRating(
          color: AppColors.primColor,
          borderColor: AppColors.primColor,
          rating: rating,
          isReadOnly: false,
          size: 30,
          filledIconData: Icons.star,
          halfFilledIconData: Icons.star_half,
          defaultIconData: Icons.star_border,
          starCount: 3,
          allowHalfRating: true,
          spacing: 2,
          onRated: (value) {
            setState(() {
              rating = value;
            });
            handleRateAction();

            // print("rating value dd -> ${value.truncate()}");
          },
        ),
      ],
    ),
  );

  Widget ss(String message) => SnackBar(
        content: Text(
          '$message'.tr,
          textAlign: TextAlign.center,
        ),
      );
}
