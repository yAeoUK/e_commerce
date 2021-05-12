import 'package:flutter/material.dart';
import 'package:flutter_ddd/common/size_config.dart';
import 'package:flutter_ddd/helper/db_helper.dart';
import 'package:flutter_ddd/helper/device_info.dart';
import 'package:flutter_ddd/helper/shared_preferences_helper.dart';
import 'package:flutter_ddd/presentation/page/home/home_screen.dart';
import 'package:flutter_ddd/presentation/page/sign_in/sign_in_screen.dart';
import 'package:flutter_ddd/presentation/page/splash/results.dart';
import 'package:flutter_ddd/presentation/page/splash/splash_screen.dart';
import '../domain/user/user_repository_base.dart';

class AppInit {
  final GlobalKey<NavigatorState> navigatorKey;
  final DbHelper dbHelper;
  final SharedPreferencesHelper preferencesHelper;
  final UserRepositoryBase userRepositoryBase;
  final DeviceInfoHelper deviceInfo;

  Future<void> init(BuildContext context)async {
    AppInit(context,
        navigatorKey: navigatorKey,
        dbHelper: dbHelper,
        preferencesHelper: preferencesHelper,
        userRepositoryBase: userRepositoryBase,
        deviceInfo: deviceInfo
    );
  }

  Future<void> initialise(BuildContext context)async{
    await dbHelper.open();
    await preferencesHelper.configure();
    await deviceInfo.configure(context);
  }

  void materialInitialise(BuildContext context){
    SizeConfig().init(context);
  }

  AppInit(BuildContext context,{
    required this.navigatorKey,
    required this.dbHelper,
    required this.preferencesHelper,
    required this.userRepositoryBase,
    required this.deviceInfo
  }) {
    // dbHelper.open().then((_) {
    //   navigatorKey.currentState.pushNamedAndRemoveUntil<void>(
    //     SplashScreen.routeName,
    //     (_) => false,
    //   );
    // });
    initialise(context).then((_) async {
      if(preferencesHelper.getBool(SharedPreferencesHelper.LOAD_SPLASH_SCREEN
                                  ,defaultValue: true)==true){
          final result=await navigatorKey.currentState!.pushNamedAndRemoveUntil(
          SplashScreen.routeName,
          (_) => false,
          );
          if(result==SplashResult.Continue){
            init(context);
          }
      }
      else if (userRepositoryBase.getUser().isRight()){
        navigatorKey.currentState!.pushNamedAndRemoveUntil<void>(
          HomeScreen.routeName,
          (_) => false,
        );
      }
      else {
        final result=await navigatorKey.currentState!.pushNamedAndRemoveUntil(
          SignInScreen.routeName,
          (_) => false,
        );
        if(result==SignInResult.success){
          init(context);
        }
      }
    });
  }
}