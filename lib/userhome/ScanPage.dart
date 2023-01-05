import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';



import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:fuelit_app/userhome/QRBillEntry.dart';

class ScanPage extends StatefulWidget{
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<ScanPage> {
  String barcodeScanRes="";
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("QR  Code Reader "),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                child: ElevatedButton(

                    style: ElevatedButton.styleFrom(
                      side: BorderSide(color: Colors.orange),
                      textStyle: const TextStyle(
                          color: Colors.white, fontSize: 25, fontStyle: FontStyle.normal),

                    ),
                    onPressed: ()  async{
                      barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
                          "#1d1d1d",
                          "HELLO--------", false,
                          ScanMode.QR);
                      // print("barcode--   $barcodeScanRes");
                      // Text('Scan result : $barcodeScanRes\n',
                      //     style: const TextStyle(fontSize: 20));
                    },
                    child: const Text('START CAMERA SCAN')


                ),




              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                child: Text(barcodeScanRes, textAlign: TextAlign.center,),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                child:Column(
                  children: [
                    ElevatedButton(

                        style: ElevatedButton.styleFrom(

                          side: BorderSide(color: Colors.orange),
                          textStyle: const TextStyle(
                              color: Colors.white, fontSize: 25, fontStyle: FontStyle.normal),

                        ),
                        onPressed: () {
                          {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => QRBillEntry(barcode: barcodeScanRes),
                                )
                            );
                          }
                          // async{
                          //   barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
                          //       "#1d1d1d",
                          //       "HELLO--------", false,
                          //       ScanMode.QR);
                          //   print("barcode--   $barcodeScanRes");
                          //   // Text('Scan result : $barcodeScanRes\n',
                          //   //     style: const TextStyle(fontSize: 20));
                          // },

                        }, child: const Text('View Bill'),
                    ),
                  ],
                ),
                // SizedBox(
                //   width: 300,
                //   child: Padding(
                //     padding: const EdgeInsets.all(10.0),
                //     child: Row(
                //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //       children: [
                //         GestureDetector(
                //           // onTap: () {
                //           //   Navigator.push(
                //           //       context,
                //           //       MaterialPageRoute(
                //           //           builder: (context) => ForgetPassword()));
                //           // },
                //           child: Text.rich(
                //             TextSpan(
                //               text: barcodeScanRes,
                //               style: TextStyle(
                //                 color: Colors.orange,
                //               ),
                //             ),
                //           ),
                //         ),
                //
                //       ],
                //     ),
                //   ),
                // ),
              )],
          ),
        ));
  }


// Future scan() async {
//           try {
//             await BarcodeScanner.scan().then((value)
//              setState(() => this.barcode=value.rawContent.toString()));
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
