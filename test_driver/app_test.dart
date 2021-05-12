import 'package:flutter_driver/flutter_driver.dart';
import 'package:flutter_test/flutter_test.dart';

void main(){
  FlutterDriver? flutterDriver;
  setUpAll(() async {
    flutterDriver=await FlutterDriver.connect();
  });

  tearDownAll((){
    flutterDriver?.close();
  });


}