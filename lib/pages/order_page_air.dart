import 'dart:async';
import 'dart:convert';
import 'dart:ffi';
import 'dart:typed_data';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';
import 'package:water/models/anibutton.dart';
import 'package:water/models/humidity.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';
import 'package:water/models/theme_color.dart';

class OrderPageAir extends StatefulWidget {
  BluetoothDevice device;
  Humidity humidity;
  BluetoothConnection connection;
  OrderPageAir({Key? key,required this.humidity, required this.device, required this.connection}) : super(key: key);

  @override
  State<OrderPageAir> createState() => _OrderPageAirState();
}

class _OrderPageAirState extends State<OrderPageAir> with SingleTickerProviderStateMixin{

  bool isDarkMode = false;
  late AnimationController _animationController;

  @override
  void initState() {
    // TODO: implement initState
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );
    super.initState();

  }
  @override



// change the old parameters to the new one
  void changeParameters(){
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


    return Scaffold(
      backgroundColor: Colors.green[50], //
      appBar: AppBar(
        title: Text(widget.humidity.name),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            //Humidity circle
            Padding(
              padding: const EdgeInsets.all(30.0),


              child: CircularPercentIndicator(
                radius: 120.0,
                startAngle: 180,
                lineWidth: 20.0,
                percent: 0.0,
                center: Text(
                  "OFF",
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                progressColor: Colors.lightGreen[700],
                //animation: true,
                circularStrokeCap: CircularStrokeCap.round,
              ),
            ),

            AnimatedToggle(
              values: ['ON', 'OFF'],
              onToggleCallback: (index) {
                isDarkMode = !isDarkMode;
                setState(() {
                  if(isDarkMode){
                    print('OFF');
                  }
                  else{
                    print('ON');
                  }
                  changeThemeMode();
                });
              },
            ),


            //****** Humidity level
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 50),
                child: Column(
                  //mainAxisAlignment: MainAxisAlignment.center,
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
                        value:50,
                        onChanged: (value) {
                          setState(() {
                            _humidityValue = value;

                          });
                        }
                    ),
                  ],
                ),
              ),
            ),


            //add change button
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


}