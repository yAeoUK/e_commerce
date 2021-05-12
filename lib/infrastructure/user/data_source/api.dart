import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter_ddd/common/parameters.dart';
import 'package:flutter_ddd/domain/result/result.dart';
import 'package:flutter_ddd/domain/result/value/message/message.dart';
import 'package:flutter_ddd/domain/result/value/sql/sql.dart';
import 'package:flutter_ddd/domain/user/user.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_ddd/domain/user/user_repository_base.dart';
import 'package:flutter_ddd/domain/user/value/username/username.dart';
import 'package:flutter_ddd/domain/user/value/password/password.dart';
import 'package:flutter_ddd/helper/db_helper.dart';
import 'package:flutter_ddd/helper/device_info.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:http/http.dart';
import 'package:provider/provider.dart';

class Api implements UserRepositoryBase {
  @override
  Future<Either<Result, User>> checkUser(Username username, Password password,BuildContext context)async{
    final Map map=<String,String>{
      'username':username.value,
      'password':password.value,
      'clientInfo':context.read<DeviceInfoHelper>().getDeviceInfo(context).toString()
    };
    String body='';
     try{
      final response=await post(Uri.parse(ROOT_URL+'login.php'),body: map);
      if(response.statusCode==200){
        body=response.body;
        final Map<String,dynamic> bodyJson=jsonDecode(body) as Map<String,dynamic>;
        if(bodyJson['result']==0){
          return right(
            User.fromJson(bodyJson['user'] as Map<String,dynamic>)
          );
        }
        else if (bodyJson['result']==1){
          final SQL sql=SQL(bodyJson['sql'].toString()??'');
          context.read<DbHelper>().execute(sql);
          return left(
            Result(
              message: Message(bodyJson['message'].toString()),
              //sql: SQL(bodyJson['sql'].toString()??''),
              //preferences: Preference()
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
           message: Message(body)
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

  @override
  Future<Either<Result, User>> facebookLogIn(FacebookAccessToken accessToken,BuildContext context) async{
    final Map map=<String,String>{
      'id':accessToken.userId,
      'clientInfo':context.read<DeviceInfoHelper>().getDeviceInfo(context).toString()
    };
    String body='';
    try{
      final response=await post(Uri.parse(ROOT_URL+'facebookVerification.php'),body: map);
      if(response.statusCode==200){
        body=response.body;
        final Map<String,dynamic> bodyJson=jsonDecode(body) as Map<String,dynamic>;
        if(bodyJson['result']==0){
          return right(
              User.fromJson(bodyJson['user'] as Map<String,dynamic>)
          );
        }
        else if (bodyJson['result']==1){
          final SQL sql=SQL(bodyJson['sql'].toString()??'');
          context.read<DbHelper>().execute(sql);
          return left(
              Result(
                message: Message(bodyJson['message'].toString()),
                //sql: SQL(bodyJson['sql'].toString()??''),
                //preferences: Preference()
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
              message: Message(body)
          )
      );
    }
  }

  @override
  Future<Either<Result, User>> googleLogIn(String id, BuildContext context) async{
    final Map map=<String,String>{
      'id':id,
      'clientInfo':context.read<DeviceInfoHelper>().getDeviceInfo(context).toString()
    };
    String body='';
    try{
      final response=await post(Uri.parse(ROOT_URL+'googleVerification.php'),body: map);
      if(response.statusCode==200){
        body=response.body;
        final Map<String,dynamic> bodyJson=jsonDecode(body) as Map<String,dynamic>;
        if(bodyJson['result']==0){
          return right(
              User.fromJson(bodyJson['user'] as Map<String,dynamic>)
          );
        }
        else if (bodyJson['result']==1){
          final SQL sql=SQL(bodyJson['sql'].toString()??'');
          context.read<DbHelper>().execute(sql);
          return left(
              Result(
                message: Message(bodyJson['message'].toString()),
                //sql: SQL(bodyJson['sql'].toString()??''),
                //preferences: Preference()
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
              message: Message(body)
          )
      );
    }
  }

  @override
  Future<Either<Result, User>> registerUser(Username username, Password password, BuildContext context) async{
    final Map map=<String,String>{
      'username':username.value,
      'password':password.value,
      'clientInfo':context.read<DeviceInfoHelper>().getDeviceInfo(context).toString()
    };
    String body='';
    try{
      final response=await post(Uri.parse(ROOT_URL+'register.php'),body: map);
      if(response.statusCode==200){
        body=response.body;
        final Map<String,dynamic> bodyJson=jsonDecode(body) as Map<String,dynamic>;
        if(bodyJson['result']==0){
          return right(
              User.fromJson(bodyJson['user'] as Map<String,dynamic>)
          );
        }
        else if (bodyJson['result']==1){
          final SQL sql=SQL(bodyJson['sql'].toString()??'');
          context.read<DbHelper>().execute(sql);
          return left(
              Result(
                message: Message(bodyJson['message'].toString()),
                //sql: SQL(bodyJson['sql'].toString()??''),
                //preferences: Preference()
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
              message: Message(body)
          )
      );
    }
  }

}