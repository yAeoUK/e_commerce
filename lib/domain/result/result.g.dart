// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'result.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Result _$ResultFromJson(Map<String, dynamic> json) {
  return Result(
    message: const MessageConverter().fromJson(json['message'] as String),
    sql: const SQLConverter().fromJson(json['sql'] as String),
  );
}

Map<String, dynamic> _$ResultToJson(Result instance) => <String, dynamic>{
      'message': const MessageConverter().toJson(instance.message),
      'sql': const SQLConverter().toJson(instance.sql),
    };
