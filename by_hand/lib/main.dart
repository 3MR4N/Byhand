import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:by_hand/screens/add_item.dart';
import 'package:by_hand/screens/edit_account.dart';
import 'package:by_hand/screens/home_page.dart';
import 'package:by_hand/screens/login.dart';
import 'package:by_hand/screens/notifications.dart';
import 'package:by_hand/screens/profile_page.dart';
import 'package:by_hand/screens/register_page.dart';
import 'package:by_hand/screens/settings.dart';
import 'package:by_hand/utilities/app_colors.dart';
import 'package:by_hand/utilities/translations/localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:get_storage/get_storage.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:by_hand/models/favoriteModel.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'models/productModel.dart';


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();

  SharedPreferences getScreen=await SharedPreferences.getInstance();
  Widget _screen;
  bool seen = getScreen.getBool('isLogin');
  if(seen==false||seen==null){
    _screen=LoginPage();
  }else{
    _screen=HomePage();
  }
  runApp(MyApp(_screen));
}

class MyApp extends StatelessWidget {
  MyApp(this.screen);
  final Widget screen;

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(
          value: Products(),
        ),
        ChangeNotifierProvider.value(
          value: Favorite(),
        ),
      ],
      child: GetMaterialApp(
        translations: LocalizationService(),
        locale: LocalizationService().getCurrentLocale(),
        fallbackLocale: Locale('en','US'),
        themeMode: ThemeMode.system,
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          fontFamily: LocalizationService().getCurrentLocale() == Locale('ar','AE')? 'Tajawal':'Roboto',
            ),
        builder: EasyLoading.init(),
        home: AnimatedSplashScreen(
            duration: 3000,
            splashIconSize: 150,
            splash: Center(child: RichText(
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
            ),),
            nextScreen: screen,
            splashTransition: SplashTransition.fadeTransition,
            pageTransitionType: PageTransitionType.fade,
            backgroundColor: Colors.white),
        routes: {
          '/login': (context) => LoginPage(),
          '/home': (context) => HomePage(),
          '/register': (context) => SignUpPage(),
          '/setting': (context) => SettingsPage(),
          '/edit_profile':(context)=>EditAccount(),
          '/profile':(context)=>ProfilePage(),
          'add_item':(context)=>AddItem(),
          '/notifications':(context)=>NotificationsPage(),


        },
      ),
    );
  }

}
