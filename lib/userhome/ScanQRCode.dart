import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';

class ScanQRCode extends StatefulWidget {
  @override
  _ScanQRState createState() => _ScanQRState();
}

class _ScanQRState extends State<ScanQRCode> {

  String qrCodeResult = "Not Yet Scanned";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Scan QR Code"),
      ),
      body: Container(
        padding: EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            //Message displayed over here
            Text(
              "Result",
              style: TextStyle(fontSize: 25.0, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            Text(
              qrCodeResult,
              style: TextStyle(
                fontSize: 20.0,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(
              height: 20.0,
            ),

            //Button to scan QR code
            TextButton(
              onPressed: ()  async{
                String barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
                    "#1d1d1d",
                    "Cancel", true,
                    ScanMode.DEFAULT);
                print("barcode--   $barcodeScanRes");
              },
              child: Text("Open Scanner",style: TextStyle(color: Colors.indigo[900]),),
              //Button having rounded rectangle border
            ),

          ],
        ),
      ),
    );
  }
}
