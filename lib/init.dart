import 'package:flutter/material.dart';
import 'package:flutter_ddd/helper/device_info.dart';
import 'package:flutter_ddd/infrastructure/db_helper.dart';
import 'package:flutter_ddd/presentation/page/home/home_screen.dart';
import 'package:flutter_ddd/presentation/page/sign_in/sign_in_screen.dart';
import 'package:flutter_ddd/presentation/page/splash/splash_screen.dart';
import 'package:flutter_ddd/shared_preferences_helper.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'domain/user/user_repository_base.dart';

class AppInit {
  final GlobalKey<NavigatorState> navigatorKey;
  final DbHelper dbHelper;
  final SharedPreferencesHelper preferencesHelper;
  final UserRepositoryBase userRepositoryBase;
  final DeviceInfo deviceInfo;

  Future<void> initialise(BuildContext context)async{
    await dbHelper.open();
    await preferencesHelper.configure();
    await deviceInfo.configure(context);
  }

  AppInit(BuildContext context,{
    @required this.navigatorKey,
    @required this.dbHelper,
    @required this.preferencesHelper,
    @required this.userRepositoryBase,
    @required this.deviceInfo
  }) {
    // dbHelper.open().then((_) {
    //   navigatorKey.currentState.pushNamedAndRemoveUntil<void>(
    //     SplashScreen.routeName,
    //     (_) => false,
    //   );
    // });
    initialise(context).then((_){
      final SharedPreferences instance=preferencesHelper.getInstance();
      if(instance.getBool(SharedPreferencesHelper.LOAD_SPLASH_SCREEN)??true){
          navigatorKey.currentState.pushNamedAndRemoveUntil<void>(
          SplashScreen.routeName,
          (_) => false,
        );
      }
      else if (userRepositoryBase.getUser()!=null){
        navigatorKey.currentState.pushNamedAndRemoveUntil<void>(
          HomeScreen.routeName,
          (_) => false,
        );
      }
      else {
        navigatorKey.currentState.pushNamedAndRemoveUntil<void>(
          SignInScreen.routeName,
          (_) => false,
        );
      }
    });
  }
}