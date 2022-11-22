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
  int _selectedIndex = 0;
   static const List<Widget> _widgetOptions = <Widget>[
    Text('Home Page', style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold)),
    Text('Reports Page', style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold)),
    Text('Transaction Page', style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold)),
    Text('Map Page', style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold)),
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
          _widgetOptions.elementAt(_selectedIndex),


          SizedBox(
            height: 200,
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

              //highlightedBorderColor: Colors.red,
              //shape:const RoundedRectangleBorder(
              //  borderRadius: BorderRadius.circular(15)
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => TransactionTable()),
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
