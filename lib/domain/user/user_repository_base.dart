import 'package:flutter/cupertino.dart';
import 'package:flutter_ddd/domain/result/result.dart';
import 'package:flutter_ddd/domain/user/user.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_ddd/domain/user/value/password/password.dart';
import 'package:flutter_ddd/domain/user/value/username/username.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';

abstract class UserRepositoryBase{
  Either<Unit,User> getUser();
  Future<void> setUser(User user);
  Future<Either<Result,User>>checkUser(Username username,Password password,BuildContext context);
  Future<Either<Result,User>>registerUser(Username username,Password password,BuildContext context);
  Future<Either<Result,User>>facebookLogIn(FacebookAccessToken accessToken,BuildContext context);
  Future<Either<Result,User>>googleLogIn(String id,BuildContext context);
}