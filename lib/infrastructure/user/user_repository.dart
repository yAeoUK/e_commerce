import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_ddd/domain/result/result.dart';
import 'package:flutter_ddd/domain/user/user.dart';
import 'package:flutter_ddd/domain/user/user_repository_base.dart';
import 'package:flutter_ddd/domain/user/value/username/username.dart';
import 'package:flutter_ddd/domain/user/value/password/password.dart';
import 'package:flutter_ddd/helper/shared_preferences_helper.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'data_source/api.dart';

class UserRepository implements UserRepositoryBase {
  SharedPreferencesHelper sharedPreferencesHelper;
  Api api;
  UserRepository({required this.sharedPreferencesHelper,
                  required this.api});

  @override
  Either<Unit, User> getUser() {
    if(sharedPreferencesHelper.containsKey(SharedPreferencesHelper.USER))
      return right(User.fromJson(json.decode(sharedPreferencesHelper.getString(SharedPreferencesHelper.USER)!) as Map<String,dynamic>));
    return left(null);
  }

  @override
  Future<void> setUser(User user) =>sharedPreferencesHelper.setString(
      SharedPreferencesHelper.USER,json.encode(user.toJson())
    );

  @override
  Future<Either<Result, User>> checkUser(Username username, Password password,BuildContext context){
    return api.checkUser(username,password,context);
  }

  @override
  Future<Either<Result, User>> facebookLogIn(FacebookAccessToken accessToken, BuildContext context) {
    return api.facebookLogIn(accessToken, context);
  }

  @override
  Future<Either<Result, User>> googleLogIn(String id, BuildContext context) {
    return api.googleLogIn(id, context);
  }

  @override
  Future<Either<Result, User>> registerUser(Username username, Password password, BuildContext context) {
    return api.registerUser(username, password, context);
  }

}