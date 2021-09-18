import 'package:by_hand/models/notifications_model.dart';
import 'package:by_hand/providers/notifications_provider.dart';
import 'package:by_hand/utilities/app_colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';

class NotificationsPage extends StatefulWidget {
  @override
  _NotificationsPageState createState() => _NotificationsPageState();
}

class _NotificationsPageState extends State<NotificationsPage> {
  List<NotificationsModel> notifications = [];

  @override
  void initState() {
    super.initState();
    getProducts();
  }

  getProducts() async {
    EasyLoading.show(status: "Loading".tr);
    NotificationsProviders().getAll().then((value) {
      EasyLoading.dismiss();
      setState(() {
        notifications = value;
      });
    }).catchError((ex) {
      EasyLoading.dismiss();
      EasyLoading.showError(ex.toString());
    });
  }

  bool isEmpty = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.backgroundColor,
        appBar: AppBar(
          backgroundColor: AppColors.primColor,
          title: Text('notifications'.tr),
          centerTitle: true,
          flexibleSpace: Container(),
        ),
        body: ListView.builder(
            shrinkWrap: true,
            physics: ScrollPhysics(),
            itemCount: notifications.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        // BoxShadow(
                        //   offset: Offset(0, 8),
                        //   blurRadius: 24,
                        //   color: Color(0x15000000),
                        // )
                      ]),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top:12.0,right: 12.0,left: 12.0),
                        child: Text('${notifications[index].title}',style: TextStyle(fontSize: 14,fontWeight: FontWeight.bold),),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Text('${notifications[index].body}'),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(12.0, 0, 12, 8),
                        child: Text(
                          '${notifications[index].createdAt}',
                          style: TextStyle(color: Colors.grey, fontSize: 10),
                          textAlign: TextAlign.start,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }));
  }
}