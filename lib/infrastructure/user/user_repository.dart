import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_ddd/domain/result/result.dart';

import 'package:flutter_ddd/domain/user/user.dart';
import 'package:flutter_ddd/domain/user/user_repository_base.dart';
import 'package:flutter_ddd/domain/user/value/username/username.dart';
import 'package:flutter_ddd/domain/user/value/password/password.dart';
import 'package:flutter_ddd/shared_preferences_helper.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'data_source/api.dart';

class UserRepository implements UserRepositoryBase {
  SharedPreferencesHelper sharedPreferencesHelper;
  Api api;
  SharedPreferences instance;
  UserRepository({@required this.sharedPreferencesHelper,
                  @required this.api}){
    instance=sharedPreferencesHelper.getInstance();
  }

  @override
  Either<Unit, User> getUser() {
    if(instance.containsKey(SharedPreferencesHelper.USER))
      return right(User.fromJson(instance.getString(SharedPreferencesHelper.USER)));
    return left(null);
  }

  @override
  Future<void> setUser(User user) =>instance.setString(
      SharedPreferencesHelper.USER,user.toJson()
    );

  @override
  Future<Either<Result, User>> checkUser(Username username, Password password,BuildContext context){
    return api.checkUser(username,password,context);
  }

}