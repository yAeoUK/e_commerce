import 'package:flutter/cupertino.dart';
import 'package:flutter_ddd/common/exception.dart';

@immutable
class Username {
  final String value;

  Username(this.value) {
    if (value == null || value.isEmpty) {
      throw NullEmptyException(code: ExceptionCode.username);
    }
  }

  @override
  bool operator ==(Object other) =>
      identical(other, this) || (other is Username && other.value == value);

  @override
  int get hashCode => runtimeType.hashCode ^ value.hashCode;
}
