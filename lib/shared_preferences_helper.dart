import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesHelper {

  static const LOAD_SPLASH_SCREEN='loadSplashScreen';
  static const USER='user';

  SharedPreferences _instance;

  SharedPreferences getInstance()=>_instance;

  Future<SharedPreferences> configure()async{
    _instance= await SharedPreferences.getInstance();
    return _instance;
  }

  void dispose(){
    _instance=null;
  }
}