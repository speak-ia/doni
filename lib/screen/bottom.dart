import 'package:donidata/screen/teledetection.dart';
import 'package:flutter/material.dart';
import 'accueil.dart'; 
import 'map.dart';
import 'wallet.dart';

class MyBottomNavigationBar extends StatefulWidget {
  @override
  _MyBottomNavigationBarState createState() => _MyBottomNavigationBarState();
}

class _MyBottomNavigationBarState extends State<MyBottomNavigationBar> {
  int _selectedIndex = 0;  

 
  static final List<Widget> _pages = <Widget>[
    Accueil(),
    //TeledetectionPage(),  
    MapPage(),   
    WalletPage(), 
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home,size: 35,),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.location_on_outlined,
            size: 35,
            ),
            label: '',
          ),
          
          BottomNavigationBarItem(
            icon: Icon(Icons.wallet,size: 35,),
            label: '',
          ),
        ],
        currentIndex: _selectedIndex, 
        selectedItemColor: Colors.blue,
        onTap: _onItemTapped,
      ),
    );
  }
}
