import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:fuelit_app/userhome/ScanQRCode.dart';

class ScanPage extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<ScanPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("QR and Bar Code Reader & Generator demo"),
      ),
      body: ListView(
        children: <Widget>[
          Card(
            child: ListTile(
              title: Text("Scan Code"),
              leading: Icon(MaterialCommunityIcons.qrcode_scan),
              onTap: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) => ScanQRCode()));
              },
            ),
          ),
        ],
      ),
    );
  }
}
