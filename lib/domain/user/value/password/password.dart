import 'package:flutter/cupertino.dart';
import 'package:flutter_ddd/common/exception.dart';

@immutable
class Password {
  final String value;
  static const minimalLength=6;
  
  Password(this.value) {
    if (value == null || value.isEmpty) {
      throw NullEmptyException(code: ExceptionCode.password);
    }
    if (value.length<minimalLength) {
      throw MinimumLengthException(code: ExceptionCode.password,min: minimalLength);
    }
  }

  @override
  bool operator ==(Object other) =>
      identical(other, this) || (other is Password && other.value == value);

  @override
  int get hashCode => runtimeType.hashCode ^ value.hashCode;
}
