import 'dart:async';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';

import '../componants/device_tile.dart';


class Connection extends StatefulWidget {
  final Function onCahtPage;
  const Connection({Key? key, required this.onCahtPage}) : super(key: key);

  @override
  State<Connection> createState() => _ConnectionState();
}

class _ConnectionState extends State<Connection> {
  late BluetoothConnection _connection;
  late StreamSubscription<BluetoothDiscoveryResult> _discoveryStreamSubscription;
  late StreamSubscription<Uint8List> _dataStreamSubscription;
  final List<BluetoothDiscoveryResult> _devices = [];
  bool _isConnected = false;

  @override
  void initState() {
    super.initState();
    _initBluetooth();
  }


  Future<void> _initBluetooth() async{
    try{
      // Start Bluetooth Discovery
      _discoveryStreamSubscription = FlutterBluetoothSerial.instance.startDiscovery().listen((r) {
        setState(() {
          _devices.add(r);
        });
      });
    }catch(ex){
      print('error initializing Bluetooth : $ex');
    }
  }
  Future<void> _connectToDevice(BluetoothDiscoveryResult device) async{
    try{
      //canceled discovery
      _discoveryStreamSubscription.cancel();

      // connect to selected device
      _connection = await BluetoothConnection.toAddress(device.device.address);
      setState(() {
        _isConnected = true;
      });

      // //listen to received Data
      // _dataStreamSubscription = _connection.input!.listen((data) {
      //   setState(() {
      //     _humidityData = utf8.decode(data);
      //   });
      // });
    }catch(ex){
      print('error connecting to device : $ex');
    }
  }

  void cancelStream() async{
    await _discoveryStreamSubscription.cancel();

    }

  @override
  void dispose() {
    // TODO: implement dispose
    cancelStream();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    List<BluetoothDevices> list = _devices
        .map(
          (device) => BluetoothDevices(
        device: device.device,
        // rssi: _device.rssi,
        // enabled: _device.availability == _DeviceAvailability.yes,
        onTap: () async{
          await _connectToDevice(device);
           //if(_isConnected)
            widget.onCahtPage(device.device, _connection);
        },
      ),
    )
       .toList();
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListView(
        children: list,
      ),
    );
  }
}

