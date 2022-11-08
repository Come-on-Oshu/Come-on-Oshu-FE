import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:oshucome/screen/LoginScreen.dart';
import 'package:oshucome/screen/MainMapScreen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context){
    return MaterialApp(
      title: 'PeCoIn',
      home: LoginScreen(),
    );
  }
}
