import 'package:flutter/material.dart';
import 'ManualBillEntry.dart';
import 'TransactionTable.dart';

class homepage extends StatelessWidget {
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
          margin: EdgeInsets.only(left: 95,bottom: 50),
          alignment: Alignment.bottomLeft,
          child: OutlinedButton(
            child: Text(
              "Scan Bill",
              style: TextStyle(fontSize: 20.0, color: Colors.white),
            ),
            style: OutlinedButton.styleFrom(
              shape: new RoundedRectangleBorder(
                borderRadius: new BorderRadius.circular(25.0),
              ),
              backgroundColor: Color(0xffF8917B),
              padding: EdgeInsets.all(30),
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => homepage()),
              );
            },
          ),
        ),
        Container(
          margin: EdgeInsets.zero,
          alignment: Alignment.center,
          child: OutlinedButton(
              child: Text("Test",
                  style: TextStyle(fontSize: 20.0, color: Colors.white)),
              style: OutlinedButton.styleFrom(
                shape: CircleBorder(),
                backgroundColor: Color(0xffF8917B),
                padding: EdgeInsets.all(80),
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => TransactionTable()),
                );
              }),
        ),

        Container(
          margin: EdgeInsets.only(right: 95,bottom: 50),
          alignment: Alignment.bottomLeft,
          child: OutlinedButton(
            child: Text(
              "Manual entry",
              style: TextStyle(fontSize: 20.0, color: Colors.white),
            ),
            style: OutlinedButton.styleFrom(
              shape: new RoundedRectangleBorder(
                borderRadius: new BorderRadius.circular(25.0),
              ),
              backgroundColor: Color(0xffF8917B),
              padding: EdgeInsets.all(30),
            ),
            onPressed: () {
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => ManualBillEntry()));
            },
          ),
        )
      ],
    );
  }
}
