import 'package:flutter/cupertino.dart';

@immutable
class Image{
  final Uri uri;

  const Image(this.uri);

  @override
  bool operator ==(Object other) =>
      identical(other, this) || (other is Image && other.uri==uri);

  @override
  int get hashCode => runtimeType.hashCode ^ uri.hashCode;

}