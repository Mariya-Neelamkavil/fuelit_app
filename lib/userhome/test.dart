import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

Future<Album> fetchAlbum() async {
  final response = await http.get('http://192.168.1.73/fuelit/config.php');

// Appropriate action depending upon the
// server response
  if (response.statusCode == 200) {
    return Album.fromJson(json.decode(response.body));
  } else {
    throw Exception('Failed to load album');
  }
}

class Album {
  final String Email_ID;

  //final int id;
  final String Name;

  Album({
    required this.Email_ID,
    required this.Name
  });

  factory Album.fromJson(Map<String, dynamic> json)
  {
    return Album(
      Email_ID: json['Email_ID'],
      Name: json['Name'],
      //title: json['title'],
    );
  }





  // Map<String, dynamic> toJson() => {
  // "Email_ID": Email_ID,
  // "Name": Name};
  }


  class test extends StatefulWidget {
  //test({Key key}) : super(key: key);

  @override
  teststate createState() => teststate();
  }

  class teststate extends State<test> {
  late Future<Album> futureAlbum;

  @override
  void initState() {
  super.initState();
  futureAlbum = fetchAlbum();
  }

  @override
  Widget build(BuildContext context) {
  return MaterialApp(
  title: 'Fetching Data',
  theme: ThemeData(
  primarySwatch: Colors.blue,
  ),
  home: Scaffold(
  appBar: AppBar(
  title: Text('FUELIT'),
  ),
  body: Center(
  child: FutureBuilder<Album>(
  future: futureAlbum,
  builder: (context, snapshot) {
  if (snapshot.hasData) {
  return Text(snapshot.data!.Name);
  } else if (snapshot.hasError) {
  return Text("${snapshot.error}");
  }
  return CircularProgressIndicator();
  },
  ),
  ),
  ),
  );
  }
  }
