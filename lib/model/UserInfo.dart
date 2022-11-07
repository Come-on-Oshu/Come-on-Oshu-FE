class UserInfo {
 late  String userid;
  late String username;

  UserInfo({required this.userid, required this.username});

  UserInfo.fromMap(Map<String, dynamic> map)
    : userid = map['userid'],
      username = map['username'];

  UserInfo.fromJson(Map<String, dynamic> json)
    : userid = json['userid'],
      username = json['username'];
}