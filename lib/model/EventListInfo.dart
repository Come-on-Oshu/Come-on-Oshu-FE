
class EventInformation {
  late  String EventID;
  late String EventName;
  late int isFestival;
  late String ImgUrl;
  late String stDate;
  late String edDate;
  late String Organization;

  EventInformation({
    required this.EventID,
    required this.EventName,
    required this.isFestival,
    required this.ImgUrl,
    required this.stDate,
    required this.edDate,
    required this.Organization,
});

  EventInformation.fromMap(Map<String, dynamic> map)
      :   EventID = map['EventID'],
        EventName = map['EventName'],
        isFestival = map['isFestival'],
        ImgUrl = map['ImgUrl'],
        stDate = map['stDate'],
        edDate = map['edDate'],
        Organization = map['Organization'];


  EventInformation.fromJson(Map<String, dynamic> json)
      : EventID = json['EventID'],
        EventName = json['EventName'],
        isFestival = json['isFestival'],
        ImgUrl = json['ImgUrl'],
        stDate = json['stDate'],
        edDate = json['edDate'],
        Organization = json['Organization'];
}