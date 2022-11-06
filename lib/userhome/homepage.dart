import 'package:flutter/material.dart';

class homepage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MyNavigationBar (),
    );

  }
}

class MyNavigationBar extends StatefulWidget {
  MyNavigationBar ({Key? key}) : super(key: key);

  @override
  _MyNavigationBarState createState() => _MyNavigationBarState();
}

class _MyNavigationBarState extends State<MyNavigationBar > {
  int _selectedIndex = 0;
  static const List<Widget> _widgetOptions = <Widget>[
    Text('Home', style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold)),
    Text('Search', style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold)),
    Text('Profile', style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold)),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body:Center(child: Column(children: <Widget>[
          Container(
            margin: EdgeInsets.only(right: 50),
            alignment: Alignment.centerRight,
            child: OutlinedButton(
              child: Text("Out", style: TextStyle(fontSize: 20.0),),
              style: OutlinedButton.styleFrom(
                shape: CircleBorder(),
                backgroundColor: Colors.black,
                padding: EdgeInsets.all(150),

              ),

              //highlightedBorderColor: Colors.red,
              //shape:const RoundedRectangleBorder(
              //  borderRadius: BorderRadius.circular(15)
              onPressed: () {},
            ),

          ),
          Container(
            margin: EdgeInsets.only(left: 50),
            alignment: Alignment.topLeft,
            child: OutlinedButton(
              child: Text("Out", style: TextStyle(fontSize: 20.0),),
              style: OutlinedButton.styleFrom(
                shape: new RoundedRectangleBorder(
                  borderRadius: new BorderRadius.circular(25.0),
                ),
                backgroundColor: Colors.black,
                padding: EdgeInsets.all(85),

              ),

              //highlightedBorderColor: Colors.red,
              //shape:const RoundedRectangleBorder(
              //  borderRadius: BorderRadius.circular(15)
              onPressed: () {},
            ),

          ),
          Container(
            margin: EdgeInsets.only(top: 25,left: 50),
            alignment: Alignment.bottomLeft,
            child: OutlinedButton(
              child: Text("Out", style: TextStyle(fontSize: 20.0),),
              style: OutlinedButton.styleFrom(
                shape: new RoundedRectangleBorder(
                  borderRadius: new BorderRadius.circular(25.0),
                ),
                backgroundColor: Colors.black,
                padding: EdgeInsets.all(85),

              ),

              //highlightedBorderColor: Colors.red,
              //shape:const RoundedRectangleBorder(
              //  borderRadius: BorderRadius.circular(15)
              onPressed: () {},
            ),

          ),


        ]),),


      backgroundColor: (Colors.teal),

      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.black,
      child: const Icon(Icons.settings),
      onPressed: () {
      // action on button press
      },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.miniEndTop,


      bottomNavigationBar: BottomNavigationBar(
          backgroundColor: Color(0x44aaaaff),
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: 'Home',
                backgroundColor: Colors.black
            ),
            BottomNavigationBarItem(
                icon: Icon(Icons.notes_outlined),
                label: 'Reports',
                backgroundColor: Colors.black
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.summarize),
              label:'Transaction Summary',
              backgroundColor: Colors.black,
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.local_gas_station),
              label:'Nearest Petrol Pump',
              backgroundColor: Colors.black,
            ),
          ],
          type: BottomNavigationBarType.shifting,
          currentIndex: _selectedIndex,
          selectedItemColor: Colors.yellow,
          iconSize: 40,
          onTap: _onItemTapped,
          elevation: 5
      ),

    );
  }
}