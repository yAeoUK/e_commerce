import 'dart:convert';

import 'package:flutter_ddd/domain/user/value/image/image.dart';
import 'package:flutter_ddd/domain/user/value/image/imageConverter.dart';
import 'package:flutter_ddd/domain/user/value/password/password.dart';
import 'package:flutter_ddd/domain/user/value/password/passwordConverter.dart';
import 'package:flutter_ddd/domain/user/value/userId/UserId.dart';
import 'package:flutter_ddd/domain/user/value/userId/UserIdConverter.dart';
import 'package:flutter_ddd/domain/user/value/username/username.dart';
import 'package:flutter_ddd/domain/user/value/username/usernameConverter.dart';
import 'package:json_annotation/json_annotation.dart';
//flutter pub run build_runner watch
part 'user.g.dart';
@JsonSerializable(nullable: false)
@UserIdConverter()
@UsernameConverter()
@PasswordConverter()
@ImageConverter()
class User {
  
  final UserId id;
  final Username username;
  final Image image;
  //final Password password;

  User({required this.id,required this.username,required this.image/*,this.password*/});

  //UserId get id => _id;

  @override
  // ignore: avoid_equals_and_hash_code_on_mutable_classes
  bool operator ==(Object other) =>
      identical(other, this) || (other is User && other.id == id);

  @override
  // ignore: avoid_equals_and_hash_code_on_mutable_classes
  int get hashCode => runtimeType.hashCode ^ id.hashCode^image.hashCode;

  // void changeName(CategoryName newName) {
  //   _name = newName;
  // }

  factory User.fromJson(Map<String,dynamic> jso) =>_$UserFromJson(jso);

  Map<String,dynamic> toJson() => _$UserToJson(this);

}