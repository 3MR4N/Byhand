import 'package:by_hand/components/button_container.dart';
import 'package:by_hand/models/package.dart';
import 'package:by_hand/providers/package_provider.dart';
import 'package:by_hand/providers/user_provider.dart';
import 'package:by_hand/screens/add_notes.dart';
import 'package:by_hand/utilities/app_colors.dart';
import 'package:by_hand/utilities/translations/localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:get/get.dart';

class SettingsPage extends StatefulWidget {
  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  void initState() {
    super.initState();
    lng = LocalizationService().getCurrentLang();
    getProductsData();

  }

  String lng = "English";
  String phone = '0785384521';

  List<Package>myModels=[];
  List<String>desc=[];
  getProductsData() {
    EasyLoading.show(status: "Loading".tr);
    PackageProvider().getAllByAccount().then((value) {
      EasyLoading.dismiss();
      setState(() {
        myModels = value;
        desc=myModels[0].description.split("\n");
      });
    }).catchError((ex) {
      EasyLoading.dismiss();
      EasyLoading.showError(ex.toString());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        backgroundColor: AppColors.primColor,
        title: Text("settings".tr),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.only(left: 20, right: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Expanded(
              flex: 8,
              child: Column(
                children: [
                  SizedBox(
                    height: 15,
                  ),
                  ButtonContainer(
                    buttonName: 'Edit Account'.tr,
                    fun: () {
                      Navigator.pushNamed(context, "/edit_profile");
                    },
                    imageCust: "assets/images/account.png",//_makingPhoneCall,
                  ),
                  SizedBox(
                    height: 6,
                  ),
                  // ButtonContainer(
                  //   buttonName: 'Support'.tr,
                  //   fun: () async {
                  //     var url = 'tel:$phone';
                  //     if (await canLaunch(url)) {
                  //       await launch(url);
                  //     } else {
                  //       throw 'Could not launch $url';
                  //     }
                  //   },
                  //   imageCust: "assets/images/support.png",//_makingPhoneCall,
                  // ),
                  ButtonContainer(
                    buttonName: 'Connect Us'.tr,
                    fun: () {
                      Navigator.push(context,MaterialPageRoute(builder: (context) => RequestNote(),));
                    },
                    imageCust: "assets/images/support.png",//_makingPhoneCall,
                  ),

                  SizedBox(
                    height: 6,
                  ),
                  Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(15)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(15)),
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: DropdownButton<String>(
                              items:
                              LocalizationService.langs.map((String value) {
                                return DropdownMenuItem(
                                  child: Text(value),
                                  value: value,
                                );
                              }).toList(),
                              value: this.lng,
                              underline: Container(
                                color: Colors.transparent,
                              ),
                              isExpanded: false,
                              onChanged: (newVal) {
                                setState(() {
                                  this.lng = newVal;
                                  LocalizationService().changeLocale(newVal);
                                });
                              },
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        lng == "English"
                            ? CircleAvatar(
                          radius: 25,
                          backgroundImage:
                          AssetImage('assets/images/uk.png'),
                        )
                            : CircleAvatar(
                          radius: 25,
                          backgroundImage:
                          AssetImage('assets/images/jo.png'),
                        )
                      ],
                    ),
                  ),
                  SizedBox(height: 16,),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                        width: double.infinity,
                        child: Text("Upgrade Account".tr,style: TextStyle(color: AppColors.primColor,fontWeight: FontWeight.bold,fontSize: 16),)),
                  ),
                  myModels.isNotEmpty
                      ? InkWell(
                    onTap: (){

                      _showDoneDia();

                    },
                        child: Container(
                            margin: EdgeInsets.only(left: 4, right: 2),
                            width: double.infinity,
                            height: 170,
                            decoration: BoxDecoration(
                              color: AppColors.primColor,
                              borderRadius: BorderRadius.circular(8.0),
                              boxShadow: [
                                BoxShadow(
                                    color: Colors.grey[300],
                                    blurRadius: 6,
                                    offset: Offset(0, 5))
                              ],
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "${myModels[0].name}",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 36),
                                      ),
                                      Text(
                                        "${myModels[0].price}",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 36),
                                      ),
                                    ],
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      "${myModels[0].description.replaceAll("\\n", "\n")}".tr,
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                      )
                      : Container()
                ],
              ),
            ),
            Container(
              width: 350,
              height: 54,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: AppColors.primColor),
              child: TextButton(
                onPressed: () async {
                  SharedPreferences prefs =
                  await SharedPreferences.getInstance();
                  prefs.setBool('isLogin', false);
                  prefs.clear();
                  Navigator.of(context).pushNamedAndRemoveUntil(
                      '/login', (Route<dynamic> route) => false);
                },
                child: Text(
                  'logout'.tr,
                  style: TextStyle(color: Colors.white, fontSize: 22),
                ),
              ),
            ),
            SizedBox(
              height: 30,
            )
          ],
        ),
      ),
    );
  }

  handelEditAccount(int type,int index) async {


    UserProvider()
        .editUser(type,index)
        .then((var res) async {
      EasyLoading.showSuccess(res['message'].toString());
    }).catchError((ex) {
      setState(() {
        EasyLoading.showError(ex.toString());
        print(ex);
      });
    });
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
                Text('Upgrade Account '.tr),
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
                  SharedPreferences pre=await SharedPreferences.getInstance();
                  handelEditAccount(2,pre.getInt('id'));
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
