import 'package:flutter/material.dart';
import 'package:fuelit_app/userhome/Reports/Daily.dart';
import 'package:fuelit_app/userhome/Reports/Monthly.dart';
import 'package:fuelit_app/userhome/Reports/Weekly.dart';


class Reports extends StatefulWidget {
  //const UserHomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<Reports> {
  int pageIndex = 0;

  final pages = [
    Daily(),
    Weekly(),
    Monthly(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffFFFF),
      body: pages[pageIndex],
      bottomNavigationBar: buildMyNavBar(context),
    );
  }

  Container buildMyNavBar(BuildContext context) {
    return Container(
      height: 50,
      decoration: BoxDecoration(
        color: Colors.orange,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
          bottomLeft: Radius.circular(20),
          bottomRight: Radius.circular(20),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          new GestureDetector(
            onTap: () {
              setState(() {
                pageIndex = 0;
              });
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Daily()),
              );
            },
            child: new Text("Daily",textAlign: TextAlign.right,),
          ),
          IconButton(
            enableFeedback: false,
            onPressed: () {
              setState(() {
                pageIndex = 0;
              });
            },
            icon: pageIndex == 0
                ? const Icon(
              Icons.view_day,
              color: Colors.white,
              size: 1,
            )
                : const Icon(
              Icons.home,
              color: Colors.white,
              size: 1,
            ),
            tooltip: "Daily",
          ),
      new GestureDetector(
        onTap: () {
          setState(() {
            pageIndex = 1;
          });
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => Weekly()),
          );
        },
        child: new Text("Weekly"),
      ),
            IconButton(
            enableFeedback: false,
            onPressed: () {
              setState(() {
                pageIndex = 1;
              });
            },
            icon: pageIndex == 1
                ? const Icon(
              Icons.notes_outlined,
              color: Colors.white,
              size: 1,
            )
                : const Icon(
              Icons.notes_outlined,
              color: Colors.white,
              size: 1,
            ),
            tooltip: "Monthly",
          ),
          new GestureDetector(
            onTap: () {
              setState(() {
                pageIndex = 2;
              });
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Monthly()),
              );
            },
            child: new Text("Monthly",textAlign: TextAlign.right,),
          ),
          IconButton(
            enableFeedback: false,
            onPressed: () {
              setState(() {
                pageIndex = 2;
              });
            },
            icon: pageIndex == 2
                ? const Icon(
              Icons.summarize,
              color: Colors.white,
              size: 1,
            )
                : const Icon(
              Icons.summarize,
              color: Colors.white,
              size: 1,
            ),
            tooltip: "Monthly",
          ),
        ],
      ),
    );

  }
}