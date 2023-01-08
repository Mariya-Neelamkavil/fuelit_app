import 'package:flutter/material.dart';
import 'package:fuelit_app/userhome/Reports/Daily.dart';
import 'package:fuelit_app/userhome/UserHomePage.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:fuelit_app/login/LoginScreen.dart' as ls;
import 'package:fuelit_app/userhome/Reports/Monthly.dart';
import 'package:fuelit_app/userhome/homepage.dart' as hp;


class Weekly extends StatefulWidget {
  // ignore: prefer_const_constructors_in_immutables
  Weekly({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<Weekly> {
  bool error = false, dataloaded = false;
  var data, a, b, c;
  List<NameOne> namelist = [];
  List<String> x = [];
  String dataurl = "http://${ls.ip}/fuelit/Report.php"; //PHP script URL

  @override
  void initState() {
    hp.MyNavigationBar();
    loaddata();
    //calling loading of data
    super.initState();
  }

  void loaddata() {
    Future.delayed(Duration.zero, () async {
      var res = await http.post(Uri.parse(dataurl));
      if (res.statusCode == 200) {
        setState(() {
          print(res.body);
          Map<String, dynamic> tempData = jsonDecode(res.body);
          List<dynamic> apiList = tempData["data"];
          List<NameOne> tempList = [];
          apiList.forEach((entitlement) {
            tempList.add(NameOne(
                fuel_consumption: entitlement["fuel_consumption"],
                date: entitlement["date"],
                amount: int.parse(entitlement["amount"])));
          });
          namelist = tempList;
          dataloaded = true;
        });
      } else {
        //there is error
        setState(() {
          error = true;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => UserHomePage()),
            ),
          ),
          title: Text("Reports"), //title of app
          backgroundColor: Colors.orange, //background color of app bar
        ),
        body: Column(children: [
          //Initialize the chart widget
          SfCartesianChart(
              primaryXAxis: CategoryAxis(),
              // Chart title
              title: ChartTitle(text: 'Weekly analysis of fuel consumption'),
              // Enable legend
              legend: Legend(isVisible: true),
              // Enable tooltip
              tooltipBehavior: TooltipBehavior(enable: true),
              series: <ChartSeries<NameOne, String>>[
                LineSeries<NameOne, String>(
                    dataSource: namelist,
                    xValueMapper: (NameOne sales, _) => sales.fuel_consumption,
                    yValueMapper: (NameOne sales, _) => sales.amount,
                    name: 'Cost',
                    color: Colors.orange,
                    // Enable data label
                    dataLabelSettings: DataLabelSettings(isVisible: true)
                    )
              ]),
          SizedBox(
            height: 20,
          ),
          Table(
            border: TableBorder.all(
                color: Colors.orange,
                width: 2),
            children: [
              TableRow( children: [
                Column(children:[Text('Date', style: TextStyle(fontSize: 15.0))]),
                Column(children:[Text('Fuel Consumption', style: TextStyle(fontSize: 15.0))]),
                Column(children:[Text('Amount', style: TextStyle(fontSize: 15.0))]),
              ]),
            ],
          ),
    Table(
    //if data is loaded then show table
    border: TableBorder.all(width: 1, color: Colors.black12),


    children: namelist.map((nameone) {
    return TableRow(children: [

    //return table row in every loop
    //table cells inside table row
    TableCell(
          child: Padding(
              padding: EdgeInsets.all(5), child: Text(nameone.date.toString()))),
    TableCell(
    child: Padding(
    padding: EdgeInsets.all(5), child: Text(nameone.fuel_consumption))),
    TableCell(
    child: Padding(
    padding: EdgeInsets.all(5), child: Text(nameone.amount.toString())))
    ]);
    }).toList(),
        ),
          SizedBox(
            height: 10,
          ),
          Table(
            // border: TableBorder.all(
            //     color: Colors.orange,
            //     width: 0),
            children: [
              TableRow( children: [
                Column(children:[Text('    ', style: TextStyle(fontSize: 20.0))]),
                Column(children:[TextButton(
    onPressed: () {
    Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => Daily()),
    );
    },
    child:Text('Daily', style: TextStyle(fontSize: 20.0,color: Colors.orange,
                  fontWeight: FontWeight.bold,)))]),
                Column(children:[TextButton(
    onPressed: () {
    Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => Weekly()),
    );
    },
    child:Text('Weekly', style: TextStyle(fontSize: 20.0,color: Colors.orange,
                  fontWeight: FontWeight.bold,)))]),
                Column(children:[TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Monthly()),
                      );
                    },
                    child:Text('Monthly', style: TextStyle(fontSize: 20.0,color: Colors.orange,
                  fontWeight: FontWeight.bold,)))]),
                Column(children:[Text('    ', style: TextStyle(fontSize: 20.0))]),
              ]),
            ],
          ),
    ],)

    );
  }
}

class NameOne {
  String fuel_consumption;
  int amount;
  String date;

  NameOne({
    required this.fuel_consumption,
    required this.amount,
    required this.date,
  });

  factory NameOne.fromJson(Map<dynamic, dynamic> json) {
    return NameOne(
      fuel_consumption: json['fuel_consumption'] as String,
      amount: json['amount'] as int,
      date: json['date'] as String,
    );
  }
}
