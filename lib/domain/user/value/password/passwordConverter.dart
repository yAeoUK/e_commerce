import 'package:flutter_ddd/domain/user/value/password/password.dart';
import 'package:json_annotation/json_annotation.dart';

class PasswordConverter implements JsonConverter<Password, String> {
  const PasswordConverter();

  @override
  Password fromJson(String json) {
    return Password(json);
  }

  @override
  String toJson(Password object) {
    return object.value;
  }

}