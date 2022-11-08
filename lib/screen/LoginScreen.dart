import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_session_manager/flutter_session_manager.dart';
import 'package:transition/transition.dart';
import 'package:http/http.dart' as http;

import 'package:oshucome/screen/EventListScreen.dart';

import 'MainMapScreen.dart';


class LoginScreen extends StatefulWidget {

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final useridcontroller = TextEditingController(); //user 입력 id 가져오는 controller
  final userpwcontroller = TextEditingController(); //user 입력 pw 가져오는 controller

  String userID = "";
  int LoginStatus = -1;
  String LoginMessage = "";

  _fetchLogin(String userid, String userpw) async {

    //api 요청 변수
    final queryParameters = {
      'id': userid,
      'pw': userpw
    };

    final uri = Uri.http('192.168.137.1:8000', '/oshu/Login', queryParameters);

    final req = http.Request("GET", uri);
    final streamedResponse = await req.send();
    final response = await http.Response.fromStream(streamedResponse);

    if(response.statusCode == 200) {
      setState(() {
        var responseBody = utf8.decode(response.bodyBytes);
        final parsed = json.decode(responseBody);
        LoginStatus = parsed['status'];
        LoginMessage = parsed['message'];
      });
    }else {
      throw Exception('failed to load data');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            const SizedBox(height: 70),
            Padding( //main image
              padding: const EdgeInsets.only(top: 60.0),
              child: Center(
                child: SizedBox(
                    width: 300,
                    height: 200,
                    child: Image.asset('images/festival.jpg')),
              ),
            ),
            SizedBox(height: 20),
            Padding( //user id field
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: SizedBox(
                width: 300,
                child: TextField(
                  controller: useridcontroller,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'ID',
                    hintText: 'Enter valid ID',),
                ),
              )
            ),
            Padding(//user pw field
              padding: const EdgeInsets.only(
                  left: 15.0, right: 15.0, top: 15, bottom: 15),
              //padding: EdgeInsets.symmetric(horizontal: 15),
              child: SizedBox(
                width: 300,
                child: TextField(
                  controller: userpwcontroller,
                  obscureText: true,
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Password',
                      hintText: 'Enter password'),
                ),
              )
            ),
            const SizedBox(
              height: 30,
            ),
            Container(
              height: 50,
              width: 300,
              decoration: BoxDecoration(
                  color: Colors.deepPurpleAccent, borderRadius: BorderRadius.circular(10)),
              child: TextButton(
                onPressed: () async {
                  _fetchLogin(useridcontroller.text, userpwcontroller.text).whenComplete(() async {

                    if(LoginStatus == 1) { //로그인 성공시
                      print(LoginMessage);
                      var sessionManager = SessionManager();
                      sessionManager.set('userid', useridcontroller.text);
                      return Navigator.push(
                          context,
                          Transition(
                              child: MapScreen(),
                              transitionEffect: TransitionEffect.RIGHT_TO_LEFT)
                      );
                    }else if(LoginStatus == 0) { //아이디가 없는 경우
                    }else if(LoginStatus == 2) { //비밀번호가 일치하지 않을때
                    }
                    print(LoginMessage);
                  });
                },
                child: const Text(
                  'Login',
                  style: TextStyle(color: Colors.white, fontSize: 25),
                ),
              ),
            ),
            const SizedBox(height:15),
            TextButton(
              child: const Text(
                '로그인 없이 사용하기',
                style: TextStyle(color: Colors.deepPurpleAccent, fontSize: 20),
              ),
              onPressed: () {
                //TODO: 메인페이지로 이동 수정
                Navigator.push(
                    context,
                    Transition(
                        child: EventListScreen(),
                        transitionEffect: TransitionEffect.RIGHT_TO_LEFT)
                );
              },
            ),
            const SizedBox(
              height: 130,
            ),
          ],
        ),
      ),
    );
  }
}
