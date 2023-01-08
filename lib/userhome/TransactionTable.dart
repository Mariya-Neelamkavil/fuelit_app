import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:fuelit_app/login/LoginScreen.dart' as ls;
import 'homepage.dart';

class TransactionTable extends StatelessWidget {
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
  var data, errormsg = "";
  String dataurl =
      "http://${ls.ip}/fuelit/TransactionTable.php"; //PHP script URL

  @override
  void initState() {
    loaddata();
    //calling loading of data
    super.initState();
  }

  loaddata() async {
    var res =
        await http.post(Uri.parse(dataurl), body: {'dbuid': ls.uid.toString()});
    if (res.statusCode == 200) {
      setState(() {
        print("200::::::::::::::::::::");

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
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => homepage()),
            ),
          ),
          title: Text("Transaction Summary"), //title of app
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
                'Date',
                style: TextStyle(fontStyle: FontStyle.italic,color: Colors.orange),
              ),
            ),
          ),
          DataColumn(
            label: Expanded(
              child: Text(
                'Fuel Consumption',
                style: TextStyle(fontStyle: FontStyle.italic,color: Colors.orange),
              ),
            ),
          ),
          DataColumn(
            label: Expanded(
              child: Text(
                'Amount',
                style: TextStyle(fontStyle: FontStyle.italic,color: Colors.orange),
              ),
            ),
          ),
        ],
        rows: namelist.map((nameone) {
          return DataRow(
            cells: <DataCell>[
              DataCell(Text(nameone.date)),
              DataCell(Text(nameone.fuel_consumption)),
              DataCell(Text(nameone.amount)),
            ],
          );
        }).toList(),
      );
    }
  }
}

class NameOne {
  String fuel_consumption, amount, date;

  NameOne({
    required this.fuel_consumption,
    required this.amount,
    required this.date,
  });

  //constructor

  factory NameOne.fromJSON(Map<String, dynamic> json) {
    return NameOne(
        fuel_consumption: json["fuel_consumption"],
        amount: json["amount"],
        date: json["date"]);
  }
}
