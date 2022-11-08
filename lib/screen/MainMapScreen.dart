import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'MyPageScreen.dart';

class MapScreen extends StatefulWidget{
  @override
  _MapScreenState createState() => _MapScreenState();
}

enum MenuType {
  seo, yuseong, jung, dong, daedeok
}

extension ParseToString on MenuType {
  String toShortString(){
    return this.toString().split('.').last;
  }
}

class _MapScreenState extends State<MapScreen>{
  late GoogleMapController mapController;
  final LatLng _center = const LatLng(36.3667, 127.3443);

  late MenuType _selection;

  void _onMapCreated(GoogleMapController controller){
    mapController = controller;
  }
  @override
  Widget build(BuildContext context){
    Size screenSize = MediaQuery.of(context).size;
    double width = screenSize.width;
    double height = screenSize.height;

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'PeCon',
            style: TextStyle(color:Colors.deepPurpleAccent),
          ),
          centerTitle: true,
          backgroundColor: Colors.white,
          leading: PopupMenuButton<MenuType>(
            icon: Icon(Icons.room, color: Colors.deepPurpleAccent),
            onSelected: (MenuType result){
              setState(() {
                _selection = result;
              });
            },
            itemBuilder: (BuildContext context) => MenuType.values
                .map((value) => PopupMenuItem(
                value: value,
                child: Text(value.toShortString())
              ))
            .toList(),
          ),
          actions: [
            IconButton(
              color: Colors.deepPurpleAccent,
              icon: Icon(Icons.account_circle), 
              onPressed: (){
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => MyPageScreen()),
                );
            })
          ],
        ),
        body: GoogleMap(
          onMapCreated: _onMapCreated,
          initialCameraPosition: CameraPosition(
            target: _center,
            zoom: 13.0,
          ),
        ),
      ),
    );
  }
}