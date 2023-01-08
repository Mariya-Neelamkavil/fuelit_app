import 'package:flutter/material.dart';
import 'package:fuelit_app/adminhome/ViewBills.dart';
import 'package:fuelit_app/adminhome/ViewUsers.dart';

class AdminHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MyNavigationBar(),
    );
  }
}

class MyNavigationBar extends StatefulWidget {
  MyNavigationBar({Key? key}) : super(key: key);

  @override
  _MyNavigationBarState createState() => _MyNavigationBarState();
}

class _MyNavigationBarState extends State<MyNavigationBar> {
  @override
  Widget build(BuildContext context) {

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Container(
          margin: EdgeInsets.only(top: 00),
          alignment: Alignment.center,
          child: OutlinedButton(
            child: Text(
              "View Bill",
              style: TextStyle(fontSize: 20.0, color: Colors.white),
            ),
            style: OutlinedButton.styleFrom(
              shape: new RoundedRectangleBorder(
                borderRadius: new BorderRadius.circular(25.0),
              ),
              backgroundColor: Colors.orange,
              padding: EdgeInsets.all(25),
            ),
            onPressed: () {
              print("Clicked:::::::::::::");
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ViewBills()),
              );
            },
          ),

        ),

        Container(
          margin: EdgeInsets.only(bottom: 00),
          alignment: Alignment.center,
          child: OutlinedButton(
            child: Text(
              "Manage users",
              style: TextStyle(fontSize: 20.0, color: Colors.white),
            ),
            style: OutlinedButton.styleFrom(
              shape: new RoundedRectangleBorder(
                borderRadius: new BorderRadius.circular(25.0),
              ),
              backgroundColor: Colors.orange,
              padding: EdgeInsets.all(25),
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ViewUsers()),
              );
            },
          ),
        )
      ],
    );
  }
}
