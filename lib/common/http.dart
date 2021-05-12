// import 'package:flutter_ddd/common/http_base.dart';
//
// class Http<T>{
//   String url;
//   Map<String,String> map;
//   Http(this.url,{this.map});
//   Future onPreConnect;
//
//   void onConnectionFailed(Future x) {
//     // TODO: implement onConnectionFailed
//   }
//
//   @override
//   void onConnectionSucceed(Future x) {
//     // TODO: implement onConnectionSucceed
//   }
//
//   @override
//   void onMessageReceived(Future x) {
//     // TODO: implement onMessageReceived
//   }
//
//   @override
//   void onPostConnection(Future x) {
//     // TODO: implement onPostConnection
//   }
//
//   @override
//   void onRetry(Future x) {
//     // TODO: implement onRetry
//   }
//
//   @override
//   Future<void> onPreConnection(Future<void> onPreConnect){
//     this.onPreConnect=onPreConnect;
//   }
//
// }