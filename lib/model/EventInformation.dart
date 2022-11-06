
class EventInformation {
  late  String title;
  late String duration;
  late String organization;
  late String location;
  late String webUrl;
  late String posterImg;

  EventInformation({
    required this.title,
    required this.duration,
    required this.organization,
    required this.location,
    required this.webUrl,
    required this.posterImg});

  EventInformation.fromMap(Map<String, dynamic> map)
    : title = map['title'],
      duration = map['duration'],
      organization = map['organization'],
      location = map['location'],
      webUrl = map['webUrl'],
      posterImg = map['posterImg'];

  EventInformation.fromJson(Map<String, dynamic> json)
      : title = json['title'],
        duration = json['duration'],
        organization = json['organization'],
        location = json['location'],
        webUrl = json['webUrl'],
        posterImg = json['posterImg'];
}