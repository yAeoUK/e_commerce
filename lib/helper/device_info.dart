import 'dart:convert';

import 'package:device_info/device_info.dart';
import 'package:flutter/cupertino.dart';
import 'package:package_info/package_info.dart';
//import 'package:trust_fall/trust_fall.dart';

class DeviceInfoHelper{

  late Map<String,String> _data;

  String getDeviceInfo(BuildContext context){
    _data.addAll({
      'appLanguage':Localizations.localeOf(context).languageCode,
    });

    return json.encode(_data).toString();
  }

  Future configure(BuildContext context)async{
    final DeviceInfoPlugin deviceInfoPlugin=DeviceInfoPlugin();
    final AndroidDeviceInfo androidDeviceInfo= await deviceInfoPlugin.androidInfo;
    //final bool isJailBroken = await TrustFall.isJailBroken;
    final PackageInfo packageInfo = await PackageInfo.fromPlatform();
    _data= {
      'buildModel':androidDeviceInfo.model,
      'androidAPI':androidDeviceInfo.version.sdkInt.toString(),
      //'rooted':isJailBroken?'1':'0',
      'isEmulator':androidDeviceInfo.isPhysicalDevice?'0':'1',
      //'appLanguage':Localizations.localeOf(context).languageCode,
      'appVersionName':packageInfo.version,
      'appVersionCode':packageInfo.buildNumber,
      'appPackageName':packageInfo.packageName
    };
  }
}