import 'dart:async';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';
import 'package:water/pages/connection.dart';
import 'package:water/pages/home_page.dart';
import 'package:provider/provider.dart';
import 'package:water/pages/home_page.dart';
import 'package:water/pages/loading_page.dart';

import 'models/home.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {



    MaterialColor mycolor = MaterialColor(0xFF689F38, <int, Color>{
      50: Color(0xFFF1F8E9),
      100: Color(0xFFDCEDC8),
      200: Color(0xFFC5E1A5),
      300: Color(0xFFAED581),
      400: Color(0xFF9CCC65),
      500: Color(0xFF8BC34A),
      600: Color(0xFF7CB342),
      700: Color(0xFF689F38),
      800: Color(0xFF558B2F),
      900: Color(0xFF33691E),
    },
    );

    return ChangeNotifierProvider(
      create: (context) => HumidityHome(),
      builder: (context, child) =>
          MaterialApp(
            title: 'Connection Page',
            debugShowCheckedModeBanner: false,
            theme: ThemeData(primarySwatch: mycolor),
            home: FutureBuilder(

              future: FlutterBluetoothSerial.instance.requestEnable(),
              builder: (context, future){
                if(future.connectionState == ConnectionState.waiting){
                  return Scaffold(
                    backgroundColor: Colors.green[50],
                    body: Container(
                      height: double.infinity,
                      child: Center(
                        child: Icon(
                          Icons.bluetooth_disabled,
                          size: 200.0,
                          color: Colors.green,
                        ),
                      ),
                    ),
                  );
                }else{
                  return Home();
                }
              },
            ),
          ),
    );
  }
}
/////////////////////////////

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Connection'),

        ),
        body: Connection(
          onCahtPage: (device1,connection1){
            BluetoothDevice device = device1;
            BluetoothConnection connection = connection1;
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context){
                      return HomePage(device: device, connection: connection,);
                    }
                )
            );
          },
        ),
      ),
    );
  }
}