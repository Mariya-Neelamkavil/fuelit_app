import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:fuelit_app/adminhome/AdminHomePage.dart';
import 'package:http/http.dart' as http;
import 'package:fuelit_app/login/LoginScreen.dart' as ls;

class ViewUsers extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() {
    return _HomePageState();
  }
}

class _HomePageState extends State<HomePage> {
  bool error = false, dataloaded = false;
  var data;
  String dataurl =
      "http://${ls.ip}/fuelit/Users.php"; //PHP script URL

  @override
  void initState() {
    loaddata();
    //calling loading of data
    super.initState();
  }

  loaddata() async {
      var res = await http.post(Uri.parse(dataurl));
      if (res.statusCode == 200) {
        setState(() {
          data = json.decode(res.body);
          dataloaded = true;
          // we set dataloaded to true,
          // so that we can build a list only
          // on data load
        });
      } else {
        //there is error
        setState(() {
          error = true;
        });
      }
    // we use Future.delayed becuase there is
    // async function inside it.
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => AdminHomePage()),
            ),
          ),
          title: Text("User List"), //title of app
          backgroundColor: Colors.orange, //background color of app bar
        ),
        body: Container(
          padding: EdgeInsets.all(15),
          //check if data is loaded, if loaded then show datalist on child
          child: dataloaded
              ? Container(width: double.infinity, child: datalist())
              : Center(
            //if data is not loaded then show progress
              child: CircularProgressIndicator()),
        ));
  }

  Widget datalist() {
    if (data["error"]) {
      return Text(data["errmsg"]);
      //print error message from server if there is any error
    } else {
      List<NameOne> namelist = List<NameOne>.from(data["data"].map((i) {
        return NameOne.fromJSON(i);
      })); //prasing data list to model

      return DataTable(
        //if data is loaded then show table
        border: TableBorder.all(width: 1, color: Colors.black45),
        columns: const <DataColumn>[
          DataColumn(
            label: Expanded(
              child: Text(
                'User Name',
                style: TextStyle(fontStyle: FontStyle.italic,color: Colors.orange)
              ),
            ),
          ),
          DataColumn(
            label: Expanded(
              child: Text(
                'Mobile Number',
                style: TextStyle(fontStyle: FontStyle.italic,color: Colors.orange),
              ),
            ),
          ),
          DataColumn(
            label: Expanded(
              child: Text(
                'E-mail ID',
                style: TextStyle(fontStyle: FontStyle.italic,color: Colors.orange),
              ),
            ),
          ),
        ],
        rows: namelist.map((nameone) {
          return DataRow(
            cells: <DataCell>[
              DataCell(Text(nameone.Name)),
              DataCell(Text(nameone.Mobile_no)),
              DataCell(Text(nameone.Email_ID)),
            ],
          );
        }).toList(),
      );
    }
  }
}

class NameOne {
  String Name,Mobile_no, Email_ID;

  NameOne({
    required this.Name,
    required this.Mobile_no,
    required this.Email_ID,
  });

  //constructor

  factory NameOne.fromJSON(Map<String, dynamic> json) {
    return NameOne(
        Name: json["Name"], Mobile_no: json["Mobile_no"], Email_ID: json["Email_ID"]);
  }
}