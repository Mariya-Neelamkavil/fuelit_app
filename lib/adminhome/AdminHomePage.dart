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
  String barcodeScanRes = "";
  @override
  Widget build(BuildContext context) {

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Container(
          margin: EdgeInsets.only(bottom: 90),
          alignment: Alignment.topRight,
          child: OutlinedButton(
            child: Text(
              "View\nBill",
              style: TextStyle(fontSize: 20.0, color: Colors.white),
            ),
            style: OutlinedButton.styleFrom(
              shape: new RoundedRectangleBorder(
                borderRadius: new BorderRadius.circular(25.0),
              ),
              backgroundColor: Colors.orange,
              padding: EdgeInsets.all(20),
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ViewBills()),
              );
            },
            // onPressed: ()  async{
            //   String barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
            //       "#1d1d1d",
            //       "Cancel", true,
            //       ScanMode.DEFAULT);
            //   print("barcode-----   $barcodeScanRes");
            // },
          ),
        ),

        Container(
          margin: EdgeInsets.only(bottom: 90),
          alignment: Alignment.bottomLeft,
          child: OutlinedButton(
            child: Text(
              "Manage\nusers",
              style: TextStyle(fontSize: 20.0, color: Colors.white),
            ),
            style: OutlinedButton.styleFrom(
              shape: new RoundedRectangleBorder(
                borderRadius: new BorderRadius.circular(25.0),
              ),
              backgroundColor: Colors.orange,
              padding: EdgeInsets.all(20),
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
