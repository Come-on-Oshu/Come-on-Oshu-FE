import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_session_manager/flutter_session_manager.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:oshucome/model/api_adapter.dart';
import 'package:transition/transition.dart';

import '../model/EventDetailInfo.dart';


import 'MyPageScreen.dart';

class MapScreen extends StatefulWidget{
  @override
  _MapScreenState createState() => _MapScreenState();
}

enum MenuType {
  seo, yuseong, jung, dong, daedeok
}

extension ParseToString on MenuType {
  String toShortString(){
    return this.toString().split('.').last;
  }
}

class _MapScreenState extends State<MapScreen>{
  late GoogleMapController mapController;
  final LatLng _center = const LatLng(36.3667, 127.3443);

  late MenuType _selection;

  List<EventDetailInfo> event_list = [];

  String username = 'default';

  EventDetailInfo Event_detail_info = EventDetailInfo(
      EventID: "default",
      EventName: "default",
      isFestival: 0,
      ImgUrl: "default",
      stDate: "default",
      edDate: "default",
      Organization: "default",
      address: "default",
      SiteUrl: "default");

  void _onMapCreated(GoogleMapController controller){
    mapController = controller;
  }

  _fetchMyPage(String userid) async {
    //api 요청 변수
    final queryParameters = {
      'userid':userid
    };
    final uri = Uri.http('192.168.137.1:8000', '/oshu/MyPage', queryParameters);

    final req = http.Request("GET", uri);
    final streamedResponse = await req.send();
    final response = await http.Response.fromStream(streamedResponse);

    if(response.statusCode == 200) {
      setState(() {
        var responseBody = utf8.decode(response.bodyBytes);
        final parsed = json.decode(responseBody);

        username = parsed['username'];

        int length = parsed['InterestEventList'].length;
        for(int i = 0; i < length; i++) {
          Event_detail_info = EventDetailInfo.fromJson(parsed['InterestEventList'][i]);
          event_list.add(Event_detail_info);
        }
      });
    }else {
      throw Exception('failed to load data');
    }
  }

  @override
  Widget build(BuildContext context){
    Size screenSize = MediaQuery.of(context).size;
    double width = screenSize.width;
    double height = screenSize.height;

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'PeCon',
            style: TextStyle(color:Colors.deepPurpleAccent),
          ),
          centerTitle: true,
          backgroundColor: Colors.white,
          leading: PopupMenuButton<MenuType>(
            icon: Icon(Icons.room, color: Colors.deepPurpleAccent),
            onSelected: (MenuType result){
              setState(() {
                _selection = result;
              });
            },
            itemBuilder: (BuildContext context) => MenuType.values
                .map((value) => PopupMenuItem(
                value: value,
                child: Text(value.toShortString())
              ))
            .toList(),
          ),
          actions: [
            IconButton(
              color: Colors.deepPurpleAccent,
              icon: Icon(Icons.account_circle), 
              onPressed: () async {
                dynamic userid = await SessionManager().get("userid");
                _fetchMyPage(userid).whenComplete(() {
                  return Navigator.push(
                      context,
                      Transition(
                          child: MyPageScreen(EventList: event_list, username: username,),
                          transitionEffect: TransitionEffect.RIGHT_TO_LEFT)
                  );
                });
            })
          ],
        ),
        body: GoogleMap(
          onMapCreated: _onMapCreated,
          initialCameraPosition: CameraPosition(
            target: _center,
            zoom: 13.0,
          ),
        ),
      ),
    );
  }
}