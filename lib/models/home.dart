import 'package:flutter/foundation.dart';
import 'humidity.dart';

class HumidityHome extends ChangeNotifier{
  // list of the humidity we have
  final List<Humidity> _humidity = [
    Humidity(name: "Soil Moisture", percent: "Humidity Module", imagePath: "lib/images/soilmoisture.jpg"),
    Humidity(name: "Air Humidity", percent: "Humidity Module", imagePath: "lib/images/humidityair.jpg")
  ];
  List<Humidity> get selected => _humidity;
}