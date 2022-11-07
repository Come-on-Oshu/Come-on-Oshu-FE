import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final useridcontroller = TextEditingController();
  final userpwcontroller = TextEditingController();


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
                  print(useridcontroller.text);
                  print(userpwcontroller.text);
                },
                child: Text(
                  'Login',
                  style: TextStyle(color: Colors.white, fontSize: 25),
                ),
              ),
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
