import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_session_manager/flutter_session_manager.dart';
import 'package:transition/transition.dart';
import 'package:http/http.dart' as http;

import 'package:oshucome/screen/EventListScreen.dart';


class LoginScreen extends StatefulWidget {

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final useridcontroller = TextEditingController();
  final userpwcontroller = TextEditingController();
  String userToken = "";

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
        userToken = parsed['Token'];
      });
    }else {
      throw Exception('failed to load data');
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('FeCo In Daejeon'),
        backgroundColor: Colors.deepPurpleAccent,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Padding( //main image
              padding: const EdgeInsets.only(top: 60.0),
              child: Center(
                child: Container(
                    width: 300,
                    height: 200,
                    child: Image.asset('images/festival.jpg')),
              ),
            ),
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
                onPressed: () {
                  //TODO: api 호출 및 연동
                  _fetchLogin(useridcontroller.text, userpwcontroller.text).whenComplete(() async {
                    print(userToken);
                    var sessionManager = SessionManager();
                    sessionManager.set("usertoken", userToken);
                    return Navigator.push(
                        context,
                        Transition(
                            child: EventListScreen(),
                            transitionEffect: TransitionEffect.RIGHT_TO_LEFT)
                    );
                  });
                },
                child: Text(
                  'Login',
                  style: TextStyle(color: Colors.white, fontSize: 25),
                ),
              ),
            ),
            SizedBox(height:15),
            TextButton(
              child: Text(
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
