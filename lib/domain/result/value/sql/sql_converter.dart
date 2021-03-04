import 'package:flutter_ddd/domain/result/value/sql/sql.dart';
import 'package:json_annotation/json_annotation.dart';

class SQLConverter implements JsonConverter<SQL, String> {
  const SQLConverter();

  @override
  SQL fromJson(String json) {
    return SQL(json);
  }

  @override
  String toJson(SQL object) {
    return object.value;
  }

}