// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map<String, dynamic> json) {
  return User(
    id: const UserIdConverter().fromJson(json['id'] as String),
    username: const UsernameConverter().fromJson(json['username'] as String),
    password: const PasswordConverter().fromJson(json['password'] as String),
  );
}

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'id': const UserIdConverter().toJson(instance.id),
      'username': const UsernameConverter().toJson(instance.username),
      'password': const PasswordConverter().toJson(instance.password),
    };
