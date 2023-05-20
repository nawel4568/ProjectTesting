import 'package:flutter/material.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';

class BluetoothDevices extends StatelessWidget {
  const BluetoothDevices({Key? key, required this.onTap,required this.device}) : super(key: key);
  final VoidCallback onTap;
  final BluetoothDevice? device;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.only(bottom: 10),
        decoration: BoxDecoration(
          color: Colors.green[100],
          borderRadius: BorderRadius.circular(20.0),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListTile(
            leading: Icon(Icons.devices),
            title: Text(device!.name ?? "Unknown Device"),
            subtitle: Text(device!.address.toString()),

            trailing: Icon(Icons.arrow_forward),
          ),
        ),
      ),
    );
  }
}
