import 'package:by_hand/my_flutter_app_icons.dart';
import 'package:by_hand/screens/categoty_screen.dart';
import 'package:by_hand/screens/favorite_page.dart';
import 'package:by_hand/screens/profile_page.dart';
import 'package:by_hand/utilities/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:by_hand/screens/add_item.dart';

import 'homeBody.dart';

class HomePage extends StatefulWidget {
  static const String id = 'home_page';

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {



  int _currentIndex = 0;
  final List<Widget> _children = [
    HomeBody(),
    CategoryScreen(),
    AddItem(),
    FavoritePage(),
    ProfilePage(),
  ];

  void onTapedBar(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0.0,
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        title: RichText(
          textAlign: TextAlign.center,
          text: TextSpan(
              text: 'By',
              style: TextStyle(
                fontFamily: 'GrandHotel',
                fontSize: 30,
                fontWeight: FontWeight.w700,
                color: AppColors.primColor,
              ),
              children: [
                TextSpan(
                  text: 'hand',
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 30,
                      fontFamily: 'GrandHotel'),
                ),
              ]),
        ),
        centerTitle: true,
        leading:           Padding(
          padding: const EdgeInsets.all(8.0),
          child: IconButton(
            icon: Icon(
              Icons.notifications_none,
              color: AppColors.primColor,
            ),
            onPressed: () {
              Navigator.pushNamed(context, '/notifications');
            },
          ),
        )
        ,
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: IconButton(
              icon: Icon(
                Icons.settings_outlined,
                color: AppColors.primColor,
              ),
              onPressed: () {
                Navigator.pushNamed(context, '/setting');
              },
            ),
          )
        ],
      ),
      body: _children[_currentIndex],
      bottomNavigationBar: bottomBar(),
    );
  }

  Widget bottomBar() => CurvedNavigationBar(
        index: _currentIndex,
        height: 50.0,
        items: <Widget>[
          Icon(
            MyFlutterApp.home_1,
            size: 16,
            color: AppColors.shadeColor,
          ),
          Icon(
            MyFlutterApp.th_large,
            size: 16,
            color: AppColors.shadeColor,
          ),
          Icon(
            MyFlutterApp.plus_circled,
            size: 16,
            color: AppColors.shadeColor,
          ),
          Icon(
            MyFlutterApp.heart_1,
            size: 16,
            color: AppColors.shadeColor,
          ),
          Icon(
            MyFlutterApp.user_1,
            size: 16,
            color: AppColors.shadeColor,
          ),
        ],
        color: Colors.white,
        buttonBackgroundColor: Colors.white,
        backgroundColor: AppColors.primColor,
        animationCurve: Curves.easeInOut,
        onTap: onTapedBar,
        letIndexChange: (index) => true,
      );
}
