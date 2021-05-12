import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesHelper {

  static const LOAD_SPLASH_SCREEN='loadSplashScreen';
  static const USER='user';

  late SharedPreferences _instance;

  SharedPreferences getInstance()=>_instance;

  Future<SharedPreferences> configure()async{
    _instance= await SharedPreferences.getInstance();
    return _instance;
  }

  void dispose(){

  }

  bool? getBool(String key,{bool? defaultValue}){
    return _instance.getBool(key)??defaultValue;
  }

  dynamic get(String key){
    return _instance.get(key);
  }

  String? getString(String key,{String? defaultValue}){
    return _instance.getString(key)??defaultValue;
  }

  Future setString(String key,String value){
    return _instance.setString(key, value);
  }

  bool containsKey(String key){
    return _instance.containsKey(key);
  }


}