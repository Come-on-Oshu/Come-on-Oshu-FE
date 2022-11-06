import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  @override
  Widget build(BuildContext context) {

    return SafeArea(//SafeArea위젯은 기기의 상단 노티바 부분, 하단 영역을 침범하지 않는 안전한 영역 잡아주는 위젯
      child: Scaffold(
        appBar: AppBar(
          title: Text('oshu'),
          backgroundColor: Colors.deepPurpleAccent,
        ),
        body: Center(
        ),
      ),
    );
  }
}