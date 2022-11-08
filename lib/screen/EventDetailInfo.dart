import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_session_manager/flutter_session_manager.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:http/http.dart' as http;

import '../model/EventDetailInfo.dart';

class EventDetailInfoScreen extends StatefulWidget {

  EventDetailInfo EI;
  EventDetailInfoScreen({required this.EI}); //이전 화면으로부터 행사 상세 정보를 요청받는다.

  @override
  _EventDetailInfoScreenState createState() => _EventDetailInfoScreenState();
}

class _EventDetailInfoScreenState extends State<EventDetailInfoScreen> {

  Future<void> _launchInBrowser(Uri url) async {
    if (!await launchUrl(
      url,
      mode: LaunchMode.externalApplication,
    )) {
      throw 'Could not launch $url';
    }
  }

  _fetchAddInterestEvent(String userid, String eventid) async {

    //api 요청 변수
    final queryParameters = {
      'id': userid,
      'eventid': eventid
    };

    final uri = Uri.http('192.168.137.1:8000', '/oshu/AddInterestEvent', queryParameters);

    final req = http.Request("GET", uri);
    final streamedResponse = await req.send();
    final response = await http.Response.fromStream(streamedResponse);

    if(response.statusCode == 200) {
      setState(() {
        var responseBody = utf8.decode(response.bodyBytes);
        final parsed = json.decode(responseBody);

      });
    }else {
      throw Exception('failed to load data');
    }
  }

  @override
  Widget build(BuildContext context) {

    String eventTitle = widget.EI.EventName;
    String eventDuration = "";
    if(widget.EI.stDate == widget.EI.edDate) {
      eventDuration = widget.EI.stDate;
    }else {
      eventDuration = "${widget.EI.stDate} ~ \n${widget.EI.edDate}";
    }

    String eventOrganization = widget.EI.Organization;
    String eventLocation = widget.EI.address;

    return SafeArea(//SafeArea위젯은 기기의 상단 노티바 부분, 하단 영역을 침범하지 않는 안전한 영역 잡아주는 위젯
        child: Scaffold(
          appBar: AppBar(
            title: const Text('FeCo In Daejeon'),
            backgroundColor: Colors.deepPurpleAccent,
          ),
          body: Container(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  eventTitle,
                  style: const TextStyle(color: Colors.deepPurple, fontSize: 20, fontWeight: FontWeight.bold),
                ),
                Container(
                  margin: const EdgeInsets.fromLTRB(0, 8, 0, 0),
                  padding: const EdgeInsets.all(20),
                  height: MediaQuery.of(context).size.height * 0.75,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    color: const Color(0xfff1e6fc),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Column( //행사 상세 목록
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(//행사 기간 column 및 관심 행사 등록 button
                        margin: const EdgeInsets.fromLTRB(0, 0, 0, 10),
                        child: Row(
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text('행사기간', style: TextStyle(color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold),),
                                Text(eventDuration, style: const TextStyle(color: Colors.grey, fontSize: 15),)
                              ],
                            ),
                            const Spacer(flex:1),
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  backgroundColor:Colors.deepPurpleAccent),
                              onPressed: () async {
                                dynamic id = await SessionManager().get("userid");
                                dynamic token = await SessionManager().get("usertoken");
                              },
                              child: Row(
                                children: const [
                                  Icon(Icons.add_box_outlined),
                                  SizedBox(width:5),
                                  Text(
                                    '관심 행사 등록',
                                    style: TextStyle(color: Colors.white, fontSize: 15),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container( //주체 기관 Container
                        margin: const EdgeInsets.fromLTRB(0, 0, 0, 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text('주체 기관', style: TextStyle(color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold),),
                            Text(eventOrganization, style: const TextStyle(color: Colors.grey, fontSize: 15),)
                          ],
                        ),
                      ),
                      Container( //위치 Container
                        margin: EdgeInsets.fromLTRB(0, 0, 0, 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text('위치', style: TextStyle(color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold),),
                            Text(eventLocation, style: const TextStyle(color: Colors.grey, fontSize: 15),),
                            const SizedBox(height:5),
                            Container( // TODO: 지도 구현
                              color: Colors.black,
                              height: MediaQuery.of(context).size.height*0.3,
                              width: MediaQuery.of(context).size.width,
                            ),
                          ],
                        ),
                      ),
                      Row(
                        children: [
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                backgroundColor:Colors.deepPurpleAccent),
                            onPressed: () {
                              _launchInBrowser(Uri.parse(widget.EI.SiteUrl));
                            },
                            child: Row(
                              children: const [
                                Icon(Icons.ad_units),
                                SizedBox(width:5),
                                Text(
                                  '안내 웹사이트',
                                  style: TextStyle(color: Colors.white, fontSize: 15),
                                ),
                              ],
                            ),
                          ),
                          const Spacer(flex:1),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                backgroundColor:Colors.deepPurpleAccent),
                            onPressed: () {
                              showDialog(
                                  context: context,
                                  barrierDismissible: true, // 바깥 영역 터치시 닫을지 여부
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      content: Container(
                                        child: Image.network(
                                          widget.EI.ImgUrl,
                                          fit: BoxFit.fill,
                                        ),
                                      ),
                                      insetPadding: const  EdgeInsets.fromLTRB(0,80,0, 80),
                                      actions: [
                                        TextButton(
                                          child: const Text('확인'),
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                          },
                                        ),
                                      ],
                                    );
                                  }
                              );
                            },
                            child: Row(
                              children: const [
                                Icon(Icons.account_balance_wallet_rounded),
                                SizedBox(width:5),
                                Text(
                                  '행사 포스터',
                                  style: TextStyle(color: Colors.white, fontSize: 15),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
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