import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class NearestPetrolPump extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
        theme: ThemeData(
          brightness: Brightness.light, //primary color for theme
        ),
     debugShowCheckedModeBanner: false,
     home: ElevatedButton(
          onPressed: _launchUrl,
          child: Text('Go to Google Map',style: TextStyle(color: Colors.orange)),
       style: ElevatedButton.styleFrom(
           backgroundColor: Colors.white),
        ),
      );
  }
}

_launchUrl() async {
  const url = 'https://www.google.com/maps/search/nearest+petrol+pumps/';
  await launch(url);
}