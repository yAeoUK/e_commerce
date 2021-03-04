import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter_ddd/domain/result/result.dart';
import 'package:flutter_ddd/domain/result/value/message/message.dart';
import 'package:flutter_ddd/domain/result/value/sql/sql.dart';
import 'package:flutter_ddd/domain/user/user.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_ddd/domain/user/user_repository_base.dart';
import 'package:flutter_ddd/domain/user/value/username/username.dart';
import 'package:flutter_ddd/domain/user/value/password/password.dart';
import 'package:flutter_ddd/helper/device_info.dart';
import 'package:http/http.dart';
import 'package:provider/provider.dart';

import '../../../parameters.dart';

class Api implements UserRepositoryBase {
  @override
  Future<Either<Result, User>> checkUser(Username username, Password password,BuildContext context)async{
    final Map map=<String,String>{
      'username':username.value,
      'password':password.value,
      'clientInfo':context.read<DeviceInfo>().data.toString()
    };
     try{
      final response=await post(ROOT_URL+'login.php',body: map);
      if(response.statusCode==200){
        final String body=response.body;
        final dynamic bodyJson=json.decode(body);
        if(bodyJson['result']=='0'){
          return right(
            User.fromJson(bodyJson['user'].toString())
          );
        }
        else if (bodyJson['result']=='1'){
          return left(
            Result(
              message: Message(bodyJson['message'].toString()),
              sql: SQL(bodyJson['sql'].toString()??'')
            )
          );
        }
      }
      return left(
        Result(
          message: Message(response.body)
        )
      );
     }catch(e){
       return left(
         Result(
           message: Message(e.toString())
         )
       );
     }
  }

  @override
  Either<Unit, User> getUser() {
    throw UnimplementedError();
  }

  @override
  Future<void> setUser(User user) {
    throw UnimplementedError();
  }
  

}