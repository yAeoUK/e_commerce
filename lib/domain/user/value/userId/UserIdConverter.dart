import 'package:flutter_ddd/domain/user/value/userId/UserId.dart';
import 'package:json_annotation/json_annotation.dart';

class UserIdConverter implements JsonConverter<UserId, String> {
  const UserIdConverter();

  @override
  UserId fromJson(String json) {
    return UserId(int.parse(json));
  }

  @override
  String toJson(UserId object) {
    return object.value.toString();
  }

}