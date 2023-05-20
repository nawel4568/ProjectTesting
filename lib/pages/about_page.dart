import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_about_page/flutter_about_page.dart';

class About extends StatelessWidget {
  const About({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AboutPage ab = AboutPage();
    ab.customStyle(descFontFamily: "Roboto",listTextFontFamily: "RobotoMedium");
    return Scaffold(
      backgroundColor: Colors.green[50],
      appBar: AppBar(
        title: Text('About'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Humidity Sensor Control App',
              style: TextStyle(fontSize: 24),
            ),
            SizedBox(height: 16),
            Text(
              'Version 1.0.0',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 16),
            Text(
              'Author: Flutter Teams',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 16),
            Text(
              'Description: This app allows you to control the humidity level using an Arduino-based sensor.',
              style: TextStyle(fontSize: 18),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 32),
            ListTile(
              leading: Icon(Icons.email),
              title: Text('Email'),
              onTap: () => launch('mailto:watergr001@gmail.com'),
            ),
            ListTile(
              leading: Icon(Icons.facebook),
              title: Text('Facebook'),
              onTap: () => launch('https://www.facebook.com/profile.php?id=100092269207172'),
            ),
            ListTile(
              leading: Icon(Icons.web),
              title: Text('LinkedIn'),
              onTap: () => launch('https://www.instagram.com/yourinstagrampage'),
            ),
          ],
        ),
      ),
    );
  }
}

