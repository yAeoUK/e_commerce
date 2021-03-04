import 'package:flutter/cupertino.dart';
import 'package:flutter_ddd/common/exception.dart';

@immutable
class UserId {
  final int value;

  UserId(this.value) {
    if (value == null ) {
      throw NullEmptyException(code: ExceptionCode.userId);
    }
    if(value<1){
      throw NotPositiveException(code:ExceptionCode.userId,value: value.toString());
    }
  }

  @override
  bool operator ==(Object other) =>
      identical(other, this) || (other is UserId && other.value == value);

  @override
  int get hashCode => runtimeType.hashCode ^ value.hashCode;
}
