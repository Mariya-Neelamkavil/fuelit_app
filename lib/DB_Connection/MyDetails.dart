import 'dart:io';

import 'package:flutter/material.dart';

import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:syncfusion_flutter_datagrid/datagrid.dart';

void main() {
  HttpOverrides.global = new MyHttpOverrides();
  runApp(MyDetails());
}

/// The application that contains datagrid on it.
class MyDetails extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Syncfusion DataGrid Demo',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: MyHomePage(),
    );
  }
}

/// The home page of the application which hosts the datagrid.
class MyHomePage extends StatefulWidget {
  /// Creates the home page.
  MyHomePage({key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late EmployeeDataSource employeeDataSource;
  late List<GridColumn> _columns;

  Future<Object> generateEmployeeList() async {
    // Give your PHP URL. It may be online URL o local host URL.
    // Follow the steps provided in the below KB to configure the mysql using
    // XAMPP and get the local host php link,
    ///
    var url = 'http://192.168.200.25/fuelit/config.php';
    final response = await http.get(url);
    var list = json.decode(response.body);

    // Convert the JSON to List collection.
    List<Employee> _employees =
    await list.map<Employee>((json) => Employee.fromJson(json)).toList();
    EmployeeDataSource employeeDataSource = EmployeeDataSource(_employees);
    return _employees;
  }

  List<GridColumn> getColumns() {
    return <GridColumn>[
      GridColumn(
          columnName: 'id',
          width: 70,
          label: Container(
              padding: EdgeInsets.all(16.0),
              alignment: Alignment.center,
              child: Text(
                'ID',
              ))),
      GridColumn(
          columnName: 'name',
          width: 80,
          label: Container(
              padding: EdgeInsets.all(8.0),
              alignment: Alignment.center,
              child: Text('Name'))),
      GridColumn(
          columnName: 'user_name',
          width: 120,
          label: Container(
              padding: EdgeInsets.all(8.0),
              alignment: Alignment.center,
              child: Text(
                'user_name',
                overflow: TextOverflow.ellipsis,
              ))),
    ];
  }

  @override
  void initState() {
    super.initState();
    _columns = getColumns();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Syncfusion flutter datagrid'),
        ),
        body: FutureBuilder<Object>(
            future: generateEmployeeList(),
            builder: (context, data) {
              return data.hasData
                  ? SfDataGrid(
                  source: employeeDataSource,
                  columns: _columns,
                  columnWidthMode: ColumnWidthMode.fill)
                  : Center(
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    value: 0.8,
                  ));
            }));
  }
}

/// An object to set the employee collection data source to the datagrid. This
/// is used to map the employee data to the datagrid widget.
class EmployeeDataSource extends DataGridSource {
  /// Creates the employee data source class with required details.
  EmployeeDataSource(this.employees) {
    buildDataGridRow();
  }

  void buildDataGridRow() {
    _employeeDataGridRows = employees
        .map<DataGridRow>((e) => DataGridRow(cells: [
      DataGridCell<int>(columnName: 'ID', value: e.ID),
      DataGridCell<String>(columnName: 'Name', value: e.Name),
      DataGridCell<String>(
          columnName: 'User_Name', value: e.User_Name),
    ]))
        .toList();
  }

  List<Employee> employees = [];

  List<DataGridRow> _employeeDataGridRows = [];

  @override
  List<DataGridRow> get rows => _employeeDataGridRows;

  @override
  DataGridRowAdapter buildRow(DataGridRow row) {
    return DataGridRowAdapter(
        cells: row.getCells().map<Widget>((e) {
          return Container(
            alignment: Alignment.center,
            padding: EdgeInsets.all(8.0),
            child: Text(e.value.toString()),
          );
        }).toList());
  }

  void updateDataGrid() {
    notifyListeners();
  }
}

class Employee {
  int ID;
  String Name;
  String User_Name;
  //int salary;

  Employee({required this.ID, required this.Name, required this.User_Name});

  factory Employee.fromJson(Map<String, dynamic> json) {
    return Employee(
        ID: int.parse(json['ID']),
        Name: json['Name'] as String,
        User_Name: json['User_Name'] as String);
  }
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}