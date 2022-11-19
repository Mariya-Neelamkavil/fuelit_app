import 'package:flutter/material.dart';
import 'package:fuelit_app/userhome/ScanPage.dart';
import 'ManualBillEntry.dart';
import 'test2.dart';

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
  int _selectedIndex = 0;
  static const List<Widget> _widgetOptions = <Widget>[
    Text('Home', style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold)),
    Text('Search', style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold)),
    Text('Profile',
        style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold)),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(children: <Widget>[
          SizedBox(
            height: 200,
          ),
          Container(
            margin: EdgeInsets.zero,
            alignment: Alignment.center,
            child: OutlinedButton(
              child: Text("TEst",
                  style: TextStyle(fontSize: 20.0, color: Colors.white)),
              style: OutlinedButton.styleFrom(
                shape: CircleBorder(),
                backgroundColor: Color(0xffF8917B),
                padding: EdgeInsets.all(80),
              ),

              //highlightedBorderColor: Colors.red,
              //shape:const RoundedRectangleBorder(
              //  borderRadius: BorderRadius.circular(15)
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => test2()),
                  );
                }
            ),
          ),
          SizedBox(
            height: 50,
          ),
          Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
            Container(
              margin: EdgeInsets.only(left: 20, top: 25),
              alignment: Alignment.topLeft,
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

                //highlightedBorderColor: Colors.red,
                //shape:const RoundedRectangleBorder(
                //  borderRadius: BorderRadius.circular(15)
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => homepage()),
                  );
                },
              ),
            ),
            Container(
              margin: EdgeInsets.only(right: 20, top: 25),
              alignment: Alignment.bottomRight,
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
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => ManualBillEntry()));
                },
              ),
            ),
          ])
        ]),
      ),
      backgroundColor: (Colors.white),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.black,
        child: const Icon(Icons.settings),
        onPressed: () {
          // action on button press
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.miniEndTop,
      bottomNavigationBar: SizedBox(
        height: 80,
        child: BottomNavigationBar(
            backgroundColor: Color(0xffF8917B),
            items: const <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                  icon: Icon(Icons.home),
                  label: 'Home',
                  backgroundColor: Color(0xffF8917B)),
              BottomNavigationBarItem(
                  icon: Icon(Icons.notes_outlined),
                  label: 'Reports',
                  backgroundColor: Color(0xffF8917B)),
              BottomNavigationBarItem(
                  icon: Icon(Icons.summarize),
                  label: 'Transaction Summary',
                  backgroundColor: Color(0xffF8917B)),
              BottomNavigationBarItem(
                  icon: Icon(Icons.local_gas_station),
                  label: 'Nearest Petrol Pump',
                  backgroundColor: Color(0xffF8917B)),
            ],
            type: BottomNavigationBarType.shifting,
            currentIndex: _selectedIndex,
            selectedItemColor: Colors.white60,
            iconSize: 40,
            onTap: _onItemTapped,
            elevation: 5),
      ),
    );
  }
}
