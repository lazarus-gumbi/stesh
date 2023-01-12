import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

class home_screen extends StatefulWidget {
  const home_screen({Key? key}) : super(key: key);

  @override
  State<home_screen> createState() => _home_screenState();
}

class _home_screenState extends State<home_screen> {

  int _selectedIndex = 0 ;

  List _pages = [
    Center(
      child: Text("Home"),
    ),
    Center(
      child: Text("Card"),
    ),
    Center(
      child: Text("History"),
    ),
    Center(
      child: Text("Settings"),
    ),
    Center(
      child: Text("Account"),
    ),

  ];

  _changeTab(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    @override
    void dispose() {

      super.dispose();
    }

    return Container(
      height: height,
      width: width,
      child: Scaffold(

        body: Center(
          child: Column(
            children: [
              Container(

                color: Color(0xff333333),
                padding: EdgeInsets.fromLTRB(15, 40, 20, 20),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Expanded(flex: 1,child: Icon(Icons.location_on,color: Color(0xffffa700),)),
                        Expanded(
                          flex: 4,
                          child: TextField(
                            style: TextStyle(fontSize: 20,fontWeight: FontWeight.w600 ),
                            textAlign: TextAlign.left,
                            textAlignVertical: TextAlignVertical.center,
                            decoration: InputDecoration.collapsed(
                              hintText: "Where From?",hintStyle: TextStyle(fontSize: 20,fontWeight: FontWeight.w600)
                            ),
                          ),
                        )
                      ],
                    ),
                    Row(
                      children: [
                        Expanded(flex:1,child: Icon(Icons.more_vert, color: Color(0xff757575),size: 25,),),
                        Expanded(flex:4,child: SizedBox(),),
                      ],
                    ),
                    Row(
                      children: [
                        Expanded(flex: 1,child: Icon(Icons.circle,color: Color(0xff757575),size: 20,)),
                        Expanded(
                          flex: 4,
                          child: TextField(
                            style: TextStyle(fontSize: 20,fontWeight: FontWeight.w600),
                            textAlign: TextAlign.left,
                            textAlignVertical: TextAlignVertical.center,
                            decoration: InputDecoration.collapsed(
                                hintText: "Where To?",hintStyle: TextStyle(fontSize: 20,fontWeight: FontWeight.w600)
                            ),
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
              Flexible(child: FlutterMap(
                options: MapOptions(
                  center: LatLng(-26.31667, 31.13333),
                  zoom: 15,
                ),
                children: [
                  TileLayer(
                  urlTemplate: "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
                  subdomains: ['a', 'b', 'c'],),
                  MarkerLayer()
                  ],

              ),
              )
            ],
          ),
          ),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _selectedIndex,
          onTap: (index) => _changeTab(index),
          iconSize: 30,
          selectedItemColor: Color.fromRGBO(255, 167, 0, 1),
          unselectedItemColor: Color(0xff757575),
          items: [
            BottomNavigationBarItem(icon: Icon(Icons.home),backgroundColor: Color(0xff333333), label: "Home",),
            BottomNavigationBarItem(icon: Icon(Icons.credit_card), label: "Payment"),
            BottomNavigationBarItem(icon: Icon(Icons.list_alt), label: "Travel History"),
            BottomNavigationBarItem(
                icon: Icon(Icons.settings), label: "Product"),

            BottomNavigationBarItem(
                icon: Icon(Icons.person), label: "Account"),
          ],
        ),
        ),
    );
  }
}
