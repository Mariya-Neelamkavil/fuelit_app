import 'package:flutter/material.dart';
import 'package:fuelit_app/userhome/NearestPetrolPump.dart';
import 'package:fuelit_app/userhome/Reports.dart';
import 'package:fuelit_app/userhome/TransactionTable.dart';
import 'package:fuelit_app/userhome/homepage.dart';

class UserHomePage extends StatefulWidget {
  //const UserHomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<UserHomePage> {
  int pageIndex = 0;

  final pages = [
    homepage(),
    Reports(),
    TransactionTable(),
    NearestPetrolPump(),
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
      height: 60,
      decoration: BoxDecoration(
        color: Colors.orange,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          IconButton(
            enableFeedback: false,
            onPressed: () {
              setState(() {
                pageIndex = 0;
              });
            },
            icon: pageIndex == 0
                ? const Icon(
              Icons.home,
              color: Colors.white,
              size: 35,
            )
                : const Icon(
              Icons.home,
              color: Colors.white,
              size: 35,
            ),
            tooltip: "Home",
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
              size: 35,
            )
                : const Icon(
              Icons.notes_outlined,
              color: Colors.white,
              size: 35,
            ),
            tooltip: "Reports",
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
              size: 35,
            )
                : const Icon(
              Icons.summarize,
              color: Colors.white,
              size: 35,
            ),
            tooltip: "Transcation Summary",
          ),
          IconButton(
            enableFeedback: false,
            onPressed: () {
              setState(() {
                pageIndex = 3;
              });
            },
            icon: pageIndex == 3
                ? const Icon(
              Icons.local_gas_station,
              color: Colors.white,
              size: 35,
            )
                : const Icon(
              Icons.local_gas_station,
              color: Colors.white,
              size: 35,
            ),
            tooltip: "Nearest petrol pump",
          ),
        ],
      ),
    );
  }
}