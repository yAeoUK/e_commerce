import 'package:flutter/cupertino.dart';
import 'package:flutter_ddd/common/exception.dart';

@immutable
class Message {
  final String value;

  Message(this.value) {
    if (value == null||value.isEmpty ) {
      throw NullEmptyException(code: ExceptionCode.message);
    }
  }

  @override
  bool operator ==(Object other) =>
      identical(other, this) || (other is Message && other.value == value);

  @override
  int get hashCode => runtimeType.hashCode ^ value.hashCode;
}
