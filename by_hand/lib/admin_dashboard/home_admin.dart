import 'package:by_hand/admin_dashboard/category_admin.dart';
import 'package:by_hand/admin_dashboard/dashboard.dart';
import 'package:by_hand/admin_dashboard/packages_admin.dart';
import 'package:by_hand/admin_dashboard/products_admin.dart';
import 'package:by_hand/admin_dashboard/users.dart';
import 'package:by_hand/models/user.dart';
import 'package:by_hand/my_flutter_app_icons.dart';
import 'package:by_hand/providers/api_helper.dart';
import 'package:by_hand/providers/user_provider.dart';
import 'package:by_hand/screens/login.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:get/get.dart';

import 'note_admin.dart';

class HomeAdmin extends StatefulWidget {
  @override
  _HomeAdminState createState() => _HomeAdminState();
}

class _HomeAdminState extends State<HomeAdmin> {
  ApiBaseHelper _helper = ApiBaseHelper();
  String fullName='';
  Users user=Users('');
  
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getProductsData();
  }

  getProductsData() async {
    EasyLoading.show(status: "Loading".tr);
    SharedPreferences a = await SharedPreferences.getInstance();

    UserProvider().getById(a.getInt('id')).then((value) {
      EasyLoading.dismiss();
      setState(() {

        fullName = value.fname+" "+value.lname;
        user=value;

      });
    }).catchError((ex) {
      EasyLoading.dismiss();
      EasyLoading.showError(ex
          .toString()
          .tr);
    });
  }

    @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
          child: SafeArea(
        child: Container(
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: user.imageUrl != null &&user.imageUrl!=''
                          ? CircleAvatar(
                        backgroundImage:
                        NetworkImage("${_helper.imageServer+user.imageUrl}"),
                        radius: 55,
                      )
                          : CircleAvatar(
                        backgroundImage:
                        AssetImage("assets/images/account.png"),
                        radius: 55,
                      ),
                    ),

                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Admin",
                            style: TextStyle(
                                color: Colors.teal,
                                fontWeight: FontWeight.bold,
                                fontSize: 36),
                          ),
                          Text(
                            "$fullName",
                            style: TextStyle(
                                color: Colors.teal,
                                fontWeight: FontWeight.bold,
                                fontSize: 16),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                child: Wrap(
                  children: [
                    Row(
                      children: [
                        Expanded(
                            flex: 1,
                            child: containerCustom(
                                Icons.person_outlined, "Users", () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => UsersGet(),
                                  ));
                            })),
                        Expanded(
                          flex: 1,
                          child: containerCustom(
                              Icons.list_alt, "Products", () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ProductsAdmin(),
                                ));
                          }),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Expanded(
                          flex: 1,
                          child: containerCustom(
                              Icons.dashboard_outlined, "Categories", () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => CategoryAdmin(),
                                ));
                          }),
                        ),
                        Expanded(
                          flex: 1,
                          child: containerCustom(
                              Icons.padding, "Packages", () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => PackagesAdmin(),
                                ));
                          }),
                        ),

                      ],
                    ),
                    Row(
                      children: [
                        Expanded(
                          flex: 1,
                          child: containerCustom(
                              Icons.notifications_none, "Notifications", () {
                            _launchURL();
                          }),
                        ),
                        Expanded(
                          flex: 1,
                          child: containerCustom(
                              Icons.notes, "Notes", () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => NotesPage(),
                                ));
                          }),
                        ),

                      ],
                    ),
                  ],
                ),
              ),

              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  width: 350,
                  height: 54,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: Colors.teal),
                  child: TextButton(
                    onPressed: () async {
                      SharedPreferences prefs =
                      await SharedPreferences.getInstance();
                      prefs.setBool('isLogin', false);
                      prefs.clear();
                      Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => LoginPage(),), (route) => false);
                    },
                    child: Text(
                      'logout'.tr,
                      style: TextStyle(color: Colors.white, fontSize: 22),
                    ),
                  ),
                ),
              ),

            ],
          ),
        ),
      )),
    );
  }

  Widget buttonDashboard(String name, String details, Color first, Color sac) =>
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          margin: EdgeInsets.only(left: 4, right: 2),
          height: 150,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8.0),
            boxShadow: [
              BoxShadow(
                  color: Colors.grey[300], blurRadius: 6, offset: Offset(0, 5))
            ],
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment(0.8, 0.0),
              // 10% of the width, so there are ten blinds.
              colors: [first, sac],
              // red to yellow
              // repeats the gradient over the canvas
            ),
          ),
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                name,
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 22),
              ),
            ),
          ),
        ),
      );

  Widget containerCustom(IconData iconData, String txt, Function fun) =>
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: InkWell(
          onTap: fun,
          child: Container(
            height: 125,
            alignment: Alignment.center,
            decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                      color: Colors.grey[300],
                      blurRadius: 8,
                      offset: Offset(0, 6))
                ],
                borderRadius: BorderRadius.circular(15)),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Container(
                width: double.infinity,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Icon(
                      iconData,
                      color: Colors.teal,
                      size: 30,
                    ),
                    Text(
                      '$txt',
                      style: TextStyle(fontSize: 20, color: Colors.teal),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      );

  _launchURL() async {
    var url = 'https://app.onesignal.com/apps/948f263b-04e0-47e0-84e9-5b52d4ca2e36#outcomes=os__click__count';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
