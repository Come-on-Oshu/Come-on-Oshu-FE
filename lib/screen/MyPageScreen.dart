import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MyPageScreen extends StatefulWidget {
  @override
  _MyPageScreenState createState() => _MyPageScreenState();
}

class _MyPageScreenState extends State<MyPageScreen> {
  String username = '김유진';

  @override
  Widget build(BuildContext context) {

    return SafeArea(//SafeArea위젯은 기기의 상단 노티바 부분, 하단 영역을 침범하지 않는 안전한 영역 잡아주는 위젯
      child: Scaffold(
        appBar: AppBar(
          title: Text('oshu'),
          backgroundColor: Colors.deepPurpleAccent,
        ),
        body: Container(
          padding: EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                username + '님의 관심 행사 목록',
                style: TextStyle(color: Colors.deepPurple, fontSize: 20, fontWeight: FontWeight.bold),
              ),
              Container(
                margin: EdgeInsets.fromLTRB(0, 8, 0, 0),
                padding: EdgeInsets.all(20),
                height: MediaQuery.of(context).size.height * 0.75,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  color: Color(0xfff1e6fc),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column( //행사 상세 목록
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}