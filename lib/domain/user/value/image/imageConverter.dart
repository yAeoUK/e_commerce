import 'package:flutter_ddd/domain/user/value/image/image.dart';
import 'package:json_annotation/json_annotation.dart';

class ImageConverter implements JsonConverter<Image, String> {
  const ImageConverter();

  @override
  Image fromJson(String json) {
    return Image(Uri.parse(json));
  }

  @override
  String toJson(Image object) {
    return object.uri.toString();
  }

}