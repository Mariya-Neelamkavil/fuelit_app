import 'package:flutter/material.dart';
import 'package:fuelit_app/adminhome/ViewBills.dart';
import 'package:fuelit_app/userhome/UserHomePage.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:syncfusion_flutter_charts/sparkcharts.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:fuelit_app/login/LoginScreen.dart' as ls;

import '../homepage.dart';

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
                    name: 'Fuel Consumption',
                    // Enable data label
                    dataLabelSettings: DataLabelSettings(isVisible: true))
              ]),
          // Expanded(
          //   child: Padding(
          //     padding: const EdgeInsets.all(8.0),
          //     //Initialize the spark charts widget
          //     child: SfSparkLineChart.custom(
          //       //Enable the trackball
          //       trackball: SparkChartTrackball(
          //           activationMode: SparkChartActivationMode.tap),
          //       //Enable marker
          //       marker: SparkChartMarker(
          //           displayMode: SparkChartMarkerDisplayMode.all),
          //       //Enable data label
          //       labelDisplayMode: SparkChartLabelDisplayMode.all,
          //       xValueMapper: (int index) => data[index].fuel_consumption,
          //       yValueMapper: (int index) => data[index].amount,
          //       dataCount: 5,
          //     ),
          //   ),
          // )
        ]));
  }
}

class NameOne {
  String fuel_consumption;
  int amount;

  NameOne({
    required this.fuel_consumption,
    required this.amount,
  });

  //constructor

  // factory NameOne.fromJSON(Map<String, dynamic> json) {
  //   return NameOne(
  //       fuel_consumption: json["fuel_consumption"], amount: json["amount"]);
  // }
  factory NameOne.fromJson(Map<dynamic, dynamic> json) {
    return NameOne(
      fuel_consumption: json['fuel_consumption'] as String,
      amount: json['amount'] as int,
    );
  }
}
