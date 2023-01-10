import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';

// import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:fuelit_app/userhome/QRBillEntry.dart';
import 'ManualBillEntry.dart';
import 'package:http/http.dart' as http;
import 'package:fuelit_app/login/LoginScreen.dart' as ls;

// import 'ScanPage.dart';
import 'package:fuelit_app/login/LoginScreen.dart';

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
  bool error = false, dataloaded = false;
  String sum="";
  var data, errormsg = "";
  String dataurl =
      "http://${ls.ip}/fuelit/FuelUsage.php"; //PHP script URL

  @override
  void initState() {
    loaddata();
    //calling loading of data
    super.initState();
    print("Init state");
  }

  loaddata() async {
    print("Loading data");
    var res =
    await http.post(Uri.parse(dataurl), body: {'dbuid': ls.uid.toString()});
    if (res.statusCode == 200) {
      setState(() {

        data = json.decode(res.body);
        dataloaded = true;
        // we set dataloaded to true,
        // so that we can build a list only
        // on data load
      });
      sum = data["sum"];
      print("Sum:::::::"+sum);
      print("Data ----- "+data["sum"]);
    } else {
      //there is error
      setState(() {
        error = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    print("Width: $width\n Height: $height");
    return Container(
        width: double.infinity,
        height: double.infinity,
        child: Stack(
          alignment: Alignment.center,
          children: [
            Positioned(
              top: 30,
              right: 0,
              child: IconButton(
                icon: Icon(
                  Icons.logout_rounded,
                  size: 35,
                  color: Colors.orange,
                ),
                onPressed: () {
                  uid=0;
                  Navigator.of(context, rootNavigator: true).push(
                      MaterialPageRoute(builder: (context) => LoginScreen()));
                },
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                OutlinedButton(
                  child: Text(
                    "Scan Bill",
                    style: TextStyle(fontSize: 20.0, color: Colors.white),
                  ),
                  style: OutlinedButton.styleFrom(
                      shape: new RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(25.0),
                      ),
                      backgroundColor: Colors.orange),
                  onPressed: () async {
                    barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
                        "#1d1d1d", "HELLO--------", false, ScanMode.QR);
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              QRBillEntry(barcode: barcodeScanRes),
                        ));
                  },
                ),
                OutlinedButton(
                    child: Text("Total\nCost\n$sum",
                        style: TextStyle(fontSize: 20.0, color: Colors.white,fontStyle: FontStyle.italic)),
                    style: OutlinedButton.styleFrom(
                      shape: CircleBorder(),
                      backgroundColor: Colors.orange,
                      padding: EdgeInsets.all(width / 15),
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => TransactionTable()),
                      );
                    }),
                OutlinedButton(
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
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => ManualBillEntry()));
                  },
                )
              ],
            )
          ],
        ));
  }
}
