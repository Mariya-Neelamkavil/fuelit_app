import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';

class ScanPage extends StatefulWidget{
  @override
  _MyAppState createState() => new _MyAppState();
}

class _MyAppState extends State<ScanPage> {
  String barcode=" ";
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: new AppBar(
          title: new Text("QR  Code Reader "),
        ),
        body: new Center(
          child: new Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                child: ElevatedButton(

                  style: ElevatedButton.styleFrom(
                      // side: BorderSide(color: Colors.yellow, width: 5),
                      textStyle: const TextStyle(
                          color: Colors.white, fontSize: 25, fontStyle: FontStyle.normal),
                      primary: Colors.blue ,

                  ),
                    onPressed: ()  async{
                      String barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
                          "#1d1d1d",
                          "Cancel", true,
                          ScanMode.DEFAULT);
                      print("barcode--   $barcodeScanRes");
                    },
                    child: const Text('START CAMERA SCAN')

                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                child: Text(barcode, textAlign: TextAlign.center,),
              ),
            ],
          ),
        ));
  }


// Future scan() async {
//           try {
//             await BarcodeScanner.scan().then((value)
//             // setState(() => this.barcode=value.rawContent.toString()));
//
//           } on PlatformException catch (e){
//             if(e.code== BarcodeScanner.CameraAccessDenied){
//               setState(() {
//                 this.barcode='The user did not grant the camera permission';
//               });
//             } else {
//               setState(() => this.barcode='Unknown error: $e');
//
//               }
//             }on FormatException{
//              setState(() => this.barcode='null (User returned using the "back"- button )');
//
//              }catch (e) {
//              setState(() =>this.barcode='Unknown error: $e');
//
//              }
//             }
          }
