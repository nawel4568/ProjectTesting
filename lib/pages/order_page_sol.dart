import 'dart:async';
import 'dart:convert';
import 'package:rxdart/rxdart.dart';

import 'dart:typed_data';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';
import 'package:water/models/anibutton.dart';
import 'package:water/models/humidity.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';


class OrderPageSol extends StatefulWidget {
  BluetoothDevice device;
  Humidity humidity;
  BluetoothConnection connection;
  OrderPageSol({Key? key,required this.humidity, required this.device, required this.connection}) : super(key: key);

  @override
  State<OrderPageSol> createState() => _OrderPageSolState();
}

class _OrderPageSolState extends State<OrderPageSol> with SingleTickerProviderStateMixin{





  bool isDarkMode = false;
  late AnimationController _animationController;
  late double? temp;
  String _humidityData = "0.0";

  StreamSubscription<Uint8List>? _dataStreamSubscription;

  BehaviorSubject<Uint8List> dataStream = BehaviorSubject<Uint8List>();

  BehaviorSubject<double> controller = BehaviorSubject<double>();


  @override
  void initState() {
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );

    super.initState();


    // print("before receiveData()..");
    // _dataStreamSubscription!.onData((data) {
    //   controller.add(double.tryParse(utf8.decode(data)) ?? 0.0);
    // });
    receiveData();
  }

  void receiveData() async {
    await _dataStreamSubscription?.cancel();
    _dataStreamSubscription = widget.connection.input!.listen((data) {
      setState(() {
        _humidityData = utf8.decode(data);
        print('the humidity is reloaded');
      });
    });
  }
  //
  // void receiveData() {
  //   print("recieve data");
  //   _dataStreamSubscription = widget.connection.input!.listen((data) {
  //     setState(() {
  //       _humidityData = utf8.decode(data);
  //       print('the humidity is reloaded');
  //     });
  //   });
  // }


  @override
  void dispose() async {
    Future.delayed(Duration.zero, () async {
      print(_dataStreamSubscription);
      await _dataStreamSubscription?.cancel();
      print(_dataStreamSubscription);
    });
    super.dispose();
  }

  // @override
  // void dispose() {
  //
  //
  //
  //   _dataStreamSubscription?.cancel();
  //   print("Dispose !!!!");
  //   super.dispose();
  // }




  // change the old parameters to the new one
  void changeParameters(){
    _sendData('$_humidityValue');
    print("the value is : $_humidityValue");
    //let user know is been successfully changed
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Parameters successfully changed'),
      ),
    );
  }


  /////////// :

  changeThemeMode() {
    if(isDarkMode) {
      _animationController.forward(from: 0.0);
    } else {
      _animationController.forward(from: 1.0);
    }
  }



  double _humidityValue = 50;
  @override
  Widget build(BuildContext context) {
    temp = double.tryParse(_humidityData) ?? 0.0;

    return Scaffold(
      backgroundColor: Colors.green[50],
      appBar: AppBar(
        title: Text(widget.humidity.name),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Humidity circle
            Padding(
              padding: const EdgeInsets.all(30.0),
              child: CircularPercentIndicator(
                radius: 120.0,
                startAngle: 180,
                lineWidth: 20.0,
                percent: temp! / 100,
                center: Text(
                  "$_humidityData%",
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                progressColor: Colors.lightGreen[700],
                circularStrokeCap: CircularStrokeCap.round,
              ),
            ),

            AnimatedToggle(
              values: ['ON', 'OFF'],
              onToggleCallback: (index) {
                isDarkMode = !isDarkMode;
                setState(() {
                  if(isDarkMode){
                    _sendData('0');
                    print('OFF');
                  }
                  else{
                    _sendData('1');
                    print('ON');
                  }
                  changeThemeMode();
                });
              },
            ),


            // Humidity level slider
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 50),
                child: Column(
                  children: [
                    Text(
                      'Humidity',
                      style: TextStyle(fontSize: 20),
                    ),
                    SizedBox(height: 5),
                    SfSlider(
                      min: 0.0,
                      max: 100.0,
                      interval: 10,
                      stepSize: 10,
                      enableTooltip: true,
                      value: _humidityValue,
                      onChanged: (value) {
                        setState(() {
                          _humidityValue = value;
                        });
                      },
                    ),
                  ],
                ),
              ),
            ),

            // Change Parameters button
            MaterialButton(
              color: Colors.lightGreen[700],
              onPressed: changeParameters,
              child: const Text(
                "Change Parameters",
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );

  }

  _sendData(String data) async{
    data = data.trim();
    print('send data : $data');

    try{
      widget.connection.output.add(Uint8List.fromList(utf8.encode(data)));
      await widget.connection.output.allSent;
    }catch(ex){
      // Ignore error, but notify state
    }
  }
}
