import 'package:flutter/material.dart';
import 'package:oshucome/screen/EventDetailInfo.dart';
import 'package:transition/transition.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../model/EventDetailInfo.dart';

class EventListScreen extends StatefulWidget {
  //TODO : EventList 레이아웃
  //TODO : EventList api 연동
  @override
  _EventListScreenState createState() => _EventListScreenState();
}

class _EventListScreenState extends State<EventListScreen> {

 //사용자가 상세 정보를 보기 위해 선택한 행사 목록 상세 정보를 저장하는 변수 - 초기화
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

  bool isLoading =false; //api로 부터 데이터를 가져오고 있는지에 대한 상태 변수

  //Event detail info api 호출 함수
  //api 호출로 받은 응답(행사 상세 정보)을 model에 저장한다.
  _fetchEI(String eventid) async {
    setState(() {
      isLoading = true;
    });
    //api 요청 변수
    final queryParameters = {
      'eventid': eventid
    };
    final uri = Uri.http('192.168.137.1:8000', '/oshu/EventDetails', queryParameters);

    final req = http.Request("GET", uri);
    final streamedResponse = await req.send();
    final response = await http.Response.fromStream(streamedResponse);

    if(response.statusCode == 200) {
      setState(() {
        var responseBody = utf8.decode(response.bodyBytes);
        final parsed = json.decode(responseBody);
        Event_detail_info = EventDetailInfo.fromJson(parsed);
        isLoading = false;
      });
    }else {
      throw Exception('failed to load data');
    }
  }

  @override
  Widget build(BuildContext context) {
    //반응형 UI를 구현하기 위해 MediaQuery를 사용함
    //화면의 크기나 화면 로테이션 여부 등의 정보들을 가져올 수 있음
    Size screenSize = MediaQuery.of(context).size; //화면의 크기 정보를 가져옴
    double width = screenSize.width;//Size로 부터 너비와 높이 알아냄
    double height = screenSize.height;

    return SafeArea(//SafeArea위젯은 기기의 상단 노티바 부분, 하단 영역을 침범하지 않는 안전한 영역 잡아주는 위젯
      child: Scaffold(
        appBar: AppBar(
          title: Text('oshu'),
          backgroundColor: Colors.grey,
        ),
        body: Container(
          child: ElevatedButton(
            child: Text(
              '상세 목록보기',
              style: TextStyle(color: Colors.white),
            ),
            style: ElevatedButton.styleFrom(
                backgroundColor:Colors.deepPurpleAccent),
            onPressed: () {
              //TODO: 선택한 행사 ID로 채워넣기
              String eventid = 'PF186264';
              _fetchEI(eventid).whenComplete(() {
                return Navigator.push(
                    context,
                    Transition(
                        child: EventDetailInfoScreen(EI: Event_detail_info,),
                        transitionEffect: TransitionEffect.RIGHT_TO_LEFT)
                );
              });
            },
          ),
        ),
      ),
    );
  }
}