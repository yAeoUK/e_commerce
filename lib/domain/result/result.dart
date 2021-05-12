import 'dart:convert';

import 'package:flutter_ddd/domain/result/value/message/message.dart';
import 'package:flutter_ddd/domain/result/value/message/message_converter.dart';
import 'package:flutter_ddd/domain/result/value/preference/preference.dart';
import 'package:flutter_ddd/domain/result/value/sql/sql.dart';
import 'package:flutter_ddd/domain/result/value/sql/sql_converter.dart';
import 'package:json_annotation/json_annotation.dart';
//flutter pub run build_runner watch
part 'result.g.dart';
@JsonSerializable(nullable: false)
@MessageConverter()
@SQLConverter()
class Result {
  
  final Message message;
  //final SQL sql;
  //final List<Preference> preferences;

  Result({required this.message});//,this.sql,this.preferences});


  @override
  // ignore: avoid_equals_and_hash_code_on_mutable_classes
  bool operator ==(Object other) =>
      identical(other, this) || (other is Result && other.message== message);//&&other.sql==sql&&other.preferences==preferences);

  @override
  // ignore: avoid_equals_and_hash_code_on_mutable_classes
  int get hashCode => runtimeType.hashCode ^ message.hashCode;// ^ sql.hashCode^preferences.hashCode;

  // void changeName(CategoryName newName) {
  //   _name = newName;
  // }

  factory Result.fromJson(String jso) => _$ResultFromJson(json.decode(jso) as Map<String,dynamic>);
  String toJson() => _$ResultToJson(this).toString();

}