import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';
import 'package:water/componants/bottom_nav_bar.dart';
import 'package:flutter/material.dart';
import 'package:water/pages/select_page.dart';
import 'package:water/pages/about_page.dart';


class HomePage extends StatefulWidget {
  late BluetoothDevice device;
  BluetoothConnection connection;
  HomePage({Key? key, required this.device, required this.connection}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  //navigate bottom bar
  int _selectedIndex = 0;

  bool isStarted = false;


  //pages to display
  late final List<Widget> _pages;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    //pages to display
    _pages = [
      // Home page
      SelectPage(device: widget.device, connection: widget.connection,),
      // About Page
      const About(),
    ];
  }
  void navigateBottomBar(int newIndex) {
    setState(() {
      _selectedIndex = newIndex;
    });
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green[50],
      bottomNavigationBar: MyBottomNavBar(
        onTabChange: (index) => navigateBottomBar(index),
      ),
      body: _pages[_selectedIndex],
    );
  }
}