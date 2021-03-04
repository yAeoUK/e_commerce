import 'package:flutter_ddd/domain/user/value/username/username.dart';
import 'package:json_annotation/json_annotation.dart';

class UsernameConverter implements JsonConverter<Username, String> {
  const UsernameConverter();

  @override
  Username fromJson(String json) {
    return Username(json);
  }

  @override
  String toJson(Username object) {
    return object.value;
  }

}