// import 'package:flutter/material.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
//
// void main() => runApp(const MyApp());
//
// class MyApp extends StatefulWidget {
//   const MyApp({Key? key}) : super(key: key);
//
//   @override
//   _MyAppState createState() => _MyAppState();
// }
//
// class _MyAppState extends State<MyApp> {
//   late GoogleMapController mapController;
//
//   final LatLng _center = const LatLng(45.521563, -122.677433);
//
//   void _onMapCreated(GoogleMapController controller) {
//     mapController = controller;
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: Scaffold(
//         appBar: AppBar(
//           title: const Text('Maps Sample App'),
//           backgroundColor: Colors.green[700],
//         ),
//         body: GoogleMap(
//           onMapCreated: _onMapCreated,
//           initialCameraPosition: CameraPosition(
//             target: _center,
//             zoom: 11.0,
//           ),
//         ),
//       ),
//     );
//   }
// }
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:oshucome/screen/DetailInformationScreen.dart';
import 'package:oshucome/screen/EventListScreen.dart';
import 'package:oshucome/screen/LoginScreen.dart';
import 'package:oshucome/screen/MyPageScreen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DetailInformationScreen()
    );
  }
}