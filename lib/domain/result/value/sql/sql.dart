import 'package:flutter/cupertino.dart';

@immutable
class SQL {
  final String value;

  SQL(this.value) {
    // if (value == null || value.isEmpty) {
    //   throw NullEmptyException(code: ExceptionCode.sql);
    // }
  }

  @override
  bool operator ==(Object other) =>
      identical(other, this) || (other is SQL && other.value == value);

  @override
  int get hashCode => runtimeType.hashCode ^ value.hashCode;
}
