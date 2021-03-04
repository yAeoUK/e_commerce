import 'package:json_annotation/json_annotation.dart';

import 'message.dart';

class MessageConverter implements JsonConverter<Message, String> {
  const MessageConverter();

  @override
  Message fromJson(String json) {
    return Message(json);
  }

  @override
  String toJson(Message object) {
    return object.value.toString();
  }

}