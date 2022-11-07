import 'dart:convert';
import 'EventDetailInfo.dart';

List<EventDetailInfo> parseEI(String responseBody) {
  // final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
  // return parsed.map<EventDetailInfo>((json) => EventDetailInfo.fromJson(json)).toList();

  final parsed = json.decode(responseBody);
  print(parsed);
  print(parsed.runtimeType);
  final v = Map<String, dynamic>.from(parsed);
  print(v);
  print(v.runtimeType);
  var a = EventDetailInfo.fromJson(v);
  print(a);
  return parsed.map<EventDetailInfo>((json) => EventDetailInfo.fromJson(json)).toList();
}


