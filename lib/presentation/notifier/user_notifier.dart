import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_ddd/application/user_app_service.dart';
import 'package:flutter_ddd/domain/user/user.dart';

export 'package:flutter_ddd/application/dto/category_dto.dart';

class UserNotifier with ChangeNotifier {
  final UserAppService _app;

  UserNotifier({@required UserAppService app}) : _app = app {
    //_updateList();
  }

  Either<Unit,User> getUser(){
    return _app.getUser();
  }

  // Future<void> setUser(User user){
  //   //return _app.setUser(user);
  // }

  // List<CategoryDto> _list;

  // List<CategoryDto> get list => _list == null ? null : List.unmodifiable(_list);

  // Future<void> saveCategory({
  //   @required String name,
  // }) async {
  //   await _app.saveCategory(name: name);
  //   _updateList();
  // }

  // Future<void> updateCategory({
  //   @required String id,
  //   @required String name,
  // }) async {
  //   await _app.updateCategory(id: id, name: name);
  //   _updateList();
  // }

  // Future<void> removeCategory(String id) async {
  //   await _app.removeCategory(id);
  //   _updateList();
  // }

  // void _updateList() {
  //   _app.getCategoryList().then((list) {
  //     _list = list;
  //     notifyListeners();
  //   });
  // }
}
