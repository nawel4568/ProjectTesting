import 'package:water/models/humidity.dart';
import 'package:flutter/material.dart';

class HumidityTile extends StatelessWidget {
  final Humidity humidity;
  void Function()? onTap;
  HumidityTile({Key? key, required this.humidity, required this.onTap}) : super(key: key);

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
            title: Text(humidity.name),
            subtitle: Text(humidity.percent),
            leading: Image.asset(humidity.imagePath),
            //trailing: trailing,
          ),
        ),
      ),
    );
  }
}