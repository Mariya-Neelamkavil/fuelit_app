import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
// import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:fuelit_app/userhome/QRBillEntry.dart';
import 'ManualBillEntry.dart';
// import 'ScanPage.dart';
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
  String barcodeScanRes = "";
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context). size. width ;
    double height = MediaQuery.of(context). size. height;
    print("Width: $width\n Height: $height");
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Container(
          margin: EdgeInsets.only(bottom: 90),
          alignment: Alignment.bottomLeft,
          child: OutlinedButton(
            child: Text(
              "Scan\nBill",
              style: TextStyle(fontSize: 20.0, color: Colors.white),
            ),
            style: OutlinedButton.styleFrom(
              shape: new RoundedRectangleBorder(
                borderRadius: new BorderRadius.circular(25.0),
              ),
              backgroundColor: Colors.orange,
              padding: EdgeInsets.all(20),
            ),
            onPressed: () async {
                barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
                  "#1d1d1d",
                  "HELLO--------", false,
                  ScanMode.QR);
              // print("barcode--   $barcodeScanRes");
              // Text('Scan result : $barcodeScanRes\n',
              //     style: const TextStyle(fontSize: 20));
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        QRBillEntry(barcode: barcodeScanRes),
                  )
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
          margin: EdgeInsets.only(top: 160),
          alignment: Alignment.topCenter,
          child: OutlinedButton(
              child: Text("Total\nUsage",
                  style: TextStyle(fontSize: 20.0, color: Colors.white)),
              style: OutlinedButton.styleFrom(
                shape: CircleBorder(),
                backgroundColor: Colors.orange,
                padding: EdgeInsets.all(width/15),
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => TransactionTable()),
                );
              }),
        ),

        Container(
          margin: EdgeInsets.only(bottom: 90),
          alignment: Alignment.bottomLeft,
          child: OutlinedButton(
            child: Text(
              "Manual\n entry",
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
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => ManualBillEntry()));
            },
        //     onPressed: ()  async{
        //       String barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
        //           "#1d1d1d",
        //           "Cancel", true,
        //           ScanMode.DEFAULT);
        //       print("barcode-----   $barcodeScanRes");
        //     },
          ),
        )
      ],
    );
  }
}
