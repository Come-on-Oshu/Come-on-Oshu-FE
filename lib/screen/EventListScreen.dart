import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class EventListScreen extends StatefulWidget {
  @override
  _EventListScreenState createState() => _EventListScreenState();
}

class _EventListScreenState extends State<EventListScreen> {
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
            onPressed: () {  },),
        ),
      ),
    );
  }
}