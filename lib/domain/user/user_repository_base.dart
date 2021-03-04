import 'package:flutter/cupertino.dart';
import 'package:flutter_ddd/domain/result/result.dart';
import 'package:flutter_ddd/domain/user/user.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_ddd/domain/user/value/password/password.dart';
import 'package:flutter_ddd/domain/user/value/username/username.dart';

abstract class UserRepositoryBase{
  Either<Unit,User> getUser();
  Future<void> setUser(User user);
  Future<Either<Result,User>>checkUser(Username username,Password password,BuildContext context);
}