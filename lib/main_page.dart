import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:stesh/home_screen.dart';
import 'package:stesh/travel_history.dart';
import 'package:stesh/wallet_screen.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {

  int _selectedIndex = 0;

  List _pages = [
    home_screen(),
    WalletScreen(),
    TravelHistory(),
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
    return Scaffold(
      body: _pages.elementAt(_selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: (index) => _changeTab(index),
        iconSize: 30,
        selectedItemColor: Color.fromRGBO(255, 167, 0, 1),
        unselectedItemColor: Color(0xff757575),
        items: [
          BottomNavigationBarItem(
            icon: Icon(FontAwesomeIcons.home,size: 21,),
            backgroundColor: Color(0xff333333),
            label: "Home",
          ),
          BottomNavigationBarItem(
              icon: Icon(FontAwesomeIcons.creditCard, size: 21,), label: "Wallet"),
          BottomNavigationBarItem(
              icon: Icon(Icons.list_alt), label: "Travel History"),
          BottomNavigationBarItem(
              icon: Icon(Icons.settings), label: "Product"),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "Account"),
        ],
        type: BottomNavigationBarType.shifting,

        elevation: 5,
      ),    );
  }
}
