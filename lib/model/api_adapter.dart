import 'dart:convert';
import 'EventDetailInfo.dart';

List<EventDetailInfo> parseEI(String responseBody) {
  final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
  return parsed.map<EventDetailInfo>((json) => EventDetailInfo.fromJson(json)).toList();
}


